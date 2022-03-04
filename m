Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B221C4CCCF1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238090AbiCDFTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238095AbiCDFTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:19:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BAF6BF8B84
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 21:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646371141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n7rwO48JtzdkJuoHFZCI8H9KL9Pu0D4gPtoWSB8Kejg=;
        b=ecAZ2Y+vYtgrk7sA2cJMta3taQpgBxozb0/JKhMInqcxd/a4jFyNecvvtJi1IF3DrwBz40
        6cVwomrlUlB5c1R9r4kWhCCcYpVNGqMebd4Hk9Q4BIotDjeJjA4wA3t4eHUcIrXHYrrKUH
        bECSPROEp/EL0PkLGdkHH6tbO67Pduw=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-NJAUmqREMhauC9GZO3UN0A-1; Fri, 04 Mar 2022 00:19:00 -0500
X-MC-Unique: NJAUmqREMhauC9GZO3UN0A-1
Received: by mail-pg1-f200.google.com with SMTP id h12-20020a63530c000000b0037c8f45bf1bso1026095pgb.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 21:19:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n7rwO48JtzdkJuoHFZCI8H9KL9Pu0D4gPtoWSB8Kejg=;
        b=Z6gT0HuqO7KkQDsBKYNvB3d6StQ0OOpRMyMyoNDDT8jFMdnz+7CKW+/6jH9t0ncOkg
         WGL91LqJNrMtx7ZjfqFXsiRCyEVI58Bt1bxXyqL55zY/R4M5ZNQ25w07+mx7wc/bisC7
         DTmH2tPNOW/E4uJIUu2aWfRjKsn3UHHFcAq/LpKb3u/rve8mS6RSM3dO3Kgubdh/wmM8
         xQxqyHq69GYURiQprnBx/wuIaoGSzGMsVZPW8C66AY1DN7sV9DFJqs6fD6Qge7/8xqaA
         Vzj63O5xGDAp+U2scx7b2LOBe3ObwT9zdDsXLBre2WcXvR/VhYCBy0X+5vKzsI/W2+Rc
         FKzg==
X-Gm-Message-State: AOAM532pEcGk43dPJc3Qf8gxUacIn6YRkQLYf3RzHsnp5R0mINfEVahP
        9ERsLi+ln+Pv5+MS9FGz2SRqs56gKjlfqB/wyzV4miROmLdyFB6fueg0jTvHJsOp9xlmL1G6Qs1
        Tcy0zr3Pbh0RzN7BO6j7qx+a8
X-Received: by 2002:a17:902:bc83:b0:14f:d9b7:ab3 with SMTP id bb3-20020a170902bc8300b0014fd9b70ab3mr38914578plb.23.1646371139355;
        Thu, 03 Mar 2022 21:18:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyxQvXTM1bbdfv800pkAzqKOP1rVnQ9jp11rKIolBaZd7PJNXmzE+rE+wUwHWSuQvUScVEx9A==
X-Received: by 2002:a17:902:bc83:b0:14f:d9b7:ab3 with SMTP id bb3-20020a170902bc8300b0014fd9b70ab3mr38914569plb.23.1646371139079;
        Thu, 03 Mar 2022 21:18:59 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.59])
        by smtp.gmail.com with ESMTPSA id p16-20020a056a000b5000b004f669806cd9sm4323865pfo.87.2022.03.03.21.18.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Mar 2022 21:18:58 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v7 12/23] mm/hugetlb: Hook page faults for uffd write protection
Date:   Fri,  4 Mar 2022 13:16:57 +0800
Message-Id: <20220304051708.86193-13-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304051708.86193-1-peterx@redhat.com>
References: <20220304051708.86193-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index b34f50156f7e..d2539e2fe066 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5680,6 +5680,26 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
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
 	 * hugetlb_cow() requires page locks of pte_page(entry) and
 	 * pagecache_page, so here we need take the former one
-- 
2.32.0

