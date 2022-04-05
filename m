Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E041B4F2166
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiDECoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiDECnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:43:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBA461265B0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649123345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cMJ3LqPsnbXMwjHxk9MsuTKHubQJUVkMzfk9UWY8MQ4=;
        b=X/tVQ8WuOQcs0Wry4k6Knl/HQdFenm3wqauPxGciWndda0ShSWTg5YNdxEAd2h1B81Ek4Q
        2g5S7GOjRQ6hYyinImlpnCw3tWIvZktoFMgwppixwBVtaXdU5cz1Ypks3d/eFJEV56rcG1
        TolWm05GZ+RFYX/AfpoMQxKW3B4nkIM=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490--fqfR7a5PF-QmGErn5FBAQ-1; Mon, 04 Apr 2022 21:49:04 -0400
X-MC-Unique: -fqfR7a5PF-QmGErn5FBAQ-1
Received: by mail-il1-f198.google.com with SMTP id o17-20020a92c691000000b002c2c04aebe7so7201424ilg.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 18:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cMJ3LqPsnbXMwjHxk9MsuTKHubQJUVkMzfk9UWY8MQ4=;
        b=V37JTsiuXmt6HVhI/dSGTM12e9LjvHe2059rBZqWgWAEavYvMHgtR3tPPSJ/JkzW3M
         AaXr/M0BZQkuiruS2vTYfEo0SxVvUgsaIGZMGtZTaQdFwkCstth0CWsBQHWKRCdPxJUl
         lyylOxNPYda1buAP/J+WzOPEJZXcwgRbmNJpg7MQddMdU48+mLQ43mt75wDD5iXPnsCg
         46cjiihyPw7cMMTWaHoXKH52lDQ9nXuMgiKXqha5htvibCdgz3ovHNrD5XoXmY/piyUb
         9/epjN5rJs3e1uXJySVGbYT3y+2AcjjR3pH/32oV6Ys5l8dWLtvSRW9nqcFeoeWDTATG
         XlAg==
X-Gm-Message-State: AOAM530uobI3IjEu+nodRcxCLxEwQy1H0DdCP/Qxi1lCV1IJUMnSbY+z
        C9ppKJx0Q8VzpmSg1IAZtUQlCNm4KajeydCB+/3hQJLfNNIx0XPEv76wZH3DpMWw6nN7YRwXQ7H
        /chxDxKdetlXBCnJLrD8tGzfQ+7vtZct8op0FukAao87diUAXrRFfDVS3eaxI0AJF2z6E6P9ytQ
        ==
X-Received: by 2002:a05:6602:2e10:b0:649:e2d4:3334 with SMTP id o16-20020a0566022e1000b00649e2d43334mr586232iow.210.1649123344085;
        Mon, 04 Apr 2022 18:49:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbt1ibJTi0gvyMJwC5hy/Js4ILQPnWU9UGGKs5bKIIkDs9NeLq7C5AVpY51XCUy10wipducA==
X-Received: by 2002:a05:6602:2e10:b0:649:e2d4:3334 with SMTP id o16-20020a0566022e1000b00649e2d43334mr586205iow.210.1649123343719;
        Mon, 04 Apr 2022 18:49:03 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id y8-20020a920908000000b002ca38acaa60sm2917919ilg.81.2022.04.04.18.49.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Apr 2022 18:49:03 -0700 (PDT)
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
Subject: [PATCH v8 12/23] mm/hugetlb: Hook page faults for uffd write protection
Date:   Mon,  4 Apr 2022 21:49:01 -0400
Message-Id: <20220405014901.14590-1-peterx@redhat.com>
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

Hook up hugetlbfs_fault() with the capability to handle userfaultfd-wp faults.

We do this slightly earlier than hugetlb_cow() so that we can avoid taking some
extra locks that we definitely don't need.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index dd642cfc538b..82df0fcfedf9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5711,6 +5711,26 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	if (unlikely(!pte_same(entry, huge_ptep_get(ptep))))
 		goto out_ptl;
 
+	/* Handle userfault-wp first, before trying to lock more pages */
+	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(huge_ptep_get(ptep)) &&
+	    (flags & FAULT_FLAG_WRITE) && !huge_pte_write(entry)) {
+		struct vm_fault vmf = {
+			.vma = vma,
+			.address = haddr,
+			.real_address = address,
+			.flags = flags,
+		};
+
+		spin_unlock(ptl);
+		if (pagecache_page) {
+			unlock_page(pagecache_page);
+			put_page(pagecache_page);
+		}
+		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+		i_mmap_unlock_read(mapping);
+		return handle_userfault(&vmf, VM_UFFD_WP);
+	}
+
 	/*
 	 * hugetlb_wp() requires page locks of pte_page(entry) and
 	 * pagecache_page, so here we need take the former one
-- 
2.32.0

