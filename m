Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FB85798C3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbiGSLuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiGSLuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:50:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9555A10A8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:50:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E9C361614
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 11:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A21C341C6;
        Tue, 19 Jul 2022 11:50:39 +0000 (UTC)
Date:   Tue, 19 Jul 2022 12:50:35 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, yee.lee@mediatek.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:KFENCE" <kasan-dev@googlegroups.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2 1/1] mm: kfence: apply kmemleak_ignore_phys on early
 allocated pool
Message-ID: <Ytaai+yWz0JG4a6O@arm.com>
References: <20220628113714.7792-1-yee.lee@mediatek.com>
 <20220628113714.7792-2-yee.lee@mediatek.com>
 <CAMuHMdX=MTsmo5ZVa8ya3xmr4Mx7f0PB3gvFF42pdaTYB6-u5A@mail.gmail.com>
 <20220715163305.e70c8542d5e7d96c5fd87185@linux-foundation.org>
 <CAMuHMdWSsibmL=LauLm+OTn0SByLA4tGsbhbMsnvSRdb381RTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWSsibmL=LauLm+OTn0SByLA4tGsbhbMsnvSRdb381RTQ@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 08:43:06PM +0200, Geert Uytterhoeven wrote:
> On Sat, Jul 16, 2022 at 1:33 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> > On Fri, 15 Jul 2022 10:17:43 +0200 Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Tue, Jun 28, 2022 at 1:42 PM <yee.lee@mediatek.com> wrote:
> > > > From: Yee Lee <yee.lee@mediatek.com>
> > > >
> > > > This patch solves two issues.
> > > >
> > > > (1) The pool allocated by memblock needs to unregister from
> > > > kmemleak scanning. Apply kmemleak_ignore_phys to replace the
> > > > original kmemleak_free as its address now is stored in the phys tree.
> > > >
> > > > (2) The pool late allocated by page-alloc doesn't need to unregister.
> > > > Move out the freeing operation from its call path.
> > > >
> > > > Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> > > > Suggested-by: Marco Elver <elver@google.com>
> > > > Signed-off-by: Yee Lee <yee.lee@mediatek.com>
> > >
> > > Thank you, this fixes the storm of
> > >
> > >     BUG: KFENCE: invalid read in scan_block+0x78/0x130
> > >     BUG: KFENCE: use-after-free read in scan_block+0x78/0x130
> > >     BUG: KFENCE: out-of-bounds read in scan_block+0x78/0x130
> > >
> > > messages I was seeing on arm64.
> >
> > Thanks, but...
> >
> > - It would be great if we could identify a Fixes: for this.
> 
> IIRC, I started seeing the issue with "[PATCH v4 3/4] mm:
> kmemleak: add rbtree and store physical address for objects
> allocated with PA" (i.e. commit 0c24e061196c21d5 ("mm: kmemleak:
> add rbtree and store physical address for objects allocated
> with PA")) of series "[PATCH v4 0/4] mm: kmemleak: store objects
> allocated with physical address separately and check when scan"
> (https://lore.kernel.org/all/20220611035551.1823303-1-patrick.wang.shcn@gmail.com),
> in an arm64 config that had enabled kfence.

Yes, I think it fixes 0c24e061196c21d5 since after that commit, the
kmemleak_free() no longer worked as expected on physically allocated
objects.

-- 
Catalin
