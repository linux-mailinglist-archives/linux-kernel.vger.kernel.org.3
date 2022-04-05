Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915824F21C8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiDECo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiDECoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:44:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C920348B21
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649123368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kYLbDoazIMJSeMNhJ5zt7FEdCu3V+kUqTKXo5M6GV7A=;
        b=DsdZCpek7tReqMpcMcautA9qE+ABAufXDD7EE6NYxl/i1OzJsvKW0xd84rZanEbHSRMN36
        uA1OTtOKUvauvvVrT4BG/xlWwDOCAB8HsiPblEsUta7m/DyjKg9Esdd2mafw0jVVme1KNk
        QjpyTy4v8m243zQr1luJfxZENUuWg/4=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-112-evMN9tRyPISt4wWNlEBifA-1; Mon, 04 Apr 2022 21:49:27 -0400
X-MC-Unique: evMN9tRyPISt4wWNlEBifA-1
Received: by mail-io1-f71.google.com with SMTP id z16-20020a05660217d000b006461c7cbee3so7400554iox.21
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 18:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kYLbDoazIMJSeMNhJ5zt7FEdCu3V+kUqTKXo5M6GV7A=;
        b=ZRTXb88HF4HgCMk56trmVtXr9mpqnH7jOZdR9MHssBepVxq31T+dXXwiWW6oCxKPBb
         xmeHB1e0+w/XADcH9knQthOYMo26cIsgb/QzL858qUq0ZG1uplRz9/un7LBCO/25S7Yx
         5y2KR5NbjxOUReLf9idvxuLh3K6HskQ63XUL0WeNNbpGGOKRE2AmsRCWSqOjVfPwqzYC
         GSPKuRGYC0GhcQDRgQIoN9kQofgLUdTeLxoNRI6Rc+AkB+C+TRHZmXVna68XbctyC/Z9
         68fVx9e1FDVUX36AksNAMdYzvhsTAo1c4uU4STuVk47JLkhDGreZO7uN4c0YXCT5OAIi
         y/oQ==
X-Gm-Message-State: AOAM531yUmQCch5bFN2DUTtdWws7xwE9Al9M7tKN+mmENCBDEC7TLTLZ
        BAPkTQxBS7iBIjh/kA1mSr56ZYqGw1k+D2BEhj/63ZWG2Gg1WrShoEhTurGDWMpwMR1ggpmBNZ3
        BEbLaL49Jpy9E1koxT+QrdMNDEInmRIYdkaq3CbQcRTxTWGuh8X0pl2CqqQFW+ZLKvndiOLgelA
        ==
X-Received: by 2002:a05:6602:2c0d:b0:60f:6ac8:ad05 with SMTP id w13-20020a0566022c0d00b0060f6ac8ad05mr539106iov.175.1649123366511;
        Mon, 04 Apr 2022 18:49:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIt71qNBgRyuVjW7pMNtAgATJ9MNf0M9CvhTW16IXYsjPRDdAvOlDVVqXJGfZlYTfnSe8R1g==
X-Received: by 2002:a05:6602:2c0d:b0:60f:6ac8:ad05 with SMTP id w13-20020a0566022c0d00b0060f6ac8ad05mr539087iov.175.1649123366302;
        Mon, 04 Apr 2022 18:49:26 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id m9-20020a0566022ac900b0064cf3d9f35fsm2767620iov.35.2022.04.04.18.49.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Apr 2022 18:49:26 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
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
        Alistair Popple <apopple@nvidia.com>, peterx@redhat.com
Subject: [PATCH v8 20/23] mm/pagemap: Recognize uffd-wp bit for shmem/hugetlbfs
Date:   Mon,  4 Apr 2022 21:49:23 -0400
Message-Id: <20220405014923.15047-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220405014646.13522-1-peterx@redhat.com>
References: <20220405014646.13522-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This requires the pagemap code to be able to recognize the newly introduced
swap special pte for uffd-wp, meanwhile the general case for hugetlb that we
recently start to support.  It should make pagemap uffd-wp support complete.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/proc/task_mmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index f46060eb91b5..194dfd7abf2b 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1421,6 +1421,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		migration = is_migration_entry(entry);
 		if (is_pfn_swap_entry(entry))
 			page = pfn_swap_entry_to_page(entry);
+		if (pte_marker_entry_uffd_wp(entry))
+			flags |= PM_UFFD_WP;
 	}
 
 	if (page && !PageAnon(page))
@@ -1556,10 +1558,15 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
 		if (page_mapcount(page) == 1)
 			flags |= PM_MMAP_EXCLUSIVE;
 
+		if (huge_pte_uffd_wp(pte))
+			flags |= PM_UFFD_WP;
+
 		flags |= PM_PRESENT;
 		if (pm->show_pfn)
 			frame = pte_pfn(pte) +
 				((addr & ~hmask) >> PAGE_SHIFT);
+	} else if (pte_swp_uffd_wp_any(pte)) {
+		flags |= PM_UFFD_WP;
 	}
 
 	for (; addr != end; addr += PAGE_SIZE) {
-- 
2.32.0

