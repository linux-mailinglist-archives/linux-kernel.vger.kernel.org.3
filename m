Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8624FFB9B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbiDMQqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236982AbiDMQpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:45:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C64568305
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649868210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yOc8sJgoC4OMuHlex8YSxARCRvJnhktuH3N8MCBMIJw=;
        b=UmdNJ9i4g4NYJObeOeqR0rulPtZ5UvZs+8kxVBOvgtf/GuO97vxEII3G+GsocLWlX+aegh
        0q2uHroAg7hkVlMB/Z4sVf1Xp6wODwSPpu5A+yMxXLXykwKRP7tOyIvQQ2HczKmCNnp3EC
        mEbMO2cNC14btK3QRCOQWjFaZM+/rNU=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-zMsh-HpVPqaJ3ODmPzQfwQ-1; Wed, 13 Apr 2022 12:43:29 -0400
X-MC-Unique: zMsh-HpVPqaJ3ODmPzQfwQ-1
Received: by mail-io1-f70.google.com with SMTP id d19-20020a0566022bf300b00645eba5c992so1411924ioy.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yOc8sJgoC4OMuHlex8YSxARCRvJnhktuH3N8MCBMIJw=;
        b=lNv+bkgj45kEz9LzBXYZoJdLyihCcGP9ZHf5+CY5plB/uO4HOgRTXrtFMHW8CABzBq
         OMOoi9vXCUqPSE30BShuDKr1QKHiKqVMBPYu8MNuSuDUg6nOBRQ59bEjqXCi8hCIvtWJ
         0XxwwHR5dEChbhZ5fxcDhlGsx0AAWS4xGEZcO8S5c46aO32NaFqGMgVXtTBPV5Sn392h
         veDdBAxQ1R/XpWxa8+WtxikSBiR+IEPOeB/Dw/68dtOGtj3rOsUu1etDD+Z9nwK3PAsg
         CNjWlxRPYQxw1gVTnpYhUOfVJonFY2FNJAhnm1WiJIBU+EoWKxzRUjheVMhjTOfzUS4h
         Ivkg==
X-Gm-Message-State: AOAM532/4+SIwcAiYnN1RNwDBpA11nyTIRBiZepBgEPGbXQRdaxwhGvh
        +hk2CPmnDRqBl4WirS0z1SjA0B1Pib46Ddrj8pO73pDaxRObLi1Ai6C5Ou2dPcKxDbZCmUwoZdi
        9+jr99dxejDPXoRTsA8JJFAy8
X-Received: by 2002:a92:dd07:0:b0:2ca:b240:e548 with SMTP id n7-20020a92dd07000000b002cab240e548mr7647578ilm.11.1649868207801;
        Wed, 13 Apr 2022 09:43:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0TZg/jo3qMMiFg3aidR13MOpqUZoW0Op3cc4CUGwfI9PSUDeHZ2hQJcifShcNCSrJ1WPg2A==
X-Received: by 2002:a92:dd07:0:b0:2ca:b240:e548 with SMTP id n7-20020a92dd07000000b002cab240e548mr7647567ilm.11.1649868207530;
        Wed, 13 Apr 2022 09:43:27 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id a5-20020a056e020e0500b002caca72891fsm237308ilk.27.2022.04.13.09.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 09:43:27 -0700 (PDT)
Date:   Wed, 13 Apr 2022 12:43:25 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH v8 03/23] mm: Check against orig_pte for finish_fault()
Message-ID: <Ylb9rXJyPm8/ao8f@xz-m1.local>
References: <20220405014646.13522-1-peterx@redhat.com>
 <20220405014836.14077-1-peterx@redhat.com>
 <CGME20220413140330eucas1p167da41e079712b829ef8237dc27b049c@eucas1p1.samsung.com>
 <710c48c9-406d-e4c5-a394-10501b951316@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lOFzOqXxPC8HVUYQ"
Content-Disposition: inline
In-Reply-To: <710c48c9-406d-e4c5-a394-10501b951316@samsung.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lOFzOqXxPC8HVUYQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Apr 13, 2022 at 04:03:28PM +0200, Marek Szyprowski wrote:
> Hi,

