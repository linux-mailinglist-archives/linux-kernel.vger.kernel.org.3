Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E2452C8CD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 02:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbiESAmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 20:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbiESAmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 20:42:01 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 8F5E92BB0D
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 17:41:59 -0700 (PDT)
Received: (qmail 208096 invoked by uid 1000); 18 May 2022 20:41:58 -0400
Date:   Wed, 18 May 2022 20:41:58 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@chromium.org>,
        linux-usb@vger.kernel.org, Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] usb: Probe EHCI, OHCI controllers asynchronously
Message-ID: <YoWSVhv1fxPR888p@rowland.harvard.edu>
References: <20220518150150.1.Ie8ea0e945a9c15066237014be219eed60066d493@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518150150.1.Ie8ea0e945a9c15066237014be219eed60066d493@changeid>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 03:02:51PM -0700, Brian Norris wrote:
> From: Dmitry Torokhov <dtor@chromium.org>
> 
> initcall_debug shows that OHCI controllers take ~60ms to probe on
> Rockchip RK3399 systems:
> 
>   probe of fe3a0000.usb returned 1 after 58941 usecs
> 
> A few of these can add up to waste non-trivial amounts of time at boot.
> 
> These host controllers don't provide resources to other drivers, so
> this shouldn't contribute to exposing race conditions.
> 
> Chrome OS kernels have carried this patch on some systems for a while
> without issues. Similar patches have been merged for a variety of (e)MMC
> host controllers for similar reasons.
> 
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> [Brian: rewrote commit message, refreshed, but retained dtor's original
>  authorship ]
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/host/ehci-platform.c | 1 +
>  drivers/usb/host/ohci-platform.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> index 1115431a255d..f343967443e2 100644
> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -518,6 +518,7 @@ static struct platform_driver ehci_platform_driver = {
>  		.pm	= pm_ptr(&ehci_platform_pm_ops),
>  		.of_match_table = vt8500_ehci_ids,
>  		.acpi_match_table = ACPI_PTR(ehci_acpi_match),
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  	}
>  };
>  
> diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
> index 4a8456f12a73..47dfbfe9e519 100644
> --- a/drivers/usb/host/ohci-platform.c
> +++ b/drivers/usb/host/ohci-platform.c
> @@ -334,6 +334,7 @@ static struct platform_driver ohci_platform_driver = {
>  		.name	= "ohci-platform",
>  		.pm	= &ohci_platform_pm_ops,
>  		.of_match_table = ohci_platform_ids,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  	}
>  };
>  
> -- 
> 2.36.1.124.g0e6072fb45-goog
> 
