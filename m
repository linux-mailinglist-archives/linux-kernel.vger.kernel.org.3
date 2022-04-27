Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6985115BE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiD0Kvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 06:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiD0Kve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 06:51:34 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CAA3AB7CF;
        Wed, 27 Apr 2022 03:22:57 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id ke5so733441qvb.5;
        Wed, 27 Apr 2022 03:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DFvDs4UX2zax4adbziwn0RYfIrK/tqgpmI5wyJl9xWk=;
        b=txl9N971Mitb19L/rporh9pX+gSFiofYsUEsWQqmAP8yoWcvMfaiKi0HoyXVykX9YZ
         +BVFExqw44qOaaUGTGPFgGsoZAAXlnhsT5fnc8/c3iMQJjWJ1gcKbNW5isoK/0ed9a1b
         mwZFgZW4D/xhp6dg6tRjHzCNE0fvbrW0PVeReKZ86PIzkjJ62+uQDDjd13yID1y7rgh0
         jh2EvZt07FXfG5Ifg0KIiw0NjqR5xgMV05b08n6HiwsVYmmC2NEeqmxF2inFogQrb/k6
         3lepXM4uGARxFNsaXcicxgi49dphhOZZPDSvttlPoIZYo7AzgPgLL26ZxY4aQDlUykCy
         abHA==
X-Gm-Message-State: AOAM530unhwEdaKc69mkv3lc8vhloUsAkN+WoZkhGEIadOmoln2zpnhq
        qFdW2V/89CK7ahJkCjNVzhtZt5Xkje/Fag==
X-Google-Smtp-Source: ABdhPJz6UTZZL4BURTn67KGPUyleLdhEDIehR5hbmEP7UX3/qw0Fi0yopLbmmzlkt/pHta1qP3CD8w==
X-Received: by 2002:a05:6214:248c:b0:441:2a61:659d with SMTP id gi12-20020a056214248c00b004412a61659dmr19331590qvb.59.1651054976735;
        Wed, 27 Apr 2022 03:22:56 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id q17-20020a05622a031100b002f1d478c218sm10090861qtw.62.2022.04.27.03.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 03:22:56 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-2f7bb893309so12858617b3.12;
        Wed, 27 Apr 2022 03:22:56 -0700 (PDT)
X-Received: by 2002:a81:8489:0:b0:2f7:edff:239f with SMTP id
 u131-20020a818489000000b002f7edff239fmr14119456ywf.256.1651054976217; Wed, 27
 Apr 2022 03:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210922091007.5516-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20210922091007.5516-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Apr 2022 12:22:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWJZM=-Py=W+qKUfCQU=Y5=G6qdp9uubNv56o+5JztaGA@mail.gmail.com>
Message-ID: <CAMuHMdWJZM=-Py=W+qKUfCQU=Y5=G6qdp9uubNv56o+5JztaGA@mail.gmail.com>
Subject: Re: [RFC PATCH] memory: renesas-rpc-if: Correct QSPI data transfer in
 Manual mode
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Wed, Sep 22, 2021 at 11:10 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> This patch fixes 2 problems:
> [1] The output warning logs and data loss when performing
> mount/umount then remount the device with jffs2 format.
> [2] The access width of SMWDR[0:1]/SMRDR[0:1] register is wrong.

