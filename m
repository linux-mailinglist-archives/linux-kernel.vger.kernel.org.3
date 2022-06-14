Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5054354B4E6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356891AbiFNPk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235793AbiFNPk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:40:26 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D9931363;
        Tue, 14 Jun 2022 08:40:25 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id 15so6645453qki.6;
        Tue, 14 Jun 2022 08:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tt+Cu2SuK6f2NZEo5x0BH6Qhmkr9WhlYq2XBsQ2WpNs=;
        b=g2u4rmOj2s3/hbbbSvjP4CvAcAQm+g0pqpSUCGG6MV/qeJiNGjlgNNsC+Ul9FAVLky
         dMuzHFg36RWh1J3r/hlUXG0rpxdgjL/q+A/Rkbw95xOI6qtWuIA5S9ew+fPO3t8+voxQ
         lKBImXDeeLmp08bgPPfxgqmniCqKsmjGo7/uZi5lA15iP0jqnzO4gPOVBP1ukeLPK2uU
         feCOjfUAkBE7pMZ3Nwia/4cVKdLyZRqvRU9IKQsk5f0x8kuIifaa/tp3Q9pR2QIc2QdS
         XVA2b2I8chp1pDVt5aaQWDvc4d+nSNEz4GKlXZRL7SbJuSZ4/grdG1fs5SnoBYBEVWNF
         pmDg==
X-Gm-Message-State: AOAM530oswoMWj3oLdkmvYY7HLYOU5BMrm6Qnv3tboWPQGDsxKwQFO20
        49aC8HOoHC9ufuaBLWmPgTXATYOCfdzimg==
X-Google-Smtp-Source: ABdhPJxwbQzRJUfd3gguGGFd+FT03oYX6suLbM8cygcvkgohlwAsH+tJVgCDlYbxyyU0bBHzKqnoEw==
X-Received: by 2002:a05:620a:46a4:b0:6a6:f528:e2e0 with SMTP id bq36-20020a05620a46a400b006a6f528e2e0mr4533932qkb.208.1655221224459;
        Tue, 14 Jun 2022 08:40:24 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id v18-20020a05622a015200b0030509559d1fsm7510634qtw.30.2022.06.14.08.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 08:40:24 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id w2so15806002ybi.7;
        Tue, 14 Jun 2022 08:40:24 -0700 (PDT)
X-Received: by 2002:a05:6902:a:b0:65c:b38e:6d9f with SMTP id
 l10-20020a056902000a00b0065cb38e6d9fmr5886189ybh.36.1655221223744; Tue, 14
 Jun 2022 08:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220614094937.8104-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220614094937.8104-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Jun 2022 17:40:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXNhy5LfmM73gR0LzoJndqE8RmTZY4QvMZF9oH1tBn_3g@mail.gmail.com>
Message-ID: <CAMuHMdXNhy5LfmM73gR0LzoJndqE8RmTZY4QvMZF9oH1tBn_3g@mail.gmail.com>
Subject: Re: [PATCH v2] clk: renesas: r8a779f0: Add HSCIF clocks
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
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

On Tue, Jun 14, 2022 at 11:49 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Change since v1: include all HSCIF

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v5.20.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
