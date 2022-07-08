Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A6E56B62F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 12:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237381AbiGHKBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 06:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237298AbiGHKBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:01:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0A683F1A;
        Fri,  8 Jul 2022 03:01:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C387462315;
        Fri,  8 Jul 2022 10:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDCFC341C0;
        Fri,  8 Jul 2022 10:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657274497;
        bh=u/AQjMr5Y/sNit28VcEutT4SJmwx63rssPloTC1VMoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d0tsQlbIUX8/3kqzit/yz68WvkkUKFPstytVPvt9WU6AbWoJZwHr32t+LSIKw0Rvd
         +SVubFy0CwYjtwk3eIuKGbnHpVkCcli5z0gZE/m1a9C0EjWNM/Z2IZloq9sJ8fjvqG
         k5c7QaOMHqvZQ4ShxhNYvZCzp5D1rRK5/FSTOfds=
Date:   Fri, 8 Jul 2022 12:01:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "yekai(A)" <yekai13@huawei.com>
Cc:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangzhou1@hisilicon.com
Subject: Re: [PATCH v5 1/3] uacce: supports device isolation feature
Message-ID: <YsgAflazb061YgC+@kroah.com>
References: <20220708070820.43958-1-yekai13@huawei.com>
 <20220708070820.43958-2-yekai13@huawei.com>
 <YsfctnUkPCo+qGJW@kroah.com>
 <288f82bf-ca0b-b049-4dcf-fd7b6a29607b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <288f82bf-ca0b-b049-4dcf-fd7b6a29607b@huawei.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 05:33:42PM +0800, yekai(A) wrote:
> 
> 
> On 2022/7/8 15:28, Greg KH wrote:
> > On Fri, Jul 08, 2022 at 03:08:18PM +0800, Kai Ye wrote:
> > > UACCE adds the hardware error isolation API. Users can configure
> > > the isolation frequency by this sysfs node. UACCE reports the device
> > > isolate state to the user space. If the AER error frequency exceeds
> > > the value of setting for a certain period of time, the device will be
> > > isolated.
> > > 
> > > Signed-off-by: Kai Ye <yekai13@huawei.com>
> > > ---
> > >  drivers/misc/uacce/uacce.c | 55 ++++++++++++++++++++++++++++++++++++++
> > >  include/linux/uacce.h      | 11 ++++++++
> > >  2 files changed, 66 insertions(+)
> > > 
> > > diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> > > index 281c54003edc..d07b5f1f0596 100644
> > > --- a/drivers/misc/uacce/uacce.c
> > > +++ b/drivers/misc/uacce/uacce.c
> > > @@ -7,6 +7,8 @@
> > >  #include <linux/slab.h>
> > >  #include <linux/uacce.h>
> > > 
> > > +#define MAX_ERR_ISOLATE_COUNT		65535
> > > +
> > >  static struct class *uacce_class;
> > >  static dev_t uacce_devt;
> > >  static DEFINE_MUTEX(uacce_mutex);
> > > @@ -339,12 +341,63 @@ static ssize_t region_dus_size_show(struct device *dev,
> > >  		       uacce->qf_pg_num[UACCE_QFRT_DUS] << PAGE_SHIFT);
> > >  }
> > > 
> > > +static ssize_t isolate_show(struct device *dev,
> > > +			    struct device_attribute *attr, char *buf)
> > > +{
> > > +	struct uacce_device *uacce = to_uacce_device(dev);
> > > +
> > > +	if (!uacce->ops->get_isolate_state)
> > > +		return -ENODEV;
> > 
> > If there is no callback, why is this sysfs even created at all?  Please
> > do not create it if it can not be accessed.
> > 
> > Use the is_visable() callback for the group to do this.
> > 
> 
> If is_visable() is used as the judgment, all uacce device nodes cannot be
> registered if there is no callback by test.

I am sorry, I do not understand.  That callback is to be used for this
type of thing, and works for lots of driver subsystems.  Why exactly
will it not work here as well?

thanks,

greg k-h
