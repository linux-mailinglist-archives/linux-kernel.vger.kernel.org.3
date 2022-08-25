Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F095A1735
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243344AbiHYQuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243302AbiHYQtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:49:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14899BD10A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661446033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0pHEpCNYxkjW/UyrCPUA7dfCnACPQEp1wsHh/kCfEpU=;
        b=A34mHb6zTugEdf9bscB4hZUUfCUNI15PUMeS9Lvhx57J4mSiD4Z5XA22rJ3y8aeklkAxVM
        r3AmOwE4orF+mDmNq/s6OQ3R2UACMX6IS7O6FnZpZ5RycRlzgyNWZS45sArOEBlwXpQYir
        7Xjzrkx/xcDeAcvUEbTZKW1md94Qidg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-YJeOGrswNsy7KzmUBM-aoA-1; Thu, 25 Aug 2022 12:47:12 -0400
X-MC-Unique: YJeOGrswNsy7KzmUBM-aoA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D0FB101AA45;
        Thu, 25 Aug 2022 16:47:11 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.192.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8104492CA2;
        Thu, 25 Aug 2022 16:47:09 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>
Subject: [PATCH v1 3/3] mm: fixup documentation regarding pte_numa() and PROT_NUMA
Date:   Thu, 25 Aug 2022 18:46:59 +0200
Message-Id: <20220825164659.89824-4-david@redhat.com>
In-Reply-To: <20220825164659.89824-1-david@redhat.com>
References: <20220825164659.89824-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pte_numa() no longer exists -- replaced by pte_protnone() -- and PROT_NUMA
probably never existed: MM_CP_PROT_NUMA also ends up using PROT_NONE.

Let's fixup the doc.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm_types.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index cf97f3884fda..85a6e9853b7b 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -631,22 +631,22 @@ struct mm_struct {
 #endif
 #ifdef CONFIG_NUMA_BALANCING
 		/*
-		 * numa_next_scan is the next time that the PTEs will be marked
-		 * pte_numa. NUMA hinting faults will gather statistics and
-		 * migrate pages to new nodes if necessary.
+		 * numa_next_scan is the next time that PTEs will be remapped
+		 * PROT_NONE to trigger NUMA hinting faults; such faults gather
+		 * statistics and migrate pages to new nodes if necessary.
 		 */
 		unsigned long numa_next_scan;
 
-		/* Restart point for scanning and setting pte_numa */
+		/* Restart point for scanning and remapping PTEs. */
 		unsigned long numa_scan_offset;
 
-		/* numa_scan_seq prevents two threads setting pte_numa */
+		/* numa_scan_seq prevents two threads remapping PTEs. */
 		int numa_scan_seq;
 #endif
 		/*
 		 * An operation with batched TLB flushing is going on. Anything
 		 * that can move process memory needs to flush the TLB when
-		 * moving a PROT_NONE or PROT_NUMA mapped page.
+		 * moving a PROT_NONE mapped page.
 		 */
 		atomic_t tlb_flush_pending;
 #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
-- 
2.37.1

