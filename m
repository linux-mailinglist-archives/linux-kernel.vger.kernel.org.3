Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC14576290
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 15:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbiGONJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 09:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiGONJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 09:09:43 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B821EECD
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 06:09:41 -0700 (PDT)
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 26FD92gj032537;
        Fri, 15 Jul 2022 22:09:02 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Fri, 15 Jul 2022 22:09:02 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 26FD92PE032531
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 15 Jul 2022 22:09:02 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <3188347c-3375-b728-cd08-ea4421d823cd@I-love.SAKURA.ne.jp>
Date:   Fri, 15 Jul 2022 22:09:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH v2] ARM: spectre-v2: fix smp_processor_id() warning
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <795c9463-452e-bf64-1cc0-c318ccecb1da@I-love.SAKURA.ne.jp>
 <e5bdea6c767d3a8260360afaddab5f7c@kernel.org>
 <YrMhVAev9wMAA8tl@shell.armlinux.org.uk>
 <421c1ca9-f553-4c0a-d963-2fdeb270dbcc@I-love.SAKURA.ne.jp>
 <fa786d1c-db06-f7f1-9ac9-6a468c1e8d81@I-love.SAKURA.ne.jp>
In-Reply-To: <fa786d1c-db06-f7f1-9ac9-6a468c1e8d81@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is reporting that CONFIG_HARDEN_BRANCH_PREDICTOR=y +
CONFIG_DEBUG_PREEMPT=y on ARM32 causes "BUG: using smp_processor_id() in
preemptible code" message [1], for this check was not designed to handle
attempts to access kernel memory like

  ----------
  int main() { return *(char *) -1; }
  ----------

. Although Russell King commented that this BUG: message might help finding
possible exploit attempts [2], this is not a kernel's problem that worth
giving up fuzz testing.

This patch explicitly disables preemption and uses raw_smp_processor_id().

Link: https://syzkaller.appspot.com/bug?extid=a7ee43e564223f195c84 [1]
Link: https://lkml.kernel.org/r/YrMhVAev9wMAA8tl@shell.armlinux.org.uk [2]
Reported-by: syzbot <syzbot+a7ee43e564223f195c84@syzkaller.appspotmail.com>
Fixes: f5fe12b1eaee220c ("ARM: spectre-v2: harden user aborts in kernel space")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 arch/arm/include/asm/system_misc.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/system_misc.h b/arch/arm/include/asm/system_misc.h
index 98b37340376b..670e8d116770 100644
--- a/arch/arm/include/asm/system_misc.h
+++ b/arch/arm/include/asm/system_misc.h
@@ -20,10 +20,13 @@ typedef void (*harden_branch_predictor_fn_t)(void);
 DECLARE_PER_CPU(harden_branch_predictor_fn_t, harden_branch_predictor_fn);
 static inline void harden_branch_predictor(void)
 {
-	harden_branch_predictor_fn_t fn = per_cpu(harden_branch_predictor_fn,
-						  smp_processor_id());
+	harden_branch_predictor_fn_t fn;
+
+	preempt_disable_notrace();
+	fn = per_cpu(harden_branch_predictor_fn, raw_smp_processor_id());
 	if (fn)
 		fn();
+	preempt_enable_no_resched_notrace();
 }
 #else
 #define harden_branch_predictor() do { } while (0)
-- 
2.34.1

