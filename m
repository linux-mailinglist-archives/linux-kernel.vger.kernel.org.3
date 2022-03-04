Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319154CD8F4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236918AbiCDQSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiCDQSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:18:32 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E28743AE3;
        Fri,  4 Mar 2022 08:17:42 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 8E3BD92009C; Fri,  4 Mar 2022 17:17:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 8807592009B;
        Fri,  4 Mar 2022 16:17:41 +0000 (GMT)
Date:   Fri, 4 Mar 2022 16:17:41 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        kernel test robot <lkp@intel.com>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v2] mips: DEC: honor CONFIG_MIPS_FP_SUPPORT=n
In-Reply-To: <20220304161036.16008-1-rdunlap@infradead.org>
Message-ID: <alpine.DEB.2.21.2203041614260.47558@angie.orcam.me.uk>
References: <20220304161036.16008-1-rdunlap@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2022, Randy Dunlap wrote:

> --- linux-next-20220303.orig/arch/mips/dec/setup.c
> +++ linux-next-20220303/arch/mips/dec/setup.c
> @@ -746,6 +746,7 @@ void __init arch_init_irq(void)
>  		dec_interrupt[DEC_IRQ_HALT] = -1;
>  
>  	/* Register board interrupts: FPU and cascade. */
> +#if defined(CONFIG_MIPS_FP_SUPPORT)
>  	if (dec_interrupt[DEC_IRQ_FPU] >= 0 && cpu_has_fpu) {
>  		struct irq_desc *desc_fpu;
>  		int irq_fpu;

 Can you please make it:

	if (IS_ENABLED(CONFIG_MIPS_FP_SUPPORT) && 
	    dec_interrupt[DEC_IRQ_FPU] >= 0 && cpu_has_fpu) {

so as not to add more #ifdef's where avoidable?

  Maciej
