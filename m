Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811475996E8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347486AbiHSIMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347471AbiHSIME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:12:04 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98086E096C;
        Fri, 19 Aug 2022 01:12:03 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id y18so2825568qtv.5;
        Fri, 19 Aug 2022 01:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=13cZgSYlONAYh9NAs+6LHBFcHKVS3iOvfRVkc4Te0KI=;
        b=0f3xHpHpK9i6+0aul/eSAcGvX3/+HIfTWMrlo4sVDSAo7zDfVk2WcDYPEc3WagkHFU
         SVKtI05FjAEc1piMxNkLJz6lX6JxBdfApvUZBOL+qoSbuclOCug6y+kkIms5K0YYJFH9
         BgSIPNQlbI/vbR6/YGyGwyeP+2Lia1uxigpp/2imYSzsvIOuqEuJWI8AVTNbRFSd/JGb
         dOE2qYQLVM5t0AGbPGzo4msRBPkc0UuuNYjqbzmUCnVn4i9i+OhQzdRQL2aENm4+w4Ak
         7iWP4fGw4dWpOt53Vkc1b86KqmHuVd5KDHp6b6GvbiqcntpvIIzb5wVYHdkV5je/sRkV
         lXmw==
X-Gm-Message-State: ACgBeo2sTWzes8b4JVc/V4JafwrIuZm+ynCHm7XCwUD4U2ZIfdWvxE19
        4ssN53vBUp8HFXUBG7Zl1bHe8geyCioqLQ==
X-Google-Smtp-Source: AA6agR6frXyJBQ5llQknU9B1FCdeCUJbwnmu3GLJgdMw/ma3Cd5REZULJbtpk3A5b1Np6JnF/bJvaA==
X-Received: by 2002:ac8:7e81:0:b0:344:95a5:75a0 with SMTP id w1-20020ac87e81000000b0034495a575a0mr3907047qtj.128.1660896722359;
        Fri, 19 Aug 2022 01:12:02 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id f22-20020a05620a409600b006bad20a6cfesm3700332qko.102.2022.08.19.01.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 01:12:01 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-334dc616f86so102672417b3.8;
        Fri, 19 Aug 2022 01:12:01 -0700 (PDT)
X-Received: by 2002:a5b:6c1:0:b0:669:a7c3:4c33 with SMTP id
 r1-20020a5b06c1000000b00669a7c34c33mr6358491ybq.543.1660896721064; Fri, 19
 Aug 2022 01:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220815151451.23293-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220815151451.23293-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 19 Aug 2022 10:11:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUYOWZ8tG-OLLam3ROAtriO=VEOH0nrWfC2T1iOoq=LWQ@mail.gmail.com>
Message-ID: <CAMuHMdUYOWZ8tG-OLLam3ROAtriO=VEOH0nrWfC2T1iOoq=LWQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] riscv: dts: renesas: Add minimal DTS for Renesas
 RZ/Five SMARC EVK
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <Conor.Dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 5:16 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Enable the minimal blocks required for booting the Renesas RZ/Five
> SMARC EVK with initramfs.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
