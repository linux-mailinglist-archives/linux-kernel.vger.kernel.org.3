Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDE848D57A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbiAMKNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiAMKNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:13:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B62C06173F;
        Thu, 13 Jan 2022 02:13:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDF5C61B77;
        Thu, 13 Jan 2022 10:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76821C36AE3;
        Thu, 13 Jan 2022 10:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642068794;
        bh=ijdFSU0tzgbikdiQ4EWHXgHfcS6vqCI0UuxTBUw4W9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C2fK+bIjUxWYxYBb9nvhY8+rSIgYzTw9h+wGOuaNdP3zJjS+caEui876bQSejC7lF
         0XArfr/GLDNt2m4mIyMBmTi4gNtNGKL1DU0DU3v3kaeXpw9IZnCk+Bw24iJNaXoBg7
         V3/AixbWHwZDFnUytl4q2Gnc+snkzm3W1G57c/3dOlxK50e5PqgQuWtYbE19AEbBCR
         Xf/8GM6nb7ZVNlpV2hL7oxzs96vOrtIz3awBL0L/1Oh1EWHNOf0c3USVhRtn92ZAfr
         n8dzmt4rOTAEA8SvZN/izu5vPPLAc7Mvts+Vnkk87nkiappaVWay+mt7ch/W/e8CtP
         KuclZGw63F0hQ==
Date:   Thu, 13 Jan 2022 12:13:09 +0200
From:   Abel Vesa <abelvesa@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        peter.chen@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, lznuaa@gmail.com
Subject: Re: [PATCH 1/1] usb: xhci-plat: fix crash when suspend if remote
 wake enable
Message-ID: <Yd/7NQLgoEU17TzI@abelvesa>
References: <20220110172738.31686-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110172738.31686-1-Frank.Li@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-01-10 11:27:38, Frank Li wrote:
> Crashed at i.mx8qm platform when suspend if enable remote wakeup
> 
> Internal error: synchronous external abort: 96000210 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 2 PID: 244 Comm: kworker/u12:6 Not tainted 5.15.5-dirty #12
> Hardware name: Freescale i.MX8QM MEK (DT)
> Workqueue: events_unbound async_run_entry_fn
> pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : xhci_disable_hub_port_wake.isra.62+0x60/0xf8
> lr : xhci_disable_hub_port_wake.isra.62+0x34/0xf8
> sp : ffff80001394bbf0
> x29: ffff80001394bbf0 x28: 0000000000000000 x27: ffff00081193b578
> x26: ffff00081193b570 x25: 0000000000000000 x24: 0000000000000000
> x23: ffff00081193a29c x22: 0000000000020001 x21: 0000000000000001
> x20: 0000000000000000 x19: ffff800014e90490 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> x14: 0000000000000000 x13: 0000000000000002 x12: 0000000000000000
> x11: 0000000000000000 x10: 0000000000000960 x9 : ffff80001394baa0
> x8 : ffff0008145d1780 x7 : ffff0008f95b8e80 x6 : 000000001853b453
> x5 : 0000000000000496 x4 : 0000000000000000 x3 : ffff00081193a29c
> x2 : 0000000000000001 x1 : 0000000000000000 x0 : ffff000814591620
> Call trace:
>  xhci_disable_hub_port_wake.isra.62+0x60/0xf8
>  xhci_suspend+0x58/0x510
>  xhci_plat_suspend+0x50/0x78
>  platform_pm_suspend+0x2c/0x78
>  dpm_run_callback.isra.25+0x50/0xe8
>  __device_suspend+0x108/0x3c0
> 
> The basic flow:
> 	1. run time suspend call xhci_suspend, xhci parent devices gate the clock.
>         2. echo mem >/sys/power/state, system _device_suspend call xhci_suspend
>         3. xhci_suspend call xhci_disable_hub_port_wake, which access register,
> 	   but clock already gated by run time suspend.
> 
> This problem was hidden by power domain driver, which call run time resume before it.
> 
> But the below commit remove it and make this issue happen.
> 	commit c1df456d0f06e ("PM: domains: Don't runtime resume devices at genpd_prepare()")
> 
> This patch call run time resume before suspend to make sure clock is on
> before access register.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Tested on i.MX8QM.

Testeb-by: Abel Vesa <abel.vesa@nxp.com>

> ---
>  drivers/usb/host/xhci-plat.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index c6b791a83ad18..7d2f665271310 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -442,6 +442,9 @@ static int __maybe_unused xhci_plat_suspend(struct device *dev)
>  	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
>  	int ret;
>  
> +	if (pm_runtime_suspended(dev))
> +		pm_runtime_resume(dev);
> +
>  	ret = xhci_priv_suspend_quirk(hcd);
>  	if (ret)
>  		return ret;
> -- 
> 2.24.0.rc1
> 
