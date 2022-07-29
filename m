Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48944584FAE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 13:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbiG2LoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 07:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236063AbiG2Ln7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 07:43:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D7787C28
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 04:43:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D817D61EDC
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 11:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC545C433D6;
        Fri, 29 Jul 2022 11:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659095038;
        bh=PlDpUa9kKZeXXUnnE5veinbmwK3klYqqIJ+ubLGpGs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F+/xlHV46vb8oTFDjdYlS09pHN1sQnHJbfskwHRvRAZYd4veiUeDSQRxhatsos8SX
         uNJkMz66b4Bu6hxsLc9m1gVkW8JqmPQAnos1U858RTF3gl1kEwkQ8B4VhlSgrOjK3L
         +CKmKlCyz8Y561H/fHRbSGnvPaZq5/ofRbn/owXo=
Date:   Fri, 29 Jul 2022 13:43:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     kah.jing.lee@intel.com, linux-kernel@vger.kernel.org,
        arnd@arndb.de, rafael.j.wysocki@intel.com, tien.sung.ang@intel.com,
        dinh.nguyen@intel.com, Zhou@kroah.com,
        Furong <furong.zhou@intel.com>, Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH v2 1/3] drivers: misc: intel_sysid: Add sysid from arch
 to drivers
Message-ID: <YuPH+4zMImvY8C0A@kroah.com>
References: <20220721123017.416438-1-kah.jing.lee@intel.com>
 <20220721123149.416618-1-kah.jing.lee@intel.com>
 <YuJAll2MEgKF0MVM@kroah.com>
 <be3f189e-c17c-2438-450d-3d84dfcd71da@linux.intel.com>
 <YuKyTKHk3c7DibX3@kroah.com>
 <7686403c-7252-ef7a-70fc-040c5ab8cb79@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7686403c-7252-ef7a-70fc-040c5ab8cb79@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 11:53:33AM -0500, Pierre-Louis Bossart wrote:
> 
> 
> On 7/28/22 10:59, Greg KH wrote:
> > On Thu, Jul 28, 2022 at 10:37:37AM -0500, Pierre-Louis Bossart wrote:
> >> Thanks for the review Greg,
> >>
> >>>> +static int intel_sysid_probe(struct platform_device *pdev)
> >>>> +{
> >>>> +	struct intel_sysid *sysid;
> >>>> +	struct resource	*regs;
> >>>> +
> >>>> +	sysid = devm_kzalloc(&pdev->dev, sizeof(struct intel_sysid),
> >>>> +		GFP_KERNEL);
> >>>> +	if (!sysid)
> >>>> +		return -ENOMEM;
> >>>> +
> >>>> +	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >>>> +	if (!regs)
> >>>> +		return -ENXIO;
> >>>> +
> >>>> +	sysid->regs = devm_ioremap_resource(&pdev->dev, regs);
> >>>> +	if (IS_ERR(sysid->regs))
> >>>> +		return PTR_ERR(sysid->regs);
> >>>> +
> >>>> +	platform_set_drvdata(pdev, sysid);
> >>>> +
> >>>> +	return devm_device_add_group(&pdev->dev, &intel_sysid_attr_group);
> >>>
> >>> You just raced with userspace and lost.  Please use the default group
> >>> for the platform device.
> >>>
> >>> I need to go remove this function, it should not be used at all as it is
> >>> broken.
> >>
> >> Can you elaborate on the issue and suggested replacement?
> >>
> >> We used this function for the SoundWire sysfs based on your review
> >> comments (2 years ago?) that we should not muck with kobj, and that
> >> function devm_device_add_group() is also used in a probe function.
> > 
> > Use the default_groups pointer in the driver structure.
> 
> did you mean dev_groups?

Yes, sorry, that's the correct name.

> I am not following the idea, for SoundWire all the attributes are really
> device-specific or described by ACPI and cannot be hard-coded in the
> driver structure.

That's what the is_visible() callback is for in the groups structure,
you determine if the attribute is visable or not at runtime, you don't
rely on the driver itself to add/remove attributes, that does not scale
and again, is racy.

thanks,

greg k-h
