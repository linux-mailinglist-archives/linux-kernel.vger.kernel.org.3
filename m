Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAF656B380
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237557AbiGHH1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237574AbiGHH1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:27:46 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23D67C1B3;
        Fri,  8 Jul 2022 00:27:43 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id p11so15103131qkg.12;
        Fri, 08 Jul 2022 00:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pWsvSmTZobtOYrT53fe/z+DLyrXo+T/u50CstCgwFFc=;
        b=zC7if4SLXMUzUO4hUIqTS1WrHNTPIOZdoOgFn40K3mop0HZzzbDNPdSeT0k/hah7g3
         NApR7oc2n+JtlnOKczONfI/TDLYE6FFiINh2pEdEXXRb1Vz77Nnlk1VxaKfSy3s7zrO2
         KVuQxPjThM9UptK67QuBFa8h00XTs1Q1axIRqpV3sdFQWzNcUlMWQLMaq2qaQKf7F+O3
         tRnylhdCz61t7WKpbKE8yyHogbaEA46j/WJrBDz8eTICs7jfOiuqKNF2doV67fJdDWKL
         cl6NxaoIqt649r+dn4VDAizMWpe/Vhr4jSRWPW3k+Wj+6uM/Lu5PxwzF0EuePg/otfAO
         VOtQ==
X-Gm-Message-State: AJIora9Q9b8tmTQS4hcGR6fJC6eTNl3iS5W+aDNJiH8mvKGVFQ6eFvv+
        GTgzH4KlJgbEFRSx3spdPAcs2eJaj2Svkw==
X-Google-Smtp-Source: AGRyM1vNq6mFO5dszfyzWYiEvqPsF9hCxd5ksnU0rWalHElJ7ed+2mbNNL/fY1eB4PDxDSKXYdoZPg==
X-Received: by 2002:a05:620a:1a15:b0:6a9:3829:b6e with SMTP id bk21-20020a05620a1a1500b006a938290b6emr1311666qkb.756.1657265262693;
        Fri, 08 Jul 2022 00:27:42 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id y17-20020a05620a25d100b006a6a5d1e240sm37473528qko.34.2022.07.08.00.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 00:27:41 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-31c89111f23so140572527b3.0;
        Fri, 08 Jul 2022 00:27:41 -0700 (PDT)
X-Received: by 2002:a81:9209:0:b0:31c:b1b7:b063 with SMTP id
 j9-20020a819209000000b0031cb1b7b063mr2415335ywg.383.1657265261362; Fri, 08
 Jul 2022 00:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220708071306.4354-1-jslaby@suse.cz> <20220708071306.4354-2-jslaby@suse.cz>
In-Reply-To: <20220708071306.4354-2-jslaby@suse.cz>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 8 Jul 2022 09:27:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXd3JR+Q+xaQG7eZAf2n9wA0TvuHguzRLRwL-wxetcbtA@mail.gmail.com>
Message-ID: <CAMuHMdXd3JR+Q+xaQG7eZAf2n9wA0TvuHguzRLRwL-wxetcbtA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] clk: renesas: rcar-gen4: Fix initconst confusion
 for cpg_pll_config
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Martin Liska <mliska@suse.cz>, Stephen Boyd <sboyd@kernel.org>
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

Hi Jiri,

On Fri, Jul 8, 2022 at 9:13 AM Jiri Slaby <jslaby@suse.cz> wrote:
> From: Andi Kleen <ak@linux.intel.com>
>
> A variable pointing to const isn't const itself. It'd have to contain
> "const" keyword after "*" too. Therefore, cpg_pll_config cannot be put
> to "rodata".  Hence use __initdata instead of __initconst to fix this.
>
> [js] more explanatory commit message.
>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-clk@vger.kernel.org
> Cc: Martin Liska <mliska@suse.cz>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Already queued as commit 0e704f6c42dc64f0 ("clk: renesas: rcar-gen4:
Fix initconst confusion for cpg_pll_config") in renesas-clk-for-v5.20,
and next-20220706 and later.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
