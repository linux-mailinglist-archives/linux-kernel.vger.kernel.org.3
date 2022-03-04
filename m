Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542354CCCF3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238072AbiCDFTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238121AbiCDFTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:19:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5807EF1EA1
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 21:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646371133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jyv1lzZ4mkTvzdL9kLWgnj86vlKE/ygyLYqVdoUf6Sw=;
        b=VXl9iCoiO9qlufgXhHbdWOyK+RBcsRdQPGh7ddP0bZElMiSsCioVmCE49qDkEZgsDIg0MW
        SDV8mzBkOHzcw4lQ+oEMaHErKC8hdb81RGE2jXUsJRctXTIV7fWGnOsdaO85CLqBIyfgTG
        B3imoILp1uw7H20QngzhOyFBR007LDk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-481-qQiV0rURMXqdGsEzr2f61g-1; Fri, 04 Mar 2022 00:18:52 -0500
X-MC-Unique: qQiV0rURMXqdGsEzr2f61g-1
Received: by mail-pl1-f199.google.com with SMTP id n12-20020a170902e54c00b0015011534fa3so4107140plf.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 21:18:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jyv1lzZ4mkTvzdL9kLWgnj86vlKE/ygyLYqVdoUf6Sw=;
        b=ajn9wtqVyKKw8AjP5rOuGudoDZOr9Ncj+Mb6I2Xft4pRqn/kFUtVGn6yXbRNLAwNyB
         hHafJVw5bSqzoltIWDu4m+qwSiKBWOcfH7tgui4Nl03T+HwYY5eN2/Fpng2u0s00owCV
         90lmjV/dGpNynEg9RRCBZJwLQ1JpRWYfxjmseeij7d6r7uNhVu2ZrDWcIMQAeSpvPS6n
         mtKiziNhCdc5eu3sSua5VRkQWCQWtArAssVwQ2rSErRuuVCDIIsAtXC7slSBZrIPghnm
         Q8slCKYBUnFj9uNAh9ttNYojGa+QuEY4U9btR3qu95tEzkKRgjm2lm/1hncMBjGSwtfZ
         CziA==
X-Gm-Message-State: AOAM530eYZafTfjtgVBW27JsYVAcwxhQ1xy1XEfXlQU8v1FLGPLpWw4l
        9gPrd8minknk/NPINZvUt4KRisjVqvaN+gCJ23Oc/P8o32UCly63111KKD5LRngRrMT7Xis5f0e
        +izxEkxd5A63VOJS67NfDU0NH
X-Received: by 2002:a63:944:0:b0:374:5324:eea1 with SMTP id 65-20020a630944000000b003745324eea1mr33249203pgj.366.1646371131327;
        Thu, 03 Mar 2022 21:18:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhisbQFqQkhrO4+7tBm5bGrC3HEMdBg8mxUGWFFpK8iGmzvB3YNBGzza29cCioxbX4vov0sQ==
X-Received: by 2002:a63:944:0:b0:374:5324:eea1 with SMTP id 65-20020a630944000000b003745324eea1mr33249184pgj.366.1646371131059;
        Thu, 03 Mar 2022 21:18:51 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.59])
        by smtp.gmail.com with ESMTPSA id p16-20020a056a000b5000b004f669806cd9sm4323865pfo.87.2022.03.03.21.18.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Mar 2022 21:18:50 -0800 (PST)
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
Subject: [PATCH v7 11/23] mm/hugetlb: Introduce huge pte version of uffd-wp helpers
Date:   Fri,  4 Mar 2022 13:16:56 +0800
Message-Id: <20220304051708.86193-12-peterx@redhat.com>
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

They will be used in the follow up patches to either check/set/clear uffd-wp
bit of a huge pte.

So far it reuses all the small pte helpers.  Archs can overwrite these versions
when necessary (with __HAVE_ARCH_HUGE_PTE_UFFD_WP* macros) in the future.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/s390/include/asm/hugetlb.h | 15 +++++++++++++++
 include/asm-generic/hugetlb.h   | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
index 60f9241e5e4a..19c4b4431d27 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -115,6 +115,21 @@ static inline pte_t huge_pte_modify(pte_t pte, pgprot_t newprot)
 	return pte_modify(pte, newprot);
 }
 
+static inline pte_t huge_pte_mkuffd_wp(pte_t pte)
+{
+	return pte;
+}
+
+static inline pte_t huge_pte_clear_uffd_wp(pte_t pte)
+{
+	return pte;
+}
+
+static inline int huge_pte_uffd_wp(pte_t pte)
+{
+	return 0;
+}
+
 static inline bool gigantic_page_runtime_supported(void)
 {
 	return true;
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index f39cad20ffc6..896f341f614d 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -35,6 +35,21 @@ static inline pte_t huge_pte_modify(pte_t pte, pgprot_t newprot)
 	return pte_modify(pte, newprot);
 }
 
+static inline pte_t huge_pte_mkuffd_wp(pte_t pte)
+{
+	return pte_mkuffd_wp(pte);
+}
+
+static inline pte_t huge_pte_clear_uffd_wp(pte_t pte)
+{
+	return pte_clear_uffd_wp(pte);
+}
+
+static inline int huge_pte_uffd_wp(pte_t pte)
+{
+	return pte_uffd_wp(pte);
+}
+
 #ifndef __HAVE_ARCH_HUGE_PTE_CLEAR
 static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 		    pte_t *ptep, unsigned long sz)
-- 
2.32.0

