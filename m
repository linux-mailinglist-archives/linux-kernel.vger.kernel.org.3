Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0821659CD39
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 02:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239129AbiHWAar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 20:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbiHWAap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 20:30:45 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E074B483
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 17:30:43 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so5601386wmk.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 17:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=UUy7pFiuNHxxZ+gAKVDwyFup/IAsLQHlSSFpnTX7fgM=;
        b=fPUcRTa30JuAaTDPsCNaPlBbMh4qBfIqEwARHGAmw260OXHFvZm5IlNlItlySOO9BC
         zlh3BfXL+8F2Tq+l9UUvf3iX3+YLOXG1fRbz5FjhjUHxIQIXQsuonv/ijkCAgj+iCL2a
         Hwq00HLFPLhDIuxCVUN4lddoVrotvJTzUcarw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=UUy7pFiuNHxxZ+gAKVDwyFup/IAsLQHlSSFpnTX7fgM=;
        b=scPxAo/6cwCprjRHrDdLETXbzPFCYbLG48hphk2lyqOun+s45mcWoplQ7Cko7AJ+0j
         kIU2RJLmc53Eqz2SxmqDdWWH12gOsQs04fQR/iHTU8Ajeq/GOmfzJECEfplyj4r/wRKN
         iAYz8rrc8RZp5SMwkuUhHmtVbxF95idnIGIOwqihVMkoHF4oFonvBDP6D6buSGihqXUb
         6ZD82DSYyoZK/33Bqf5ROx4nuA0iTOg+0s1H4KaiZgQ5223S0a8u2GPi/48BRo7W45f3
         Y2AGSgHMd5NxOWt+jPmJIy70I88OcPXXFfQH6GaUuw2xxbjBArR9coW7PwnaMfMQIgSs
         LYZw==
X-Gm-Message-State: ACgBeo3+XmaE/28J1/l8Dyh4Tgjkhm4mX89VKE3kyH0tzIzhUwaNeQdp
        JdPon/KRV/hUD9aB0X8h81WyqfMAeE89jJuK7Gg=
X-Google-Smtp-Source: AA6agR7OTP6PMQ2t9lcuBSj1FFNbSPo+MEVjTKZAblWZjVImfq1Ms2uZmY4lKQoSF42B8mM8lUDv2SZQZd1zbz8SNoI=
X-Received: by 2002:a05:600c:1990:b0:3a6:2a00:3ddb with SMTP id
 t16-20020a05600c199000b003a62a003ddbmr458666wmq.72.1661214642422; Mon, 22 Aug
 2022 17:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1661094034.git.i.kononenko@yadro.com> <f9814f62fe2d6b6c21400ee3c83e46e61e0c72d1.1661094034.git.i.kononenko@yadro.com>
In-Reply-To: <f9814f62fe2d6b6c21400ee3c83e46e61e0c72d1.1661094034.git.i.kononenko@yadro.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 23 Aug 2022 00:30:30 +0000
Message-ID: <CACPK8XenuLrB-iOCo57FjeoOdEieHyxSM2ZM-X73AfP3fq3r+g@mail.gmail.com>
Subject: Re: [PATCH 2/3] drivers/misc: (aspeed-lpc-snoop): Add regmap cleanup
 on a shutdown.
