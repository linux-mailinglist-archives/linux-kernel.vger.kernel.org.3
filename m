Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670D64F06D2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 04:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiDCCvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 22:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiDCCvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 22:51:40 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD76324942
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 19:49:46 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t4so5515733pgc.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 19:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0edowekvp+uuabuvCBvmZKu7k9xu44C+w2QWuBKwXVg=;
        b=3dMnBV4kTdo2WSciKxJYmAvpw7AXg+p1T7qReeNIsAg9ObVb5KAqh/PpPL3m0fgd4Y
         oGduNrh4X484v+yN6pxoeKd7cankKPiivDqNTmf5+0a252b+RNt6r2rhIigXJcbAT8p7
         WS7vsgnpJelzKwddJVQ3rnU7FyRQYaiOoLM5kLYgQkzm1OqLjkLDdyuedGTu8YzaXsNc
         ayZABioTmxF68JUvHh82NrI1seLWO5w4/bFU+0LrhB3p0iHP/n/C0lgKdH2BmU11Hcij
         ukj0Slag8wF6GzQVngme9rPCzCCVjvo7eDHN5bVtbUPY+m5boGvo06SVCzz0XWzOhEjB
         PtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0edowekvp+uuabuvCBvmZKu7k9xu44C+w2QWuBKwXVg=;
        b=QPUJ2J4qPNRJfuJ6v8dAsvlTOkCAM5VDjN2i7JByS9EI8rHs4gbSkeycVgNORzI4yW
         sxai7sGph2jT44gE2fc8zIKfDqdXA7gZAPWBzl3JYi9TALgOk4nLqbQ0DSnHVOrIgEYe
         eTGTyMPwOJ3h4Gk19TNH1Wlfhd57miIcjFL8T4OY9ZAghWMlmOr37T9rXN26TBugUIrT
         VVmdaKv9Jia3Ue+DJOodVpyI5dvwtN2SWpwG3nRC+Ghqr8b+l1RyhENvMfR+iHtA2uKR
         wLefiG+lQOh340gzoYLDCPuimjpmLJfn5O7cm4jVBNiG7Iz8jNVgQ2zv7Z7C44+TqEno
         0M+A==
X-Gm-Message-State: AOAM533U3HpXja5ReX+zHKfQu9IMjKGiUPdoZRBsHmy8vyLtV83UP1LH
        MKidl+9r6ui07sTFOEUOKixOyQKvQvO91Q==
X-Google-Smtp-Source: ABdhPJyDRXDH8Tz4dAGJv60lUuLMHE7z7aPaZZDJTkLlzwE4WSvWneTIZD0ZfdfJklDfoH1bNBhFsA==
X-Received: by 2002:a63:a555:0:b0:382:3ec:ee4f with SMTP id r21-20020a63a555000000b0038203ecee4fmr20547497pgu.79.1648954186335;
        Sat, 02 Apr 2022 19:49:46 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id d9-20020a056a00198900b004fafdb88076sm7600992pfl.117.2022.04.02.19.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 19:49:45 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        aneesh.kumar@linux.ibm.com, steven.price@arm.com,
        lengxujun2007@126.com, arnd@arndb.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        smuchun@gmail.com, duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>,
        Qian Cai <quic_qiancai@quicinc.com>
Subject: [PATCH] arm64: mm: fix pmd_leaf()
Date:   Sun,  3 Apr 2022 10:49:28 +0800
Message-Id: <20220403024928.4125-1-songmuchun@bytedance.com>
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
 arch/arm64/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 94e147e5456c..09eaae46a19b 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -535,7 +535,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 				 PMD_TYPE_TABLE)
 #define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
 				 PMD_TYPE_SECT)
-#define pmd_leaf(pmd)		pmd_sect(pmd)
+#define pmd_leaf(pmd)		(pmd_present(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))
 #define pmd_bad(pmd)		(!pmd_table(pmd))
 
 #define pmd_leaf_size(pmd)	(pmd_cont(pmd) ? CONT_PMD_SIZE : PMD_SIZE)
-- 
2.11.0

