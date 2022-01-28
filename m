Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5B549FA86
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348887AbiA1NTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:19:38 -0500
Received: from server.lespinasse.org ([63.205.204.226]:50591 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348606AbiA1NTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:19:09 -0500
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-52-ed;
 t=1643375406; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=XOBjo9P4P5QXbaTzEPxUaN/dHjWwd81pn2JDgJBu6Nw=;
 b=Zgl+0z8dPqYhAgCkfq3ZaZLo8J9FklZBrFYZ4KUxrJk41QL0gHK48EflaTggGi9/FdgST
 /d9N/2pIOp1kt5sAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-52-rsa; t=1643375406; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=XOBjo9P4P5QXbaTzEPxUaN/dHjWwd81pn2JDgJBu6Nw=;
 b=RXZkQsc2fCt/keozAMU/+XTvOIbG+hRQ17sOqDMwCKaDiYIBy5bbSMu1P7SzsdOIgr897
 WQ9H4PuFncpvLdHeCZmk3ra+Z6DWX8BPsJWxn6LEiGOKr1JqS0I2+w+I383l8o8/1aZM/Fd
 qRUP0R0hKcZ1PsULYeWwhiUsYSZFa1GmB1l2PyVhUayXj9CD6nNDa5kiDtFv+C4UW/6/anx
 VwJbO6oUIWxKuKVbXkpglJtm+UIBFSmE5DYQq3BG2jFi+7KEvYUh2jPlutoQqdgL/vC3ueP
 shObKmkZFJqxctv+L/84bRkDjWtOFNxoPQCrJmC5bsFMy6MCfCk5rHKHYRww==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id E3C61160951;
        Fri, 28 Jan 2022 05:10:06 -0800 (PST)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id CB74720337; Fri, 28 Jan 2022 05:10:06 -0800 (PST)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-team@fb.com, Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [PATCH v2 04/35] do_anonymous_page: use update_mmu_tlb()
Date:   Fri, 28 Jan 2022 05:09:35 -0800
Message-Id: <20220128131006.67712-5-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220128131006.67712-1-michel@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_mmu_tlb() can be used instead of update_mmu_cache() when the
page fault handler detects that it lost the race to another page fault.

It looks like this one call was missed in
https://patchwork.kernel.org/project/linux-mips/patch/1590375160-6997-2-git-send-email-maobibo@loongson.cn
after Andrew asked to replace all update_mmu_cache() calls with an alias
in the previous version of this patch here:
https://patchwork.kernel.org/project/linux-mips/patch/1590031837-9582-2-git-send-email-maobibo@loongson.cn/#23374625

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index c125c4969913..cd9432df3a27 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3799,7 +3799,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 			&vmf->ptl);
 	if (!pte_none(*vmf->pte)) {
-		update_mmu_cache(vma, vmf->address, vmf->pte);
+		update_mmu_tlb(vma, vmf->address, vmf->pte);
 		goto release;
 	}
 
-- 
2.20.1

