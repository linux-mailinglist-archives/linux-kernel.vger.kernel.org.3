Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29C951C10C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379844AbiEENqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379780AbiEENqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:46:22 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBC95714E
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 06:42:41 -0700 (PDT)
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 245DgKTo042035;
        Thu, 5 May 2022 22:42:20 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Thu, 05 May 2022 22:42:20 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 245DgKNi042032
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 5 May 2022 22:42:20 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <738afe71-2983-05d5-f0fc-d94efbdf7634@I-love.SAKURA.ne.jp>
Date:   Thu, 5 May 2022 22:42:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] checkpatch: warn about flushing system-wide workqueues
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Tejun Heo <tj@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
References: <d34dac10-c12f-8bda-35c4-9cb158781db2@I-love.SAKURA.ne.jp>
 <a6288570ed3534b0316723061f5604e3871accef.camel@perches.com>
 <6e4ed62e-888b-6e7a-c13d-67656f39ca94@I-love.SAKURA.ne.jp>
In-Reply-To: <6e4ed62e-888b-6e7a-c13d-67656f39ca94@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/04/25 9:33, Tetsuo Handa wrote:
> On 2022/04/25 8:45, Joe Perches wrote:
>> And it's probably more readable using separate lines and it looks as
>> if the 3rd test is unnecessary as it could be combined with the 2nd.
>>
>> 		if ($line =~ /\bflush_scheduled_work\s*\(/ ||
>> 		    $line =~ /\bflush_workqueue\s*\(\s*system(_\w*)?_wq\s*\)/) {
> 
> We don't need to worry about possibility like
> 
> 	flush_workqueue(system_module1_wq);
> 
> ? Then, we can simplify like you suggested.

I initially thought that also doing static checks by scripts/checkpatch.pl
is better than only doing runtime WARN_ON(). But not all patches are checked
by scripts/checkpatch.pl . Thus, as an attempt to check without exemptions,
I now think that doing static checks via BUILD_BUG_ON() is better than
scripts/checkpatch.pl . I sent below patch to linux-next.git , and so far
it seems working (I mean, no build failure reports caused by compilers).

Subject: workqueue: Wrap flush_workqueue() using a macro

A conversion to stop flushing kernel-global workqueues is in progress.
Wrap flush_workqueue() and inject BUILD_BUG_ON() checks, in order to
prevent users who are not aware of this conversion from again start
flushing kernel-global workqueues.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 include/linux/workqueue.h | 21 +++++++++++++++++++++
 kernel/workqueue.c        |  1 +
 2 files changed, 22 insertions(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 7b13fae377e2e..9f78414d507c8 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -654,4 +654,25 @@ int workqueue_offline_cpu(unsigned int cpu);
 void __init workqueue_init_early(void);
 void __init workqueue_init(void);
 
+/*
+ * Detect attempt to flush system-wide workqueues at compile time when possible.
+ * See https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp for
+ * reasons and steps for converting system-wide workqueues into local workqueues.
+ * Checks for system_wq and system_{long,unbound,highpri}_wq will be added after
+ * all in-tree users stopped flushing these workqueues.
+ */
+#define flush_workqueue(wq)						\
+({									\
+	BUILD_BUG_ON_MSG(__builtin_constant_p(&(wq) == &system_freezable_wq) &&	\
+			 &(wq) == &system_freezable_wq,			\
+			 "Please avoid flushing system_freezable_wq."); \
+	BUILD_BUG_ON_MSG(__builtin_constant_p(&(wq) == &system_power_efficient_wq) && \
+			 &(wq) == &system_power_efficient_wq,		\
+			 "Please avoid flushing system_power_efficient_wq."); \
+	BUILD_BUG_ON_MSG(__builtin_constant_p(&(wq) == &system_freezable_power_efficient_wq) &&	\
+			 &(wq) == &system_freezable_power_efficient_wq, \
+			 "Please avoid flushing system_freezable_power_efficient_wq."); \
+	flush_workqueue(wq);						\
+})
+
 #endif
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index abcc9a2ac3197..5c612532f3e93 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2813,6 +2813,7 @@ static void warn_flush_attempt(struct workqueue_struct *wq)
  * This function sleeps until all work items which were queued on entry
  * have finished execution, but it is not livelocked by new incoming ones.
  */
+#undef flush_workqueue
 void flush_workqueue(struct workqueue_struct *wq)
 {
 	struct wq_flusher this_flusher = {
-- 

Tejun, can we use this approach? If yes, when to apply?

If we can include this patch into 5.18, can be applied as-is.
If we can include this patch into 5.19, can be applied with checks for
system_{long,unbound,highpri}_wq added because all flush_workqueue() users
on system_*_wq are gone in next-20220505.

Now that all flush_workqueue() users on system_*_wq are gone in next-20220505,
next step is to remove all flush_scheduled_work() users. Therefore, instead of
using /\bflush_workqueue\s*\(\s*system(_\w*)?_wq\s*\)/ in scripts/checkpatch.pl ,
I think we can ask BUILD_BUG_ON() for blocking new system_*_wq users, and ask
scripts/checkpatch.pl for blocking new system_wq users.
