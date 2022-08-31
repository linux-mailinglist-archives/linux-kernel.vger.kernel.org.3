Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5A25A80BE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiHaO5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiHaO4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:56:22 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6613BD399D;
        Wed, 31 Aug 2022 07:56:14 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-3378303138bso309561047b3.9;
        Wed, 31 Aug 2022 07:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=JtKb77zNdGsRJt2tSkl+rd9dzEha879rPA4FbQ4zhmU=;
        b=WuQII7iUZBVsy9e8duur0pmJ2mtebJ7AmHlsXVGy/0l7XmW9S8vCkFo7yYDd/EidCL
         Ua85m+GA9AgZf8LtfwPbbbm5md1IE39GErVtVvhLprgEVroM/a2udzWTplKoO09DAAbS
         e5yYGurmKxAZZFnyXQlzTXY5vLzDwaHCXYAoRhTlhsKwJStQAx0xCUT5lJl4+zMcjFdJ
         1tAuAh4nDmGoJrZ6oYrPU6oXUTQh7zZbg+pPqiKE02lsQ1LnV/F9r91ASd7zzx5SkBmO
         LF0/w7ghmRAizyAVa+g0j4pK78fFS0z/L82xjfyoPy4ySfYTB6db5ORBw5Xf3bS1Qfhm
         SFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=JtKb77zNdGsRJt2tSkl+rd9dzEha879rPA4FbQ4zhmU=;
        b=FvfyaG7sKLT4MOHa7ns+Unckex5UCYt4Ohgs1epzOu6qcSrtUrQFbS9PnGOpLfDMa/
         MruHXMyJEwOs7qjIimpH87ypBijpdLjPrB+oBEngXcyQScfcCp+13bAIFW7suoavZfxp
         dTK2aoXJjjeoYBxQlv2EUoInoxv4jktt24ehjOvhLSm8YaPKF+6X2Qh88iEElaipYkDE
         /c6NDvNZcSAkBQv8bGJWycZzR5kwHgtEXXaKkjn++fmBOFY8EQ2jmO2L9NGD+j5V3m25
         uJhB+PosjIhk8JZwi3kaznQNrKhiEO8jxQx0nZTh0xagikKQ6mGNNx1OSOubB9GivWCT
         dCpw==
X-Gm-Message-State: ACgBeo1Z08CgCcMFZ1R72eanTIDF8OonsYUd2vA+4Imsknqzq4oRk16j
        O5Ti8S2MSpQk+wQ9AuW/moY6R1Hvg+b8vLRQSOmH7jo38F4=
X-Google-Smtp-Source: AA6agR4jFVMzeiWKseL0yZv0p7X9A7hbGIUKQXcA7Dr0iVXdyF0ALkr9svl6rC76U15/2Wkql44cZAjsTDpDccy6S8M=
X-Received: by 2002:a81:49c3:0:b0:33e:da0a:cc8e with SMTP id
 w186-20020a8149c3000000b0033eda0acc8emr18426602ywa.382.1661957773138; Wed, 31
 Aug 2022 07:56:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220406072417.14185-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220406072417.14185-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 31 Aug 2022 15:55:45 +0100
Message-ID: <CA+V-a8sZ8prbLgvg3MbqztgijQn8ZQDX_zSm5Uj6eQ8wvd7EFg@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/renesas-ostm: Add support for RZ/V2L SoC
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Wed, Apr 6, 2022 at 8:24 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> The OSTM block is identical on Renesas RZ/G2L and RZ/V2L SoC's, so instead
> of adding dependency for each SoC's add dependency on ARCH_RZG2L. The
> ARCH_RZG2L config option is already selected by ARCH_R9A07G044 and
> ARCH_R9A07G054.
>
> With the above change OSTM will be enabled on RZ/V2L SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/clocksource/renesas-ostm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
This patch has not been merged yet.

Do you want me to resend it?

Cheers,
Prabhakar
