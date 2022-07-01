Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB785635A4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbiGAOdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiGAOdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:33:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02273F89C;
        Fri,  1 Jul 2022 07:28:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CC076227C;
        Fri,  1 Jul 2022 14:28:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC2DC341C7;
        Fri,  1 Jul 2022 14:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656685730;
        bh=eb0RVw4u/anxVBhBeK6RNGoBor+v7IkGnAADFe79wz8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N4dveUvYzzWyC8fMV0v0hedmOK1ZAMnFbdqhysk4WaSM0nBJ5UGNNFqdZwQ6rvMIn
         CP7ClyXkRLM/63cRf55J9y6B7IMxWTTHcdoGVsMy4uSFk7LGQjzFjqRc6omPUcwwRn
         B9kqf9pRrlu6yoi8KFGJ7VRs49YYxJ/d2sia7XcvSGprDsbgyvadOiPqbzPAT1XDvJ
         9lUkAzGaYu2A49lfHm5lhFMTyzyBYx8+fliV5Kgwv/5AtG9NtVvmMuvIb5P+3JK/48
         moPFmDTxjnYJm7qHwhnkR8pKAXK4Y2HtDwBqgBMGVmYIOksPHsfjZwJ/VArWBElV2u
         fj3qZ04BLthLw==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1o7HdY-004bu7-EO;
        Fri, 01 Jul 2022 15:28:48 +0100
MIME-Version: 1.0
Date:   Fri, 01 Jul 2022 15:28:48 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Guo Ren <guoren@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/4] Add PLIC support for Renesas RZ/Five SoC / Fix
 T-HEAD PLIC edge flow
In-Reply-To: <20220630100241.35233-1-samuel@sholland.org>
References: <20220630100241.35233-1-samuel@sholland.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <92a45bf04cfe140c7605559fa3d8f4eb@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: samuel@sholland.org, prabhakar.mahadev-lad.rj@bp.renesas.com, prabhakar.csengg@gmail.com, sagar.kadam@sifive.com, paul.walmsley@sifive.com, palmer@dabbelt.com, guoren@kernel.org, tglx@linutronix.de, geert+renesas@glider.be, linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com, krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-30 11:02, Samuel Holland wrote:
> This patch series adds PLIC support for Renesas RZ/Five SoC.
> 
> Since the T-HEAD C900 PLIC has the same behavior, it also applies the
> fix for that variant.
> 
> This series is an update of v2 of the RZ/Five series[0], and replaces
> the separate T-HEAD series[1].
> 
> [0]:
> https://lore.kernel.org/linux-riscv/20220626004326.8548-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> [1]:
> https://lore.kernel.org/linux-riscv/20220627051257.38543-1-samuel@sholland.org/
> 
> Changes in v3:
>  - Add a more detailed explanation for why #interrupt-cells differs
>  - Add andestech,nceplic100 as a fallback compatible
>  - Separate the conditional part of the binding into two blocks (one 
> for
>    the PLIC implementation and the other for the SoC integration)
>  - Use a quirk bit for selecting the flow instead of a variant ID
>  - Use the andestech,nceplic100 compatible to select the new behavior
>  - Use handle_edge_irq instead of handle_fasteoi_ack_irq so .irq_ack
>    always gets called
>  - Do not set the handler name, as RISC-V selects 
> GENERIC_IRQ_SHOW_LEVEL
>  - Use the same name for plic_edge_chip as plic_chip
> 
> Changes in v2:
>  - Fixed review comments pointed by Marc and Krzysztof.
> 
> Changes in v1:
>  - Fixed review comments pointed by Rob and Geert.
>  - Changed implementation for EDGE interrupt handling on Renesas 
> RZ/Five
>    SoC.
> 
> Lad Prabhakar (2):
>   dt-bindings: interrupt-controller: sifive,plic: Document Renesas
>     RZ/Five SoC
>   irqchip/sifive-plic: Add support for Renesas RZ/Five SoC
> 
> Samuel Holland (2):
>   dt-bindings: interrupt-controller: Require trigger type for T-HEAD
>     PLIC
>   irqchip/sifive-plic: Fix T-HEAD PLIC edge trigger handling
> 
>  .../sifive,plic-1.0.0.yaml                    | 65 +++++++++++++--
>  drivers/irqchip/irq-sifive-plic.c             | 80 +++++++++++++++++--
>  2 files changed, 135 insertions(+), 10 deletions(-)

I'm going to provisionally queue this into -next so that it
can get some testing. I'd still want the DT changes to be
Ack'ed before the next merge window though.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
