Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1B359BEC9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 13:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbiHVLsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 07:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbiHVLsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 07:48:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FBC356C4;
        Mon, 22 Aug 2022 04:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=FP0rqVkS7XNyZ+T6mnt4iA8cRfE4EBcdmhTN5+Ff0gY=; b=gzsc6ulLBX1hjaG4BJGuxvIhO2
        WYG1VCFXQlW5cz1JcFGViaRfar5joFuy161FvJ+qi3PB8kddpM4crTRXG4XWj5BF2pdrk7Gu7brUf
        zL8+dTFkrm6cYyMTqGJItsoUaZIqq9EZT1C/IlEXogkbt8/LgnxZWvXauspJDbVCU/wJp7SKQEddN
        /S93Ps1tbHnwvLlCxKG3JG2Blr7T3haSD9yAvgv1i2hYiOnORqt1CdfrHnz47r7887EWgjVcESDrz
        AhEx+XT6rucODBiA+qQVTEDkpOfgTSNITLlzwL+8rXPunZq4To7lwui9uNwPiO11tIGgkvc7+q3/I
        FmkmeQQg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQ5uL-0054jp-2d; Mon, 22 Aug 2022 11:47:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BEEFE300880;
        Mon, 22 Aug 2022 13:47:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 976A320187A69; Mon, 22 Aug 2022 13:47:50 +0200 (CEST)
Message-ID: <20220822114648.922711674@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 22 Aug 2022 13:18:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, ebiederm@xmission.com,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, tj@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 4/6] sched/completion: Add wait_for_completion_state()
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
 include/linux/completion.h |    1 +
 kernel/sched/completion.c  |    9 +++++++++
 2 files changed, 10 insertions(+)

--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -103,6 +103,7 @@ extern void wait_for_completion(struct c
 extern void wait_for_completion_io(struct completion *);
 extern int wait_for_completion_interruptible(struct completion *x);
 extern int wait_for_completion_killable(struct completion *x);
+extern int wait_for_completion_state(struct completion *x, unsigned int state);
 extern unsigned long wait_for_completion_timeout(struct completion *x,
 						   unsigned long timeout);
 extern unsigned long wait_for_completion_io_timeout(struct completion *x,
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -247,6 +247,15 @@ int __sched wait_for_completion_killable
 }
 EXPORT_SYMBOL(wait_for_completion_killable);
 
+int __sched wait_for_completion_state(struct completion *x, unsigned int state)
+{
+	long t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT, state);
+	if (t == -ERESTARTSYS)
+		return t;
+	return 0;
+}
+EXPORT_SYMBOL(wait_for_completion_state);
+
 /**
  * wait_for_completion_killable_timeout: - waits for completion of a task (w/(to,killable))
  * @x:  holds the state of this particular completion


