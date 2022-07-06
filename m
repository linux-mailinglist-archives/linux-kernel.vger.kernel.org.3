Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D87568494
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiGFKEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbiGFKEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:04:38 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831AA24F12;
        Wed,  6 Jul 2022 03:04:37 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id k20so10664082qkj.1;
        Wed, 06 Jul 2022 03:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bj57DZQxAwyQ5rJJj/iE7VR9xSo/KE2P6unWd/aXevs=;
        b=me00YsG/CTPgmtw6XBBNNqyHRnIhI5p4+QrnMlqczQBUU5g8ALhHRfeaXQ54m2JhjL
         B2aVuqw0AoVgm5K2r7k7YEZJ7RPHkSF15PPENHNE5k5gRiMNebhTw6iva0+YnkYKkP85
         lbu0+IgKGZNinFjkbLpWkgY+EVV9PzhsIy0YzQItEc7qrec62fTNY7ub7ExmzYpB+8cw
         qjEivTws2DYbF1/hFICTAA0v2ho/RETLQAdcXwV7smV2Fw79/juMqBA58Iwx5OkUPYf1
         dCUeeJNX5BGkwl9qbwrNhEIAVcDkHvH31jCLOyoGqD9c0h+63Fpp22RWPrUUzPCKDpGk
         dd0Q==
X-Gm-Message-State: AJIora+9UYeQkxIC4YJClRYpI8pV3MRWfBJtn+GP9cWAD6RrHx46XJj6
        k3TZCu+tlY0hQzyPKejbTqKtknGL9KRLECh/
X-Google-Smtp-Source: AGRyM1uew14ejTFGCfT4Wj367a0dGX6ivHmE5ftDDeHvVWEGdY5QNX6jtVG2mdBkJ7kxdm7k90YzEw==
X-Received: by 2002:ae9:f808:0:b0:6af:dfa:a290 with SMTP id x8-20020ae9f808000000b006af0dfaa290mr26249582qkh.741.1657101876397;
        Wed, 06 Jul 2022 03:04:36 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id y11-20020a05620a44cb00b006a37eb728cfsm25037529qkp.1.2022.07.06.03.04.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 03:04:35 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 64so17199350ybt.12;
        Wed, 06 Jul 2022 03:04:35 -0700 (PDT)
X-Received: by 2002:a25:2b48:0:b0:668:3b7d:326c with SMTP id
 r69-20020a252b48000000b006683b7d326cmr41431788ybr.380.1657101874906; Wed, 06
 Jul 2022 03:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220630051630.1718927-1-anshuman.khandual@arm.com> <20220630051630.1718927-27-anshuman.khandual@arm.com>
In-Reply-To: <20220630051630.1718927-27-anshuman.khandual@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Jul 2022 12:04:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVJiS6vm2td-PBH3zpsNZJeeoudS4+yu4JG08sOi+XFdA@mail.gmail.com>
Message-ID: <CAMuHMdVJiS6vm2td-PBH3zpsNZJeeoudS4+yu4JG08sOi+XFdA@mail.gmail.com>
Subject: Re: [PATCH V6 26/26] mm/mmap: Drop ARCH_HAS_VM_GET_PAGE_PROT
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-s390 <linux-s390@vger.kernel.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Christoph Hellwig <hch@infradead.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
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

On Thu, Jun 30, 2022 at 7:20 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
> Now all the platforms enable ARCH_HAS_GET_PAGE_PROT. They define and export
> own vm_get_page_prot() whether custom or standard DECLARE_VM_GET_PAGE_PROT.
> Hence there is no need for default generic fallback for vm_get_page_prot().
> Just drop this fallback and also ARCH_HAS_GET_PAGE_PROT mechanism.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

>  arch/m68k/Kconfig       |  1 -

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
