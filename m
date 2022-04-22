Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED66A50B012
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbiDVGDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbiDVGDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:03:49 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EE54F473
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:00:57 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id b7so8624996plh.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sIHHWuXCFhgIuVLEw6qrEOnv9syAmIvNW41hiA3znas=;
        b=SOBh1fU+ek+mwjGri8dzq6pef9j78Zr2x/jT9SaI85A+HQkk8bA/T2JrdJj03jaz2/
         fcNUQX4nKN+c2RYGvLoXSmG5HKZJOV6nxXnYYrWrG0E1AVaAJwD4k+jotH5A6UeMRhlY
         aVp4sP43Hqgc0cCmT8f+J1Z2BHzjW7467I9ce0l81Buuj2PSru0HCasQKsrM5mq9PXKX
         +uHpndlPMOycVEadM5NXsUqbzd8ROuMS3kixTlEw4Ir4JjvP/9AVvNU2yRsPYg4cUPwt
         09qWlawywp74oZXGvT6TBnrCFpDTMTcTFyE2dZNFn9XmlL47RHvm8/heVC+99RyaYnB3
         TRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sIHHWuXCFhgIuVLEw6qrEOnv9syAmIvNW41hiA3znas=;
        b=8MYNY/PAcrvKbtG4+lVWYArcOIb0bz2kkM+Nhyb7Wdx8O22UCpJXFfyANKhp6J1ijQ
         9hn6BmCzs2YwoGIi3WSdGjduLPagc0a6usj+6jieeakig/liXbVEk8lFVwbqt8raLyqD
         1Q1pb/2CrRPARd12td2uaY48tagnrOv2E83vMYESran/zdtwnlOFSpV9e15fnSyQhsVz
         NIb7p2fY4YlHQZjaz64KrgQvPEimlihj0rDNurGlFDdUwrJayIU0nTJMoJsCaBWYtSp0
         92YJ2Cesb3mqQMtc/u8NlYVUuuXs1Pkwa+rVgE13lPgd4vpVv0YHIIWc3/cAnqjWe2K1
         1pVw==
X-Gm-Message-State: AOAM531cRolpkQ+G/tT55MUKDGMlCiUOhQqYoeIBIhvdBXcFsl7bAsoE
        QMkeYPokO239aAWRMbve3vtSlg==
X-Google-Smtp-Source: ABdhPJxWgtwSeKPW/si2v9A21Ai8Ex0JgbDjAcJhrdIPLdEDJ5McfxSOMH64Ih+VY/b9HCxtO5ubSQ==
X-Received: by 2002:a17:903:11d1:b0:151:9fb2:9858 with SMTP id q17-20020a17090311d100b001519fb29858mr2993208plh.136.1650607256188;
        Thu, 21 Apr 2022 23:00:56 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id ck14-20020a056a00328e00b0050a3c5f415csm1029801pfb.23.2022.04.21.23.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 23:00:55 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     will@kernel.org, steven.price@arm.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        lengxujun2007@126.com, arnd@arndb.de, quic_qiancai@quicinc.com,
        aneesh.kumar@linux.ibm.com
Cc:     smuchun@gmail.com, duanxiongchun@bytedance.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3] arm64: mm: fix p?d_leaf()
Date:   Fri, 22 Apr 2022 14:00:33 +0800
Message-Id: <20220422060033.48711-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pmd_leaf() is used to test a leaf mapped PMD, however, it misses
the PROT_NONE mapped PMD on arm64.  Fix it.  A real world issue [1]
caused by this was reported by Qian Cai. Also fix pud_leaf().

Link: https://patchwork.kernel.org/comment/24798260/ [1]
Fixes: 8aa82df3c123 ("arm64: mm: add p?d_leaf() definitions")
Reported-by: Qian Cai <quic_qiancai@quicinc.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v3:
 - Fix pud_leaf() as well.
 - Rework pmd_leaf() as present && !table.

 arch/arm64/include/asm/pgtable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 930077f7b572..9aae3773b6c4 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -551,7 +551,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 				 PMD_TYPE_TABLE)
 #define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
 				 PMD_TYPE_SECT)
-#define pmd_leaf(pmd)		pmd_sect(pmd)
+#define pmd_leaf(pmd)		(pmd_present(pmd) && !pmd_table(pmd))
 #define pmd_bad(pmd)		(!pmd_table(pmd))
 
 #define pmd_leaf_size(pmd)	(pmd_cont(pmd) ? CONT_PMD_SIZE : PMD_SIZE)
@@ -641,7 +641,7 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 #define pud_none(pud)		(!pud_val(pud))
 #define pud_bad(pud)		(!pud_table(pud))
 #define pud_present(pud)	pte_present(pud_pte(pud))
-#define pud_leaf(pud)		pud_sect(pud)
+#define pud_leaf(pud)		(pud_present(pud) && !pud_table(pud))
 #define pud_valid(pud)		pte_valid(pud_pte(pud))
 
 static inline void set_pud(pud_t *pudp, pud_t pud)
-- 
2.11.0

