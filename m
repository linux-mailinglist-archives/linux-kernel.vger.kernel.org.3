Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367B759B90C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbiHVGJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiHVGJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:09:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D46E24F05
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 23:09:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 250D2B80E88
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949E7C433C1;
        Mon, 22 Aug 2022 06:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661148571;
        bh=jkfZw4GZo+upzS4/44GEBKA5bFWYoet3Hu9G/RHcY3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vWe7EWIPjr57tZHdahPOxSZbHiqx3NeDYX9EuhQYcVT4ZRfmE6c/7Pm/+FGwQIfke
         xhyga+2I80lQUGCyd7oGDfHBjU3jktlKIcm2MQloVdLCbnxL142l09vYZ1kLpd2nVF
         OAuuS//fXeq9M3ILrkaYRnFq3NPKlJ8xLZxUGACo=
Date:   Mon, 22 Aug 2022 08:09:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH -next] driver core: switch to use dev_err_probe()
Message-ID: <YwMdl/3ZBKAYsqN1@kroah.com>
References: <20220819094656.1945653-1-yangyingliang@huawei.com>
 <Yv9a9+iREzQWYecQ@kroah.com>
 <1d4d1ef7-7386-cf8f-0a5a-04690ec27ed6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d4d1ef7-7386-cf8f-0a5a-04690ec27ed6@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 10:10:22AM +0800, Yang Yingliang wrote:
> Hi,
> 
> On 2022/8/19 17:42, Greg KH wrote:
> > On Fri, Aug 19, 2022 at 05:46:56PM +0800, Yang Yingliang wrote:
> > > Use dev_err_probe() to simplify code and print error code.
> > > 
> > > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > > ---
> > >   drivers/base/core.c | 8 +++-----
> > >   1 file changed, 3 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > index 753e7cca0f40..e51a09f9d0ec 100644
> > > --- a/drivers/base/core.c
> > > +++ b/drivers/base/core.c
> > > @@ -2507,11 +2507,9 @@ static ssize_t uevent_store(struct device *dev, struct device_attribute *attr,
> > >   	int rc;
> > >   	rc = kobject_synth_uevent(&dev->kobj, buf, count);
> > > -
> > > -	if (rc) {
> > > -		dev_err(dev, "uevent: failed to send synthetic uevent\n");
> > > -		return rc;
> > > -	}
> > > +	if (rc)
> > > +		return dev_err_probe(dev, rc,
> > > +				     "uevent: failed to send synthetic uevent\n");
> > I do not understand this at all, this is not on the probe path at all,
> > so why is this function needed?
> > 
> > Have you tested this?  What was the resulting output before and after
> > this change?
> Yes, after this change, the error code will be print.

You did not answer my question.

Again, this is not on the probe() callback path, so why are you wanting
to call dev_err_probe()?

thanks,

greg k-h
