Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04285519692
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 06:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344529AbiEDEcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 00:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbiEDEcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 00:32:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E1226567
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 21:28:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2122161A15
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 04:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DAAC385A5;
        Wed,  4 May 2022 04:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651638527;
        bh=p1sC2kgNy/ciouevqgVW07qQLywBX+ltDnzUbh6Z8Fs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oBT2b1YZ8bSsPSSZ14OR1nsnXRmajf+pI9awNmySLyNk2qXLZERL4GWdfkcEYMCqY
         qK5dn5LdHUKypvf193flkx9eGv3BjlXq4HdNRKvEDQsEofsD9ccx9H2ccF1fLXF0Mf
         6JIy9uFFCEIHZZKND8w5Gnvbnh0rQdcS/2ksEkx+f9jRj16c23zdFv+ShB6MO4QDUL
         CwifKjUN9Pkyf8CORsA5B3DI61/LBWp9Z7xZmQnedBtPdw3rnEYvmaWYTpZPsyCMo9
         b5Wr8Lt+kV7gZFv90fJ32ZE/okaOl5YsnJBizzsalsL5648zQDcmtG2b79Km5UM+Ix
         ATyxbfxWotGsw==
Date:   Wed, 4 May 2022 13:28:42 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] kprobes: Fix build errors with CONFIG_KRETPROBES=n
Message-Id: <20220504132842.119ab5c798cc7731b08b8835@kernel.org>
In-Reply-To: <165163539094.74407.3838114721073251225.stgit@devnote2>
References: <20220502184050.1792743-1-jcmvbkbc@gmail.com>
        <165163539094.74407.3838114721073251225.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Max,

Can you test this patch? Since the other archs already implemented
kretprobe, I couldn't test it without modifying kernel.

Thank you,

