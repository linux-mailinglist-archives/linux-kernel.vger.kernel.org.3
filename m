Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC070583F28
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbiG1Mqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiG1Mqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:46:49 -0400
Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA6C226AE2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=kbj3q
        Tqnrg1aWomJ8FUCn9visdKTYiERh+eNV2ZOAfI=; b=lnZIBy2vMQJ+2fMYDRric
        oHtUcDGBR50ePIXtA2WOVutVijYm3AAQ/Hr/BILheXDKrMFQp/R63PDOMQrcItfm
        zamswVMIiwn1qOEWRfyyZ6Y5c4oblgMWuY61wrBJkhyc2WAkt51W4T+zQdBlJchT
        Zj64K/HeSBGn8Ai8fCyo80=
Received: from zd-ThinkPad-X390.kernelci.com (unknown [175.9.180.245])
        by smtp11 (Coremail) with SMTP id D8CowADHHQrihOJiQy8BBQ--.1286S2;
        Thu, 28 Jul 2022 20:45:25 +0800 (CST)
From:   zhangduo <zduo006@163.com>
To:     zduo006@163.com
Cc:     anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        naveen.n.rao@linux.ibm.com, zhangduo@kylinos.cn
Subject: [PATCH 2/2] kprobes: modify the copy_kprobe to make more clearly
Date:   Thu, 28 Jul 2022 20:45:16 +0800
Message-Id: <20220728124516.60621-1-zduo006@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowADHHQrihOJiQy8BBQ--.1286S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw1DGryxKFW5Aw1DGrWrGrg_yoW8Zr4kpF
        s8Cw45tFWkXay8uFyqqw48Zr1Fkw47ZryxGrWYyw1Syr1UXr1UX3WIvrWUJF98GrZakr4S
        yF10qrWjyrZ7Aa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRfHUkUUUUU=
X-Originating-IP: [175.9.180.245]
X-CM-SenderInfo: p2gx0iiqw6il2tof0z/1tbiYxZMc1aEKMWpKAABs1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 4f3e84343..8bcef7d3c 100644
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

