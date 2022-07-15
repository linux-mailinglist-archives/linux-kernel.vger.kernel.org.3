Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8846E575D36
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 10:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbiGOISA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 04:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiGOIR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 04:17:58 -0400
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E177E83C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 01:17:57 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id d17so3265527qvs.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 01:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A8U10zfMg2MHnCiIBNObwk422GWQl02SfoTHfiQ0fc8=;
        b=5+cOQFh/UKDgoTKIhIuPOujKoQORqDMMxA0MnlJaJ+qkYAeeJ9VTOAlXZa5AJiKeW/
         Tg1MQK7NPvuLgwlKI64HQG28bUitNCgWQR2sDCh6u/lEB8f5FsGERLhzfbdvlSalR8FS
         ZoQ3TgvfwDeAg7cGpjSXCYPC9m1rHe7ScjWsJivtpFlNlHzgRgf62Y7RZbctJhXzXhul
         LlcrYToZXhQXbRiGaXLBTSlBTod0HG1gCo7OzGdGJIcyF5coT3m/O4XeaPTqy2Fiy01j
         Bo218TfrJ/4fVKKA/3RZaDOnBoSxk2m8+WSl4f78g0XnObvhDAj8ka2bJqNF5I66gfHb
         Kqqw==
X-Gm-Message-State: AJIora/rZqUV5dWUcodkBo8QPp93/IW6+X5HNjJRFetv5IFqJLboGQ5U
        UEl5ukMz94Y2iJVUZGnhPK7i7KK2eixkEQ==
X-Google-Smtp-Source: AGRyM1vlQQXbSiA3kC0MBZhvWblRhLspINEzujyIw3nvUYyymma0z/u6SCQhA+BVWYf+JJjLD6FrAg==
X-Received: by 2002:a0c:b31a:0:b0:473:8062:b1b4 with SMTP id s26-20020a0cb31a000000b004738062b1b4mr11209414qve.85.1657873076964;
        Fri, 15 Jul 2022 01:17:56 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id r20-20020a05620a299400b006b1a343c2absm3338578qkp.131.2022.07.15.01.17.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 01:17:56 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-31c8a1e9e33so40289327b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 01:17:56 -0700 (PDT)
X-Received: by 2002:a81:af27:0:b0:31c:833f:eda5 with SMTP id
 n39-20020a81af27000000b0031c833feda5mr14511861ywh.358.1657873075845; Fri, 15
 Jul 2022 01:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220628113714.7792-1-yee.lee@mediatek.com> <20220628113714.7792-2-yee.lee@mediatek.com>
In-Reply-To: <20220628113714.7792-2-yee.lee@mediatek.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 15 Jul 2022 10:17:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX=MTsmo5ZVa8ya3xmr4Mx7f0PB3gvFF42pdaTYB6-u5A@mail.gmail.com>
Message-ID: <CAMuHMdX=MTsmo5ZVa8ya3xmr4Mx7f0PB3gvFF42pdaTYB6-u5A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: kfence: apply kmemleak_ignore_phys on early
 allocated pool
To:     yee.lee@mediatek.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:KFENCE" <kasan-dev@googlegroups.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yee,

On Tue, Jun 28, 2022 at 1:42 PM <yee.lee@mediatek.com> wrote:
> From: Yee Lee <yee.lee@mediatek.com>
>
> This patch solves two issues.
>
> (1) The pool allocated by memblock needs to unregister from
> kmemleak scanning. Apply kmemleak_ignore_phys to replace the
> original kmemleak_free as its address now is stored in the phys tree.
>
> (2) The pool late allocated by page-alloc doesn't need to unregister.
> Move out the freeing operation from its call path.
>
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Yee Lee <yee.lee@mediatek.com>

Thank you, this fixes the storm of

    BUG: KFENCE: invalid read in scan_block+0x78/0x130
    BUG: KFENCE: use-after-free read in scan_block+0x78/0x130
    BUG: KFENCE: out-of-bounds read in scan_block+0x78/0x130

messages I was seeing on arm64.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
