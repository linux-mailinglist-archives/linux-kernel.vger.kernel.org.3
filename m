Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F7159BEC8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 13:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbiHVLsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 07:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbiHVLsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 07:48:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4022F33E2F;
        Mon, 22 Aug 2022 04:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=+VGhKqt+LL5MmFcK09GygvpYyZGnPDq4Xy6ZFB/l0dY=; b=ZC2O3cCP2i/xTTJ1nmtqA6MLmV
        8H25wm0MUedCed0XVlGlHVa0R7Sh8hbJfqXbNqtfKyDs/yeD0k6oR05NnDtw+QiuP04k9kSQh0SSA
        XcKTTFEBJLGwJ+A0tvYuRVocJJ1kMtBuIatEAqnEFRYgIkGrNlrDDIC6g5b6R9wIV/wcnEbBrK8HU
        iQ3YB4GuH2w/yCeJ/XZCN4FvNizLj6E2cY8fcwxIqfgeRJADBJh3y35RSEQzLpcdxve1VN1dVKHdD
        1Sr5JAhlwZ879X66lv18N9oPYV6W4MLJB1GjNM/FdePSEwsCsGYWCW7IEwlb6EPqYbWOqVkgLLvml
        NjvkKrfw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQ5uL-0054ju-TF; Mon, 22 Aug 2022 11:47:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C1903300A6D;
        Mon, 22 Aug 2022 13:47:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9C26220187A71; Mon, 22 Aug 2022 13:47:50 +0200 (CEST)
Message-ID: <20220822114648.989212021@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 22 Aug 2022 13:18:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, ebiederm@xmission.com,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, tj@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 5/6] sched/wait: Add wait_event_state()
References: <20220822111816.760285417@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows waiting with a custom @state.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/wait.h |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -931,6 +931,34 @@ extern int do_wait_intr_irq(wait_queue_h
 	__ret;									\
 })
 
+#define __wait_event_state(wq, condition, state)				\
+	___wait_event(wq, condition, state, 0, 0, schedule())
+
+/**
+ * wait_event_state - sleep until a condition gets true
+ * @wq_head: the waitqueue to wait on
+ * @condition: a C expression for the event to wait for
+ * @state: state to sleep in
+ *
+ * The process is put to sleep (@state) until the @condition evaluates to true
+ * or a signal is received.  The @condition is checked each time the waitqueue
+ * @wq_head is woken up.
+ *
+ * wake_up() has to be called after changing any variable that could
+ * change the result of the wait condition.
+ *
+ * The function will return -ERESTARTSYS if it was interrupted by a
+ * signal and 0 if @condition evaluated to true.
+ */
+#define wait_event_state(wq_head, condition, state)				\
+({										\
+	int __ret = 0;								\
+	might_sleep();								\
+	if (!(condition))							\
+		__ret = __wait_event_state(wq_head, condition, state);		\
+	__ret;									\
+})
+
 #define __wait_event_killable_timeout(wq_head, condition, timeout)		\
 	___wait_event(wq_head, ___wait_cond_timeout(condition),			\
 		      TASK_KILLABLE, 0, timeout,				\