Revisiting commit fff53a551db50f5e ("memory: renesas-rpc-if: Correct
QSPI data transfer in Manual mode") in  v5.16-rc1...

> --- a/drivers/memory/renesas-rpc-if.c
> +++ b/drivers/memory/renesas-rpc-if.c

>  int rpcif_manual_xfer(struct rpcif *rpc)
>  {
> -       u32 smenr, smcr, pos = 0, max = 4;
> +       u32 smenr, smcr, pos = 0, max = rpc->bus_size == 2 ? 8 : 4;
>         int ret = 0;
>
> -       if (rpc->bus_size == 2)
> -               max = 8;
> -
>         pm_runtime_get_sync(rpc->dev);
>
>         regmap_update_bits(rpc->regmap, RPCIF_PHYCNT,
> @@ -378,37 +424,36 @@ int rpcif_manual_xfer(struct rpcif *rpc)
>         regmap_write(rpc->regmap, RPCIF_SMOPR, rpc->option);
>         regmap_write(rpc->regmap, RPCIF_SMDMCR, rpc->dummy);
>         regmap_write(rpc->regmap, RPCIF_SMDRENR, rpc->ddr);
> +       regmap_write(rpc->regmap, RPCIF_SMADR, rpc->smadr);
>         smenr = rpc->enable;
>
>         switch (rpc->dir) {
>         case RPCIF_DATA_OUT:
>                 while (pos < rpc->xferlen) {
> -                       u32 nbytes = rpc->xferlen - pos;
> -                       u32 data[2];
> +                       u32 bytes_left = rpc->xferlen - pos;
> +                       u32 nbytes, data[2];
>
>                         smcr = rpc->smcr | RPCIF_SMCR_SPIE;
> -                       if (nbytes > max) {
> -                               nbytes = max;
> +
> +                       /* nbytes may only be 1, 2, 4, or 8 */
> +                       nbytes = bytes_left >= max ? max : (1 << ilog2(bytes_left));
> +                       if (bytes_left > nbytes)
>                                 smcr |= RPCIF_SMCR_SSLKP;
> -                       }
> +
> +                       smenr |= RPCIF_SMENR_SPIDE(rpcif_bits_set(rpc, nbytes));
> +                       regmap_write(rpc->regmap, RPCIF_SMENR, smenr);
>
>                         memcpy(data, rpc->buffer + pos, nbytes);
> -                       if (nbytes > 4) {
> +                       if (nbytes == 8) {
>                                 regmap_write(rpc->regmap, RPCIF_SMWDR1,
>                                              data[0]);
>                                 regmap_write(rpc->regmap, RPCIF_SMWDR0,
>                                              data[1]);
> -                       } else if (nbytes > 2) {
> +                       } else {
>                                 regmap_write(rpc->regmap, RPCIF_SMWDR0,
>                                              data[0]);
> -                       } else  {
> -                               regmap_write(rpc->regmap, RPCIF_SMWDR0,
> -                                            data[0] << 16);
>                         }
>
> -                       regmap_write(rpc->regmap, RPCIF_SMADR,
> -                                    rpc->smadr + pos);

Removing this implies SMADR is auto-incrementing for writes...

> -                       regmap_write(rpc->regmap, RPCIF_SMENR, smenr);
>                         regmap_write(rpc->regmap, RPCIF_SMCR, smcr);
>                         ret = wait_msg_xfer_end(rpc);
>                         if (ret)
> @@ -448,14 +493,16 @@ int rpcif_manual_xfer(struct rpcif *rpc)
>                         break;
>                 }
>                 while (pos < rpc->xferlen) {
> -                       u32 nbytes = rpc->xferlen - pos;
> -                       u32 data[2];
> +                       u32 bytes_left = rpc->xferlen - pos;
> +                       u32 nbytes, data[2];
>
> -                       if (nbytes > max)
> -                               nbytes = max;
> +                       /* nbytes may only be 1, 2, 4, or 8 */
> +                       nbytes = bytes_left >= max ? max : (1 << ilog2(bytes_left));
>
>                         regmap_write(rpc->regmap, RPCIF_SMADR,
>                                      rpc->smadr + pos);

... while keeping this assumes SMADR is not auto-incrementing for
reads?

Figure 62.17 "Example of Data Transfer Setting Flow in Manual Operating
Mode" does show writing SMADR in each loop iteration.
I cannot find anything about auto-incrementing in the documentation,
except for Figure 62.28 "Write Buffer Usage Sequence", which does
not apply as Linux does not support the write buffer yet.

Given you tested this, and the BSP commit 0d37f69cacb33435 ("memory:
renesas-rpc-if: Correct QSPI data transfer in Manual mode") does the
same, I assume it's working fine?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
