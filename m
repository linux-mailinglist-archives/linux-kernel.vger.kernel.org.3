Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E685A276C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 14:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236634AbiHZMJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 08:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiHZMJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 08:09:09 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D26FDD4E9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 05:09:05 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id c93so1852143edf.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 05:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=YuVqmzQlgDLVeMfz82ukovg183Kkhpx5KS52wtbn28M=;
        b=W4bXSIoag6LWeTBh/1jxGm6x/QC46KeGlzkhseHYgvl+uWPMjtYe+8DM+CW1taOw12
         T70K3asPyqu992+teLnKyJ+m92T/XK+ZU+Ce21Js0/6uY9cHOHWupkjwscgpSLDqaPvI
         W3YVivSmqtEim7+0n1mXkmLpLvTLDv5LwosD6IDn7yCAymILfUrIUAblK0iG7taedcHs
         MCagWmIRyA1hSYdphZbJlZ56VrrS9zZ/osfmt21afOQYmxoF2RDMGW7WS5/UrL6lyerG
         Nv7UnHvqUxrjGgFitRiZJ+RWEfQMqI+S3j+/aqzZ+7BS8nnc0WavgY0yD4ov51Qv53jE
         MA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=YuVqmzQlgDLVeMfz82ukovg183Kkhpx5KS52wtbn28M=;
        b=yVWvuu3LMX94NCmx662bMIFBuVV2Hj5KW5B2gDYZxv70aJVmQhjibElXpj2AFKnKQM
         Jg6na5Ar/8FsN8z2J1vGFDWfzRqh5dyfvELUoQwWiSIZDO49WqIP3HO39vBEkS4zBSlN
         fNuYYioNvTrWZLh5NsL/yJE/pA6MCcM5HHEjUAysWKt+EpM33S/rSOWiSwvJkoNbHPpz
         8dybDZz+hD8aVoxkKyUiUtoAD/SthgL+XGlW++FH9C0rz86S8157ayTR9a4capmRXs7V
         JDfi6veIrQ6KbQ6airbZViCwndn3V28iZ3raUBAGV61Q7PsVHiiNoIAJcpZluviOoHpj
         tMfA==
X-Gm-Message-State: ACgBeo3OQFkD98YCN/KYB+KwMvsj+zjUrV44cz59ru8+o63ymgkEnOz/
        FmZk8ToBu4XO1XNY5K6WTAdc50GKzfkoqIc4ZZ9vvg==
X-Google-Smtp-Source: AA6agR476O7GEA2TkGTpeX6Bb/ZsYMhrYTgB5AMiHmoNlEeCfxhHq1Dpj97AC0YTY5eU4InIRfWYumB79jJnGtx6N8A=
X-Received: by 2002:aa7:d7c1:0:b0:447:d3ec:69cb with SMTP id
 e1-20020aa7d7c1000000b00447d3ec69cbmr3432665eds.105.1661515744171; Fri, 26
 Aug 2022 05:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220819060801.10443-1-jinpu.wang@ionos.com> <20220819060801.10443-8-jinpu.wang@ionos.com>
 <Ywi23cKqPcJEWxHB@Red>
In-Reply-To: <Ywi23cKqPcJEWxHB@Red>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Fri, 26 Aug 2022 14:08:53 +0200
Message-ID: <CAMGffEkBcxn9=2BKS=yHkbADWYrZh04b05kOGdRfCL+1zn1djw@mail.gmail.com>
Subject: Re: [PATCH v1 07/19] crypto: gemin: Fix error check for dma_map_sg
To:     LABBE Corentin <clabbe@baylibre.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 2:04 PM LABBE Corentin <clabbe@baylibre.com> wrote:
>
> Le Fri, Aug 19, 2022 at 08:07:49AM +0200, Jack Wang a =C3=A9crit :
> > dma_map_sg return 0 on error.
> >
> > Cc: Corentin Labbe <clabbe@baylibre.com>
> > Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: linux-crypto@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > ---
> >  drivers/crypto/gemini/sl3516-ce-cipher.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
>
> Hello
>
> There is a typo in subject gemin -> gemini.
indeed, maybe Herbert can fix the subject in his tree.
>
> Acked-by: Corentin Labbe <clabbe@baylibre.com>
> Tested-by: Corentin Labbe <clabbe@baylibre.com>
>
> Thanks
> Regards
Thx!
