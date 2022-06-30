Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AA456273C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 01:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbiF3XoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 19:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiF3XoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 19:44:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61406326DE;
        Thu, 30 Jun 2022 16:43:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 156ECB82CD4;
        Thu, 30 Jun 2022 23:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA99CC341D1;
        Thu, 30 Jun 2022 23:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656632635;
        bh=eyoIxjqXwe6a+k27angKqff/ZHeX4NCkAQUMfqeZnqs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h5pGmyR+BbEGhmec0pYuj5FrqsKLM4mTaPUTeh/LkgythWvwsfHnMHjUjzSgqvVLr
         gK4pOVOaDNGsN1gO7ns+6d9TW5TDoA237eu822yv8FmZSgTzxbaX+KBOSgbW6670lp
         sHUHhZD1bWTPxqJjHfM0thUM7/MSDi/5rbXEjE6dbzevPYEmyxRZ6gW4dqRfTvoEHR
         vrY+Ve8wxpdiIuVSgrR/KRDvSMJK4IEOOHVXLIfXPw0MTuoe3wS7h/qwG8PrKWWymJ
         Rmw2c0jxGSg5Rtkm2kE33/L4t5AaEdo5iKeTvOxo0zr+2M24MNNH4+607We3rH3FAN
         gzB9IoZUq4aPw==
Received: by mail-vs1-f48.google.com with SMTP id d187so761541vsd.10;
        Thu, 30 Jun 2022 16:43:55 -0700 (PDT)
X-Gm-Message-State: AJIora+hbezt1jbqiQONCNEq2jLndR/98WxvWXMj2bWl4HhkBNT5xPwB
        wdP3hEfPTQrYk0km57Z9Qa1GWnVzHXsnsSmGkII=
X-Google-Smtp-Source: AGRyM1uEB5FFrm+HdwYN5uiyj6I1oWB4vU5B6wSiitayditj5pSvoL87RU0uu+at6zQuX+F9vEQynXsbmQKJ9eeWyao=
X-Received: by 2002:a05:6102:f8b:b0:354:57e8:4c1b with SMTP id
 e11-20020a0561020f8b00b0035457e84c1bmr10760309vsv.8.1656632634620; Thu, 30
 Jun 2022 16:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220630100241.35233-1-samuel@sholland.org> <20220630100241.35233-5-samuel@sholland.org>
In-Reply-To: <20220630100241.35233-5-samuel@sholland.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 1 Jul 2022 07:43:43 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRm656yG0qaksQ47oozKhiJ6aSCgy1u721+59Wu8Sb=Ng@mail.gmail.com>
Message-ID: <CAJF2gTRm656yG0qaksQ47oozKhiJ6aSCgy1u721+59Wu8Sb=Ng@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] irqchip/sifive-plic: Fix T-HEAD PLIC edge trigger handling
To:     Samuel Holland <samuel@sholland.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Thu, Jun 30, 2022 at 6:02 PM Samuel Holland <samuel@sholland.org> wrote:
>
> The T-HEAD PLIC ignores additional edges seen while an edge-triggered
> interrupt is being handled. Because of this behavior, the driver needs
> to complete edge-triggered interrupts in the .irq_ack callback before
> handling them, instead of in the .irq_eoi callback afterward. Otherwise,
> it could miss some interrupts.
>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>
> Changes in v3:
>  - Rebased on top of the RZ/Five patches
>
>  drivers/irqchip/irq-sifive-plic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index 90e44367bee9..b3a36dca7f1b 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -474,7 +474,6 @@ static int __init plic_init(struct device_node *node,
>
>  IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
>  IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
> -IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_init); /* for firmware driver */
>
>  static int __init plic_edge_init(struct device_node *node,
>                                  struct device_node *parent)
> @@ -483,3 +482,4 @@ static int __init plic_edge_init(struct device_node *node,
>  }
>
>  IRQCHIP_DECLARE(andestech_nceplic100, "andestech,nceplic100", plic_edge_init);
> +IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_edge_init);
> --
> 2.35.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
