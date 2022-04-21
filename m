Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE4F50A072
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiDUNNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiDUNM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:12:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03EAA558E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:10:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFAE31515;
        Thu, 21 Apr 2022 06:10:07 -0700 (PDT)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 548E53F73B;
        Thu, 21 Apr 2022 06:10:06 -0700 (PDT)
Date:   Thu, 21 Apr 2022 14:10:04 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     cj.chengjian@huawei.com, huawei.libin@huawei.com,
        xiexiuqi@huawei.com, liwei391@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        zengshun.wu@outlook.com
Subject: Re: [RFC PATCH -next v2 3/4] arm64/ftrace: support dynamically
 allocated trampolines
Message-ID: <YmFXrBG5AmX3+4f8@lakrids>
References: <20220316100132.244849-1-bobo.shaobowang@huawei.com>
 <20220316100132.244849-4-bobo.shaobowang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316100132.244849-4-bobo.shaobowang@huawei.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 06:01:31PM +0800, Wang ShaoBo wrote:
> From: Cheng Jian <cj.chengjian@huawei.com>
> 
> When tracing multiple functions customly, a list function is called
> in ftrace_(regs)_caller, which makes all the other traced functions
> recheck the hash of the ftrace_ops when tracing happend, apparently
> it is inefficient.

... and when does that actually matter? Who does this and why?

