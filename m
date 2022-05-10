Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F7552141D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241181AbiEJLso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbiEJLsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:48:40 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11144250E8A;
        Tue, 10 May 2022 04:44:42 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.2.9.158])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxutgpUHpiPAkQAA--.54769S2;
        Tue, 10 May 2022 19:44:41 +0800 (CST)
From:   Mao Bibo <maobibo@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: smp: optimization for flush_tlb_mm when exiting
Date:   Tue, 10 May 2022 19:44:41 +0800
Message-Id: <20220510114441.2959886-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxutgpUHpiPAkQAA--.54769S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XryDWFyDur17Ww17Cw1Dtrb_yoWkXFXEyw
        sIgwn5Gryrtw1Iv3yxWr4fWF909wsY9F1v9r9Fgr9Iy3s8tr1UZaykur97XrZ5XrZYvFZ5
        Jr9xJryUAay2qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbxkYjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE-syl42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5
        B8BUUUUUU==
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When process exits or execute new binary, it will call function
exit_mmap with old mm, there is such function call trace:
  exit_mmap(struct mm_struct *mm)
      --> tlb_finish_mmu(&tlb, 0, -1)
         --> arch_tlb_finish_mmu(tlb, start, end, force)
	    --> tlb_flush_mmu(tlb);
               --> tlb_flush(struct mmu_gather *tlb)
                  --> flush_tlb_mm(tlb->mm)

It is not necessary to flush tlb since oldmm is not used anymore
by the process, there is similar operations on IA64/ARM64 etc,
this patch adds such optimization on MIPS.

Signed-off-by: Mao Bibo <maobibo@loongson.cn>
---
 arch/mips/kernel/smp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 1986d1309410..1d93b85271ba 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -518,6 +518,12 @@ static inline void smp_on_each_tlb(void (*func) (void *info), void *info)
 
 void flush_tlb_mm(struct mm_struct *mm)
 {
+	if (!mm)
+		return;
+
+	if (atomic_read(&mm->mm_users) == 0)
+		return;		/* happens as a result of exit_mmap() */
+
 	preempt_disable();
 
 	if (cpu_has_mmid) {
-- 
2.27.0