On Wed,  4 May 2022 12:36:31 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Max Filippov reported:
> 
> When building kernel with CONFIG_KRETPROBES=n kernel/kprobes.c
> compilation fails with the following messages:
> 
>   kernel/kprobes.c: In function ‘recycle_rp_inst’:
>   kernel/kprobes.c:1273:32: error: implicit declaration of function
>                                    ‘get_kretprobe’
> 
>   kernel/kprobes.c: In function ‘kprobe_flush_task’:
>   kernel/kprobes.c:1299:35: error: ‘struct task_struct’ has no member
>                                    named ‘kretprobe_instances’
> 
> This came from the commit d741bf41d7c7 ("kprobes: Remove
> kretprobe hash") which introduced get_kretprobe() and
> kretprobe_instances member in task_struct when CONFIG_KRETPROBES=y,
> but did not make recycle_rp_inst() and kprobe_flush_task()
> depending on CONFIG_KRETPORBES.
> 
> Since those functions are only used for kretprobe, move those
> functions into #ifdef CONFIG_KRETPROBE area.
> 
> Reported-by: Max Filippov <jcmvbkbc@gmail.com>
> Fixes: d741bf41d7c7 ("kprobes: Remove kretprobe hash")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  include/linux/kprobes.h |    2 -
>  kernel/kprobes.c        |  144 +++++++++++++++++++++++------------------------
>  2 files changed, 72 insertions(+), 74 deletions(-)
> 
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 157168769fc2..55041d2f884d 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -424,7 +424,7 @@ void unregister_kretprobe(struct kretprobe *rp);
>  int register_kretprobes(struct kretprobe **rps, int num);
>  void unregister_kretprobes(struct kretprobe **rps, int num);
>  
> -#ifdef CONFIG_KRETPROBE_ON_RETHOOK
> +#if defined(CONFIG_KRETPROBE_ON_RETHOOK) || !defined(CONFIG_KRETPROBES)
>  #define kprobe_flush_task(tk)	do {} while (0)
>  #else
>  void kprobe_flush_task(struct task_struct *tk);
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index dd58c0be9ce2..f214f8c088ed 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1257,79 +1257,6 @@ void kprobe_busy_end(void)
>  	preempt_enable();
>  }
>  
> -#if !defined(CONFIG_KRETPROBE_ON_RETHOOK)
> -static void free_rp_inst_rcu(struct rcu_head *head)
> -{
> -	struct kretprobe_instance *ri = container_of(head, struct kretprobe_instance, rcu);
> -
> -	if (refcount_dec_and_test(&ri->rph->ref))
> -		kfree(ri->rph);
> -	kfree(ri);
> -}
> -NOKPROBE_SYMBOL(free_rp_inst_rcu);
> -
> -static void recycle_rp_inst(struct kretprobe_instance *ri)
> -{
> -	struct kretprobe *rp = get_kretprobe(ri);
> -
> -	if (likely(rp))
> -		freelist_add(&ri->freelist, &rp->freelist);
> -	else
> -		call_rcu(&ri->rcu, free_rp_inst_rcu);
> -}
> -NOKPROBE_SYMBOL(recycle_rp_inst);
> -
> -/*
> - * This function is called from delayed_put_task_struct() when a task is
> - * dead and cleaned up to recycle any kretprobe instances associated with
> - * this task. These left over instances represent probed functions that
> - * have been called but will never return.
> - */
> -void kprobe_flush_task(struct task_struct *tk)
> -{
> -	struct kretprobe_instance *ri;
> -	struct llist_node *node;
> -
> -	/* Early boot, not yet initialized. */
> -	if (unlikely(!kprobes_initialized))
> -		return;
> -
> -	kprobe_busy_begin();
> -
> -	node = __llist_del_all(&tk->kretprobe_instances);
> -	while (node) {
> -		ri = container_of(node, struct kretprobe_instance, llist);
> -		node = node->next;
> -
> -		recycle_rp_inst(ri);
> -	}
> -
> -	kprobe_busy_end();
> -}
> -NOKPROBE_SYMBOL(kprobe_flush_task);
> -
> -static inline void free_rp_inst(struct kretprobe *rp)
> -{
> -	struct kretprobe_instance *ri;
> -	struct freelist_node *node;
> -	int count = 0;
> -
> -	node = rp->freelist.head;
> -	while (node) {
> -		ri = container_of(node, struct kretprobe_instance, freelist);
> -		node = node->next;
> -
> -		kfree(ri);
> -		count++;
> -	}
> -
> -	if (refcount_sub_and_test(count, &rp->rph->ref)) {
> -		kfree(rp->rph);
> -		rp->rph = NULL;
> -	}
> -}
> -#endif	/* !CONFIG_KRETPROBE_ON_RETHOOK */
> -
>  /* Add the new probe to 'ap->list'. */
>  static int add_new_kprobe(struct kprobe *ap, struct kprobe *p)
>  {
> @@ -1928,6 +1855,77 @@ static struct notifier_block kprobe_exceptions_nb = {
>  #ifdef CONFIG_KRETPROBES
>  
>  #if !defined(CONFIG_KRETPROBE_ON_RETHOOK)
> +static void free_rp_inst_rcu(struct rcu_head *head)
> +{
> +	struct kretprobe_instance *ri = container_of(head, struct kretprobe_instance, rcu);
> +
> +	if (refcount_dec_and_test(&ri->rph->ref))
> +		kfree(ri->rph);
> +	kfree(ri);
> +}
> +NOKPROBE_SYMBOL(free_rp_inst_rcu);
> +
> +static void recycle_rp_inst(struct kretprobe_instance *ri)
> +{
> +	struct kretprobe *rp = get_kretprobe(ri);
> +
> +	if (likely(rp))
> +		freelist_add(&ri->freelist, &rp->freelist);
> +	else
> +		call_rcu(&ri->rcu, free_rp_inst_rcu);
> +}
> +NOKPROBE_SYMBOL(recycle_rp_inst);
> +
> +/*
> + * This function is called from delayed_put_task_struct() when a task is
> + * dead and cleaned up to recycle any kretprobe instances associated with
> + * this task. These left over instances represent probed functions that
> + * have been called but will never return.
> + */
> +void kprobe_flush_task(struct task_struct *tk)
> +{
> +	struct kretprobe_instance *ri;
> +	struct llist_node *node;
> +
> +	/* Early boot, not yet initialized. */
> +	if (unlikely(!kprobes_initialized))
> +		return;
> +
> +	kprobe_busy_begin();
> +
> +	node = __llist_del_all(&tk->kretprobe_instances);
> +	while (node) {
> +		ri = container_of(node, struct kretprobe_instance, llist);
> +		node = node->next;
> +
> +		recycle_rp_inst(ri);
> +	}
> +
> +	kprobe_busy_end();
> +}
> +NOKPROBE_SYMBOL(kprobe_flush_task);
> +
> +static inline void free_rp_inst(struct kretprobe *rp)
> +{
> +	struct kretprobe_instance *ri;
> +	struct freelist_node *node;
> +	int count = 0;
> +
> +	node = rp->freelist.head;
> +	while (node) {
> +		ri = container_of(node, struct kretprobe_instance, freelist);
> +		node = node->next;
> +
> +		kfree(ri);
> +		count++;
> +	}
> +
> +	if (refcount_sub_and_test(count, &rp->rph->ref)) {
> +		kfree(rp->rph);
> +		rp->rph = NULL;
> +	}
> +}
> +
>  /* This assumes the 'tsk' is the current task or the is not running. */
>  static kprobe_opcode_t *__kretprobe_find_ret_addr(struct task_struct *tsk,
>  						  struct llist_node **cur)
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