To:     Igor Kononenko <i.kononenko@yadro.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Aug 2022 at 15:54, Igor Kononenko <i.kononenko@yadro.com> wrote:
>
> The bmc might be rebooted while the host is still reachable and the host
> might send requests through configured lpc-kcs channels in same time.
> That leads to raise lpc-snoop interrupts that haven't adjusted IRQ
> handlers on next early kernel boot, because on the aspeed-chip reboot
> might keep registers on a unclean state that is configured on the last
> boot.
>
> The patch brings an way to masking lpc-snoop interrupts all through
> a bmc-rebooting time.
>
> Tested on a YADRO VEGMAN N110 stand.
>
> Signed-off-by: Igor Kononenko <i.kononenko@yadro.com>
> ---
>  drivers/soc/aspeed/aspeed-lpc-snoop.c | 44 +++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> index eceeaf8dfbeb..6ec47bf1dc6b 100644
> --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> @@ -235,6 +235,41 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
>         return rc;
>  }
>
> +static void aspeed_lpc_reset_regmap(struct aspeed_lpc_snoop *lpc_snoop)
> +{
> +       u8 index;
> +       struct lpc_regman_cleanup {
> +               u32 offset;
> +               u32 mask;
> +               u8 val;
> +       };
> +       static struct lpc_regman_cleanup cleanup_list[] = {
> +               // Prevent handling ENINIT_SNPxW
> +               { .offset = HICR5,
> +                 .mask = HICR5_EN_SNP0W | HICR5_ENINT_SNP0W,
> +                 .val = 0 },
> +               { .offset = HICR5,
> +                 .mask = HICR5_EN_SNP1W | HICR5_ENINT_SNP1W,
> +                 .val = 0 },
> +               { .offset = HICRB,
> +                 .mask = HICRB_ENSNP0D | HICRB_ENSNP1D,
> +                 .val = 0 },
> +               // Reset SNOOP channel IRQ status
> +               { .offset = HICR6,
> +                 .mask = HICR6_STR_SNP0W | HICR6_STR_SNP1W,
> +                 .val = 1 },
> +       };
> +       for (index = 0; index < ARRAY_SIZE(cleanup_list); index++) {

Did you consider open coding the various updates instead of using a
for loop? I don't think the for loop help us here.

You could instead make these three updates:

/* Prevent handling ENINIT_SNPxW */
regmap_clear_bits(lpc_snoop->regmap, HICR5,
                                  HICR5_EN_SNP0W | HICR5_ENINT_SNP0W |
HICR5_EN_SNP1W | HICR5_ENINT_SNP1W);

regmap_clear_bits(lpc_snoop->regmap, HICRB,
                               HICRB_ENSNP0D | HICRB_ENSNP1D);

/* Reset SNOOP channel IRQ status */
regmap_set_bits(lpc_snoop->regmap, HICR6,
                            HICR6_STR_SNP0W | HICR6_STR_SNP1W);



> +               u32 val = 0;
> +
> +               if (cleanup_list[index].val)
> +                       val = cleanup_list[index].mask;
> +               regmap_update_bits(lpc_snoop->regmap,
> +                                  cleanup_list[index].offset,
> +                                  cleanup_list[index].mask, val);
> +       }
> +}
> +
>  static void aspeed_lpc_disable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
>                                      int channel)
>  {
> @@ -285,6 +320,7 @@ static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
>                 return -ENODEV;
>         }
>
> +       aspeed_lpc_reset_regmap(lpc_snoop);
>         dev_set_drvdata(&pdev->dev, lpc_snoop);
>
>         rc = of_property_read_u32_index(dev->of_node, "snoop-ports", 0, &port);
> @@ -345,6 +381,13 @@ static int aspeed_lpc_snoop_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +static void aspeed_lpc_snoop_shutdown(struct platform_device *pdev)
> +{
> +       struct aspeed_lpc_snoop *lpc_snoop = dev_get_drvdata(&pdev->dev);
> +
> +       aspeed_lpc_reset_regmap(lpc_snoop);
> +}
> +
>  static const struct aspeed_lpc_snoop_model_data ast2400_model_data = {
>         .has_hicrb_ensnp = 0,
>  };
> @@ -370,6 +413,7 @@ static struct platform_driver aspeed_lpc_snoop_driver = {
>         },
>         .probe = aspeed_lpc_snoop_probe,
>         .remove = aspeed_lpc_snoop_remove,
> +       .shutdown = aspeed_lpc_snoop_shutdown,
>  };
>
>  module_platform_driver(aspeed_lpc_snoop_driver);
> --
> 2.25.1
>
