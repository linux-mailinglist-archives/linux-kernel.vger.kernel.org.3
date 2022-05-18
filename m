Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF1552B3E5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbiERHtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbiERHtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:49:43 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993AD122B47;
        Wed, 18 May 2022 00:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652860182; x=1684396182;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=lSIe3VyW9rMeUh0m88iIR7bL+fGEX4/7scgZGDYUqTo=;
  b=uniKWtko1U15hq26Pc97dk32cb/2DgbGq8AzopcSzEqXWnFVBo5eRxvT
   4LY69pQjZChG9ZBm78Yk8ofRluRWgY9oPXx6AObkdiapiBszGy20vu3k1
   MhCGi8wfIs4UGetnuiMSx5apcy0Iy+RNRw3/4Hqn3NmHNSu9L0Y4fA5pG
   g=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 18 May 2022 00:49:42 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 00:49:42 -0700
Received: from blr-ubuntu-185.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 18 May 2022 00:49:33 -0700
From:   Vivek Kumar <quic_vivekuma@quicinc.com>
To:     <corbet@lwn.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <tglx@linutronix.de>, <maz@kernel.org>, <axboe@kernel.dk>,
        <rafael@kernel.org>, <akpm@linux-foundation.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-mm@kvack.org>
CC:     <len.brown@intel.com>, <pavel@ucw.cz>, <paulmck@kernel.org>,
        <bp@suse.de>, <keescook@chromium.org>, <songmuchun@bytedance.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <pasha.tatashin@soleen.com>, <tabba@google.com>, <ardb@kernel.org>,
        <tsoni@quicinc.com>, <quic_psodagud@quicinc.com>,
        <quic_svaddagi@quicinc.com>,
        Vivek Kumar <quic_vivekuma@quicinc.com>,
        Prasanna Kumar <quic_kprasan@quicinc.com>
Subject: [RFC 5/6] Hibernate: Add check for pte_valid in saveable page
Date:   Wed, 18 May 2022 13:18:40 +0530
Message-ID: <1652860121-24092-6-git-send-email-quic_vivekuma@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652860121-24092-1-git-send-email-quic_vivekuma@quicinc.com>
References: <1652860121-24092-1-git-send-email-quic_vivekuma@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add check for pte_valid in saveable page after being checked for
the rest. This is required as PTE is removed for pages allocated
with dma_alloc_coherent with DMA_ATTR_NO_KERNEL_MAPPING flag set.
This patch makes sure that these pages are not considered for
snapshot.

Signed-off-by: Vivek Kumar <quic_vivekuma@quicinc.com>
Signed-off-by: Prasanna Kumar <quic_kprasan@quicinc.com>
---
 kernel/power/snapshot.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 2a40675..a6ad2a5 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1308,6 +1308,41 @@ static inline void *saveable_highmem_page(struct zone *z, unsigned long p)
 }
 #endif /* CONFIG_HIGHMEM */
 
+static bool kernel_pte_present(struct page *page)
+{
+	pgd_t *pgdp;
+	p4d_t *p4dp;
+	pud_t *pudp, pud;
+	pmd_t *pmdp, pmd;
+	pte_t *ptep;
+	unsigned long addr = (unsigned long)page_address(page);
+
+	pgdp = pgd_offset_k(addr);
+	if (pgd_none(READ_ONCE(*pgdp)))
+		return false;
+
+	p4dp = p4d_offset(pgdp, addr);
+	if (p4d_none(READ_ONCE(*p4dp)))
+		return false;
+
+	pudp = pud_offset(p4dp, addr);
+	pud = READ_ONCE(*pudp);
+	if (pud_none(pud))
+		return false;
+	if (pud_sect(pud))
+		return true;
+
+	pmdp = pmd_offset(pudp, addr);
+	pmd = READ_ONCE(*pmdp);
+	if (pmd_none(pmd))
+		return false;
+	if (pmd_sect(pmd))
+		return true;
+
+	ptep = pte_offset_kernel(pmdp, addr);
+	return pte_valid(READ_ONCE(*ptep));
+}
+
 /**
  * saveable_page - Check if the given page is saveable.
  *
@@ -1341,6 +1376,14 @@ static struct page *saveable_page(struct zone *zone, unsigned long pfn)
 	    && (!kernel_page_present(page) || pfn_is_nosave(pfn)))
 		return NULL;
 
+	/*
+	 * Even if page is not reserved and if it's not present in kernel PTE;
+	 * don't snapshot it ! This happens to the pages allocated using
+	 * __dma_alloc_coherent with DMA_ATTR_NO_KERNEL_MAPPING flag set.
+	 */
+	if (!kernel_pte_present(page))
+		return NULL;
+
 	if (page_is_guard(page))
 		return NULL;
 
-- 
2.7.4

