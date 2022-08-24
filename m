Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F8F59F06A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 02:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbiHXAqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 20:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbiHXAq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 20:46:28 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D47586B65;
        Tue, 23 Aug 2022 17:46:27 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h5so18070869wru.7;
        Tue, 23 Aug 2022 17:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=XGaQkMUxyNcihNRKJRLiIaRtaN1b1CuxNyHRTtmolkM=;
        b=kUqxJzNVKYfqKUDMRKI8VVAC+gyu48N1ltCtB3CEPciKXABCOLq7ugr6gCvnI48uO9
         D6imX3IQ/sPcslARwJzPrzLjYxUboqjS0W0TxJQE9YGSr5u5TbLtX3G0kHF1n+k52XaS
         axHOVIzGKc9NqQAyjQQ2NyDBGOvqtxdFaySWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=XGaQkMUxyNcihNRKJRLiIaRtaN1b1CuxNyHRTtmolkM=;
        b=g+T4wCpzlTEeHqB2Cf0MQmgt05Csaqkhn+Hd3i9XvHCeSJ+PJrGHJqPwHahi3W9yD5
         ALuqDVsy4YDEaPhNvHs9V5JmQBoqm8KMpcr2DAhQVOMydwCu3w9CEFHa8Y/qdZL0vvxd
         KwLcRDviy75bkAG8FFZjUcQ05gSRXPN5bAyFh1Og39yL7CxGF+6hHlnLKPMmBrJePTiO
         /yUbtohlwbpVZFhKOsjXctQUDUirwPqoxRSuvPcLmCtDFtBlnaWA7pWrJDLDyxhyoYaG
         W14DZ8ZqPLLMfW/6gajz4WPWsa8peTfcoep5pOq2nb1vFUJ7ctT5RnubpSnNmQka+iwY
         jvUg==
X-Gm-Message-State: ACgBeo2s3qaEo6J3pFLUHyiz0eWe+P3jovRrcoKv7UikLzuZnvTKjYM8
        am32VlPdxeY0zr68lmNzNcnie+tMsP0HsxnbGRbFAZ7HViNZRA==
X-Google-Smtp-Source: AA6agR7fuYY9EZSN0oIP//lfh/BqtJq0jICtYK+RauIjd9N8/v0xxKlLpD1fH0FuztD8gB30kSvbc30iqADMMDyJiMU=
X-Received: by 2002:a05:6000:1c0c:b0:225:569c:dd2c with SMTP id
 ba12-20020a0560001c0c00b00225569cdd2cmr7029200wrb.628.1661301985880; Tue, 23
 Aug 2022 17:46:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220819094905.1962513-1-chin-ting_kuo@aspeedtech.com>
In-Reply-To: <20220819094905.1962513-1-chin-ting_kuo@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 24 Aug 2022 00:46:13 +0000
Message-ID: <CACPK8XfeocBz6phbYyuHHMmZhisw5kGr3QpkdWv3LocvAN=WsA@mail.gmail.com>
Subject: Re: [PATCH] watchdog: aspeed_wdt: Reorder output signal register configuration
To:     Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, andrew@aj.id.au,
        BMC-SW@aspeedtech.com, linux-watchdog@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, Bonnie_Lo@wiwynn.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2022 at 09:49, Chin-Ting Kuo
<chin-ting_kuo@aspeedtech.com> wrote:
>
> If the output driving type is push-pull mode, the output
> polarity should be selected in advance. Otherwise, an unexpected
> value will be output at the moment of changing to push-pull mode.
> Thus, output polarity, WDT18[31], must be configured before
> changing driving type, WDT18[30].
>
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>

Thanks Chin-Ting.

Fixes: 012c04601f9d ("watchdog: aspeed: Support configuration of
external signal properties")
Reviewed-by: Joel Stanley <joel@jms.id.au>

I wonder if any of these machines hit the bug:

$ git grep -l aspeed,ext-push-pull arch/arm/boot/dts/
arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts
arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts


> ---
>  drivers/watchdog/aspeed_wdt.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index 436571b6fc79..a03e4ff812a2 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -325,18 +325,18 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>                 u32 reg = readl(wdt->base + WDT_RESET_WIDTH);
>
>                 reg &= config->ext_pulse_width_mask;
> -               if (of_property_read_bool(np, "aspeed,ext-push-pull"))
> -                       reg |= WDT_PUSH_PULL_MAGIC;
> +               if (of_property_read_bool(np, "aspeed,ext-active-high"))
> +                       reg |= WDT_ACTIVE_HIGH_MAGIC;
>                 else
> -                       reg |= WDT_OPEN_DRAIN_MAGIC;
> +                       reg |= WDT_ACTIVE_LOW_MAGIC;
>
>                 writel(reg, wdt->base + WDT_RESET_WIDTH);
>
>                 reg &= config->ext_pulse_width_mask;
> -               if (of_property_read_bool(np, "aspeed,ext-active-high"))
> -                       reg |= WDT_ACTIVE_HIGH_MAGIC;
> +               if (of_property_read_bool(np, "aspeed,ext-push-pull"))
> +                       reg |= WDT_PUSH_PULL_MAGIC;
>                 else
> -                       reg |= WDT_ACTIVE_LOW_MAGIC;
> +                       reg |= WDT_OPEN_DRAIN_MAGIC;
>
>                 writel(reg, wdt->base + WDT_RESET_WIDTH);
>         }
> --
> 2.25.1
>
