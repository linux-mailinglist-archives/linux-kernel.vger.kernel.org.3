Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4014D59CD2C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 02:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238718AbiHWAWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 20:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbiHWAWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 20:22:22 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5450B2715C
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 17:22:21 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k9so15133348wri.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 17:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Mz0byrLcRTsU0F5GvVr/+gvi7taYHKM3YuyQL8j7nNQ=;
        b=LOucV1wiHZHotBZZ9b5YkGXXXjfFuWz3ppGvlnqWCa7QIFMjgJeA9a0zrYU2ocFs8J
         oz0UkvhlzmPuoOfBVzzNc2QurNAXE8GsX6jxirfeN1og8baaJriiQiyHRPtTd0xJngBq
         4HJ+eHVkbmkeFpLSNpatKx68srJZ1gbmiZ7Ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Mz0byrLcRTsU0F5GvVr/+gvi7taYHKM3YuyQL8j7nNQ=;
        b=x/9oTDmY0QjlwEzWz37yIOipR7jq6gS8+1bTv4xzoSDOMswWqK5ICll9IVRuvYAI1G
         1cw7StrIJfAHeEmAti7GP8IrKprHMDBgd7oijItLEcXSfob0IuiUfa2WYzvwPlh/Qayu
         re8KyuvkmIkxr8BtAcbKt3juuY+nMWLjorPKzT2UO9Rw1wPvfpteLCpZjPrkJHwdvWze
         p6pq5195t0t8it747ZZjp0Nt7LHSUfP2fm8cUYkcPaBfLvTutq1buuqLE28kNUIwcRQN
         NQ9eBMGzmT+Peywr83yaBZqMcg5exZQRlw1Jaf6Fjd6/In5rREniE9ldHWnElK8TRa7j
         fnGQ==
X-Gm-Message-State: ACgBeo3O043JeQ4N6p15DQuOwNzkUrVHMXhxcaj0GQ0aI4M1LtbNfklx
        zHHEomwedcNOYErhO/BVCT0ArinI3unBkfu9JyE=
X-Google-Smtp-Source: AA6agR7Btjdk0SI6WHiOceolZFSYZ80nCvqqc97cKVSAbqPfqxJzMNT7rFnn8uI6otZfk9oS0BvZubzamgD7yOO/lTw=
X-Received: by 2002:a5d:6484:0:b0:225:55d8:d528 with SMTP id
 o4-20020a5d6484000000b0022555d8d528mr4561198wri.3.1661214139760; Mon, 22 Aug
 2022 17:22:19 -0700 (PDT)
MIME-Version: 1.0
References: <fb81dda34f9db0b9f743b247a2464576dcccd7c9.1661094034.git.i.kononenko@yadro.com>
 <ad3cd046c4dcb9169aaff6c0b739b23d0a06014d.1661149313.git.i.kononenko@yadro.com>
In-Reply-To: <ad3cd046c4dcb9169aaff6c0b739b23d0a06014d.1661149313.git.i.kononenko@yadro.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 23 Aug 2022 00:22:07 +0000
Message-ID: <CACPK8Xfe+hPLXcgwWxZtb5H_WG8GRJ7pLfRXG3jupk8ANc7wgQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ipmi:kcs_bmc: Add cleanup regmap(interrupt-regs)
 on a shutdown.
To:     Igor Kononenko <i.kononenko@yadro.com>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Corey Minyard <minyard@acm.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, kernel test robot <lkp@intel.com>
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

On Mon, 22 Aug 2022 at 06:36, Igor Kononenko <i.kononenko@yadro.com> wrote:
>
> The previos v1 [PATCH 1/3] have error of getting `struct kcs_bmc_device`
> pointer from `struct platform_device *`. Replaced to retriveing pointer by
> `platform_get_drvdata()`

Can we get a v3 with your original commit message added? You had a
good write up in v1 but it was dropped in v2.

This change looks like the right thing to do. We should get Andrew to
review too, as he spends more time with the KCS controllers.

The missed irq issue was seen with the other LPC sub drivers because
the clock wasn't enabled. We ended up with this patch:

https://lore.kernel.org/all/20201208091748.1920-1-wangzhiqiang.bj@bytedance.com/

Do we need to do something similar for KCS?

>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Igor Kononenko <i.kononenko@yadro.com>
> ---
>  drivers/char/ipmi/kcs_bmc_aspeed.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
> index cdc88cde1e9a..8437f3cfe3f4 100644
> --- a/drivers/char/ipmi/kcs_bmc_aspeed.c
> +++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
> @@ -636,6 +636,14 @@ static int aspeed_kcs_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +static void aspeed_kcs_shutdown(struct platform_device *pdev)
> +{
> +       struct aspeed_kcs_bmc *priv = platform_get_drvdata(pdev);
> +       struct kcs_bmc_device *kcs_bmc = &priv->kcs_bmc;
> +
> +       aspeed_kcs_irq_mask_update(kcs_bmc, (KCS_BMC_EVENT_TYPE_IBF), 0);
> +}
> +
>  static const struct of_device_id ast_kcs_bmc_match[] = {
>         { .compatible = "aspeed,ast2400-kcs-bmc-v2" },
>         { .compatible = "aspeed,ast2500-kcs-bmc-v2" },
> @@ -651,6 +659,7 @@ static struct platform_driver ast_kcs_bmc_driver = {
>         },
>         .probe  = aspeed_kcs_probe,
>         .remove = aspeed_kcs_remove,
> +       .shutdown = aspeed_kcs_shutdown,
>  };
>  module_platform_driver(ast_kcs_bmc_driver);
>
> --
> 2.25.1
>
