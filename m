Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AF252DCD4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243935AbiESSah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243955AbiESSac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:30:32 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6861AED8E2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:30:24 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id i1so5510684plg.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mGwVn8RHselKV0air8yMqpzaEEJKFNShOYXjybSXJNI=;
        b=GGS28zJ2n2buwhhkptrcMlxiv/ufYgHyGsbryhRNp3gNf94fakNVd+3CP6VO6oLiHO
         4SPYQzlz8D9i7daFH1molB3QLlP8VJ/KGVCqbJdr02oaQEhcJBj2pVKDWpWDArmB1RSD
         CRYwCc8aQufDQCLI7pILGztuHJIzcNKBGVJWgEftXS2StQPkocMb57XlZsjqHSwS4OMd
         +bG6y9kcYZyWesa+NUzWt8dNKs/eco+x43uzhC2YKiCA0psA6d+JlXlW1z/QlBflv5kZ
         GCPSFju9p6WrOej/yIx5CFC+SUa79W/LYShld15IKoIBlf8GOQLD2qKoL7G5U6lxjhHq
         P+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mGwVn8RHselKV0air8yMqpzaEEJKFNShOYXjybSXJNI=;
        b=B5FtFylg06rza2Eb2Vs54YQbB6FnNlcfOuNyCLVsmr/nZhUjfj0gshiu7JHWDyOcaz
         mhRPnrmZHNGuq98wPaaB3tham3GTX3dbosCN5hKRGjg4jBVtCc8OhSTPlrWne2pwB/RC
         PClDetVNr7zd2y9/ZZ3D/f4auPdlvcnRUmsodoEdVyhQCIB/7ZgMn7rkQCVwDIKgmVOK
         ngi9hg3q3TXTinoVAV1g8WiOZlXLEO7dUl6kQf/G80bm9fYVrbNcgkMWzzunev15jiBX
         HdA8ONLNg+9Exd2bZbYWHDWrhoybRqNGUKVDKm4tm87oVZbT5/h8cdpQIFrU6QbmqH08
         LBuQ==
X-Gm-Message-State: AOAM533NUBhk/tgy7nh9v1ama+builVSqHxdelywv5kTccI3jLFG/Fni
        Sx7kOGiwHeE7GRRQo+TV884=
X-Google-Smtp-Source: ABdhPJxT1QxjP12z0PKvPrABcDUayvMg83/qvOvUBLREZ00HVl+HxsB9o+PmAXQYSJAqpz/2P+yNRw==
X-Received: by 2002:a17:902:da90:b0:15e:adc2:191d with SMTP id j16-20020a170902da9000b0015eadc2191dmr5907894plx.134.1652985023806;
        Thu, 19 May 2022 11:30:23 -0700 (PDT)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.googlemail.com with ESMTPSA id z5-20020a63e105000000b003c14af505f6sm3884674pgh.14.2022.05.19.11.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 11:30:23 -0700 (PDT)
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Suren Baghdasaryan <surenb@google.com>,
        Chih-En Lin <shiyn.lin@gmail.com>,
        Colin Cross <ccross@google.com>,
        Feng Tang <feng.tang@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mike Rapoport <rppt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, Kaiyang Zhao <zhao776@purdue.edu>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Jim Huang <jserv.tw@gmail.com>
Subject: [RFC PATCH 3/6] mm, pgtable: Add ownership for the PTE table
Date:   Fri, 20 May 2022 02:31:24 +0800
Message-Id: <20220519183127.3909598-4-shiyn.lin@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220519183127.3909598-1-shiyn.lin@gmail.com>
References: <20220519183127.3909598-1-shiyn.lin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the ownership for the PTE table to prepare the following patch
of the Copy-On-Write (COW) page table. It uses the address of PMD index
to become the owner to identify which process can update its page table
state from the COW page table.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 include/linux/mm.h       |  1 +
 include/linux/mm_types.h |  1 +
 include/linux/pgtable.h  | 14 ++++++++++++++
 3 files changed, 16 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9f44254af8ce..221926a3d818 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2328,6 +2328,7 @@ static inline bool pgtable_pte_page_ctor(struct page *page)
 		return false;
 	__SetPageTable(page);
 	inc_lruvec_page_state(page, NR_PAGETABLE);
+	page->cow_pte_owner = NULL;
 	return true;
 }
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 8834e38c06a4..5dcbd7f6c361 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -221,6 +221,7 @@ struct page {
 #ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
 	int _last_cpupid;
 #endif
+	pmd_t *cow_pte_owner; /* cow pte: pmd */
 } _struct_page_alignment;
 
 /**
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index f4f4077b97aa..faca57af332e 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -590,6 +590,20 @@ static inline int pte_unused(pte_t pte)
 }
 #endif
 
+static inline bool set_cow_pte_owner(pmd_t *pmd, pmd_t *owner)
+{
+	struct page *page = pmd_page(*pmd);
+
+	smp_store_release(&page->cow_pte_owner, owner);
+	return true;
+}
+
+static inline bool cow_pte_owner_is_same(pmd_t *pmd, pmd_t *owner)
+{
+	return (smp_load_acquire(&pmd_page(*pmd)->cow_pte_owner) == owner) ?
+		true : false;
+}
+
 #ifndef pte_access_permitted
 #define pte_access_permitted(pte, write) \
 	(pte_present(pte) && (!(write) || pte_write(pte)))
-- 
2.36.1

