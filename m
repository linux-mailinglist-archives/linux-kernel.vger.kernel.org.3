Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FFB57DA39
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 08:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbiGVGYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 02:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGVGYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 02:24:31 -0400
Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D63F8237F6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 23:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=GGKDF
        3nUFsN3cK6wOIiZIkAavfgxhT3JN2+FAQQ5L2A=; b=h5xYoNHA4/NfjbhI5fEib
        ZjfWwTIiaK1rRcbBUnGPKapvTTW4EeJ+v/4nQQwZKZZo8zvLMfDOEvXDUrCdluqC
        QgH0bsJGy8ZcbqBIM2dtgJDAKf8HgZJW9Tzur+VxlTNQSEpQRq1C1Ocwvw6I4rND
        A4UKSUt0J5148LPJFFkg80=
Received: from zd-ThinkPad-X390.kernelci.com (unknown [106.19.210.167])
        by smtp10 (Coremail) with SMTP id DsCowAAXMfpyQtpi6UqpOg--.11247S2;
        Fri, 22 Jul 2022 14:23:49 +0800 (CST)
From:   zhangduo <zduo006@163.com>
To:     naveen.n.rao@linux.ibm.com
Cc:     anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        zhangduo <zhangduo@kylinos.cn>
Subject: [PATCH 1/2] kprobes:  modify the copy_kprobe to make more clearly
Date:   Fri, 22 Jul 2022 14:25:49 +0800
Message-Id: <20220722062549.21020-1-zduo006@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowAAXMfpyQtpi6UqpOg--.11247S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw1DGryxKFW5Aw1DGrWrGrg_yoW8Zr4kpF
        s8Cw45tFWkXay8WFyqqw48Zr1Fkw47AryxGrZ0yw1Syr1UXr1UZ3WIvrWUJF98GrZakr4I
        yF10qryjyrZ7Aa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jg2-nUUUUU=
X-Originating-IP: [106.19.210.167]
X-CM-SenderInfo: p2gx0iiqw6il2tof0z/1tbiThVGc1UDQjraRAAAse
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhangduo <zhangduo@kylinos.cn>

  copy_kprobe() are called in init_aggr_kprobe() to copy opcode
  and insn from 'p' to 'ap',but in copy_kprobe(p,ap) implemtation
  'p' pass to 'struct kprobe *ap' , 'ap' pass to 'struct kprobe *p',
  it looks strange, because p means orig kprobe instance, ap
  means aggregator kprobe, not the same.  and before the add_new_kprobe()
  calling used the opposite copy from 'ap' to 'p', so modify copy_kprobe's
  parameter name as 'p_src' and 'p_dst' to fit all.

Signed-off-by: zhangduo <zhangduo@kylinos.cn>
---
 kernel/kprobes.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f214f8c08..f1dddc8fe 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -405,10 +405,10 @@ static inline bool kprobe_unused(struct kprobe *p)
 }
 
 /* Keep all fields in the kprobe consistent. */
-static inline void copy_kprobe(struct kprobe *ap, struct kprobe *p)
+static inline void copy_kprobe(struct kprobe *p_dst, struct kprobe *p_src)
 {
-	memcpy(&p->opcode, &ap->opcode, sizeof(kprobe_opcode_t));
-	memcpy(&p->ainsn, &ap->ainsn, sizeof(struct arch_specific_insn));
+	memcpy(&p_dst->opcode, &p_src->opcode, sizeof(kprobe_opcode_t));
+	memcpy(&p_dst->ainsn, &p_src->ainsn, sizeof(struct arch_specific_insn));
 }
 
 #ifdef CONFIG_OPTPROBES
@@ -1277,7 +1277,7 @@ static int add_new_kprobe(struct kprobe *ap, struct kprobe *p)
 static void init_aggr_kprobe(struct kprobe *ap, struct kprobe *p)
 {
 	/* Copy the insn slot of 'p' to 'ap'. */
-	copy_kprobe(p, ap);
+	copy_kprobe(ap, p);
 	flush_insn_slot(ap);
 	ap->addr = p->addr;
 	ap->flags = p->flags & ~KPROBE_FLAG_OPTIMIZED;
@@ -1350,7 +1350,7 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
 	}
 
 	/* Copy the insn slot of 'ap' to 'p'. */
-	copy_kprobe(ap, p);
+	copy_kprobe(p, ap);
 	ret = add_new_kprobe(ap, p);
 
 out:
-- 
2.25.1

