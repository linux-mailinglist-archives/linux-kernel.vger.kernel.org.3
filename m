Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCBB55E216
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344527AbiF1Jtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344511AbiF1JtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:49:00 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A9E2CDF0;
        Tue, 28 Jun 2022 02:48:55 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id cs6so19172817qvb.6;
        Tue, 28 Jun 2022 02:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qmsHjaT7nLNEUigJCn2XHg2FRw3Jceu7QHHPyWgnjqo=;
        b=g5JAVx8ZIm1q8Y7AknFfm7h6VYFxH09KkZoOBIfWOZKJTFYcos7Mj/2Ot0ksGUnq3J
         63pqG2OSuCnag4pUCj66FmuW+WlTlfH40MoBmmZ0v8Cb0uCp0k9dw/BNkFexGkAeU0jr
         k9G7IJ5+3bPd5nMDYnQFxJ7RKW97kvvLfZjfcFmY/2c3c3evUBNSJxxE6xk84NBdPpoy
         ZENdiMLHTK0i/R1L+TTaS9iekN6T5Jb+XZbLPKP4Vr4dPsdvOEZQDLtmNqg39uDthWhA
         JEf23U9Aoucfr0dA2S9L8VRWbD75K/2IIJV5fKLMBvcVf+UuVA4YMjnSCxB1y+n1MEb3
         cqpQ==
X-Gm-Message-State: AJIora8m/03PPZOzQvuyJL1als/Wtbq1uHJf5SWj82h/6vWAqcJZHwv0
        xKl9IHFqvCUf77vMg7ho/XFBV9QQRpM5Ew==
X-Google-Smtp-Source: AGRyM1vv8FMtgbhpCc3DfK5B3yHX8YT5E/HLbE1yPAxs+AAoNh0T3/m3lJxflo9ovLN6I7FlIC0sLA==
X-Received: by 2002:a05:622a:54a:b0:318:444c:d9cf with SMTP id m10-20020a05622a054a00b00318444cd9cfmr11919011qtx.646.1656409734082;
        Tue, 28 Jun 2022 02:48:54 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id s9-20020ac85289000000b00304efba3d84sm8748589qtn.25.2022.06.28.02.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 02:48:53 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id v185so11759474ybe.8;
        Tue, 28 Jun 2022 02:48:53 -0700 (PDT)
X-Received: by 2002:a05:6902:a:b0:65c:b38e:6d9f with SMTP id
 l10-20020a056902000a00b0065cb38e6d9fmr19354286ybh.36.1656409733344; Tue, 28
 Jun 2022 02:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220622181723.13033-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220622181723.13033-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220622181723.13033-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Jun 2022 11:48:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX-yE3MAR8ugEj6CZ5u-Bfv81pvs0FC0gZ4WrXOt0DHzg@mail.gmail.com>
Message-ID: <CAMuHMdX-yE3MAR8ugEj6CZ5u-Bfv81pvs0FC0gZ4WrXOt0DHzg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: r9a07g043-cpg: Add Renesas
 RZ/Five CPG Clock and Reset Definitions
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

On Wed, Jun 22, 2022 at 8:17 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Renesas RZ/Five SoC has almost the same clock structure compared to the
> Renesas RZ/G2UL SoC, re-use the r9a07g043-cpg.h header file and just
> amend the RZ/Five CPG clock and reset definitions.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Will queue in renesas-clk-for-v5.20.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
