Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04904A7110
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 13:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344222AbiBBMu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 07:50:59 -0500
Received: from foss.arm.com ([217.140.110.172]:57630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230258AbiBBMu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 07:50:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B18111FB;
        Wed,  2 Feb 2022 04:50:58 -0800 (PST)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E52FF3F718;
        Wed,  2 Feb 2022 04:50:57 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        Steev Klimaszewski <steev@kali.org>
Subject: Re: [PATCH] irqchip/gic-v3-its: Skip HP notifier when no ITS is registered
In-Reply-To: <20220202103454.2480465-1-maz@kernel.org>
References: <20220202103454.2480465-1-maz@kernel.org>
Date:   Wed, 02 Feb 2022 12:50:52 +0000
Message-ID: <87pmo5o2j7.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/22 10:34, Marc Zyngier wrote:
> We have some systems out there that have both LPI support and an
> ITS, but that don't expose the ITS in their firmware tables
> (either because it is broken or because they run under a hypervisor
> that hides it...).
>

Huh :)

> Is such a configuration, we still register the HP notifier to free
> the allocated tables if needed, resulting in a warning as there is
> no memory to free (nothing was allocated the first place).
>

Right, so list_empty(&its_nodes) means no ->pend_page, but still having the
HP notifier means we hit the WARN_ON(!pend_page).

> Fix it by keying the HP notifier on the presence of at least one
> sucessfully probed ITS.
>

That looks fine to me.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

> Fixes: d23bc2bc1d63 ("irqchip/gic-v3-its: Postpone LPI pending table freeing and memreserve")
> Reported-by: Steev Klimaszewski <steev@kali.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 9e93ff2b6375..cd772973114a 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -5517,6 +5517,9 @@ int __init its_lpi_memreserve_init(void)
>       if (!efi_enabled(EFI_CONFIG_TABLES))
>               return 0;
>
> +	if (list_empty(&its_nodes))
> +		return 0;
> +
>       gic_rdists->cpuhp_memreserve_state = CPUHP_INVALID;
>       state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
>                                 "irqchip/arm/gicv3/memreserve:online",
> --
> 2.34.1
