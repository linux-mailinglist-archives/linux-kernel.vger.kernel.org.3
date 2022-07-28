Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F465843BF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiG1P7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiG1P7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:59:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E8C6BD44
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 08:59:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E12E61C4E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 15:59:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F34C433D6;
        Thu, 28 Jul 2022 15:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659023951;
        bh=UumqePG1sWgAECeyEvk1HAPaaYMXIQnD1SpC1qAihEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BIdV8669AKDBtqjl/Owj6EVbIRjmd4o9WrbxlNeiGnhQ2O0+owDXJttVu7bWHvZzi
         S4GuDNfOTXRlSvInx/4YaSw/XxKXJ7AEBW6tMrJNYSid/NAsd1JS4k9gMkVjaBNQNS
         INjS9SNJdxkeYpWxh5HtwpubV2t2e1wo+sRv9b9s=
Date:   Thu, 28 Jul 2022 17:59:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     kah.jing.lee@intel.com, linux-kernel@vger.kernel.org,
        arnd@arndb.de, rafael.j.wysocki@intel.com, tien.sung.ang@intel.com,
        dinh.nguyen@intel.com, Zhou@kroah.com,
        Furong <furong.zhou@intel.com>, Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH v2 1/3] drivers: misc: intel_sysid: Add sysid from arch
 to drivers
Message-ID: <YuKyTKHk3c7DibX3@kroah.com>
References: <20220721123017.416438-1-kah.jing.lee@intel.com>
 <20220721123149.416618-1-kah.jing.lee@intel.com>
 <YuJAll2MEgKF0MVM@kroah.com>
 <be3f189e-c17c-2438-450d-3d84dfcd71da@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be3f189e-c17c-2438-450d-3d84dfcd71da@linux.intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 10:37:37AM -0500, Pierre-Louis Bossart wrote:
> Thanks for the review Greg,
> 
> >> +static int intel_sysid_probe(struct platform_device *pdev)
> >> +{
> >> +	struct intel_sysid *sysid;
> >> +	struct resource	*regs;
> >> +
> >> +	sysid = devm_kzalloc(&pdev->dev, sizeof(struct intel_sysid),
> >> +		GFP_KERNEL);
> >> +	if (!sysid)
> >> +		return -ENOMEM;
> >> +
> >> +	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> +	if (!regs)
> >> +		return -ENXIO;
> >> +
> >> +	sysid->regs = devm_ioremap_resource(&pdev->dev, regs);
> >> +	if (IS_ERR(sysid->regs))
> >> +		return PTR_ERR(sysid->regs);
> >> +
> >> +	platform_set_drvdata(pdev, sysid);
> >> +
> >> +	return devm_device_add_group(&pdev->dev, &intel_sysid_attr_group);
> > 
> > You just raced with userspace and lost.  Please use the default group
> > for the platform device.
> > 
> > I need to go remove this function, it should not be used at all as it is
> > broken.
> 
> Can you elaborate on the issue and suggested replacement?
> 
> We used this function for the SoundWire sysfs based on your review
> comments (2 years ago?) that we should not muck with kobj, and that
> function devm_device_add_group() is also used in a probe function.

Use the default_groups pointer in the driver structure.

thanks,

greg k-h
