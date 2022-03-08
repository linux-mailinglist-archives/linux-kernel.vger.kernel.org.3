Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15D64D0D03
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 01:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245481AbiCHAvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 19:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244301AbiCHAvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 19:51:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE11F28E29
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 16:50:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66DAFB81686
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 00:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD099C340EF;
        Tue,  8 Mar 2022 00:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646700616;
        bh=Kv+yY9E+DYOUfGXI4e3etZBeNRkR4t4l0wyhFQINGm4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=icoTRQd5NmdJTiFKjqLxohZMoKg1VLUj244SwSAg3OjjkIg4C0hSdDvv8VB73qd5h
         tKSNRNKZhlTu24R5AuQLD5Oz4CiNZ4o0SBneRR5sUTHkD7XnaQlvTR+W/ocnxGJL83
         p5kij24S6LMz1dJ82NPR3HZmFIae5LFUOtmHU5Ys=
Date:   Mon, 7 Mar 2022 16:50:15 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm: thp: don't have to lock page anymore when splitting
 PMD
Message-Id: <20220307165015.77fbcbe9e1fa2fe15f3eb239@linux-foundation.org>
In-Reply-To: <CAHbLzkqY69nFniK+ckQaeu117Q+OqZ2hvFEdVbZaW2C_zAzDbg@mail.gmail.com>
References: <20220303222014.517033-1-shy828301@gmail.com>
        <CADFyXm6W9CVkO4XPYep-tHg55c8m8NES783kcVYrdjSMbzYoDA@mail.gmail.com>
        <CAHbLzkriyBy2HqjssurLSnhoyuUzpJRZjMPNx34MTgxeO0dddg@mail.gmail.com>
        <13ad4ba1-2a88-9459-3995-70af36aba33e@redhat.com>
        <20220306180718.6d4e6233130b94fdad98df88@linux-foundation.org>
        <84a6c9c1-d18f-6955-2666-0a2d7bce6094@redhat.com>
        <20220307154326.6494f7fca7def491a23e5df1@linux-foundation.org>
        <CAHbLzkqY69nFniK+ckQaeu117Q+OqZ2hvFEdVbZaW2C_zAzDbg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Mar 2022 16:03:12 -0800 Yang Shi <shy828301@gmail.com> wrote:

> On Mon, Mar 7, 2022 at 3:43 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > @@ -2133,8 +2133,6 @@ void __split_huge_pmd(struct vm_area_str
> >  {
> >         spinlock_t *ptl;
> >         struct mmu_notifier_range range;
> > -       bool do_unlock_folio = false;
> > -       pmd_t _pmd;
> >
> >         mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
> >                                 address & HPAGE_PMD_MASK,
> > @@ -2153,42 +2151,14 @@ void __split_huge_pmd(struct vm_area_str
> >                         goto out;
> >         }
> >
> > -repeat:
> >         if (pmd_trans_huge(*pmd)) {
> > -               if (!folio) {
> > +               if (!folio)
> >                         folio = page_folio(pmd_page(*pmd));
> 
> We could remove the "if (pmd_trans_huge(*pmd))" section since folio is
> actually not used afterward at all.

>
> ...
>
> 
> With the above if removed, this could be changed to:
> 
> if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
>             is_pmd_migration_entry(*pmd))
>                 __split_huge_pmd_locked(vma, pmd, range.start, freeze);
> 

OK, looks sane.  Can someone please test all this?

--- a/mm/huge_memory.c~mm-huge_memory-remove-stale-locking-logic-from-__split_huge_pmd-fix
+++ a/mm/huge_memory.c
@@ -2151,12 +2151,10 @@ void __split_huge_pmd(struct vm_area_str
 			goto out;
 	}
 
-	if (pmd_trans_huge(*pmd)) {
-		if (!folio)
-			folio = page_folio(pmd_page(*pmd));
-	} else if (!(pmd_devmap(*pmd) || is_pmd_migration_entry(*pmd)))
-		goto out;
-	__split_huge_pmd_locked(vma, pmd, range.start, freeze);
+	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
+	    is_pmd_migration_entry(*pmd)))
+		__split_huge_pmd_locked(vma, pmd, range.start, freeze);
+
 out:
 	spin_unlock(ptl);
 	/*
_

