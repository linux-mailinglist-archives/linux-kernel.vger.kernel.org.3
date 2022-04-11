Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D374FBC08
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346048AbiDKMa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245248AbiDKMa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:30:26 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C5F2CC86
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:28:12 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id bg24so2704671pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QodfVSYvtajfZu5GfMihFlyPJS016l+/i2+aa3dvR/M=;
        b=48tVOWYpd8ZPY/3YXoKZl/BMYH7ui+Amk8t7+6bc6Y3MHSVGrA7nNaU4JNpefswj4O
         3QIbwtZ5+BHBTZNgGUx6DrH3/naQop/ghumvjDr5b4gjrSw5xBXTR+9zH8IAaoLG5gv8
         gD+ExHUS5TaUwjwlBih/bZxaVMFu2pAfBQK6etpOVvQnbXqO15kpDPu07EQ5Hns27pDy
         GdJdYuKQsFNBL/EYDP1UNsIuB8BOmBL5kmxp4DW+gbRcvB5rsPta4dYUENQVHVbbLWVR
         zP4WnsTReOaNJvd5FYJsk+SEB+0e5y8/aNOQ5n1BKxPeWkivTzYBGdVtTERal50mDJcC
         dgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QodfVSYvtajfZu5GfMihFlyPJS016l+/i2+aa3dvR/M=;
        b=RyX65f0FHFlbXAR+jHMtq0wkRQmBFIldxOFFu0iomvpfi9TcmrYJIWr3cD64rZimTW
         lywov/UA7PkKaAGGtsI+oesRpiHgB+3ztM3ONdVTo6ASwbstIkwOoLo5Ovo0/5z91DWC
         /A3uwTOU9BgRj1IEps520tXjzgwurtzOPR/LuJPhH1cj/coICCzHJ4hXnfCrIXHBDKhu
         +D9WClHyICpOVEtLwYfXSQ7eiv3hKZq6LVmTC0/orTNcTQxOySv+QzNTqESpAR+ZxVdo
         +q/bAUQzUGrJGGcs0neOutyO7XdVWLQZdwHULBMMwocCqARm5rw7dXHQz1XcLmsxKSRC
         obiA==
X-Gm-Message-State: AOAM533s9IDCyyi25Pzb1sN7+X5NX6TXkQ2l0zPboKk/7AAfr8tB2Ks3
        ZjvZvQ8EWuK8UvlOelR4ojrQ2XAbEDo/Vw==
X-Google-Smtp-Source: ABdhPJymaL28YkA+U0QTjSOpHtH19n1Ae0krubSKlT0fk5Q1jJNPCSnDRqn1pqEh0YKC/Ps/1r0OBw==
X-Received: by 2002:a17:90a:600b:b0:1cb:8ba5:d3bc with SMTP id y11-20020a17090a600b00b001cb8ba5d3bcmr7319539pji.42.1649680091792;
        Mon, 11 Apr 2022 05:28:11 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id fa11-20020a17090af0cb00b001ca6e27a684sm20065699pjb.16.2022.04.11.05.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 05:28:11 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     will@kernel.org, catalin.marinas@arm.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        steven.price@arm.com, lengxujun2007@126.com, arnd@arndb.de,
        smuchun@gmail.com, duanxiongchun@bytedance.com,
        quic_qiancai@quicinc.com, aneesh.kumar@linux.ibm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2] arm64: mm: fix pmd_leaf()
Date:   Mon, 11 Apr 2022 20:26:53 +0800
Message-Id: <20220411122653.40284-1-songmuchun@bytedance.com>
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

The pmd_leaf() is used to test a leaf mapped PMD, however, it misses
the PROT_NONE mapped PMD on arm64.  Fix it.  A real world issue [1]
caused by this was reported by Qian Cai.

Link: https://patchwork.kernel.org/comment/24798260/ [1]
Fixes: 8aa82df3c123 ("arm64: mm: add p?d_leaf() definitions")
Reported-by: Qian Cai <quic_qiancai@quicinc.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v2:
- Replace pmd_present() with pmd_val() since we expect pmd_leaf() works
  well on non-present pmd case.

 arch/arm64/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index ad9b221963d4..00cdd2d895d3 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -551,7 +551,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 				 PMD_TYPE_TABLE)
 #define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
 				 PMD_TYPE_SECT)
-#define pmd_leaf(pmd)		pmd_sect(pmd)
+#define pmd_leaf(pmd)		(pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))
 #define pmd_bad(pmd)		(!pmd_table(pmd))
 
 #define pmd_leaf_size(pmd)	(pmd_cont(pmd) ? CONT_PMD_SIZE : PMD_SIZE)
-- 
2.11.0

