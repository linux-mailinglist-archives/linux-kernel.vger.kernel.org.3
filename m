Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DA74F21D7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiDECn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiDECnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:43:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B265315AE24
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649123342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1OYbScRjTNz5QBi4xGatPlRbPmUiT0LOinB85jUkB/M=;
        b=L/BBwTYeBPsyYH4JiLRV2thymvAaY+vrSAIi67NrTTwBKM8boXGihDQShxCNODnL2UOEAY
        0ELSrhYIa3phD0eKYKVtVB75NbeydG4JlbKuLGnimj1I0WyiZ2eiNX+yuNCzEpKon47PWv
        aL8E9Usqd7fRKR3M6iK7lz1H42yDeOA=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-PnNWMM54ME6FFusKLR1g5w-1; Mon, 04 Apr 2022 21:49:02 -0400
X-MC-Unique: PnNWMM54ME6FFusKLR1g5w-1
Received: by mail-io1-f69.google.com with SMTP id x16-20020a6bfe10000000b006409f03e39eso7462484ioh.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 18:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1OYbScRjTNz5QBi4xGatPlRbPmUiT0LOinB85jUkB/M=;
        b=njevMjeQHqnssYvm05IxuFjGh0Ow5j3csBZ3jVXQlnaSkoBM5AH1dpkmWTnPWl79dV
         PCPKKwsTtgAEdbbBy+stYOn7kSEuE6Y7XNP0yr8jAoAehIzQUeDVT4qPr/LzuR1DEEFJ
         zouX1G5BotDBx+M18a9RTFD+urc0s3RDmbiZbU/0TWu/FLL0jYQ3QhLf6PzeywCpH8NK
         eRSxNII67jBLD6nd6/nbK1vp+UcwDemDA17ancaaU/bEQ8DwkXystq1JtPx664YRddv0
         MY78IRtPS53XyLyU/k/K+m01Q2qovQq0jzpsLs/ayaDbOuEdTxEdNJPvWhBhv7U0QtbD
         QBLA==
X-Gm-Message-State: AOAM5303R+iWCB0l9u3EEkbKj6APeUVYflyPpPo1xou7T9dyqh7ikwgE
        YZ6RswZq/PboHHUvL0T2j9k1JC4rbPHrWmA3+FIuJmHpL7hMimNViuGeEfMLsIvPftOmXu+Rrqd
        663UzrpBruFn6UbsYq9G/q9dGCoFYtkXelH68hBIec5kme8MRSHoKVL0mwsWonEymawBdQTDrqw
        ==
X-Received: by 2002:a05:6638:a3a:b0:323:5c6d:ae20 with SMTP id 26-20020a0566380a3a00b003235c6dae20mr735143jao.80.1649123341205;
        Mon, 04 Apr 2022 18:49:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMAeWuW/3+txDsVV62vki1LADOgkDFuyCvrbdc9Pj11bhRHmjppURbT8nshi8PLqZuUQv4iQ==
X-Received: by 2002:a05:6638:a3a:b0:323:5c6d:ae20 with SMTP id 26-20020a0566380a3a00b003235c6dae20mr735120jao.80.1649123340991;
        Mon, 04 Apr 2022 18:49:00 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id l14-20020a05660227ce00b00645ebb013c1sm8287007ios.45.2022.04.04.18.48.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Apr 2022 18:49:00 -0700 (PDT)
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
Subject: [PATCH v8 11/23] mm/hugetlb: Introduce huge pte version of uffd-wp helpers
Date:   Mon,  4 Apr 2022 21:48:58 -0400
Message-Id: <20220405014858.14531-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220405014646.13522-1-peterx@redhat.com>
References: <20220405014646.13522-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
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
index bea47e7cc6a0..be99eda87f4d 100644
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

