Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4345576AC0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 01:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiGOXdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 19:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiGOXdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 19:33:10 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7501012AF9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 16:33:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E928BCE30C4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 23:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B59C34115;
        Fri, 15 Jul 2022 23:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1657927986;
        bh=C2b3YLrjkNeagDR8DxwpKkhSaFC5JfY7+Rq4F/K+LUM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FEnapZq/UkEN2jjYPl8+26kKS3k5gOPiKVO0480IXNXy2jy8Fv0LNLk5zZKQEjRrd
         7uGrChARWx5XIGasYrEq7mh0U8jZqSDuZSVl6LlXXIqHcVq9FN9LzLQkQsozA42DTC
         uB/aBzyjZrXApZE1z7dWbS9MuKm4D+hzdrGkWso0=
Date:   Fri, 15 Jul 2022 16:33:05 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     yee.lee@mediatek.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:KFENCE" <kasan-dev@googlegroups.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 1/1] mm: kfence: apply kmemleak_ignore_phys on early
 allocated pool
Message-Id: <20220715163305.e70c8542d5e7d96c5fd87185@linux-foundation.org>
In-Reply-To: <CAMuHMdX=MTsmo5ZVa8ya3xmr4Mx7f0PB3gvFF42pdaTYB6-u5A@mail.gmail.com>
References: <20220628113714.7792-1-yee.lee@mediatek.com>
        <20220628113714.7792-2-yee.lee@mediatek.com>
        <CAMuHMdX=MTsmo5ZVa8ya3xmr4Mx7f0PB3gvFF42pdaTYB6-u5A@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 10:17:43 +0200 Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Tue, Jun 28, 2022 at 1:42 PM <yee.lee@mediatek.com> wrote:
> > From: Yee Lee <yee.lee@mediatek.com>
> >
> > This patch solves two issues.
> >
> > (1) The pool allocated by memblock needs to unregister from
> > kmemleak scanning. Apply kmemleak_ignore_phys to replace the
> > original kmemleak_free as its address now is stored in the phys tree.
> >
> > (2) The pool late allocated by page-alloc doesn't need to unregister.
> > Move out the freeing operation from its call path.
> >
> > Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> > Suggested-by: Marco Elver <elver@google.com>
> > Signed-off-by: Yee Lee <yee.lee@mediatek.com>
> 
> Thank you, this fixes the storm of
> 
>     BUG: KFENCE: invalid read in scan_block+0x78/0x130
>     BUG: KFENCE: use-after-free read in scan_block+0x78/0x130
>     BUG: KFENCE: out-of-bounds read in scan_block+0x78/0x130
> 
> messages I was seeing on arm64.

Thanks, but...

- It would be great if we could identify a Fixes: for this.

- This patch has been accused of crashing the kernel:

	https://lkml.kernel.org/r/YsFeUHkrFTQ7T51Q@xsang-OptiPlex-9020

  Do we think that report is bogus?
