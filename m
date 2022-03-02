Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB874C9FB8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbiCBIrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiCBIri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:47:38 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9886BABA4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:46:55 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 12so1098116pgd.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 00:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZWLmgm9buCbXqY23s5VhjmfJZhCL4RghEpABSyXi0/w=;
        b=QeneTRGP9wfQ25M47Q+R8Wl68p5vbBqnFJgw6WQkaxsfswBfxD1OITyA/HIqzBVEo2
         AZnzxKeNl71ZMwKvldPBo/wm56YZT2vbzLAEyG8hvJerHG+nXA3Zw60rCyyOd0IpAdop
         J5DaQ73SFL4Scu7mhuf9krPmf8PFtNI7oPVChKCk6vmzr9midVGbN6LbpOIaShuS9YYg
         bGP22tPqpAGxGlbbLkhLm4bbuSykKGe4jJAwXg0fUSGEYcyZYd6ndab19DhXAeVFaVkB
         jcJ8izz4tngPcWkiO8vQR5PPQLzHKWKeHu0zP523nhOOPDxxIA4DenbBNVzA1yYmCiMi
         gIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZWLmgm9buCbXqY23s5VhjmfJZhCL4RghEpABSyXi0/w=;
        b=2ZjeQW8MKhrR/B6uN7eoiXmKVwDop5Zloo55H/78YFkZjaC7mzzVqNfMyxwK9mfvQR
         krdoFKLTRe6N9rDPIvJ2hkJbnQBmDgxQcTqfErP/EEOioecjQ5Xmqp6NTeu2GHBIbK23
         rolCz+tknALEzt4/3U43sBzkbeeqXam8JTecVv8rvjeT+Sn0TTgfs2FLytzvNcmk85R4
         rVz3RF+9AN2eUS7LOamNvvi3q81+MBN/odEqZg7QT1Zeb+39nLZYPf/RCrWezmSgVlQS
         oYTQf/wkb0U1HoLEjZn1C/l4QqAJz1Tds0tZl8gJpmi74AuAmwrMjr0baEEqgQYU7RC5
         scjg==
X-Gm-Message-State: AOAM530pseLzgKAZwd3KHs7fLb4HbwWrLqw0OlSk3gPoYBAsxm7oCKa3
        4rNuM73MtcyayOsfeSqJaMo7Kw==
X-Google-Smtp-Source: ABdhPJxKaSrM6iBBGkvbdb2L3RZylc2pqe5tLOOKYk/MoVAf2KGjquxtsY4qytU/fXNy/oElueVSrg==
X-Received: by 2002:a63:4386:0:b0:378:b62e:28b3 with SMTP id q128-20020a634386000000b00378b62e28b3mr11156359pga.442.1646210813974;
        Wed, 02 Mar 2022 00:46:53 -0800 (PST)
Received: from FVFYT0MHHV2J.bytedance.net ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id s10-20020a63214a000000b003652f4ee81fsm14828816pgm.69.2022.03.02.00.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 00:46:53 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     will@kernel.org, akpm@linux-foundation.org, david@redhat.com,
        bodeddub@amazon.com, osalvador@suse.de, mike.kravetz@oracle.com,
        rientjes@google.com, mark.rutland@arm.com, catalin.marinas@arm.com,
        james.morse@arm.com, song.bao.hua@hisilicon.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 RESEND 1/2] arm64: avoid flushing icache multiple times on contiguous HugeTLB
Date:   Wed,  2 Mar 2022 16:46:23 +0800
Message-Id: <20220302084624.33340-1-songmuchun@bytedance.com>
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