> We notified X86_64 has delivered a dynamically allocated trampoline
> which calls the callback directly to solve this problem. This patch
> introduces similar trampolines for ARM64, but we also should also
> handle long jump different.
> 
> Similar to X86_64, save the local ftrace_ops at the end.
> the ftrace trampoline layout:
> 
>          ftrace_(regs_)caller_tramp            low
>                    `--> +---------------------+ ^
>                         | ftrace_regs_entry:  | |
>                         | ...                 | |
>                         +---------------------+ |
>                         | ftrace_common:      | |
>                         | ...                 | |
>                         | ldr x2, <ftrace_ops>| |
>        ftrace callsite  | ...                 | |
>                    `--> +---------------------+ |
>                         | nop                  >> bl <callback>
>  ftrace graph callsite  | PLT entrys (TODO)   | |
>                    `--> +---------------------+ |
>                         | nop                  >> bl <graph callback>
>                         | PLT entrys (TODO)   | |
>                         +---------------------+ |
>                         | ftrace_regs_restore:| |
>                         | ...                 | |
>                         +---------------------+ |
>                         | ftrace_ops          | |
>                         +---------------------+ |
>                                                high

Chengming Zhou has patches to unify the two calls in the trampoline:

  https://lore.kernel.org/linux-arm-kernel/20220420160006.17880-1-zhouchengming@bytedance.com/

... and I'd much prefer that we do that *before* we copy-paste that code
for dynamic trampolines.

> Adopting the new dynamical trampoline is benificial when only one
> callback is registered to a function, when tracing happened, ftrace_ops
> can get its own callback directly from this trampoline allocated.
> 
> To compare the efficiency of calling schedule() when using traditional
> dynamic ftrace(using ftrace_ops_list) and ftrace using dynamic trampoline,
> We wrote a module to register multiple ftrace_ops, but only one(in our
> testcase is 'schedule') is used to measure the performance on the call
> path used by Unixbench.
> 
> This is the partial code:
> ```
>      static struct ftrace_ops *ops_array[100];
>      static struct ftrace_ops ops = {
>              .func                    = my_callback_func,
>              .flags                   = FTRACE_OPS_FL_PID,
>      };
>      static int register_ftrace_test_init(void)
>      {
>              int i, ret;
> 
>              if (cnt > 100 || cnt < 0)
>                      return -1;
> 
>              for (i = 0; i < cnt; i++) {
>                      ops_array[i] = kzalloc(sizeof(struct ftrace_ops), GFP_KERNEL);
>                      if (!ops_array[i])
>                              return -1;
> 
>                      *ops_array[i] = ops;
> 
>                      ret = ftrace_set_filter(ops_array[i], "cpuset_write_u64",
>                                  strlen("cpuset_write_u64"), 1);
>                      if (ret)
>                              return ret;
> 
>                      ret = register_ftrace_function(ops_array[i]);
>                      if (ret)
>                              return ret;
>              }
> 
>              ret = ftrace_set_filter(&ops, "schedule", strlen("schedule"), 1);
>              if (ret)
>                      return ret;
>              return register_ftrace_function(&ops);
>      }
> ```
> 
> So in our test, ftrace_ops_list can be illustrated:
> 
> HEAD(ftrace_ops_list)
> `-> +--------+    +--------+    +--------+     +------------+    +--------+
>     +  ops0  + -> +  ops1  + -> +  ops2  + ... +  ops(cnt-1)+ -> +   ops  +
>     +--------+    +--------+    +--------+     +------------+    +--------+ \_END
>         `-------------cpuset_write_u64----------------`           `schedule`
> 
> This is the result testing on kunpeng920 with CONFIG_RANDOMIZE_BASE=n
> (we also add first NA row for comparison with not tracing any function):
> 
>     command: taskset -c 1 ./Run -c 1 context1
>     +------------------UnixBench context1--------------------+
>     +---------+--------------+-----------------+-------------+
>     +         +            Score               + improvement +
>     +         +--------------+-----------------+-------------+
>     +         +  traditional +  dynamic tramp  +     +/-     +
>     +---------+--------------+-----------------+-------------+
>     +   NA    +    554.6     +     553.6       +      -      +
>     +---------+--------------+-----------------+-------------+
>     +  cnt=0  +    542.4     +     549.7       +    +1.2%    +
>     +---------+--------------+-----------------+-------------+
>     +  cnt=3  +    528.7     +     549.7       +    +3.9%    +
>     +---------+--------------+-----------------+-------------+
>     +  cnt=6  +    523.9     +     549.8       +    +4.9%    +
>     +---------+--------------+-----------------+-------------+
>     +  cnt=15 +    504.2     +     549.0       +    +8.9%    +
>     +---------+--------------+-----------------+-------------+
>     +  cnt=20 +    492.6     +     551.1       +    +11.9%   +
>     +---------+--------------+-----------------+-------------+
> 
> References:
> - https://lore.kernel.org/linux-arm-kernel/20200109142736.1122-1-cj.chengjian@huawei.com/
> 
> Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> ---
>  arch/arm64/kernel/ftrace.c | 286 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 286 insertions(+)
> 
> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> index 4506c4a90ac1..d35a042baf75 100644
> --- a/arch/arm64/kernel/ftrace.c
> +++ b/arch/arm64/kernel/ftrace.c
> @@ -10,12 +10,14 @@
>  #include <linux/module.h>
>  #include <linux/swab.h>
>  #include <linux/uaccess.h>
> +#include <linux/vmalloc.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/debug-monitors.h>
>  #include <asm/ftrace.h>
>  #include <asm/insn.h>
>  #include <asm/patching.h>
> +#include <asm/set_memory.h>
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  /*
> @@ -48,6 +50,290 @@ static int ftrace_modify_code(unsigned long pc, u32 old, u32 new,
>  	return 0;
>  }
>  
> +/* ftrace dynamic trampolines */
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +#ifdef CONFIG_MODULES
> +#include <linux/moduleloader.h>
> +
> +static inline void *alloc_tramp(unsigned long size)
> +{
> +	return module_alloc(size);
> +}
> +
> +static inline void tramp_free(void *tramp)
> +{
> +	module_memfree(tramp);
> +}
> +#else
> +static inline void *alloc_tramp(unsigned long size)
> +{
> +	return NULL;
> +}
> +
> +static inline void tramp_free(void *tramp) {}
> +#endif
> +
> +/* ftrace_caller trampoline template */
> +extern void ftrace_caller_tramp(void);
> +extern void ftrace_caller_tramp_end(void);
> +extern void ftrace_caller_tramp_call(void);
> +extern void ftrace_caller_tramp_graph_call(void);
> +extern void ftrace_caller_tramp_ops(void);
> +
> +/* ftrace_regs_caller trampoline template */
> +extern void ftrace_regs_caller_tramp(void);
> +extern void ftrace_regs_caller_tramp_end(void);
> +extern void ftrace_regs_caller_tramp_call(void);
> +extern void ftrace_regs_caller_tramp_graph_call(void);
> +extern void ftrace_regs_caller_tramp_ops(void);
> +
> +
> +/*
> + * The ARM64 ftrace trampoline layout :
> + *
> + *
> + *         ftrace_(regs_)caller_tramp            low
> + *                   `--> +---------------------+ ^
> + *                        | ftrace_regs_entry:  | |
> + *                        | ...                 | |
> + *                        +---------------------+ |
> + *                        | ftrace_common:      | |
> + *                        | ...                 | |
> + *                        | ldr x2, <ftrace_ops>| |
> + *       ftrace callsite  | ...                 | |
> + *                   `--> +---------------------+ |
> + *                        | nop                  >> bl <callback>
> + * ftrace graph callsite  | PLT entrys (TODO)   | |
> + *                   `--> +---------------------+ |
> + *                        | nop                  >> bl <graph callback>
> + *                        | PLT entrys (TODO)   | |
> + *                        +---------------------+ |
> + *                        | ftrace_regs_restore:| |
> + *                        | ...                 | |
> + *                        +---------------------+ |
> + *                        | ftrace_ops          | |
> + *                        +---------------------+ |
> + *                                               high
> + */

