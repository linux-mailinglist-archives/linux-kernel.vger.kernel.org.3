Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3698E585204
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 17:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiG2PDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 11:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiG2PDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 11:03:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0300B1FE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:03:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5077B61AC9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 15:03:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BFEC433C1;
        Fri, 29 Jul 2022 15:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659106985;
        bh=XQhKrj3mBkmm98vaiqZCcsYovhORhaIgbJh9hVRNzwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=daLcI1iv3PX39Fx76j5qPHaQB72ymYbKc6AsnVgpC4NA26mIa9NuZEgWv1+L2oido
         1jyvyTg+b0AyKxgzElaxr1hjUS0RZTYC7MPhJxxrqoH9z5vPdpd6GVy8F1eF1qFOze
         k9GkYl1DuGNkoh7BQ9LpqbApv/HqR7wWd/Try0k8=
Date:   Fri, 29 Jul 2022 17:03:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 2/5] soundwire: sysfs: cleanup the logic for creating the
 dp0 sysfs attributes
Message-ID: <YuP2pjhyKTTfpXQq@kroah.com>
References: <20220729135041.2285908-1-gregkh@linuxfoundation.org>
 <20220729135041.2285908-2-gregkh@linuxfoundation.org>
 <9365e038-2146-98f8-f989-02827f221c34@linux.intel.com>
 <YuP0Ffs3G7ZBR0AC@kroah.com>
 <cfacb124-a9ff-0a93-8f92-93d164b15966@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfacb124-a9ff-0a93-8f92-93d164b15966@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 09:57:52AM -0500, Pierre-Louis Bossart wrote:
> 
> 
> On 7/29/22 09:52, Greg Kroah-Hartman wrote:
> > On Fri, Jul 29, 2022 at 09:46:26AM -0500, Pierre-Louis Bossart wrote:
> >>
> >>
> >> On 7/29/22 08:50, Greg Kroah-Hartman wrote:
> >>> There's no need to special-case the dp0 sysfs attributes, the
> >>> is_visible() callback in the attribute group can handle that for us, so
> >>> add that and add it to the attribute group list making the logic simpler
> >>> overall.
> >>>
> >>> This is a step on the way to moving all of the sysfs attribute handling
> >>> into the default driver core attribute group logic so that the soundwire
> >>> core does not have to do any of it manually.
> >>>
> >>> Cc: Vinod Koul <vkoul@kernel.org>
> >>> Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
> >>> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> >>> Cc: Sanyog Kale <sanyog.r.kale@intel.com>
> >>> Cc: alsa-devel@alsa-project.org
> >>> Cc: linux-kernel@vger.kernel.org
> >>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>> ---
> >>>  drivers/soundwire/sysfs_slave.c | 18 ++++++++++++------
> >>>  1 file changed, 12 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/drivers/soundwire/sysfs_slave.c b/drivers/soundwire/sysfs_slave.c
> >>> index 83e3f6cc3250..3723333a5c2b 100644
> >>> --- a/drivers/soundwire/sysfs_slave.c
> >>> +++ b/drivers/soundwire/sysfs_slave.c
> >>> @@ -174,6 +174,16 @@ static ssize_t words_show(struct device *dev,
> >>>  }
> >>>  static DEVICE_ATTR_RO(words);
> >>>  
> >>> +static umode_t dp0_is_visible(struct kobject *kobj, struct attribute *attr,
> >>> +			      int n)
> >>> +{
> >>> +	struct sdw_slave *slave = dev_to_sdw_dev(kobj_to_dev(kobj));
> >>> +
> >>> +	if (slave->prop.dp0_prop)
> >>> +		return attr->mode;
> >>> +	return 0;
> >>> +}
> >>
> >> This changes the results slightly by creating an empty 'dp0' directory
> >> with no attributes inside.
> >>
> >> Before:
> >>
> >> [root@fedora ~]# cd /sys/bus/soundwire/devices/sdw:3:025d:0714:01
> >> [root@fedora sdw:3:025d:0714:01]# ls dp0
> >> ls: cannot access 'dp0': No such file or directory
> >>
> >> After:
> >> [root@fedora sdw:3:025d:0714:01]# ls dp0
> > 
> > That should be fine, tools should just be looking for the attributes,
> > not the existance of a directory, right?
> 
> The idea what that we would only expose ports that actually exist.
> That's helpful information anyone with a basic knowledge of the
> SoundWire specification would understand.

Is "dp0" a port?  If so, why isn't it a real device?

> The attributes are really details that few people/applications would
> understand, and unfortunately the information reported in DSDT is more
> often than not complete garbage.

I don't understand what DSDT is, or how it is relevant here :(

thanks,

greg k-h
