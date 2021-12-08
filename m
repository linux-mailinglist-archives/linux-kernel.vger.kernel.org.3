Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD8346CED2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 09:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244753AbhLHI3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 03:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244745AbhLHI3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 03:29:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CEAC061574
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 00:25:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00982B81FE0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 08:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6019C341C3;
        Wed,  8 Dec 2021 08:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638951947;
        bh=j+/1Bbc4ClHV3nE1hAtk/I6JUrYndnXTixb73sLPF3c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BvR7zWnsyRH1OExiaOyX30ws/QKSgvzkKI7a5xvUQhl432jgh5TXNLCznEeP1gIm1
         e5yF/Yb85bgJ95vq+SkG+bDBtHc3BWWaDAhbNB4WIZhZmtZAv882HstrmkYe7gJc5R
         lZV4vRn/Er8kAh+KAgBTQri8S/8qYnT+8R12Ik57RYh1vck/QrCh0KpI7pytSP3lV0
         dwMCb8hz+otPlvbNtlJHzWZxXI4DVZWkXNKQ80gVLH31ZaM8vdIzv90O9IDmgAghXx
         ftvkshzpfDptsz5wMFJQHSSvyKgv/LLGu3CXFGXQyA67wg4QtVqR56AZCZtjO0eDDm
         4ceQxgpc/D/Gw==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1musGn-00AiPS-S5; Wed, 08 Dec 2021 08:25:45 +0000
MIME-Version: 1.0
Date:   Wed, 08 Dec 2021 08:25:45 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     linux-kernel@vger.kernel.org, Wudi Wang <wangwudi@hisilicon.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] irqchip/irq-gic-v3-its.c: Return its_invall_cmd.col when
 building INVALL
In-Reply-To: <20211208015429.5007-1-zhangshaokun@hisilicon.com>
References: <20211208015429.5007-1-zhangshaokun@hisilicon.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <522e91148810ca7c77ad492d3a92c7a9@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: zhangshaokun@hisilicon.com, linux-kernel@vger.kernel.org, wangwudi@hisilicon.com, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-08 01:54, Shaokun Zhang wrote:
> From: Wudi Wang <wangwudi@hisilicon.com>
> 
> INVALL CMD specifies that the ITS must ensure any caching associated 
> with
> the interrupt collection defined by ICID is consistent with the LPI
> configuration tables held in memory for all Redistributors. SYNC is
> required to ensure that INVALL is executed.

The patch title doesn't quite spell out the issue. It should say 
something
like:

"Force synchronisation when issuing INVALL"

> 
> Currently, LPI configuration data may be inconsistent with that in the
> memory within a short period of time after the INVALL command is 
> executed.

I'm curious: have you seen any issue with this on actual HW? In my
experience, all implementations treat INVALL as a synchronous command,

Or was this solely done via inspection?

> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Wudi Wang <wangwudi@hisilicon.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>

This needs:

Fixes: cc2d3216f53 ("irqchip: GICv3: ITS command queue")

> ---
>  drivers/irqchip/irq-gic-v3-its.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
> b/drivers/irqchip/irq-gic-v3-its.c
> index eb0882d15366..0cb584d9815b 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -742,7 +742,7 @@ static struct its_collection
> *its_build_invall_cmd(struct its_node *its,
> 
>  	its_fixup_cmd(cmd);
> 
> -	return NULL;
> +	return desc->its_invall_cmd.col;
>  }
> 
>  static struct its_vpe *its_build_vinvall_cmd(struct its_node *its,

I'll fix the above locally, no need to resend.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
