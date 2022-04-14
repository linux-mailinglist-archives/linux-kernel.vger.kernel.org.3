Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D65500778
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 09:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbiDNHqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 03:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240691AbiDNHqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:46:04 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A475AA64;
        Thu, 14 Apr 2022 00:41:50 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id a186so555589qkc.10;
        Thu, 14 Apr 2022 00:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UHi37QgFrguKoFdX0YvnqEc8jgtMaeE9jDv0V4psTXQ=;
        b=JoxCyLPQxJLMOiUotTkdDR4LzJfQnyaQj3hek83UBnbg33Qdc40hac/L2dX1NQ2rox
         9Cp6R/mhqcJn983X31lpcW/uh46DocZUVJGNVcTqEEqxzhdrj5hLqWgsyPcSXvh3NxNo
         h/jd0derrLAiGYZ848OaUjQlcYlw/FRl59mZxoLnj09gLOMVXzdqubagfiazhEDSiFWE
         JB5bXcfUNdTFaF8sL1nmaH++RH0t4SFOZoF7eOtfX2bsh+EuL3PTZxJnqYRBVRZ5guAS
         EI+HJm8RXt2DwpPW/q43GFvTp+Bw0h5pUYg7D8udEsKuUG/VNTqKRyltxf9CpMwhiSAV
         PrMA==
X-Gm-Message-State: AOAM532PNbsapo5AzkcdE9eQYHeTE1nmrGWTvIn40KVzFQj/7T2CJ575
        pgOep+DvsrXDyYVKth65RVngiVtscnkvQQ==
X-Google-Smtp-Source: ABdhPJzfV3/8nBgzPcSrjas9v446LDH/ixJM+RQtS/tXFZzxIn2qWJdnKNOeyaTjhm7T8MyhHnfrjg==
X-Received: by 2002:ae9:de47:0:b0:69c:7e33:e343 with SMTP id s68-20020ae9de47000000b0069c7e33e343mr306435qkf.228.1649922109498;
        Thu, 14 Apr 2022 00:41:49 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id o10-20020ac85a4a000000b002ed143903a9sm818942qta.45.2022.04.14.00.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 00:41:49 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id z33so7961906ybh.5;
        Thu, 14 Apr 2022 00:41:49 -0700 (PDT)
X-Received: by 2002:a25:9e89:0:b0:63c:ad37:a5de with SMTP id
 p9-20020a259e89000000b0063cad37a5demr857786ybq.342.1649922108771; Thu, 14 Apr
 2022 00:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <c3b2a8d1a69f1b1e8d1a460148406cfb83e52eb4.1649857740.git.geert+renesas@glider.be>
 <50714f3e-7561-37fd-7a05-222fd6185c47@linaro.org>
In-Reply-To: <50714f3e-7561-37fd-7a05-222fd6185c47@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Apr 2022 09:41:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWQjJYhtQ9k0ZhoOS0htvr+nM5+Z_SG=WNsg64ZHuytFw@mail.gmail.com>
Message-ID: <CAMuHMdWQjJYhtQ9k0ZhoOS0htvr+nM5+Z_SG=WNsg64ZHuytFw@mail.gmail.com>
Subject: Re: [PATCH v2] memory: renesas-rpc-if: Simplify single/double data
 register access
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
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

Hi Krzysztof,

On Thu, Apr 14, 2022 at 9:28 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 13/04/2022 15:49, Geert Uytterhoeven wrote:
> > For manual write and read, factor out the common access to the first
> > data register by keeping track of the current data pointer.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> This does not apply on a next branch. Maybe because I put "memory:
> renesas-rpc-if: Fix HF/OSPI data transfer in Manual Mode" for fixes?
> Does this patch depend on that fix?

There is no functional dependency, but a slight contextual one.
It should apply with some fuzz:

$ git am --show-current-patch | patch -p1
patching file drivers/memory/renesas-rpc-if.c
Hunk #1 succeeded at 458 (offset -30 lines).
Hunk #2 succeeded at 471 with fuzz 1 (offset -31 lines).
Hunk #3 succeeded at 515 (offset -31 lines).
Hunk #4 succeeded at 531 (offset -32 lines).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
