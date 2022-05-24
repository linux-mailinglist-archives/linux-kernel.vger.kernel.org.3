Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D3A53270E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 12:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236033AbiEXKFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 06:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiEXKFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 06:05:50 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F58D75221
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 03:05:48 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gi33so25764719ejc.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 03:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WekZdZTtTNu0NCjGCUwHIK8cT32r5xb10hc0djOUWXs=;
        b=iQdlwXfcFTeKrLPSKVE/Bm0wY66qW8ercKJraL44NeKyxEydbTPt7CkSnFPLomQQDI
         Bb6wfH8bHi8LeEWFw87oHU5bQZH7gx6ZNmZAysdrEwZ2uR/YW0qP1THblazfpJx1+3gr
         T+UoQpVOD+6mq4lpryYZzi85Qoibl0SitRsc5L75FXOkE1mwe1vEb1mkLL+mQkdjyTxZ
         waO5mZlPtHZy8fz96dJUTLR4Hul/Ea9NeHca6IeTAg+ytGfH9gial0XvID9ws8jwxw6v
         vhBkSEN2a4i219Ucj2Ld9Rfw1nBGmXZGi15iS6OyNjDT8VfD3LSR/1C3w+W6witY4oV1
         icqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WekZdZTtTNu0NCjGCUwHIK8cT32r5xb10hc0djOUWXs=;
        b=QLcWFS1rMogtzr85OSvzGbL7lmkcM4ByAg7KH3/6gDv5XOu/LVLTkHPDQozsATWbcH
         XFlXW1muG3BaZGhNeUuobYSoFa4nOAeKVBukPlFG0yGQZJxHF+/j26691d3C8g41sqbB
         x1gdhN1/qQKJ3en7u/yrDcLiOAFL0isZO55XaL8EpUIiz9fIjdCIrcN9wzmY1ImMr1Rp
         4lRsazYF9vHuRt+T8z/Ro6LpcMv01rcTMktxJqwu6z63CSyphAlz7GtYnp8F90NKYw7i
         NN6aFhDy0KoNf3qwhNTr9pvls3cOQKeF8IqZ//TihRFJkuSol7yViIbH608kZ4GbEU/f
         ktQQ==
X-Gm-Message-State: AOAM530mUh2AW1q5o4s1vgScHB60lkea3Lu8XnlSNsTIhSelnUJziA35
        +AdZy1YmV+VnCOpWAEYJ3TdJVky9lHdKLx7Fx7s=
X-Google-Smtp-Source: ABdhPJz7BFtcuW392zVcxz+55BtKJcIy0OchNSwmEIJCh+IDTmYaxQ2WerYbh16n7ynBHq0RShXf5gQOBDfZGuJlQP0=
X-Received: by 2002:a17:906:7309:b0:6f5:ea1:afa with SMTP id
 di9-20020a170906730900b006f50ea10afamr23767700ejc.170.1653386746877; Tue, 24
 May 2022 03:05:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220524071403.128644-1-21cnbao@gmail.com> <YoyTWaDmSiBUkaeg@arm.com>
In-Reply-To: <YoyTWaDmSiBUkaeg@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 24 May 2022 22:05:35 +1200
Message-ID: <CAGsJ_4xPFkc6Kn2G5pPPk8XJ4iZV=atzan=Quq6Ljc_5vr1fnA@mail.gmail.com>
Subject: Re: [PATCH] arm64: enable THP_SWAP for arm64
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        hanchuanhua <hanchuanhua@oppo.com>,
        =?UTF-8?B?5byg6K+X5piOKFNpbW9uIFpoYW5nKQ==?= 
        <zhangshiming@oppo.com>, =?UTF-8?B?6YOt5YGl?= <guojian@oppo.com>,
        Barry Song <v-songbaohua@oppo.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>, Shaohua Li <shli@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Steven Price <steven.price@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 8:12 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, May 24, 2022 at 07:14:03PM +1200, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > THP_SWAP has been proved to improve the swap throughput significantly
> > on x86_64 according to commit bd4c82c22c367e ("mm, THP, swap: delay
> > splitting THP after swapped out").
> > As long as arm64 uses 4K page size, it is quite similar with x86_64
> > by having 2MB PMD THP. So we are going to get similar improvement.
> > For other page sizes such as 16KB and 64KB, PMD might be too large.
> > Negative side effects such as IO latency might be a problem. Thus,
> > we can only safely enable the counterpart of X86_64.
> >
> > Cc: "Huang, Ying" <ying.huang@intel.com>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: Shaohua Li <shli@kernel.org>
> > Cc: Rik van Riel <riel@redhat.com>
> > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  arch/arm64/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index d550f5acfaf3..8e3771c56fbf 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -98,6 +98,7 @@ config ARM64
> >       select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
> >       select ARCH_WANT_LD_ORPHAN_WARN
> >       select ARCH_WANTS_NO_INSTR
> > +     select ARCH_WANTS_THP_SWAP if ARM64_4K_PAGES
>
> I'm not opposed to this but I think it would break pages mapped with
> PROT_MTE. We have an assumption in mte_sync_tags() that compound pages
> are not swapped out (or in). With MTE, we store the tags in a slab

I assume you mean mte_sync_tags() require that THP is not swapped as a whole,
as without THP_SWP, THP is still swapping after being splitted. MTE doesn't stop
THP from swapping through a couple of splitted pages, does it?

> object (128-bytes per swapped page) and restore them when pages are
> swapped in. At some point we may teach the core swap code about such
> metadata but in the meantime that was the easiest way.
>

If my previous assumption is true,  the easiest way to enable THP_SWP
for this moment
might be always letting mm fallback to the splitting way for MTE
hardware. For this
moment, I care about THP_SWP more as none of my hardware has MTE.

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 45c358538f13..d55a2a3e41a9 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -44,6 +44,8 @@
        __flush_tlb_range(vma, addr, end, PUD_SIZE, false, 1)
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */

+#define arch_thp_swp_supported !system_supports_mte
+
 /*
  * Outside of a few very special situations (e.g. hibernation), we always
  * use broadcast TLB invalidation instructions, therefore a spurious page
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2999190adc22..064b6b03df9e 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -447,4 +447,16 @@ static inline int split_folio_to_list(struct folio *folio,
        return split_huge_page_to_list(&folio->page, list);
 }

+/*
+ * archs that select ARCH_WANTS_THP_SWAP but don't support THP_SWP due to
+ * limitations in the implementation like arm64 MTE can override this to
+ * false
+ */
+#ifndef arch_thp_swp_supported
+static inline bool arch_thp_swp_supported(void)
+{
+       return true;
+}
+#endif
+
 #endif /* _LINUX_HUGE_MM_H */
diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index 2b5531840583..dde685836328 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -309,7 +309,7 @@ swp_entry_t get_swap_page(struct page *page)
        entry.val = 0;

        if (PageTransHuge(page)) {
-               if (IS_ENABLED(CONFIG_THP_SWAP))
+               if (IS_ENABLED(CONFIG_THP_SWAP) && arch_thp_swp_supported())
                        get_swap_pages(1, &entry, HPAGE_PMD_NR);
                goto out;
        }

> --
> Catalin

Thanks
Barry
