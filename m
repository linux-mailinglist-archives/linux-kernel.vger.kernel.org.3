Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63463587A25
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 11:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbiHBJzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 05:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbiHBJzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 05:55:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2371F65DA;
        Tue,  2 Aug 2022 02:55:38 -0700 (PDT)
Date:   Tue, 02 Aug 2022 09:55:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659434136;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PlK+/AjwBJ+jEPpZkjnGHifK9JOqSjGxvWKQwXq9xDo=;
        b=nipJZR1RSfHSRgvstpsX1Ja2jNFMMGrMK276PahTgoACLdTDEKn2QbNnOEwZQHPzWfoRKC
        +D4Ckfe7PQESmVi4mJTXWp9ETx7YHRkK9nRj/R7w5QmYn2nGPIKdW+TaEwjOLi5mlr2EWi
        IcBitNjKUrYRvsY+0zSc6tJR+MQaov1uqcFwCReicvH9YOC3m2VpzpfZ90jel/UYHNEm5r
        +f5FaI18ARidh7q5k2cjGad3e9lJ9/Ab0O2QGEzeiFqSWwS377sZPAQffOr2ZayPZDiB6s
        PLmBi5LXhCm+YEZ1UOZR0iGiOgn3Ivl5r/KCD5ZIY9ayYJLuKZqc0G4/w/ds1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659434136;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PlK+/AjwBJ+jEPpZkjnGHifK9JOqSjGxvWKQwXq9xDo=;
        b=Q+RoLbEe2imC4BOsI7fXXy++syBCFbtzz9Sykve7RGP0NTdcz+c88ynxxprE22Uk8WwsWk
        MQcQoIDHLY9Z82BA==
From:   "tip-bot2 for Chen Zhongjin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] kprobes: Forbid probing on trampoline and BPF code areas
Cc:     Chen Zhongjin <chenzhongjin@huawei.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220801033719.228248-1-chenzhongjin@huawei.com>
References: <20220801033719.228248-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Message-ID: <165943413527.15455.6314879465363056432.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     28f6c37a2910f565b4f5960df52b2eccae28c891
Gitweb:        https://git.kernel.org/tip/28f6c37a2910f565b4f5960df52b2eccae28c891
Author:        Chen Zhongjin <chenzhongjin@huawei.com>
AuthorDate:    Mon, 01 Aug 2022 11:37:19 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 02 Aug 2022 11:47:29 +02:00

kprobes: Forbid probing on trampoline and BPF code areas

kernel_text_address() treats ftrace_trampoline, kprobe_insn_slot
and bpf_text_address as valid kprobe addresses - which is not ideal.

These text areas are removable and changeable without any notification
to kprobes, and probing on them can trigger unexpected behavior:

  https://lkml.org/lkml/2022/7/26/1148

Considering that jump_label and static_call text are already
forbiden to probe, kernel_text_address() should be replaced with
core_kernel_text() and is_module_text_address() to check other text
areas which are unsafe to kprobe.

[ mingo: Rewrote the changelog. ]

Fixes: 5b485629ba0d ("kprobes, extable: Identify kprobes trampolines as kernel text area")
Fixes: 74451e66d516 ("bpf: make jited programs visible in traces")
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20220801033719.228248-1-chenzhongjin@huawei.com
---
 kernel/kprobes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f214f8c..80697e5 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1560,7 +1560,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	preempt_disable();
 
 	/* Ensure it is not in reserved area nor out of text */
-	if (!kernel_text_address((unsigned long) p->addr) ||
+	if (!(core_kernel_text((unsigned long) p->addr) ||
+	    is_module_text_address((unsigned long) p->addr)) ||
 	    within_kprobe_blacklist((unsigned long) p->addr) ||
 	    jump_label_text_reserved(p->addr, p->addr) ||
 	    static_call_text_reserved(p->addr, p->addr) ||
