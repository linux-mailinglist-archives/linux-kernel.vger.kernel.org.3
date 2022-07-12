Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131E8571BA0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbiGLNpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiGLNnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:43:49 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86686FD36;
        Tue, 12 Jul 2022 06:43:47 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id q13so1048720qkc.9;
        Tue, 12 Jul 2022 06:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pQS00Ive5J+ba8NcW5/XxGDFCx4+KWgGjETq4y82+f0=;
        b=odb5lFam3DekNalLnxiaeA2OGR2+fBi9DWuRDhOLPzZXPMmmlTrTqq5429m+uiobhP
         J/2oO4K9vfqreYn93guZ+nReonPB/URa8rspetk8PbW3pjJcVuuWNWSbgyoIsI2IrcLk
         0WJclN8vH1I9VPHqvqp9I9HwDexk9d4tmnWkyWWqgTahobYM0QuRwGE7YjSJzPDHTJlR
         kwnv3lHi8yEij1AanIVh/kXJ8bVUvaNz/bwC+pbeKGBRjGtJO9ftr+X9eeiuZdsn/+Ea
         aufzkiwe0OSQDLhoQmKzwQsOjNA/8iF7RLGWf18PYujClbO9lvaD7m8+3bHZNm3UMAEn
         H0XQ==
X-Gm-Message-State: AJIora+bIsg6Vxl77dt/eB5hkCK0SMsamE4Y3f5YNnVNWXvMqpFkhGLg
        pOKCPWNvB+KcmebilPVkXM5mBIZeaBiesw==
X-Google-Smtp-Source: AGRyM1u50Dwt7Tw6SefDRP3zBqQ8BSLz2Mwsafiw8LbM09IH5X1GzhPMnjI58ORUj23pp9yfZPSNzQ==
X-Received: by 2002:a05:620a:4446:b0:6af:1d31:c257 with SMTP id w6-20020a05620a444600b006af1d31c257mr15122009qkp.399.1657633426566;
        Tue, 12 Jul 2022 06:43:46 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id u14-20020a05620a430e00b006a6a6f148e6sm9522371qko.17.2022.07.12.06.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 06:43:46 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-31c8bb90d09so81250437b3.8;
        Tue, 12 Jul 2022 06:43:44 -0700 (PDT)
X-Received: by 2002:a0d:dd09:0:b0:31c:e3b9:7442 with SMTP id
 g9-20020a0ddd09000000b0031ce3b97442mr25172382ywe.47.1657633423854; Tue, 12
 Jul 2022 06:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220611035551.1823303-1-patrick.wang.shcn@gmail.com>
In-Reply-To: <20220611035551.1823303-1-patrick.wang.shcn@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Jul 2022 15:43:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXRwVVYXK+SrVMt_FQe4KPQfozERQzYqweEYUvy4BuWRA@mail.gmail.com>
Message-ID: <CAMuHMdXRwVVYXK+SrVMt_FQe4KPQfozERQzYqweEYUvy4BuWRA@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] mm: kmemleak: store objects allocated with
 physical address separately and check when scan
To:     Patrick Wang <patrick.wang.shcn@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yee.lee@mediatek.com,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
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

Hi Patrick,

On Sat, Jun 11, 2022 at 8:50 AM Patrick Wang
<patrick.wang.shcn@gmail.com> wrote:
> The kmemleak_*_phys() interface uses "min_low_pfn" and
> "max_low_pfn" to check address. But on some architectures,
> kmemleak_*_phys() is called before those two variables
> initialized. The following steps will be taken:
>
> 1) Add OBJECT_PHYS flag and rbtree for the objects allocated
>    with physical address
> 2) Store physical address in objects if allocated with OBJECT_PHYS
> 3) Check the boundary when scan instead of in kmemleak_*_phys()

Thanks for your series!

> This patch set will solve:
> https://lore.kernel.org/r/20220527032504.30341-1-yee.lee@mediatek.com
> https://lore.kernel.org/r/9dd08bb5-f39e-53d8-f88d-bec598a08c93@gmail.com

Thanks, this finally gets rid of the thousands of suspected memory
leaks reported since commit 23c2d497de21f258 ("mm: kmemleak: take
a full lowmem check in kmemleak_*_phys()") in v5.18-rc3 on my arm64
boards.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
