Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC03580657
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236863AbiGYVVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbiGYVVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:21:34 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED37C1C113;
        Mon, 25 Jul 2022 14:21:33 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z18so3247646edb.10;
        Mon, 25 Jul 2022 14:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NOH91MiZSkF2YO00YePVnFm+Af2B5FjN1XDIKq1x0N4=;
        b=dIrmlfv5M2mdxPn4g9hE2TIxEyrfiC14kGTfWybm5gW0hRhCM43lWlJ9XLB18BGKgv
         nF1LBJeY6CcAT42Jw0xRR90su+vOigT5Zv7CqeqjWn2pJl+q4qiQ9lfDn0lAsp824jdz
         gK4G6A9p2w+iyqakTLJZV2+2BpxBigjYvB+K68iUnZ5azX++W3SFBHM+ucY764yuOzpo
         6h8dnXETvvDcovgDPscUg0XMUxP59RG7B8ZEQya8h+QCb/MKBqFacf2PQxXlgDduSF/R
         5lOnAT960Ehsx9p6sMll2CXgds/7MBF606XwlCdKQcfuZJ8HzTa/asjvT7/C+0YF62yM
         7qIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NOH91MiZSkF2YO00YePVnFm+Af2B5FjN1XDIKq1x0N4=;
        b=RpN1WCFReUJQ01bPVztfgZrozdw3KOvNmin1Up1kXYPsJoa+fO7iNFmNj9Qcy2OgQF
         AVMv/pbJSqUza6s5/NP9v3ASIG4JMyJyPeZktoIwNiaDScfd7uEjVBkVaRE/yZyQsjAp
         +yl1viGPlyi5oql3OFKIe40dZdAEwHQSBPXGCoRD/Lu9hOh4Ov1hdDZH3Qpt6qDRu9I8
         auRDVjcnk75f+XYBOwSrH58GgBUxhZEDCPnePMnfBXl633r1mYA3LoRhmCmE8oRZK0JJ
         eB54jeP/qMPIeXDny1u5OVgppPrKgfOIQzYL4hsshrz0kiAwToc8KLvj2GXhfkC4swSc
         oeOw==
X-Gm-Message-State: AJIora9nf+gRNX2mlinahMLdU6Om80mCOeyeOtPWYMWD3yJAl1LlInu1
        02WCjgjjMkPpNIkd6wGHXzywhJcTAIaKgbpnTpU=
X-Google-Smtp-Source: AGRyM1v3t0clX13p9/r7yj3ysKAgxa8d0XddjTv5svTAMh5QvLmquJFDnJfiFyWtcjo1zQTSv9mBVDJFwyvOjqLCU+M=
X-Received: by 2002:a05:6402:5c8:b0:433:545f:a811 with SMTP id
 n8-20020a05640205c800b00433545fa811mr15300442edx.101.1658784092374; Mon, 25
 Jul 2022 14:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220724164316.68393-1-matti.lehtimaki@gmail.com>
In-Reply-To: <20220724164316.68393-1-matti.lehtimaki@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jul 2022 23:20:55 +0200
Message-ID: <CAHp75VeJtorTzV-dmxgJz+UD4gTWY1v67U0iU5nZ1pR36W9tMg@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: st_sensors: Retry ID verification on failure
To:     =?UTF-8?Q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 6:54 PM Matti Lehtim=C3=A4ki
<matti.lehtimaki@gmail.com> wrote:
>
> Some sensors do not always start fast enough to read a valid ID from
> registers at first attempt. Let's retry at most 3 times with short sleep
> in between to fix random timing issues.

...

> +               for (i =3D 0; i < VERIFY_ID_RETRY_COUNT; i++) {
> +                       err =3D regmap_read(sdata->regmap,
> +                                         sdata->sensor_settings->wai_add=
r, &wai);
> +
> +                       if (!err && sdata->sensor_settings->wai =3D=3D wa=
i)
> +                               return 0;
> +
> +                       msleep(20);

NIH regmap_read_poll_timeout()


> +               }

--=20
With Best Regards,
Andy Shevchenko
