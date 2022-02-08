Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A314AD13B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbiBHFq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbiBHFqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 00:46:55 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2024C0401EA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 21:46:54 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id x65so2520189pfx.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 21:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZWLmgm9buCbXqY23s5VhjmfJZhCL4RghEpABSyXi0/w=;
        b=0HYhkWbJnwjpTlx6yPo8iGOzEbRV18XhnOFuEUyVggVDiXTNWhIYIA/aPOw0uT/L09
         yYlF5uQgKM92dhsGYUFEULlf710NYp+6d5gV72NVyUEGVTIeAnH/far1EjAK173nhvMA
         GjeUDLqL5ol5Xc/S8j13re2FPQ9DbSQqW4hnoMvWW0ONXTDzniTB/sZvR27PUX0rMR31
         2IaLUB3SKzesIpY3I5KoXVmMF8mTMmaVUWVDnPWX1VyYk6Y9IovfyCE5NfGDDwrp7+vU
         YDwbvjgGwRCxwOisVBbjwLb+EY70DD8YjVX2AO/x2nJabwLLDDkrf3fSuV6Gb6SzM5iE
         q6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZWLmgm9buCbXqY23s5VhjmfJZhCL4RghEpABSyXi0/w=;
        b=mLn6LUn0nSU0zfi8yQLMQYUBEmm6xPccyIOE+oX9ACpp1mq827iP3Ez/h/tmy6DroZ
         +0GBfcVU1Es2cJjzL7ikCerypRIp7myaK2oOLZgNtzma2ZdSl0zv27s2uKByZ09iuRv6
         1Jp6TmnTaLwMYy0Js8+I1xdnmOIb8+BrfMYie7UQUaJ6FvCGJvmc0dy5RaOWj9fGdI7C
         oAPXL/Y21h+1qpCtp5DhDIHXppfM2AWDbaQhr8MsSYpNC2P0kdGtiqPhG7MA5IbxxT2i
         blc8xRI7UulWviABychmagAVjEXPDTdnwFhJ5GYebUd5dm/l1Tb8D9mcEDjdTjekHS1L
         TJrQ==
X-Gm-Message-State: AOAM533e1ewLat0h5FCfYjF22pe+YwVuSHoh39DNiBC8YG9oueJ7oCA2
        9Sdm+y4bqJuxnnhhR8nQbiOOcQ==
X-Google-Smtp-Source: ABdhPJwaR77nsHjzpwtt7ubQtGVX/NP0wNsgi1dJyCP5hRbqwsfRyYHkv7pveQ5ABAYLcpJ/rdv9DQ==
X-Received: by 2002:a63:df46:: with SMTP id h6mr2348666pgj.26.1644299214205;
        Mon, 07 Feb 2022 21:46:54 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id 20sm1160680pjf.15.2022.02.07.21.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 21:46:53 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     will@kernel.org, akpm@linux-foundation.org, david@redhat.com,
        bodeddub@amazon.com, osalvador@suse.de, mike.kravetz@oracle.com,
        rientjes@google.com, mark.rutland@arm.com, catalin.marinas@arm.com,
        james.morse@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 1/2] arm64: avoid flushing icache multiple times on contiguous HugeTLB
Date:   Tue,  8 Feb 2022 13:46:31 +0800
Message-Id: <20220208054632.66534-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a contiguous HugeTLB page is mapped, set_pte_at() will be called
CONT_PTES/CONT_PMDS times.  Therefore, __sync_icache_dcache() will
flush cache multiple times if the page is executable (to ensure
the I-D cache coherency).  However, the first flushing cache already
covers subsequent cache flush operations.  So only flusing cache
for the head page if it is a HugeTLB page to avoid redundant cache
flushing.  In the next patch, it is also depends on this change
since the tail vmemmap pages of HugeTLB is mapped with read-only
meanning only head page struct can be modified.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/arm64/mm/flush.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index 2aaf950b906c..a06c6ac770d4 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -52,6 +52,13 @@ void __sync_icache_dcache(pte_t pte)
 {
 	struct page *page = pte_page(pte);
 
+	/*
+	 * HugeTLB pages are always fully mapped, so only setting head page's
+	 * PG_dcache_clean flag is enough.
+	 */
+	if (PageHuge(page))
+		page = compound_head(page);
+
 	if (!test_bit(PG_dcache_clean, &page->flags)) {
 		sync_icache_aliases((unsigned long)page_address(page),
 				    (unsigned long)page_address(page) +
-- 
2.11.0

