Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AF155926F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 07:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiFXFke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 01:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFXFkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 01:40:33 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F91069988
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 22:40:32 -0700 (PDT)
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 25O5dwZE025105;
        Fri, 24 Jun 2022 14:39:58 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Fri, 24 Jun 2022 14:39:58 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 25O5dv5b025098
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 24 Jun 2022 14:39:58 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <fa786d1c-db06-f7f1-9ac9-6a468c1e8d81@I-love.SAKURA.ne.jp>
Date:   Fri, 24 Jun 2022 14:39:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ARM: spectre-v2: fix smp_processor_id() warning
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
In-Reply-To: <421c1ca9-f553-4c0a-d963-2fdeb270dbcc@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/06/23 0:02, Tetsuo Handa wrote:
> On 2022/06/22 23:04, Russell King (Oracle) wrote:
>> Which makes me think... having the loud complaint from the kernel there
>> is actually a good thing, it makes people sit up and notice that
>> something is wrong.
> 
> OK. Then, would you change the code not to emit "BUG:" message, for
> syzkaller stops testing upon encountering "BUG:" string?
> 

Something like this?

 arch/arm/include/asm/system_misc.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/system_misc.h b/arch/arm/include/asm/system_misc.h
index 98b37340376b..09d5c2262165 100644
--- a/arch/arm/include/asm/system_misc.h
+++ b/arch/arm/include/asm/system_misc.h
@@ -20,10 +20,22 @@ typedef void (*harden_branch_predictor_fn_t)(void);
 DECLARE_PER_CPU(harden_branch_predictor_fn_t, harden_branch_predictor_fn);
 static inline void harden_branch_predictor(void)
 {
-	harden_branch_predictor_fn_t fn = per_cpu(harden_branch_predictor_fn,
-						  smp_processor_id());
+	static DEFINE_RATELIMIT_STATE(predictor_rs, 10 * HZ, 1);
+	const bool is_preemptible = preemptible();
+	harden_branch_predictor_fn_t fn;
+
+	if (unlikely(is_preemptible)) {
+		ratelimit_set_flags(&predictor_rs, RATELIMIT_MSG_ON_RELEASE);
+		if (__ratelimit(&predictor_rs))
+			pr_err("%s[%d] page fault with preemption enabled (exploit attempt?)\n",
+			       current->comm, task_pid_nr(current));
+		preempt_disable_notrace();
+	}
+	fn = per_cpu(harden_branch_predictor_fn, raw_smp_processor_id());
 	if (fn)
 		fn();
+	if (unlikely(is_preemptible))
+		preempt_enable_no_resched_notrace();
 }
 #else
 #define harden_branch_predictor() do { } while (0)
-- 
2.18.4
