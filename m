Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C7C4CE894
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 04:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiCFDtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 22:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiCFDtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 22:49:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045F933362
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 19:48:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6164A6111C
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 03:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCB6C340EF;
        Sun,  6 Mar 2022 03:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646538504;
        bh=D/0wISMD5O7JNkdCi1RFp5QRJyju1ohlwZCc/vnRgCw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kGlRKCSWLwdCKl+eJ30KQb0cEp0ZtEgvLYzd9vv0Y5AuLtMmhwhbCJoSM8npW6cQZ
         ojeRjBbWNw/cAPYGtfbLk0zGTxc7fSP724cxKj/wj5uz7hoqsAjE4/HPenZAa21P8N
         kfMHf0htLAJX3VGQmd3Af4b8niH/9ceqh9yHkXlLM8xZwwWSR2tW9JQMg2Vjrwy5m2
         r6eYPZ5fmleeTE824d/n26bghAjHHF2aW9LoyXUbmPR8+NBVd/h/5/AdXWon3RgKFw
         /4cih4tJ4J9ViUCyHl1g3hXF2DaqyAa9pHAy4bL4S0cm4llo39q9UsWvaFV5uTV3dd
         1y29Zm6yL/Aag==
Date:   Sun, 6 Mar 2022 12:48:19 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        alexei.starovoitov@gmail.com, alyssa.milburn@intel.com,
        andrew.cooper3@citrix.com, hjl.tools@gmail.com,
        joao@overdrivepizza.com, jpoimboe@redhat.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mbenes@suse.cz,
        Masami Hiramatsu <mhiramat@kernel.org>,
        ndesaulniers@google.com, samitolvanen@google.com, x86@kernel.org
Subject: Re: [PATCH v2 12/39] x86/ibt,ftrace: Search for __fentry__ location
Message-Id: <20220306124819.2dfd845ad2dc37720c6d0827@kernel.org>
In-Reply-To: <YiDlx0J1KMNP39if@hirez.programming.kicks-ass.net>
References: <20220225083647.12ceb54b@gandalf.local.home>
        <1646159447.ngbqgzj71t.naveen@linux.ibm.com>
        <20220301142016.22e787fb@gandalf.local.home>
        <Yh9vF8REB1JlhQCJ@hirez.programming.kicks-ass.net>
        <20220302110138.6d2abcec@gandalf.local.home>
        <20220302144716.1772020c@gandalf.local.home>
        <Yh/Y2FHw90m00owK@hirez.programming.kicks-ass.net>
        <1646300416.yyrqygami4.naveen@linux.ibm.com>
        <YiC89O5WtsU871Sf@hirez.programming.kicks-ass.net>
        <20220303093413.387ee6f1@gandalf.local.home>
        <YiDlx0J1KMNP39if@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2022 16:59:03 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Mar 03, 2022 at 09:34:13AM -0500, Steven Rostedt wrote:
> > On Thu, 3 Mar 2022 14:04:52 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > > @@ -1596,7 +1596,7 @@ static int check_ftrace_location(struct kprobe *p)
> > > > {
> > > > 	unsigned long ftrace_addr;
> > > > 
> > > > -	ftrace_addr = ftrace_location((unsigned long)p->addr);
> > > > +	ftrace_addr = ftrace_location_range((unsigned long)p->addr, (unsigned long)p->addr);  
> > > 
> > > Yes, although perhaps a new helper. I'll go ponder during lunch.
> > 
> > Is there more places to add that to make it worth creating a helper?
> 
> This is what I ended up with, I've looked at all ftrace_location() sites
> there are, seems to work too, both the built-in boot time ftrace tests
> and the selftests work splat-less.
> 
> I should update the Changelog some though.
> 
> Naveen also mentioned register_ftrace_direct() could be further cleaned
> up, but I didn't want to do too much in once go.
> 
> ---
> 
> Subject: x86/ibt,ftrace: Search for __fentry__ location
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Wed Feb 23 10:01:38 CET 2022
> 
> Have ftrace_location() search the symbol for the __fentry__ location
> when it isn't at func+0 and use this for {,un}register_ftrace_direct().
> 
> This avoids a whole bunch of assumptions about __fentry__ being at
> func+0.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/kprobes/core.c |   11 +---------
>  kernel/bpf/trampoline.c        |   20 +++----------------
>  kernel/kprobes.c               |    8 +------
>  kernel/trace/ftrace.c          |   43 +++++++++++++++++++++++++++++++++--------
>  4 files changed, 43 insertions(+), 39 deletions(-)
> 
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -193,17 +193,10 @@ static unsigned long
>  __recover_probed_insn(kprobe_opcode_t *buf, unsigned long addr)
>  {
>  	struct kprobe *kp;
> -	unsigned long faddr;
> +	bool faddr;
>  
>  	kp = get_kprobe((void *)addr);
> -	faddr = ftrace_location(addr);
> -	/*
> -	 * Addresses inside the ftrace location are refused by
> -	 * arch_check_ftrace_location(). Something went terribly wrong
> -	 * if such an address is checked here.
> -	 */
> -	if (WARN_ON(faddr && faddr != addr))
> -		return 0UL;
> +	faddr = ftrace_location(addr) == addr;

OK, this looks good to me. 

>  	/*
>  	 * Use the current code if it is not modified by Kprobe
>  	 * and it cannot be modified by ftrace.
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -117,18 +117,6 @@ static void bpf_trampoline_module_put(st
>  	tr->mod = NULL;
>  }
>  
> -static int is_ftrace_location(void *ip)
> -{
> -	long addr;
> -
> -	addr = ftrace_location((long)ip);
> -	if (!addr)
> -		return 0;
> -	if (WARN_ON_ONCE(addr != (long)ip))
> -		return -EFAULT;
> -	return 1;
> -}
> -
>  static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
>  {
>  	void *ip = tr->func.addr;
> @@ -160,12 +148,12 @@ static int modify_fentry(struct bpf_tram
>  static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
>  {
>  	void *ip = tr->func.addr;
> +	unsigned long faddr;
>  	int ret;
>  
> -	ret = is_ftrace_location(ip);
> -	if (ret < 0)
> -		return ret;
> -	tr->func.ftrace_managed = ret;
> +	faddr = ftrace_location((unsigned long)ip);
> +	if (faddr)
> +		tr->func.ftrace_managed = true;
>  
>  	if (bpf_trampoline_module_get(tr))
>  		return -ENOENT;
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1562,14 +1562,10 @@ static inline int warn_kprobe_rereg(stru
>  
>  static int check_ftrace_location(struct kprobe *p)
>  {
> -	unsigned long ftrace_addr;
> +	unsigned long addr = (unsigned long)p->addr;
>  
> -	ftrace_addr = ftrace_location((unsigned long)p->addr);
> -	if (ftrace_addr) {
> +	if (ftrace_location(addr) == addr) {
>  #ifdef CONFIG_KPROBES_ON_FTRACE
> -		/* Given address is not on the instruction boundary */
> -		if ((unsigned long)p->addr != ftrace_addr)
> -			return -EILSEQ;

OK, so this means we only use the ftrace if the kprobe puts the
sym+ftrace-offset. Thus if there is ENDBR at the first instruction,
kprobe will use int3, right?
I agree with this, but later I have to add another patch to use ftrace
for the kprobes on symbol+0. But anyway, that is another issue.

So this looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

>  		p->flags |= KPROBE_FLAG_FTRACE;
>  #else	/* !CONFIG_KPROBES_ON_FTRACE */
>  		return -EINVAL;
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -1568,17 +1568,34 @@ unsigned long ftrace_location_range(unsi
>  }
>  
>  /**
> - * ftrace_location - return true if the ip giving is a traced location
> + * ftrace_location - return the ftrace location
>   * @ip: the instruction pointer to check
>   *
> - * Returns rec->ip if @ip given is a pointer to a ftrace location.
> - * That is, the instruction that is either a NOP or call to
> - * the function tracer. It checks the ftrace internal tables to
> - * determine if the address belongs or not.
> + * If @ip matches the ftrace location, return @ip.
> + * If @ip matches sym+0, return sym's ftrace location.
> + * Otherwise, return 0.
>   */
>  unsigned long ftrace_location(unsigned long ip)
>  {
> -	return ftrace_location_range(ip, ip);
> +	struct dyn_ftrace *rec;
> +	unsigned long offset;
> +	unsigned long size;
> +
> +	rec = lookup_rec(ip, ip);
> +	if (!rec) {
> +		if (!kallsyms_lookup_size_offset(ip, &size, &offset))
> +			goto out;
> +
> +		/* map sym+0 to __fentry__ */
> +		if (!offset)
> +			rec = lookup_rec(ip, ip + size - 1);
> +	}
> +
> +	if (rec)
> +		return rec->ip;
> +
> +out:
> +	return 0;
>  }
>  
>  /**
> @@ -4962,7 +4979,8 @@ ftrace_match_addr(struct ftrace_hash *ha
>  {
>  	struct ftrace_func_entry *entry;
>  
> -	if (!ftrace_location(ip))
> +	ip = ftrace_location(ip);
> +	if (!ip)
>  		return -EINVAL;
>  
>  	if (remove) {
> @@ -5110,11 +5128,16 @@ int register_ftrace_direct(unsigned long
>  	struct ftrace_func_entry *entry;
>  	struct ftrace_hash *free_hash = NULL;
>  	struct dyn_ftrace *rec;
> -	int ret = -EBUSY;
> +	int ret = -ENODEV;
>  
>  	mutex_lock(&direct_mutex);
>  
> +	ip = ftrace_location(ip);
> +	if (!ip)
> +		goto out_unlock;
> +
>  	/* See if there's a direct function at @ip already */
> +	ret = -EBUSY;
>  	if (ftrace_find_rec_direct(ip))
>  		goto out_unlock;
>  
> @@ -5222,6 +5245,10 @@ int unregister_ftrace_direct(unsigned lo
>  
>  	mutex_lock(&direct_mutex);
>  
> +	ip = ftrace_location(ip);
> +	if (!ip)
> +		goto out_unlock;
> +
>  	entry = find_direct_entry(&ip, NULL);
>  	if (!entry)
>  		goto out_unlock;


-- 
Masami Hiramatsu <mhiramat@kernel.org>
