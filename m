Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C412554994D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241359AbiFMQwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 12:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236579AbiFMQvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 12:51:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1469B1C2045
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 07:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mt3fuP+cCSiA3z/WonoxJoieU0BtWY4bTV+4sIenAvw=; b=iuiTqtcML6fcps3YzLvQaYNOUK
        8UvXhncw5yePv7qZ8anU8Js6hub5k6UZ1rT+3bFZRkxy0HVa4EOrSP1FesCLokSGLokv0IauUIoeG
        R9Es3/oUj1agM3e9FWdBHawZvy5S/XO/fDMzFdeLD1x0QlusDYGqClbMzELqfQQewPw29kN/dBzEE
        JWnSlhi/syYVUv95kO8CElU/V1JxoR9ppeBXY0TxoVIbLky5ARD4mBF4Bf9aDFvxJrE8t6MdOfd6+
        +1nwzBMBPifi1Mj/6FKcOGpRwGPYRyrkliqXZN79TJfF8K6d2V7Tlz6KcjsIuf1qSPkdUzWkqhmyQ
        K35bAUSA==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o0lBW-00Gv2G-NR; Mon, 13 Jun 2022 14:36:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5190F302E11;
        Mon, 13 Jun 2022 16:36:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3A2442029F884; Mon, 13 Jun 2022 16:36:54 +0200 (CEST)
Date:   Mon, 13 Jun 2022 16:36:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        eranian@google.com, alexey.budankov@linux.intel.com,
        ak@linux.intel.com, mark.rutland@arm.com, megha.dey@intel.com,
        frederic@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        kim.phillips@amd.com, linux-kernel@vger.kernel.org,
        santosh.shukla@amd.com
Subject: Re: [RFC v2] perf: Rewrite core context handling
Message-ID: <YqdLhrJnJUqONjim@hirez.programming.kicks-ass.net>
References: <20220113134743.1292-1-ravi.bangoria@amd.com>
 <YqdLH+ZU/sf4n0pa@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqdLH+ZU/sf4n0pa@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 04:35:11PM +0200, Peter Zijlstra wrote:
> 
> 
> Right, so sorry for being incredibly tardy on this. Find below the
> patch fwd ported to something recent.
> 
> I'll reply to this with fixes and comments.

You write:

>> A simple perf stat/record/top survives with the patch but machine
>> crashes with first run of perf test (stale cpc->task_epc causing the
>>crash). Lockdep is also screaming a lot :)


> @@ -7669,20 +7877,15 @@ static void perf_event_addr_filters_exec
>  void perf_event_exec(void)
>  {
>  	struct perf_event_context *ctx;
> -	int ctxn;
> -
> -	for_each_task_context_nr(ctxn) {
> -		perf_event_enable_on_exec(ctxn);
> -		perf_event_remove_on_exec(ctxn);
>  
> -		rcu_read_lock();
> -		ctx = rcu_dereference(current->perf_event_ctxp[ctxn]);
> -		if (ctx) {
> -			perf_iterate_ctx(ctx, perf_event_addr_filters_exec,
> -					 NULL, true);
> -		}
> -		rcu_read_unlock();
> +	rcu_read_lock();
> +	ctx = rcu_dereference(current->perf_event_ctxp);
> +	if (ctx) {
> +		perf_event_enable_on_exec(ctx);
> +		perf_event_remove_on_exec(ctx);
> +		perf_iterate_ctx(ctx, perf_event_addr_filters_exec, NULL, true);
>  	}
> +	rcu_read_unlock();
>  }
>  
>  struct remote_output {

The above goes *bang* because perf_event_remove_on_exec() will take a
mutex, which isn't allowed under rcu_read_lock().

The below cures.

---
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4384,8 +4384,6 @@ static void perf_event_remove_on_exec(st
 	unsigned long flags;
 	bool modified = false;
 
-	perf_pin_task_context(current);
-
 	mutex_lock(&ctx->mutex);
 
 	if (WARN_ON_ONCE(ctx->task != current))
@@ -4406,13 +4404,11 @@ static void perf_event_remove_on_exec(st
 	raw_spin_lock_irqsave(&ctx->lock, flags);
 	if (modified)
 		clone_ctx = unclone_ctx(ctx);
-	--ctx->pin_count;
 	raw_spin_unlock_irqrestore(&ctx->lock, flags);
 
 unlock:
 	mutex_unlock(&ctx->mutex);
 
-	put_ctx(ctx);
 	if (clone_ctx)
 		put_ctx(clone_ctx);
 }
@@ -7878,14 +7874,16 @@ void perf_event_exec(void)
 {
 	struct perf_event_context *ctx;
 
-	rcu_read_lock();
-	ctx = rcu_dereference(current->perf_event_ctxp);
-	if (ctx) {
-		perf_event_enable_on_exec(ctx);
-		perf_event_remove_on_exec(ctx);
-		perf_iterate_ctx(ctx, perf_event_addr_filters_exec, NULL, true);
-	}
-	rcu_read_unlock();
+	ctx = perf_pin_task_context(current);
+	if (!ctx)
+		return;
+
+	perf_event_enable_on_exec(ctx);
+	perf_event_remove_on_exec(ctx);
+	perf_iterate_ctx(ctx, perf_event_addr_filters_exec, NULL, true);
+
+	perf_unpin_context(ctx);
+	put_ctx(ctx);
 }
 
 struct remote_output {
