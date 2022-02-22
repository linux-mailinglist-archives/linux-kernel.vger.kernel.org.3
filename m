Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB264C04CB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 23:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbiBVWmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 17:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbiBVWl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 17:41:56 -0500
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66A512859F;
        Tue, 22 Feb 2022 14:41:29 -0800 (PST)
Received: by mail-oo1-f54.google.com with SMTP id i10-20020a4aab0a000000b002fccf890d5fso19766225oon.5;
        Tue, 22 Feb 2022 14:41:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rPId1Out0wm+HHqPU053cmwRwdP07g4lwxXmiuigjpA=;
        b=UHpmL9/OialVJRPyPj/JbtBD/Z4MIUNIgteiE4xmlQULqilNSXTJcXgMcyfK7Fz6aH
         aSo5oeoYQbHTCsoax3fucimjYghuGC3BDLCxnatiMh5hVXoUM9Xd7vo6V6oMWyXLvRx8
         hxUlEV8qkKLRvgnI35zGz3sR1yYG23Ro10Ui2V6SM4ePlROdO+sSgLIq0WNW9CeO4znW
         E/Z/8j2lPocXw2nhnzX3KNu9y1QU0sCCOafoulCsFMo2Ij4v91hm8I/z85TKD94Kdcpl
         Qv29ew2vUjHM4xGrtfzDb9nywSpS3SLl1s5sjVUmMo6uNc7fVOL8lTPcIwRnFl1ZFKZs
         FQxw==
X-Gm-Message-State: AOAM533fMOhRGwpQc6nl+slK8HrIGJaBTv1VE/7a+RTg18BgcPYcprW3
        RVh0F6UeuorRyVOJ0hdA2w==
X-Google-Smtp-Source: ABdhPJz9Cv6rtk5Ogd0dXe8KzsFKukcAHRwgYgJX5SpwdhLEjt4dpr2VrviaIMfkpv3AEYKl7G6quA==
X-Received: by 2002:a05:6870:5b13:b0:ce:c0c9:6ee with SMTP id ds19-20020a0568705b1300b000cec0c906eemr2772725oab.320.1645569689205;
        Tue, 22 Feb 2022 14:41:29 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j2sm4836404ooi.39.2022.02.22.14.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:41:28 -0800 (PST)
Received: (nullmailer pid 3727703 invoked by uid 1000);
        Tue, 22 Feb 2022 22:41:27 -0000
Date:   Tue, 22 Feb 2022 16:41:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] of/irq: Use interrupts-extended to find parent
Message-ID: <YhVml6hUqiS2tAmG@robh.at.kernel.org>
References: <20220216022040.61532-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216022040.61532-1-samuel@sholland.org>
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

On Tue, Feb 15, 2022 at 08:20:39PM -0600, Samuel Holland wrote:
> Some OF irqchips, such as the RISC-V PLIC, use interrupts-extended to
> specify their parent domain(s). That binding does not allow using the
> interrupt-parent property in the irqchip node, which prevents
> of_irq_init from properly detecting the irqchip hierarchy.
> 
> If no interrupt-parent property is present in the enclosing bus or root
> node, then desc->interrupt_parent will be NULL for both the per-CPU
> RISC-V INTCs (the actual root domains) and the RISC-V PLIC. Similarly,
> if the bus or root node specifies `interrupt-parent = <&plic>`, then
> of_irq_init will hit the `desc->interrupt_parent == np` check, and again
> all parents will be NULL. So things happen to work today for some boards
> due to Makefile ordering.
> 
> However, things break when another irqchip ("foo") is stacked on top of
> the PLIC. The bus/root node will have `interrupt-parent = <&foo>`,
> since that is what all of the other peripherals need. When of_irq_init
> runs, it will try to find the PLIC's parent domain. But because
> of_irq_find_parent ignores interrupts-extended, it will fall back to
> using the interrupt-parent property of the PLIC's parent node (i.e. the
> bus or root node), and see "foo" as the PLIC's parent domain. But this
> is wrong, because "foo" is actually the PLIC's child domain!
> 
> So of_irq_init wrongly attempts to init the stacked irqchip before the
> PLIC. This fails and breaks boot.
> 
> Fix this by having of_irq_find_parent return the first node referenced
> by interrupts-extended when that property is present. Even if the
> property references multiple different IRQ domains, this will still work
> reliably in of_irq_init as long as all referenced domains are the same
> distance away from some root domain (e.g. the RISC-V INTCs referenced by
> the PLIC's interrupts-extended are always all root domains).
> 
> Acked-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
> Changes in v2:
>  - Add comments noting the assumptions made here
> 
>  drivers/of/irq.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index 2b07677a386b..c7d14f5c4660 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -60,7 +60,12 @@ struct device_node *of_irq_find_parent(struct device_node *child)
>  		return NULL;
>  
>  	do {
> -		if (of_property_read_u32(child, "interrupt-parent", &parent)) {
> +		/*
> +		 * interrupts-extended can reference multiple parent domains.
> +		 * This only returns the first one.
> +		 */
> +		if (of_property_read_u32(child, "interrupt-parent", &parent) &&
> +		    of_property_read_u32(child, "interrupts-extended", &parent)) {
>  			p = of_get_parent(child);

of_irq_find_parent() fundamentally works with interrupt-parent. 
'Finding' the parent just doesn't make sense for 'interrupts-extended' 
because it is explicit. Other than the comment, what gets returned in 
the case of 'interrupts-extended' is ambiguous.

Also, this will walk parent nodes to find 'interrupts-extended'. While 
that's somewhat unlikely to occur, it is not what you want.

Instead, just check 'interrupts-extended' within of_irq_init() and 
then fallback to calling of_irq_find_parent(). Then the ambiguous 
nature of only looking at the 1st entry is in one place. (And more 
easily fixed if we ever need all the parents.)

Rob
