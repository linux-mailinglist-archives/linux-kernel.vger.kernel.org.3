Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2CA5851D2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 16:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237233AbiG2OwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 10:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbiG2OwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 10:52:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401936D574
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:52:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC329B82816
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 14:52:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099A1C433D6;
        Fri, 29 Jul 2022 14:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659106329;
        bh=F3R+IOAPEQcMnDp1+HJeg+EseSWL8jzg1ZzFD/TqHPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jx8RM2gZ0DRSCk7nSuPoQxG+jpm3VnWYi6IsuXN62pdo5x/bDUpQ0n/Z8sFwRNuLP
         tO56S+uBmc5IAjpYCdRGQWSxe0PxLpYSABHXnr65omm4BltMbQzIu9+1SJjdkWh3Lp
         3VPyYUk84A3A+HUQtcDIg1K4OBRMSMoXopRWibcI=
Date:   Fri, 29 Jul 2022 16:52:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 2/5] soundwire: sysfs: cleanup the logic for creating the
 dp0 sysfs attributes
Message-ID: <YuP0Ffs3G7ZBR0AC@kroah.com>
References: <20220729135041.2285908-1-gregkh@linuxfoundation.org>
 <20220729135041.2285908-2-gregkh@linuxfoundation.org>
 <9365e038-2146-98f8-f989-02827f221c34@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9365e038-2146-98f8-f989-02827f221c34@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 09:46:26AM -0500, Pierre-Louis Bossart wrote:
> 
> 
> On 7/29/22 08:50, Greg Kroah-Hartman wrote:
> > There's no need to special-case the dp0 sysfs attributes, the
> > is_visible() callback in the attribute group can handle that for us, so
> > add that and add it to the attribute group list making the logic simpler
> > overall.
> > 
> > This is a step on the way to moving all of the sysfs attribute handling
> > into the default driver core attribute group logic so that the soundwire
> > core does not have to do any of it manually.
> > 
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
> > Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > Cc: Sanyog Kale <sanyog.r.kale@intel.com>
> > Cc: alsa-devel@alsa-project.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/soundwire/sysfs_slave.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/soundwire/sysfs_slave.c b/drivers/soundwire/sysfs_slave.c
> > index 83e3f6cc3250..3723333a5c2b 100644
> > --- a/drivers/soundwire/sysfs_slave.c
> > +++ b/drivers/soundwire/sysfs_slave.c
> > @@ -174,6 +174,16 @@ static ssize_t words_show(struct device *dev,
> >  }
> >  static DEVICE_ATTR_RO(words);
> >  
> > +static umode_t dp0_is_visible(struct kobject *kobj, struct attribute *attr,
> > +			      int n)
> > +{
> > +	struct sdw_slave *slave = dev_to_sdw_dev(kobj_to_dev(kobj));
> > +
> > +	if (slave->prop.dp0_prop)
> > +		return attr->mode;
> > +	return 0;
> > +}
> 
> This changes the results slightly by creating an empty 'dp0' directory
> with no attributes inside.
> 
> Before:
> 
> [root@fedora ~]# cd /sys/bus/soundwire/devices/sdw:3:025d:0714:01
> [root@fedora sdw:3:025d:0714:01]# ls dp0
> ls: cannot access 'dp0': No such file or directory
> 
> After:
> [root@fedora sdw:3:025d:0714:01]# ls dp0

That should be fine, tools should just be looking for the attributes,
not the existance of a directory, right?

thanks,

greg k-h