As above, I'd prefer we unify the callsite and graph callsite first.

> +
> +static unsigned long
> +create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
> +{
> +	unsigned long start_offset, end_offset, ops_offset;
> +	unsigned long caller_size, size, offset;
> +	unsigned long pc, npages;
> +	unsigned long *ptr;
> +	void *trampoline;
> +	u32 load;
> +	int ret;
> +
> +	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
> +		start_offset = (unsigned long)ftrace_regs_caller_tramp;
> +		end_offset = (unsigned long)ftrace_regs_caller_tramp_end;
> +		ops_offset = (unsigned long)ftrace_regs_caller_tramp_ops;
> +	} else {
> +		start_offset = (unsigned long)ftrace_caller_tramp;
> +		end_offset = (unsigned long)ftrace_caller_tramp_end;
> +		ops_offset = (unsigned long)ftrace_caller_tramp_ops;
> +	}
> +
> +	caller_size = end_offset - start_offset + AARCH64_INSN_SIZE;
> +	size = caller_size + sizeof(void *);
> +
> +	trampoline = alloc_tramp(size);
> +	if (!trampoline)
> +		return 0;
> +
> +	*tramp_size = size;
> +	npages = DIV_ROUND_UP(*tramp_size, PAGE_SIZE);
> +
> +	/*
> +	 * copy ftrace_caller/ftrace_regs_caller trampoline template
> +	 * onto the trampoline memory
> +	 */
> +	ret = copy_from_kernel_nofault(trampoline, (void *)start_offset, caller_size);
> +	if (WARN_ON(ret < 0))
> +		goto free;

Why is this using copy_from_kernel_nofault() ?

There's no reason whatsoever that this should legitimately fault, so it
should be fine to use memcpy().

> +
> +	/*
> +	 * Stored ftrace_ops at the end of the trampoline.
> +	 * This will be used to load the third parameter for the callback.
> +	 * Basically, that location at the end of the trampoline takes the
> +	 * place of the global function_trace_op variable.
> +	 */
> +	ptr = (unsigned long *)(trampoline + caller_size);
> +	*ptr = (unsigned long)ops;
> +
> +	/*
> +	 * Update the trampoline ops REF
> +	 *	ldr x2, <ftrace_ops>
> +	 */
> +	ops_offset -= start_offset;
> +	pc = (unsigned long)trampoline + ops_offset;
> +	offset = (unsigned long)ptr - pc;
> +	if (WARN_ON(offset % AARCH64_INSN_SIZE != 0))
> +		goto free;
> +
> +	load = aarch64_insn_gen_load_literal(AARCH64_INSN_REG_2,
> +		AARCH64_INSN_VARIANT_64BIT, offset);
> +	if (ftrace_modify_code(pc, 0, load, false))
> +		goto free;
> +
> +	ops->flags |= FTRACE_OPS_FL_ALLOC_TRAMP;
> +
> +	set_vm_flush_reset_perms(trampoline);
> +
> +	/*
> +	 * Module allocation needs to be completed by making the page
> +	 * executable. The page is still writable, which is a security hazard,
> +	 * but anyhow ftrace breaks W^X completely.
> +	 */
> +	set_memory_ro((unsigned long)trampoline, npages);
> +	set_memory_x((unsigned long)trampoline, npages);
> +

Where is the cache maintenance performed?

