Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55DCE495EFC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 13:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380352AbiAUM0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 07:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbiAUM0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 07:26:49 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916E9C061574;
        Fri, 21 Jan 2022 04:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oJK25nad9Ku+botT29oqxyUUwfOA24v8IepgHTqcOuc=; b=mpvLbtSMWuybwwODDd6F7LqVot
        tlSVND9tmkZCWh/KCJPVxUURVTcM9XlheYPrpqTSINhfoCZTXc7HfGDajIn9nXjM9ixolrTnC7Rfs
        iMAQ2YuIlw7bDEcNkuZEwWzg61CQIXaXOzDyCyJO/aSVRNE8AQfNAPaCqjKQ5kcrNABLL9sKuznPX
        OmyZ3J93brq95wuyVLAQ2aagRncj1mtoJ3LfB1h/pTNbRIRWOSSMeLR1c5UE36qfruGrj26XZ0JMx
        tuwq679AlQl6OpOIeOBzLAv18Eo5Q5LjawSBhQ4rpblU82m112l2BL6BtyBk8ATXJtHE3+SPJiNm1
        bC5kWiKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAszq-002Zom-BL; Fri, 21 Jan 2022 12:26:26 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 499B59867E1; Fri, 21 Jan 2022 13:26:25 +0100 (CET)
Date:   Fri, 21 Jan 2022 13:26:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, x86@kernel.org, pjt@google.com,
        posk@google.com, avagin@google.com, jannh@google.com,
        tdelisle@uwaterloo.ca, mark.rutland@arm.com, posk@posk.io,
        david@redhat.com
Subject: Re: [RFC][PATCH v2 5/5] sched: User Mode Concurency Groups
Message-ID: <20220121122625.GG20638@worktop.programming.kicks-ass.net>
References: <20220120155517.066795336@infradead.org>
 <20220120160822.914418096@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120160822.914418096@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 04:55:22PM +0100, Peter Zijlstra wrote:
> +/*
> + * Pinning a page inhibits rmap based unmap for Anon pages. Doing a load
> + * through the user mapping ensures the user mapping exists.
> + */
> +#define umcg_pin_and_load(_self, _pagep, _member)				\
> +({										\
> +	__label__ __out;							\
> +	int __ret = -EFAULT;							\
> +										\
> +	if (pin_user_pages_fast((unsigned long)(_self), 1, 0, &(_pagep)) != 1)	\
> +		goto __out;							\
> +										\
> +	if (!PageAnon(_pagep) ||						\
> +	    get_user(_member, &(_self)->_member)) {				\
> +		unpin_user_page(_pagep);					\
> +		goto __out;							\
> +	}									\
> +	__ret = 0;								\
> +__out:	__ret;									\
> +})

Per the thread with David, this wants changing like so.

---

--- a/kernel/sched/umcg.c
+++ b/kernel/sched/umcg.c
@@ -34,25 +34,26 @@ static struct task_struct *umcg_get_task
 }
 
 /*
- * Pinning a page inhibits rmap based unmap for Anon pages. Doing a load
- * through the user mapping ensures the user mapping exists.
+ * Pinning a page inhibits rmap based unmap for Anon pages. Doing a store
+ * through the user mapping ensures the user mapping exists and is writable.
  */
-#define umcg_pin_and_load(_self, _pagep, _member)				\
-({										\
-	__label__ __out;							\
-	int __ret = -EFAULT;							\
-										\
-	if (pin_user_pages_fast((unsigned long)(_self), 1, 0, &(_pagep)) != 1)	\
-		goto __out;							\
-										\
-	if (!PageAnon(_pagep) ||						\
-	    get_user(_member, &(_self)->_member)) {				\
-		unpin_user_page(_pagep);					\
-		goto __out;							\
-	}									\
-	__ret = 0;								\
-__out:	__ret;									\
-})
+static int umcg_pin_page(struct umcg_task __user *self, struct page **pagep)
+{
+	int ret = -EFAULT;
+
+	if (pin_user_pages_fast((unsigned long)self, 1, FOLL_WRITE, pagep) != 1)
+		goto out;
+
+	if (!PageAnon(*pagep) ||
+	    put_user(0ULL, &self->__zero[0])) {
+		unpin_user_page(*pagep);
+		goto out;
+	}
+
+	ret = 0;
+out:
+	return ret;
+}
 
 /**
  * umcg_pin_pages: pin pages containing struct umcg_task of
@@ -72,10 +73,13 @@ static int umcg_pin_pages(void)
 			 tsk->umcg_server))
 		return -EBUSY;
 
-	ret = umcg_pin_and_load(self, tsk->umcg_page, server_tid);
+	ret = umcg_pin_page(self, &tsk->umcg_page);
 	if (ret)
 		goto clear_self;
 
+	if (get_user(server_tid, &self->server_tid))
+		goto unpin_self;
+
 	ret = -ESRCH;
 	server = umcg_get_task(server_tid);
 	if (!server)
@@ -83,7 +87,7 @@ static int umcg_pin_pages(void)
 
 	/* must cache due to possible concurrent change */
 	tsk->umcg_server_task = READ_ONCE(server->umcg_task);
-	ret = umcg_pin_and_load(tsk->umcg_server_task, tsk->umcg_server_page, server_tid);
+	ret = umcg_pin_page(tsk->umcg_server_task, &tsk->umcg_server_page);
 	if (ret)
 		goto clear_server;
 
@@ -414,7 +418,7 @@ static int umcg_wait(u64 timo)
 				break;
 			}
 
-			ret = umcg_pin_and_load(self, page, state);
+			ret = umcg_pin_page(self, &page);
 			if (ret) {
 				page = NULL;
 				break;
