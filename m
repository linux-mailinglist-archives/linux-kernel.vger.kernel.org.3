Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277F158516C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 16:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236942AbiG2OUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 10:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbiG2OT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 10:19:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2347A500
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:19:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB9CDB82802
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 14:19:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66E1C433D6;
        Fri, 29 Jul 2022 14:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659104395;
        bh=rG+qA9pRCh2XHrx6FPAQMmQX+gy1CarW8WVq6ER5xt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pv0PQedtK+W5XN5LIhRHRvE3N86IVP8C3RjR+hcaZcAG9IFPIIpYWLmEU1hT66tjg
         iV29/MuQi5uAgiI1LHVsfkSw3jzhIBG+sGVT2VnWiBwQlTFViZMmBVR4LivjK2whK6
         4pMAV+y3jG8AYKg3xRlbf7RwL2Vau3QV1ke0Cn1A=
Date:   Fri, 29 Jul 2022 16:19:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 3/5] soundwire: sysfs: have the driver core handle the
 creation of the device groups
Message-ID: <YuPsiB5QUWjlzIYi@kroah.com>
References: <20220729135041.2285908-1-gregkh@linuxfoundation.org>
 <20220729135041.2285908-3-gregkh@linuxfoundation.org>
 <be630e3a-3b3b-48cf-d61c-840ab04f1140@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be630e3a-3b3b-48cf-d61c-840ab04f1140@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 09:12:17AM -0500, Pierre-Louis Bossart wrote:
> 
> > diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
> > index 893296f3fe39..81c77e6ddbad 100644
> > --- a/drivers/soundwire/bus_type.c
> > +++ b/drivers/soundwire/bus_type.c
> > @@ -193,6 +193,7 @@ int __sdw_register_driver(struct sdw_driver *drv, struct module *owner)
> >  
> >  	drv->driver.owner = owner;
> >  	drv->driver.probe = sdw_drv_probe;
> > +	drv->driver.dev_groups = sdw_attr_groups;
> >  
> >  	if (drv->remove)
> >  		drv->driver.remove = sdw_drv_remove;
> 
> Minor rebase issue: this version of the bus_type.c code is no longer
> up-to-date, this patch creates a conflict with "soundwire: bus_type: fix
> remove and shutdown support" merged by Vinod - should be in your
> char-misc tree as well for 5.20.

Sorry, did this against Linus's tree, I will rebase it against 5.20-rc1
when that comes out and resend it then.

thanks,

greg k-h
