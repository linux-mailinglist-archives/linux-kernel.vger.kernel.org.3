Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8ED54470F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241129AbiFIJPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240651AbiFIJPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:15:37 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B1C19299;
        Thu,  9 Jun 2022 02:15:36 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id 15so12107785qki.6;
        Thu, 09 Jun 2022 02:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7nTBBYryHSMMkovXdmbTlpzxYn9tgvrwGD6VKVeo3rI=;
        b=LoPFjriZuXVeF6lAFuiPtTPyJsMwMV8M0jL/9Bi+Y6fM8OdXNZEYjjTUXGDFmLJHgQ
         eVca2xutLCtB8ivo++3Pm/Tml/sVdj56aunh2mcfgxadONm3vrbaEnSZIsbo8SZxqq9r
         gixR59ohG5E24FSCTbZjpIiqkZzZr5UEV0auMyPXUsb33l9JaXVa5r9c+S6epo0YMDcR
         0jvk70J0a7+47wDMHGWoCyGBdzoc+9QwzvhdDuEuWg7fbHK/ff/NUYYsuGWPkDHSsD1i
         v/StmyAuYsB2PCgfPWUgC3JKtfT81Z4tcBcNMatr+EpvwyN1taFNoj4+pfjxZjO2JveF
         q1Iw==
X-Gm-Message-State: AOAM531XLG1ZDcQSprnVTC9QnqS9bFNv687e8kTude97Q/eVRj6m9Hxj
        lk6lmgj32Z2S/88QTtAaUzbnMCWR5h6UtQ==
X-Google-Smtp-Source: ABdhPJz/1We6QwUuziB5GoCh/cgmeXDc1kek5l623fMSL0phV7X5WWvw8bjtUA4ICwG4gZz3y4+maw==
X-Received: by 2002:a05:620a:125a:b0:6a6:bfab:5c45 with SMTP id a26-20020a05620a125a00b006a6bfab5c45mr13277299qkl.736.1654766135283;
        Thu, 09 Jun 2022 02:15:35 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id v12-20020a05620a440c00b006a6a904c0a5sm6102817qkp.107.2022.06.09.02.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 02:15:34 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id r3so6569563ybr.6;
        Thu, 09 Jun 2022 02:15:34 -0700 (PDT)
X-Received: by 2002:a25:d748:0:b0:65c:6b00:55af with SMTP id
 o69-20020a25d748000000b0065c6b0055afmr37699311ybg.365.1654766134128; Thu, 09
 Jun 2022 02:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220525151216.24133-1-wsa+renesas@sang-engineering.com> <20220525151216.24133-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220525151216.24133-2-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 9 Jun 2022 11:15:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWEzhE8aAfsDRpzpv=ZFLb7Cn0r-En0K6O7heT6OA1JEA@mail.gmail.com>
Message-ID: <CAMuHMdWEzhE8aAfsDRpzpv=ZFLb7Cn0r-En0K6O7heT6OA1JEA@mail.gmail.com>
Subject: Re: [PATCH 2/2] thermal: rcar_gen3_thermal: improve logging during probe
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Wed, May 25, 2022 at 7:07 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> When setting up a new board, a plain "Can't register thermal zone"
> didn't help me much because the thermal zones in DT were all fine. I
> just had a sensor entry too much in the parent TSC node. Reword the
> failure/success messages to contain the sensor number to make it easier
> to understand which sensor is affected. Example output now:
>
> rcar_gen3_thermal e6198000.thermal: Sensor 0: Trip points loaded: 1
> rcar_gen3_thermal e6198000.thermal: Sensor 1: Trip points loaded: 1
> rcar_gen3_thermal e6198000.thermal: Sensor 2: Trip points loaded: 1
> rcar_gen3_thermal e6198000.thermal: Sensor 3: Can't register thermal zone
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for your patch!

> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -511,7 +511,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>                 zone = devm_thermal_zone_of_sensor_register(dev, i, tsc,
>                                                             &rcar_gen3_tz_of_ops);
>                 if (IS_ERR(zone)) {
> -                       dev_err(dev, "Can't register thermal zone\n");
> +                       dev_err(dev, "Sensor %u: Can't register thermal zone\n", i);

LGTM.

>                         ret = PTR_ERR(zone);
>                         goto error_unregister;
>                 }
> @@ -533,7 +533,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>                 if (ret < 0)
>                         goto error_unregister;
>
> -               dev_info(dev, "TSC%u: Loaded %d trip points\n", i, ret);
> +               dev_info(dev, "Sensor %u: Trip points loaded: %u\n", i, ret);

I actually prefer the old wording (I'm undecided about "sensor" vs.
"TSC", though, but consistency rules), as it makes it clear "ret"
is the number of trip points, and not a success code.

>         }
>
>         if (!priv->num_tscs) {

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
