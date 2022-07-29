Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6330584DF2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 11:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbiG2JQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 05:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiG2JQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 05:16:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD7F66ADD
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 02:16:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47D8C61D3A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 09:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4281C433C1;
        Fri, 29 Jul 2022 09:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659086164;
        bh=FvjchVb1a62ysId8AI3Wh3k06CFUyn06kg/iS2JkxPQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kVjbgbUYKONtR5odkSYpoZGE/vS/9UY6/B0hYI1ZSdup43YZxKlOQXJiXNYxHL6e8
         uEJZM3Yz96rMHEPn5dE8Ny7CJ3NDIhAm4g2iQZ8GDAUBFmPu5HZvhLyrpcWnoOH2DP
         X4gsVrslK4z4oGvIus7Sfm0ayBxnaPD8usdxHvMUrFcJa1eaFUkqkLPlSB5LWniSS5
         kUK6seLpRal766bRkC5u8FPs/FlihV5Kr0W2uOos6J71hpOUXNEys+iW5mgQ/p9JwS
         WEuYmDH0Jqt0mX71BrIMDjtAHtluEayK6Wy2NWa5CQFyfMWyHI6gpT9PB7QIRZSmNV
         AIakT4Gp+NF0Q==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oHM6E-00AqXE-Ez;
        Fri, 29 Jul 2022 10:16:02 +0100
MIME-Version: 1.0
Date:   Fri, 29 Jul 2022 10:16:02 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqdomain: do not shadow nr_irqs global definition
In-Reply-To: <20220729090307.57905-1-mailhol.vincent@wanadoo.fr>
References: <20220729090307.57905-1-mailhol.vincent@wanadoo.fr>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <2e3ef1724d1d9acdbbf1a80487891a7f@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: mailhol.vincent@wanadoo.fr, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-29 10:03, Vincent Mailhol wrote:
> include/linux/irqnr.h declares a global variable named `nr_irqs'.
> 
> The inline function irq_domain_alloc_irqs() from
> include/linux/irqdomain.h also uses the same name and thus shadow the
> global declaration. Rename the function argument from `nr_irqs' to
> `nbr_irqs'.
> 
> This patch silences below -Wshadow warning:
> 
> | In file included from ./arch/x86/include/asm/irqdomain.h:5,
> |                  from ./arch/x86/include/asm/msi.h:5,
> |                  from ./include/linux/msi.h:23,
> |                  from ./include/linux/kvm_host.h:19,
> |                  from arch/x86/kernel/../kvm/vmx/vmx.h:5,
> |                  from arch/x86/kernel/asm-offsets.c:22:
> | ./include/linux/irqdomain.h: In function 'irq_domain_alloc_irqs':
> | ./include/linux/irqdomain.h:514:38: warning: declaration of
> 'nr_irqs' shadows a global declaration [-Wshadow]
> |   514 |                         unsigned int nr_irqs, int node, void 
> *arg)
> |       |                         ~~~~~~~~~~~~~^~~~~~~
> | In file included from ./include/linux/interrupt.h:10,
> |                  from ./include/linux/kernel_stat.h:9,
> |                  from ./include/linux/cgroup.h:26,
> |                  from ./include/linux/memcontrol.h:13,
> |                  from ./include/linux/swap.h:9,
> |                  from ./include/linux/suspend.h:5,
> |                  from arch/x86/kernel/asm-offsets.c:13:
> | ./include/linux/irqnr.h:8:12: note: shadowed declaration is here
> |     8 | extern int nr_irqs;
> |       |            ^~~~~~~
> 
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
>  include/linux/irqdomain.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> index 00d577f90883..76949bb029b0 100644
> --- a/include/linux/irqdomain.h
> +++ b/include/linux/irqdomain.h
> @@ -511,9 +511,9 @@ extern int irq_domain_activate_irq(struct irq_data
> *irq_data, bool early);
>  extern void irq_domain_deactivate_irq(struct irq_data *irq_data);
> 
>  static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
> -			unsigned int nr_irqs, int node, void *arg)
> +					unsigned int nbr_irqs, int node, void *arg)
>  {
> -	return __irq_domain_alloc_irqs(domain, -1, nr_irqs, node, arg, false,
> +	return __irq_domain_alloc_irqs(domain, -1, nbr_irqs, node, arg, 
> false,
>  				       NULL);
>  }

I really don't think this is worth it. A function has its
own namespace, and this warning is on the long list of
"this is completely silly". Case in point:

$ git grep 'unsigned int nr_irqs'| wc -l
207

Is anything broken? Not as far as I can tell.

If there was anything to fix, it is the top-level definition
that should be more indicative of its global status. But again,
there is nothing broken so far.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
