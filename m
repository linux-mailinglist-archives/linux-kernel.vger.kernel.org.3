Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DAD58E247
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiHIWBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiHIWBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:01:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19C28E08
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660082470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KrXV1mhD8NFSPZwAf9c4FL2hL9qvLlZq2jcNtWuZzdA=;
        b=YWQlnY9GGa44oSDEKV+26Vjp8Ia44VGC1qVFzT6lr+WhlET05t0YRfya4RNVcyjEkSOXju
        bI3FY4OiuoGNUquJ13Yz/SDv2WDzL2hX0fQw/eYNcuPGnSdJMYd/XaYbYgc2M93Gc2l507
        LZ9jrkmiOXE2diKDFvwZSuSDGD8FUAE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189-37XCWSq8ORS9edrlrLQvMA-1; Tue, 09 Aug 2022 18:01:09 -0400
X-MC-Unique: 37XCWSq8ORS9edrlrLQvMA-1
Received: by mail-qv1-f72.google.com with SMTP id oh2-20020a056214438200b0047bd798af75so1659534qvb.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=KrXV1mhD8NFSPZwAf9c4FL2hL9qvLlZq2jcNtWuZzdA=;
        b=IzIz+Q0XRDpRPAoVRUqwLSTzcOdi1d1N7iIHg+zesc1McScH+ZRhvZoDRx2Akz1r8L
         MPwmvXJpsMWb/9pPMgJied5RcMfe2nvXKldUdc5261Ar017x8Y1dK5osyRD8Iy0+/iOO
         d9q98TIAsirukNdWtUkfNSdQxX9mlWzktuPBo/273XL32M4sUMKWa1T+XPqL2XQCOYOR
         MxgCZWWNTPKzC6UZIW1QpEIO2rs7DLNJFvgoMwKF+UT9VFCTW8nRtGGsS45wgeNR7SxD
         f/oOzX9Y3ltukhem32gohx3FzI+7p9BkJ6IjArctzokrWpkQViWgDJ+fGK/MmrElIIJd
         SI9g==
X-Gm-Message-State: ACgBeo39L7d+zfvwKycYT5GCE0G/7m6IzgWAj3BvZwgvr+3Hq6zYcqwu
        yAhJzXo3lzFWJw1aTmyLWFIIy4ZtM93izrevGAeGa4IKAnGpEd+JcMEDFtRJ96gs66wSxiFnDFu
        xJ3KJ0FujuHhHrJ/qPpp8NN5L
X-Received: by 2002:a05:6214:f24:b0:476:72bb:2473 with SMTP id iw4-20020a0562140f2400b0047672bb2473mr21833890qvb.82.1660082468620;
        Tue, 09 Aug 2022 15:01:08 -0700 (PDT)
X-Google-Smtp-Source: AA6agR53TiwBc9GpPqRdwAZDQe2UaVr8TnIHRxStNg8j6qBByy+9hjyDW7m38tabiWtpuwTjDL75Bw==
X-Received: by 2002:a05:6214:f24:b0:476:72bb:2473 with SMTP id iw4-20020a0562140f2400b0047672bb2473mr21833862qvb.82.1660082468439;
        Tue, 09 Aug 2022 15:01:08 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id b16-20020a05622a021000b0031eddc83560sm10563383qtx.90.2022.08.09.15.01.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Aug 2022 15:01:08 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v3 4/7] mm/thp: Carry over dirty bit when thp splits on pmd
Date:   Tue,  9 Aug 2022 18:00:57 -0400
Message-Id: <20220809220100.20033-5-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220809220100.20033-1-peterx@redhat.com>
References: <20220809220100.20033-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carry over the dirty bit from pmd to pte when a huge pmd splits.  It
shouldn't be a correctness issue since when pmd_dirty() we'll have the page
marked dirty anyway, however having dirty bit carried over helps the next
initial writes of split ptes on some archs like x86.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/huge_memory.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0611b2fd145a..e8e78d1bac5f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2005,7 +2005,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	pgtable_t pgtable;
 	pmd_t old_pmd, _pmd;
 	bool young, write, soft_dirty, pmd_migration = false, uffd_wp = false;
-	bool anon_exclusive = false;
+	bool anon_exclusive = false, dirty = false;
 	unsigned long addr;
 	int i;
 
@@ -2098,6 +2098,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			SetPageDirty(page);
 		write = pmd_write(old_pmd);
 		young = pmd_young(old_pmd);
+		dirty = pmd_dirty(old_pmd);
 		soft_dirty = pmd_soft_dirty(old_pmd);
 		uffd_wp = pmd_uffd_wp(old_pmd);
 
@@ -2161,6 +2162,9 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 				entry = pte_wrprotect(entry);
 			if (!young)
 				entry = pte_mkold(entry);
+			/* NOTE: this may set soft-dirty too on some archs */
+			if (dirty)
+				entry = pte_mkdirty(entry);
 			if (soft_dirty)
 				entry = pte_mksoft_dirty(entry);
 			if (uffd_wp)
-- 
2.32.0

