Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3268524A2E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352574AbiELKWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345059AbiELKWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:22:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073795B3D1;
        Thu, 12 May 2022 03:22:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A114F61CE2;
        Thu, 12 May 2022 10:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A62AC385CB;
        Thu, 12 May 2022 10:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652350932;
        bh=MwEdIPt8V7IcGJwcblLAwmE2i5Lh/8BkDawpPULT2II=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TaC4Ro+XrApotYdCJoxHvramF2ezR+O1E0eYlTMMjWtxZfspVKTMSqdhNgqa2PoSt
         24TK/sqR8iJkV1q6I0626qlpJb2xtMk8LcDR2jwXRoIPlUkPMclaoNAQH7Jjk+nFcO
         HeoQmg8OyKK0QDaOt+Sb8HlNE3Nh2sl5aDg+zH3s=
Date:   Thu, 12 May 2022 12:22:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, dtor@chromium.org, gwendal@chromium.org,
        vbendeb@chromium.org, andy@infradead.org,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?utf-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Darren Hart <dvhart@infradead.org>,
        Jeremy Soller <jeremy@system76.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH v12] platform/chrome: Add ChromeOS ACPI device driver
Message-ID: <YnzfzRhGwtO9RtNi@kroah.com>
References: <YnycZaoBPF89t/qF@debian-BULLSEYE-live-builder-AMD64>
 <YnzdDMPR3qZ1waJW@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnzdDMPR3qZ1waJW@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 03:10:20AM -0700, Dmitry Torokhov wrote:
> Hi Muhammad,
> 
> On Thu, May 12, 2022 at 10:34:29AM +0500, Muhammad Usama Anjum wrote:
> > +static int chromeos_acpi_device_probe(struct platform_device *pdev)
> > +{
> > +	chromeos_acpi_gpio_groups = get_gpio_pkg_num(&pdev->dev);
> > +
> > +	/*
> > +	 * If the platform has more GPIO attribute groups than the number of
> > +	 * groups this driver supports, give out a warning message.
> > +	 */
> > +	if (chromeos_acpi_gpio_groups > ARRAY_SIZE(chromeos_acpi_all_groups) - 2)
> > +		dev_warn(&pdev->dev, "Only %zu GPIO attr groups supported by the driver out of total %u.\n",
> > +			 ARRAY_SIZE(chromeos_acpi_all_groups) - 2, chromeos_acpi_gpio_groups);
> 
> I know that we can bikeshed this until dawn of time, but we are dealing
> here with data coming from the system firmware and a singleton device,
> so it should be all available pretty early in boot sequence. I
> understand we want to solve the "race" even though it is purely
> theoretical, but we should be able to figure out what gpios are
> supported and construct the groups array(s) before registering the
> platform driver. Or do we see that runtime costs of constricting groups
> dynamically outweigh space wasted by unused groups?

I really really do not like dynamically created groups as it's more
complex and fragile.  This is much simpler code overall.

thanks,

greg k-h
