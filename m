Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432105609B4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiF2Ssq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 14:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiF2Sso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:48:44 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BEB247;
        Wed, 29 Jun 2022 11:48:43 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id z16so7884945qkj.7;
        Wed, 29 Jun 2022 11:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cXKqNI+/sqOYyJuUtCM7197IW3EKPfuEBZYWu6etnmg=;
        b=M4SNyZjW4IzQcuaBqTFBabSuxMLLHrjNVv1/t2tJVW7A61Emscbyip/hReCLVTIfn+
         4Rb7HBhh3dmZ5CdZG2ga4S8CLDttey8GJ0rtfuMmSMxItTh6iX/Cpg4KgGfGBFj1R/NI
         98xWnR6pC1uLnOVrJ2PR9IVQD2XXBQASTMzsxYy8+gQIJC/DIsygfWbwkxBN2wRsB0MV
         T4c2lJXqDiHNk4P2I366rwmpRF1GLpKIKL/opmyP74tGqEc+BBiB/pjfyf9HM6eXQuE6
         dZqb9xqvc3OUHFk6d6Cl8Aqr5SiWzNPL5L0mCDecAuMG9nAu8OWAcA6AzfkxDlGcYrsW
         Oaxg==
X-Gm-Message-State: AJIora9HucIgJuMBr8G8PKj/r18slFuQkVOlfP/2lF3V+WCfhRT17PL3
        7GcSGuu8YhtZCy7VM+BQdYzXsxj6Dw41pQ==
X-Google-Smtp-Source: AGRyM1s1By5yDx+300u2B15JLMsSVppEMwZN6nwhHMO4gA752p84dVRPsz4OZnJsXDcAY6Fp3ihK2w==
X-Received: by 2002:a05:620a:13b4:b0:6b1:17a5:a489 with SMTP id m20-20020a05620a13b400b006b117a5a489mr3216805qki.144.1656528522410;
        Wed, 29 Jun 2022 11:48:42 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id t16-20020a37aa10000000b006a760640118sm13774927qke.27.2022.06.29.11.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 11:48:41 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id o19so23023730ybg.2;
        Wed, 29 Jun 2022 11:48:41 -0700 (PDT)
X-Received: by 2002:a05:6902:1246:b0:66d:5b0b:19b0 with SMTP id
 t6-20020a056902124600b0066d5b0b19b0mr4728646ybu.365.1656528520803; Wed, 29
 Jun 2022 11:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656341824.git.geert+renesas@glider.be> <2fd9b9e3f60fe555d9dcad499c90e3ec869aa96e.1656341824.git.geert+renesas@glider.be>
 <c65d6a94-b5c2-e2e4-6fdb-b7982d291e01@linaro.org> <CAMuHMdW=s42sfFwimizTsNjyKue+W9NasTOG0jgjkgkoKv3wfw@mail.gmail.com>
 <bab4d845-330e-c7f0-5dac-a96caa93a39e@linaro.org>
In-Reply-To: <bab4d845-330e-c7f0-5dac-a96caa93a39e@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 29 Jun 2022 20:48:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUuU4qtfYh=hpY9bWMLKAnz83Oj8f=M9_iUxmR+Zetsow@mail.gmail.com>
Message-ID: <CAMuHMdUuU4qtfYh=hpY9bWMLKAnz83Oj8f=M9_iUxmR+Zetsow@mail.gmail.com>
Subject: Re: [PATCH 5/7] memory: renesas-rpc-if: Move resource acquisition to .probe()
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
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

On Wed, Jun 29, 2022 at 8:26 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 29/06/2022 19:55, Geert Uytterhoeven wrote:
> > On Wed, Jun 29, 2022 at 7:44 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >> On 27/06/2022 17:31, Geert Uytterhoeven wrote:
> >>> While the acquired resources are tied to the lifetime of the RPC-IF core
> >>> device (through the use of managed resource functions), the actual
> >>> resource acquisition is triggered from the HyperBus and SPI child
> >>> drivers.  Due to this mismatch, unbinding and rebinding the child
> >>> drivers manually fails with -EBUSY:
> >>>
> >>>     # echo rpc-if-hyperflash > /sys/bus/platform/drivers/rpc-if-hyperflash/unbind
> >>>     # echo rpc-if-hyperflash > /sys/bus/platform/drivers/rpc-if-hyperflash/bind
> >>>     rpc-if ee200000.spi: can't request region for resource [mem 0xee200000-0xee2001ff]
> >>>     rpc-if-hyperflash: probe of rpc-if-hyperflash failed with error -16
> >>>
> >>> Fix this by moving all resource acquisition to the core driver's probe
> >>> routine.
> >>>
> >>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >>
> >> This looks like a fix, so how about putting it as first in the series,
> >> so backporting is easy/automatic?
> >
> > Unfortunately that is not as simple as it sounds, as this really
> > depends on patch 4.
>
> You sure? Except rebasing I don't see that. rpcif_sw_init() received the
> rpcif so it had access to all fields.

Yes I am, don't be misguided by the name of the local variable.
The rpcif structure is allocated by the HF or SPI child driver,
and thus not available in the RPC core driver's .probe() function.
The rpc_priv structure (as of patch 4) is allocated by the RPC core driver.

> > I agree patches 1-3 could be moved later, if you think it is worthwhile.
>
> This would not be enough, it has to be first patch to be backportable.

I can make it second? ;-)
Note that that still precludes (easily) backporting s2ram support.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