Hi, Marek,

> 
> On 05.04.2022 03:48, Peter Xu wrote:
> > We used to check against none pte in finish_fault(), with the assumption
> > that the orig_pte is always none pte.
> >
> > This change prepares us to be able to call do_fault() on !none ptes.  For
> > example, we should allow that to happen for pte marker so that we can restore
> > information out of the pte markers.
> >
> > Let's change the "pte_none" check into detecting changes since we fetched
> > orig_pte.  One trivial thing to take care of here is, when pmd==NULL for
> > the pgtable we may not initialize orig_pte at all in handle_pte_fault().
> >
> > By default orig_pte will be all zeros however the problem is not all
> > architectures are using all-zeros for a none pte.  pte_clear() will be the
> > right thing to use here so that we'll always have a valid orig_pte value
> > for the whole handle_pte_fault() call.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> This patch landed in today's linux next-202204213 as commit fa6009949163 
> ("mm: check against orig_pte for finish_fault()"). Unfortunately it 
> causes serious system instability on some ARM 32bit machines. I've 
> observed it on all tested boards (various Samsung Exynos based, 
> Raspberry Pi 3b and 4b, even QEMU's virt 32bit machine) when kernel was 
> compiled from multi_v7_defconfig.

Thanks for the report.

> 
> Here is a crash log from QEMU's ARM 32bit virt machine:
> 
> 8<--- cut here ---
> Unable to handle kernel paging request at virtual address e093263c
> [e093263c] *pgd=42083811, *pte=00000000, *ppte=00000000
> Internal error: Oops: 807 [#1] SMP ARM
> Modules linked in:
> CPU: 1 PID: 37 Comm: kworker/u4:0 Not tainted 
> 5.18.0-rc2-00176-gfa6009949163 #11684
> Hardware name: Generic DT based system
> PC is at cpu_ca15_set_pte_ext+0x4c/0x58
> LR is at handle_mm_fault+0x46c/0xbb0

I had a feeling that for some reason the pte_clear() isn't working right
there when it's applying to a kernel stack variable for arm32.  I'm totally
newbie to arm32, so what I'm reading is this:

https://people.kernel.org/linusw/arm32-page-tables

Especially:

https://dflund.se/~triad/images/classic-mmu-page-table.jpg

It does match with what I read from arm32's proc-v7-2level.S of it, where
from the comment above cpu_v7_set_pte_ext:

  * - ptep  - pointer to level 2 translation table entry
  *    (hardware version is stored at +2048 bytes)        <----------

So it seems to me that arm32 needs to store some metadata at offset 0x800
of any pte_t* pointer passed over to pte_clear(), then it must be a real
pgtable or it'll write to random places in the kernel, am I correct?

Does it mean that all pte_*() operations upon a kernel stack var will be
wrong?  I thought it could happen easily in the rest of mm too but I didn't
yet check much.  The fact shows that it's mostly possible the current code
just work well with arm32 and no such violation occured yet.

That does sound a bit tricky, IMHO.  But I don't have an immediate solution
to make it less tricky.. though I have a thought of workaround, by simply
not calling pte_clear() on the stack var.

Would you try the attached patch to replace this problematic patch? So we
need to revert commit fa6009949163 and apply the new one.  Please let me
know whether it'll solve the problem, so far I only compile tested it, but
I'll run some more test to make sure the uffd-wp scenarios will be working
right with the new version.

Thanks,

-- 
Peter Xu

--lOFzOqXxPC8HVUYQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-mm-Check-against-orig_pte-for-finish_fault-when-prop.patch"

From c9eb74ef2414b542b20f934060a4b9123ba83d0f Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Wed, 13 Apr 2022 12:31:01 -0400
Subject: [PATCH] mm: Check against orig_pte for finish_fault() when proper

This patch allows do_fault() to trigger on !pte_none() cases too.  This
prepares for the pte markers to be handled by do_fault() just like none
pte.

To achieve this, instead of unconditionally check against pte_none() in
finish_fault(), we may hit the case that the orig_pte was some pte marker
so what we want to do is to replace the pte marker with some valid pte
entry.  Then if orig_pte was set we'd want to check the current *pte (under
pgtable lock) against orig_pte rather than none pte.

Right now there's no solid way to safely reference orig_pte because when
pmd is not allocated handle_pte_fault() will not initialize orig_pte, so
it's not safe to reference it.

There's another solution proposed before this patch to do pte_clear() for
vmf->orig_pte for pmd==NULL case, however it turns out it'll break arm32
because arm32 could have assumption that pte_t* pointer will always reside
on a real ram32 pgtable, not any kernel stack variable.

To solve this, we add a new flag FAULT_FLAG_ORIG_PTE_VALID, and it'll be
set along with orig_pte when there is valid orig_pte, or it'll be cleared
when orig_pte was not initialized.

It'll be updated every time we call handle_pte_fault(), so e.g. if a page
fault retry happened it'll be properly updated along with orig_pte.

[1] https://lore.kernel.org/lkml/710c48c9-406d-e4c5-a394-10501b951316@samsung.com/

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm_types.h |  3 +++
 mm/memory.c              | 13 ++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5c567eabfb16..717a47056330 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -817,6 +817,8 @@ typedef struct {
  * @FAULT_FLAG_UNSHARE: The fault is an unsharing request to unshare (and mark
  *                      exclusive) a possibly shared anonymous page that is
  *                      mapped R/O.
+ * @FAULT_FLAG_ORIG_PTE_VALID: whether the fault has vmf->orig_pte cached.
+ *                        We should only access orig_pte if this flag set.
  *
  * About @FAULT_FLAG_ALLOW_RETRY and @FAULT_FLAG_TRIED: we can specify
  * whether we would allow page faults to retry by specifying these two
@@ -853,6 +855,7 @@ enum fault_flag {
 	FAULT_FLAG_INSTRUCTION =	1 << 8,
 	FAULT_FLAG_INTERRUPTIBLE =	1 << 9,
 	FAULT_FLAG_UNSHARE =		1 << 10,
+	FAULT_FLAG_ORIG_PTE_VALID =	1 << 11,
 };
 
 #endif /* _LINUX_MM_TYPES_H */
diff --git a/mm/memory.c b/mm/memory.c
index f89034a60e9a..8e7f39c651c3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4301,6 +4301,15 @@ void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
 	set_pte_at(vma->vm_mm, addr, vmf->pte, entry);
 }
 
+static bool vmf_pte_changed(struct vm_fault *vmf)
+{
+	if (vmf->flags & FAULT_FLAG_ORIG_PTE_VALID) {
+		return !pte_same(*vmf->pte, vmf->orig_pte);
+	}
+
+	return !pte_none(*vmf->pte);
+}
+
 /**
  * finish_fault - finish page fault once we have prepared the page to fault
  *
@@ -4359,7 +4368,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 				      vmf->address, &vmf->ptl);
 	ret = 0;
 	/* Re-check under ptl */
-	if (likely(pte_none(*vmf->pte)))
+	if (likely(!vmf_pte_changed(vmf)))
 		do_set_pte(vmf, page, vmf->address);
 	else
 		ret = VM_FAULT_NOPAGE;
@@ -4837,6 +4846,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		 * concurrent faults and from rmap lookups.
 		 */
 		vmf->pte = NULL;
+		vmf->flags &= ~FAULT_FLAG_ORIG_PTE_VALID;
 	} else {
 		/*
 		 * If a huge pmd materialized under us just retry later.  Use
@@ -4860,6 +4870,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		 */
 		vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
 		vmf->orig_pte = *vmf->pte;
+		vmf->flags |= FAULT_FLAG_ORIG_PTE_VALID;
 
 		/*
 		 * some architectures can have larger ptes than wordsize,
-- 
2.32.0


--lOFzOqXxPC8HVUYQ--

