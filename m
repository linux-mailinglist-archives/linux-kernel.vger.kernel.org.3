Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CB8538A9B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 06:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243844AbiEaEgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 00:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243839AbiEaEgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 00:36:21 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75C948217E;
        Mon, 30 May 2022 21:36:19 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxeeQ7m5VisVAJAA--.36194S2;
        Tue, 31 May 2022 12:36:16 +0800 (CST)
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Zhaolong Zhang <zhangzl2013@126.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hongchen Zhang <zhanghongchen@loongson.cn>
Subject: [PATCH] MIPS: fix pmd_mkinvalid
Date:   Tue, 31 May 2022 12:36:09 +0800
Message-Id: <1653971769-14152-1-git-send-email-zhanghongchen@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAf9BxeeQ7m5VisVAJAA--.36194S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF1rXF4rJryxAr15Xw4Dtwb_yoW3GrbEka
        17uw4fWry0yF42vry7Xa95GFyag3Wru3s3X3Z3tw1jvas09w1UGayvq347Zr4Y9rsxurWf
        WF95GryrCFsxGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2AFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF04k2
        0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUywZ7UUUUU=
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pmd_mkinvalid should not clear dirty flag,otherwise the pmd
dirty flag,it's ok to just clear _PAGE_VALID.

Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
---
 arch/mips/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 374c632..d30a186 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -698,7 +698,7 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 
 static inline pmd_t pmd_mkinvalid(pmd_t pmd)
 {
-	pmd_val(pmd) &= ~(_PAGE_PRESENT | _PAGE_VALID | _PAGE_DIRTY);
+	pmd_val(pmd) &= ~_PAGE_VALID;
 
 	return pmd;
 }
-- 
1.8.3.1

