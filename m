Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0834F4FE7D6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 20:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358697AbiDLSX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 14:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbiDLSXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 14:23:49 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A645D64B;
        Tue, 12 Apr 2022 11:21:31 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-d6ca46da48so21586696fac.12;
        Tue, 12 Apr 2022 11:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I9K/IbA6njg/QBogrNbqGgrHZw9vf98X/iD1tq6MrZU=;
        b=O0UP0rLpyee8/U74KLDMSJTKFZIZaKmPv4EWTyP53yjzC2dkt77IqfUGtpndulFrWk
         fpfL6iOo/Fnif8xFbziMEnMbJnYIeKwCNg/JugsnGh8/LN7sIrrHSond8m3LZzDCXhxX
         vN9xtEYzmSc5O6VDB/U1XcEJj1NDslLYPS9qIszBb0ZC8nzsU6CkFsor3Xw0886ooVfY
         B6uXH8j/pA0pIfOLAWsIxq69DRIRM+FjlwdlO+/97+vEaFtRsae5qcOxRWTbwuittIbE
         kVUg/p0jtYTQ1FOS3a8kNcuZ1sT9Ss+G0MpKPcFPULopFlYMg4kxS1x0NeGDdTTsN1Tf
         fNxw==
X-Gm-Message-State: AOAM532vzEdQ86xSRStjmv3yMk+QiZrkcYtEnHUuhGCgBr/mKRuqq2uz
        LvsjNyBE7C+Xjsznx9PKMQ==
X-Google-Smtp-Source: ABdhPJwpHRJvNnM83ToUTv3S4bhcDhv4xGnfrj++Kx0/XfUfWlY1G9l0jnSkcRNRMsN4OqKnUnQN5w==
X-Received: by 2002:a05:6870:2197:b0:e2:a317:3d8 with SMTP id l23-20020a056870219700b000e2a31703d8mr2665045oae.162.1649787690571;
        Tue, 12 Apr 2022 11:21:30 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 65-20020aca0544000000b002f980b50140sm8860760oif.18.2022.04.12.11.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 11:21:30 -0700 (PDT)
Received: (nullmailer pid 572909 invoked by uid 1000);
        Tue, 12 Apr 2022 18:21:29 -0000
Date:   Tue, 12 Apr 2022 13:21:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Marc Zyngier <maz@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v3] of/irq: Use interrupts-extended to find parent
Message-ID: <YlXDKQld00eYlXdI@robh.at.kernel.org>
References: <20220412051529.6293-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412051529.6293-1-samuel@sholland.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Apr 2022 00:15:28 -0500, Samuel Holland wrote:
> The RISC-V PLIC binding uses interrupts-extended to specify its parent
> domain(s). That binding does not allow the interrupt-parent property to
> appear in the irqchip node. This prevents of_irq_init from properly
> detecting the irqchip hierarchy.
> 
> If no interrupt-parent property is present in the enclosing bus or root
> node, then desc->interrupt_parent will be NULL for both the per-CPU
> RISC-V INTC (the actual root domain) and the RISC-V PLIC. Similarly, if
> the bus or root node specifies `interrupt-parent = <&plic>`, then
> of_irq_init will hit the `desc->interrupt_parent == np` check, and again
> all parents will be NULL. So things happen to work today for some boards
> due to Makefile ordering.
> 
> However, things break when another irqchip ("foo") is stacked on top of
> the PLIC. The bus or root node will have `interrupt-parent = <&foo>`,
> since that is what all of the other peripherals need. When of_irq_init
> runs, it will try to find the PLIC's parent domain. of_irq_find_parent
> will fall back to using the interrupt-parent property of the PLIC's
> parent node (i.e. the bus or root node), and of_irq_init will see "foo"
> as the PLIC's parent domain. But this is wrong, because "foo" is
> actually the PLIC's child domain!
> 
> So of_irq_init wrongly attempts to init the stacked irqchip before the
> PLIC. This fails and breaks booting.
> 
> Fix this by using the first node referenced by interrupts-extended as
> the parent when that property is present. This allows of_irq_init to see
> the relationship between the PLIC and the per-CPU RISC-V INTC, and thus
> only the RISC-V INTC is (correctly) considered a root domain.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
> Changes in v3:
>  - Move the check into of_irq_init. Do not touch of_irq_find_parent.
> 
> Changes in v2:
>  - Add comments noting the assumptions made here
> 
>  drivers/of/irq.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 

Applied, thanks!
