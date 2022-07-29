Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CDE585131
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 15:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbiG2N6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 09:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbiG2N5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 09:57:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC38C69F33
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 06:57:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CC10B80D3F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 13:57:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12A8C433D6;
        Fri, 29 Jul 2022 13:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659103068;
        bh=AI4Yp0CPqdTfx0f6fSb0DtypGBCe3Evvs99rZwaQ1ME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PL++qAyNJpC9mSw3wv539iYG5aDhziWlDSpomRHjDZzb5WJVJ1ErzkS/8xWg4ArZa
         B70PELWxcytAmDVC713zv1usLPHXNqvXNO9zl5lltjrxeVnAhY8mWKOJ+Oy9l0InkS
         19K2WNw5ie4KcrSpVsrE2K4vmvrqhDydqS2QaZJk=
Date:   Fri, 29 Jul 2022 15:57:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     kah.jing.lee@intel.com, linux-kernel@vger.kernel.org,
        arnd@arndb.de, rafael.j.wysocki@intel.com, tien.sung.ang@intel.com,
        dinh.nguyen@intel.com, Zhou@kroah.com,
        Furong <furong.zhou@intel.com>, Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH v2 1/3] drivers: misc: intel_sysid: Add sysid from arch
 to drivers
Message-ID: <YuPnWcTNDEmkxfOo@kroah.com>
References: <20220721123017.416438-1-kah.jing.lee@intel.com>
 <20220721123149.416618-1-kah.jing.lee@intel.com>
 <YuJAll2MEgKF0MVM@kroah.com>
 <be3f189e-c17c-2438-450d-3d84dfcd71da@linux.intel.com>
 <YuKyTKHk3c7DibX3@kroah.com>
 <7686403c-7252-ef7a-70fc-040c5ab8cb79@linux.intel.com>
 <YuPH+4zMImvY8C0A@kroah.com>
 <YuPK6cvPJvL+L3/t@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuPK6cvPJvL+L3/t@kroah.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 01:56:25PM +0200, Greg KH wrote:
> On Fri, Jul 29, 2022 at 01:43:55PM +0200, Greg KH wrote:
> > On Thu, Jul 28, 2022 at 11:53:33AM -0500, Pierre-Louis Bossart wrote:
> > > 
> > > 
> > > On 7/28/22 10:59, Greg KH wrote:
> > > > On Thu, Jul 28, 2022 at 10:37:37AM -0500, Pierre-Louis Bossart wrote:
> > > >> Thanks for the review Greg,
> > > >>
> > > >>>> +static int intel_sysid_probe(struct platform_device *pdev)
> > > >>>> +{
> > > >>>> +	struct intel_sysid *sysid;
> > > >>>> +	struct resource	*regs;
> > > >>>> +
> > > >>>> +	sysid = devm_kzalloc(&pdev->dev, sizeof(struct intel_sysid),
> > > >>>> +		GFP_KERNEL);
> > > >>>> +	if (!sysid)
> > > >>>> +		return -ENOMEM;
> > > >>>> +
> > > >>>> +	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > >>>> +	if (!regs)
> > > >>>> +		return -ENXIO;
> > > >>>> +
> > > >>>> +	sysid->regs = devm_ioremap_resource(&pdev->dev, regs);
> > > >>>> +	if (IS_ERR(sysid->regs))
> > > >>>> +		return PTR_ERR(sysid->regs);
> > > >>>> +
> > > >>>> +	platform_set_drvdata(pdev, sysid);
> > > >>>> +
> > > >>>> +	return devm_device_add_group(&pdev->dev, &intel_sysid_attr_group);
> > > >>>
> > > >>> You just raced with userspace and lost.  Please use the default group
> > > >>> for the platform device.
> > > >>>
> > > >>> I need to go remove this function, it should not be used at all as it is
> > > >>> broken.
> > > >>
> > > >> Can you elaborate on the issue and suggested replacement?
> > > >>
> > > >> We used this function for the SoundWire sysfs based on your review
> > > >> comments (2 years ago?) that we should not muck with kobj, and that
> > > >> function devm_device_add_group() is also used in a probe function.
> > > > 
> > > > Use the default_groups pointer in the driver structure.
> > > 
> > > did you mean dev_groups?
> > 
> > Yes, sorry, that's the correct name.
> > 
> > > I am not following the idea, for SoundWire all the attributes are really
> > > device-specific or described by ACPI and cannot be hard-coded in the
> > > driver structure.
> > 
> > That's what the is_visible() callback is for in the groups structure,
> > you determine if the attribute is visable or not at runtime, you don't
> > rely on the driver itself to add/remove attributes, that does not scale
> > and again, is racy.
> 
> In looking at your attribute code, ick, you dynamically create a ton of
> them.  But for the ones that you do not, you can just have the driver
> core add them.  Let me make up a patch that shows what I am thinking
> of...

Here's a series for this:
	https://lore.kernel.org/r/20220729135041.2285908-1-gregkh@linuxfoundation.org

I'll go fix up the other devm_device_add_groups() users, and then start
tackling devm_device_add_group() as well.

thanks,

greg k-h