> +	return (unsigned long)trampoline;
> +
> +free:
> +	tramp_free(trampoline);
> +	return 0;
> +}
> +
> +static unsigned long calc_trampoline_call_offset(bool save_regs, bool is_graph)
> +{
> +	unsigned start_offset, call_offset;
> +
> +	if (save_regs) {
> +		start_offset = (unsigned long)ftrace_regs_caller_tramp;
> +		if (is_graph)
> +			call_offset = (unsigned long)ftrace_regs_caller_tramp_graph_call;
> +		else
> +			call_offset = (unsigned long)ftrace_regs_caller_tramp_call;
> +	} else {
> +		start_offset = (unsigned long)ftrace_caller_tramp;
> +		if (is_graph)
> +			call_offset = (unsigned long)ftrace_caller_tramp_graph_call;
> +		else
> +			call_offset = (unsigned long)ftrace_caller_tramp_call;
> +	}

This should be simplified by unifying the call sites.

Since we need the offsets in a few places, we should factor that out.
For example, have a structure with those offsets, and a helper which
returns that filled with either the regular offsets or the regs offsts.
More ideally, fill those in at compile-time.

> +
> +	return call_offset - start_offset;
> +}
> +
> +static inline ftrace_func_t
> +ftrace_trampoline_get_func(struct ftrace_ops *ops, bool is_graph)
> +{
> +	ftrace_func_t func;
> +
> +	if (!is_graph)
> +		func = ftrace_ops_get_func(ops);
> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> +	else
> +		func = (ftrace_func_t)ftrace_graph_caller;
> +#endif
> +
> +	return func;
> +}
> +
> +static int
> +ftrace_trampoline_modify_call(struct ftrace_ops *ops, bool is_graph, bool active)
> +{
> +	unsigned long offset;
> +	unsigned long pc;
> +	ftrace_func_t func;
> +	u32 nop, branch;
> +
> +	offset = calc_trampoline_call_offset(ops->flags &
> +				FTRACE_OPS_FL_SAVE_REGS, is_graph);
> +	pc = ops->trampoline + offset;
> +
> +	func = ftrace_trampoline_get_func(ops, is_graph);
> +	nop = aarch64_insn_gen_nop();
> +	branch = aarch64_insn_gen_branch_imm(pc, (unsigned long)func,
> +				AARCH64_INSN_BRANCH_LINK);
> +
> +	if (active)
> +		return ftrace_modify_code(pc, 0, branch, false);
> +	else
> +		return ftrace_modify_code(pc, 0, nop, false);
> +}
> +
> +extern int ftrace_graph_active;
> +void arch_ftrace_update_trampoline(struct ftrace_ops *ops)
> +{
> +	unsigned int size;
> +
> +	/*
> +	 * If kaslr is enabled, the address of tramp and ftrace call
> +	 * may be far away, Therefore, long jump support is required.
> +	 */
> +	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> +		return;

IIUC this can be required in some unusual configurations *today* even
without KASLR, so we probably want to add the long jump support first.

Thanks,
Mark.

> +
> +	if (!ops->trampoline) {
> +		ops->trampoline = create_trampoline(ops, &size);
> +		if (!ops->trampoline)
> +			return;
> +		ops->trampoline_size = size;
> +	}
> +
> +	/* These is no static trampoline on ARM64 */
> +	WARN_ON(!(ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP));
> +
> +	/* atomic modify trampoline: <call func> */
> +	WARN_ON(ftrace_trampoline_modify_call(ops, false, true));
> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> +	/* atomic modify trampoline: <call graph func> */
> +	WARN_ON(ftrace_trampoline_modify_call(ops, true, ftrace_graph_active));
> +#endif
> +}
> +
> +static void *addr_from_call(void *ptr)
> +{
> +	u32 insn;
> +	unsigned long offset;
> +
> +	if (aarch64_insn_read(ptr, &insn))
> +		return NULL;
> +
> +	/* Make sure this is a call */
> +	if (!aarch64_insn_is_bl(insn)) {
> +		pr_warn("Expected bl instruction, but not\n");
> +		return NULL;
> +	}
> +
> +	offset = aarch64_get_branch_offset(insn);
> +
> +	return (void *)ptr + AARCH64_INSN_SIZE + offset;
> +}
> +
> +void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
> +			   unsigned long frame_pointer);
> +
> +void *arch_ftrace_trampoline_func(struct ftrace_ops *ops, struct dyn_ftrace *rec)
> +{
> +	unsigned long offset;
> +
> +	/* If we didn't allocate this trampoline, consider it static */
> +	if (!ops || !(ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP))
> +		return NULL;
> +
> +	offset = calc_trampoline_call_offset(ops->flags & FTRACE_OPS_FL_SAVE_REGS,
> +					ftrace_graph_active);
> +
> +	return addr_from_call((void *)ops->trampoline + offset);
> +}
> +
> +void arch_ftrace_trampoline_free(struct ftrace_ops *ops)
> +{
> +	if (!ops || !(ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP))
> +		return;
> +
> +	tramp_free((void *)ops->trampoline);
> +	ops->trampoline = 0;
> +	ops->trampoline_size = 0;
> +}
> +#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> +
>  /*
>   * Replace tracer function in ftrace_caller()
>   */
> -- 
> 2.25.1
> 
