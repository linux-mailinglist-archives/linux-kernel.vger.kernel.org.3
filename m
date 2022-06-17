Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A860254F6DA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381427AbiFQLkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbiFQLkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:40:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8EE685A0B6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:40:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68CD011FB;
        Fri, 17 Jun 2022 04:40:09 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.39.168])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A4E23F73B;
        Fri, 17 Jun 2022 04:40:07 -0700 (PDT)
Date:   Fri, 17 Jun 2022 12:40:00 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        christophe.leroy@csgroup.eu, naveen.n.rao@linux.vnet.ibm.com,
        mbenes@suse.cz, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [RFC][PATCH] ftrace,objtool: PC32 based __mcount_loc
Message-ID: <YqxoEJG6jGDWitg3@FVFF77S0Q05N>
References: <YqxkhV1YcI6e+xXp@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqxkhV1YcI6e+xXp@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 01:24:53PM +0200, Peter Zijlstra wrote:
> 
> Hi,
> 
> I recently noticed that __mcount_loc is 64bit wide, containing absolute
> addresses. Since __mcount_loc is a permanent section (not one we drop
> after boot), this bloats the kernel memory usage for no real purpose.
> 
> The below patch adds __mcount_loc_32 and objtool support to generate it.
> This saves, on an x86_64-defconfig + FTRACE, 23975*4 ~= 94K of permanent
> storage.

We have a similar issue on arm64, which is exacerbated by needing ABS64
relocations (24 bytes per entry!) adding significant bloat when FTRACE is
enabled.

It'd be really nice if going forwards compilers could expose an option to
generate PC32/PREL32 entries directly for this.

Mark.

> 
> XXX hobbled sorttable for now
> XXX compile tested only
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  Makefile                                |    3 ++
>  arch/x86/Kconfig                        |    2 -
>  include/asm-generic/vmlinux.lds.h       |    1 
>  include/linux/ftrace.h                  |    6 -----
>  include/linux/ftrace_types.h            |   21 +++++++++++++++++
>  include/linux/module.h                  |    3 +-
>  kernel/trace/Kconfig                    |   18 +++++++++++++++
>  kernel/trace/ftrace.c                   |   38 +++++++++++++++++++++-----------
>  scripts/Makefile.lib                    |    1 
>  tools/objtool/builtin-check.c           |    2 +
>  tools/objtool/check.c                   |   25 ++++++++++-----------
>  tools/objtool/include/objtool/builtin.h |    1 
>  12 files changed, 90 insertions(+), 31 deletions(-)
> 
> --- a/Makefile
> +++ b/Makefile
> @@ -858,6 +858,9 @@ endif
>  ifdef CONFIG_FTRACE_MCOUNT_USE_OBJTOOL
>    CC_FLAGS_USING	+= -DCC_USING_NOP_MCOUNT
>  endif
> +ifdef CONFIG_FTRACE_MCOUNT32_USE_OBJTOOL
> +  CC_FLAGS_USING	+= -DCC_USING_NOP_MCOUNT -DCC_USING_MCOUNT_LOC_32
> +endif
>  ifdef CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT
>    ifdef CONFIG_HAVE_C_RECORDMCOUNT
>      BUILD_C_RECORDMCOUNT := y
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -190,7 +190,7 @@ config X86
>  	select HAVE_CONTEXT_TRACKING_OFFSTACK	if HAVE_CONTEXT_TRACKING
>  	select HAVE_C_RECORDMCOUNT
>  	select HAVE_OBJTOOL_MCOUNT		if HAVE_OBJTOOL
> -	select HAVE_BUILDTIME_MCOUNT_SORT
> +	select HAVE_BUILDTIME_MCOUNT_SORT	if !HAVE_OBJTOOL_MCOUNT
>  	select HAVE_DEBUG_KMEMLEAK
>  	select HAVE_DMA_CONTIGUOUS
>  	select HAVE_DYNAMIC_FTRACE
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -172,6 +172,7 @@
>  #define MCOUNT_REC()	. = ALIGN(8);				\
>  			__start_mcount_loc = .;			\
>  			KEEP(*(__mcount_loc))			\
> +			KEEP(*(__mcount_loc_32))		\
>  			KEEP(*(__patchable_function_entries))	\
>  			__stop_mcount_loc = .;			\
>  			ftrace_stub_graph = ftrace_stub;	\
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -19,6 +19,7 @@
>  #include <linux/types.h>
>  #include <linux/init.h>
>  #include <linux/fs.h>
> +#include <linux/ftrace_types.h>
>  
>  #include <asm/ftrace.h>
>  
> @@ -926,11 +927,6 @@ static inline unsigned long get_lock_par
>  
>  #ifdef CONFIG_FTRACE_MCOUNT_RECORD
>  extern void ftrace_init(void);
> -#ifdef CC_USING_PATCHABLE_FUNCTION_ENTRY
> -#define FTRACE_CALLSITE_SECTION	"__patchable_function_entries"
> -#else
> -#define FTRACE_CALLSITE_SECTION	"__mcount_loc"
> -#endif
>  #else
>  static inline void ftrace_init(void) { }
>  #endif
> --- /dev/null
> +++ b/include/linux/ftrace_types.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _LINUX_FTRACE_TYPES_H
> +#define _LINUX_FTRACE_TYPES_H
> +
> +#ifdef CONFIG_FTRACE_MCOUNT_RECORD
> +
> +#ifdef CC_USING_PATCHABLE_FUNCTION_ENTRY
> +#define FTRACE_CALLSITE_SECTION	"__patchable_function_entries"
> +typedef unsigned long mcount_t;
> +#elif CC_USING_MCOUNT_LOC_32
> +#define FTRACE_CALLSITE_SECTION	"__mcount_loc_32"
> +typedef u32 mcount_t;
> +#else
> +#define FTRACE_CALLSITE_SECTION	"__mcount_loc"
> +typedef unsigned long mcount_t;
> +#endif
> +
> +#endif /* CONFIG_FTRACE_MCOUNT_RECORD */
> +
> +#endif /* _LINUX_FTRACE_TYPES_H */
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -28,6 +28,7 @@
>  #include <linux/srcu.h>
>  #include <linux/static_call_types.h>
>  #include <linux/cfi.h>
> +#include <linux/ftrace_types.h>
>  
>  #include <linux/percpu.h>
>  #include <asm/module.h>
> @@ -493,7 +494,7 @@ struct module {
>  #endif
>  #ifdef CONFIG_FTRACE_MCOUNT_RECORD
>  	unsigned int num_ftrace_callsites;
> -	unsigned long *ftrace_callsites;
> +	mcount_t *ftrace_callsites;
>  #endif
>  #ifdef CONFIG_KPROBES
>  	void *kprobes_text_start;
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -717,16 +717,33 @@ config FTRACE_MCOUNT_USE_PATCHABLE_FUNCT
>  	bool
>  	depends on FTRACE_MCOUNT_RECORD
>  
> +#
> +# mcount preference:
> +#  * objtool --mcount32
> +#  * gcc -mrecord-mcount
> +#  * objtool --mcount
> +#  * recordmcount
> +#
> +
> +config FTRACE_MCOUNT32_USE_OBJTOOL
> +	def_bool y
> +	depends on HAVE_OBJTOOL_MCOUNT
> +	depends on !FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
> +	depends on FTRACE_MCOUNT_RECORD
> +	select OBJTOOL
> +
>  config FTRACE_MCOUNT_USE_CC
>  	def_bool y
>  	depends on $(cc-option,-mrecord-mcount)
>  	depends on !FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
> +	depends on !FTRACE_MCOUNT32_USE_OBJTOOL
>  	depends on FTRACE_MCOUNT_RECORD
>  
>  config FTRACE_MCOUNT_USE_OBJTOOL
>  	def_bool y
>  	depends on HAVE_OBJTOOL_MCOUNT
>  	depends on !FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
> +	depends on !FTRACE_MCOUNT32_USE_OBJTOOL
>  	depends on !FTRACE_MCOUNT_USE_CC
>  	depends on FTRACE_MCOUNT_RECORD
>  	select OBJTOOL
> @@ -735,6 +752,7 @@ config FTRACE_MCOUNT_USE_RECORDMCOUNT
>  	def_bool y
>  	depends on !FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
>  	depends on !FTRACE_MCOUNT_USE_CC
> +	depends on !FTRACE_MCOUNT32_USE_OBJTOOL
>  	depends on !FTRACE_MCOUNT_USE_OBJTOOL
>  	depends on FTRACE_MCOUNT_RECORD
>  
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6544,18 +6544,26 @@ static __init int ftrace_init_dyn_tracef
>  
>  static int ftrace_cmp_ips(const void *a, const void *b)
>  {
> -	const unsigned long *ipa = a;
> -	const unsigned long *ipb = b;
> +	const mcount_t *_a = a;
> +	const mcount_t *_b = b;
>  
> -	if (*ipa > *ipb)
> +#ifdef CC_USING_MCOUNT_LOC_32
> +	const unsigned long ipa = (unsigned long)_a + *_a;
> +	const unsigned long ipb = (unsigned long)_b + *_b;
> +#else
> +	const unsigned long ipa = *_a;
> +	const unsigned long ipb = *_b;
> +#endif
> +
> +	if (ipa > ipb)
>  		return 1;
> -	if (*ipa < *ipb)
> +	if (ipa < ipb)
>  		return -1;
>  	return 0;
>  }
>  
>  #ifdef CONFIG_FTRACE_SORT_STARTUP_TEST
> -static void test_is_sorted(unsigned long *start, unsigned long count)
> +static void test_is_sorted(mcount_t *start, unsigned long count)
>  {
>  	int i;
>  
> @@ -6570,23 +6578,23 @@ static void test_is_sorted(unsigned long
>  		pr_info("ftrace section at %px sorted properly\n", start);
>  }
>  #else
> -static void test_is_sorted(unsigned long *start, unsigned long count)
> +static void test_is_sorted(mcount_t *start, unsigned long count)
>  {
>  }
>  #endif
>  
>  static int ftrace_process_locs(struct module *mod,
> -			       unsigned long *start,
> -			       unsigned long *end)
> +			       mcount_t *start,
> +			       mcount_t *end)
>  {
>  	struct ftrace_page *start_pg;
>  	struct ftrace_page *pg;
>  	struct dyn_ftrace *rec;
>  	unsigned long count;
> -	unsigned long *p;
>  	unsigned long addr;
>  	unsigned long flags = 0; /* Shut up gcc */
>  	int ret = -ENOMEM;
> +	mcount_t *p;
>  
>  	count = end - start;
>  
> @@ -6637,7 +6645,13 @@ static int ftrace_process_locs(struct mo
>  	pg = start_pg;
>  	while (p < end) {
>  		unsigned long end_offset;
> -		addr = ftrace_call_adjust(*p++);
> +#ifdef CC_USING_MCOUNT_LOC_32
> +		addr = (unsigned long)p + *p;
> +		p++;
> +#else
> +		addr = *p++;
> +#endif
> +		addr = ftrace_call_adjust(addr);
>  		/*
>  		 * Some architecture linkers will pad between
>  		 * the different mcount_loc sections of different
> @@ -7280,8 +7294,8 @@ int __init __weak ftrace_dyn_arch_init(v
>  
>  void __init ftrace_init(void)
>  {
> -	extern unsigned long __start_mcount_loc[];
> -	extern unsigned long __stop_mcount_loc[];
> +	extern mcount_t __start_mcount_loc[];
> +	extern mcount_t __stop_mcount_loc[];
>  	unsigned long count, flags;
>  	int ret;
>  
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -234,6 +234,7 @@ objtool_args =								\
>  	$(if $(CONFIG_HAVE_NOINSTR_HACK), --hacks=noinstr)		\
>  	$(if $(CONFIG_X86_KERNEL_IBT), --ibt)				\
>  	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
> +	$(if $(CONFIG_FTRACE_MCOUNT32_USE_OBJTOOL), --mcount32)		\
>  	$(if $(CONFIG_UNWINDER_ORC), --orc)				\
>  	$(if $(CONFIG_RETPOLINE), --retpoline)				\
>  	$(if $(CONFIG_SLS), --sls)					\
> --- a/tools/objtool/builtin-check.c
> +++ b/tools/objtool/builtin-check.c
> @@ -65,6 +65,7 @@ const struct option check_options[] = {
>  	OPT_CALLBACK_OPTARG('h', "hacks", NULL, NULL, "jump_label,noinstr", "patch toolchain bugs/limitations", parse_hacks),
>  	OPT_BOOLEAN('i', "ibt", &opts.ibt, "validate and annotate IBT"),
>  	OPT_BOOLEAN('m', "mcount", &opts.mcount, "annotate mcount/fentry calls for ftrace"),
> +	OPT_BOOLEAN(0,   "mcount32", &opts.mcount32, "annotate mcount/fentry calls for ftrace"),
>  	OPT_BOOLEAN('n', "noinstr", &opts.noinstr, "validate noinstr rules"),
>  	OPT_BOOLEAN('o', "orc", &opts.orc, "generate ORC metadata"),
>  	OPT_BOOLEAN('r', "retpoline", &opts.retpoline, "validate and annotate retpoline usage"),
> @@ -120,6 +121,7 @@ static bool opts_valid(void)
>  	    opts.hack_noinstr		||
>  	    opts.ibt			||
>  	    opts.mcount			||
> +	    opts.mcount32		||
>  	    opts.noinstr		||
>  	    opts.orc			||
>  	    opts.retpoline		||
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -803,15 +803,16 @@ static int create_ibt_endbr_seal_section
>  
>  static int create_mcount_loc_sections(struct objtool_file *file)
>  {
> -	struct section *sec;
> -	unsigned long *loc;
> +	const char *secname = opts.mcount32 ? "__mcount_loc_32" : "__mcount_loc";
> +	unsigned int entsize = opts.mcount32 ? sizeof(u32) : sizeof(u64);
>  	struct instruction *insn;
> +	struct section *sec;
>  	int idx;
>  
> -	sec = find_section_by_name(file->elf, "__mcount_loc");
> +	sec = find_section_by_name(file->elf, secname);
>  	if (sec) {
>  		INIT_LIST_HEAD(&file->mcount_loc_list);
> -		WARN("file already has __mcount_loc section, skipping");
> +		WARN("file already has %s section, skipping", secname);
>  		return 0;
>  	}
>  
> @@ -822,19 +823,18 @@ static int create_mcount_loc_sections(st
>  	list_for_each_entry(insn, &file->mcount_loc_list, call_node)
>  		idx++;
>  
> -	sec = elf_create_section(file->elf, "__mcount_loc", 0, sizeof(unsigned long), idx);
> +	sec = elf_create_section(file->elf, secname, 0, entsize, idx);
>  	if (!sec)
>  		return -1;
>  
>  	idx = 0;
>  	list_for_each_entry(insn, &file->mcount_loc_list, call_node) {
> -
> -		loc = (unsigned long *)sec->data->d_buf + idx;
> -		memset(loc, 0, sizeof(unsigned long));
> +		void *loc = sec->data->d_buf + idx * entsize;
> +		memset(loc, 0, entsize);
>  
>  		if (elf_add_reloc_to_insn(file->elf, sec,
> -					  idx * sizeof(unsigned long),
> -					  R_X86_64_64,
> +					  idx * entsize,
> +					  opts.mcount32 ? R_X86_64_PC32 : R_X86_64_64,
>  					  insn->sec, insn->offset))
>  			return -1;
>  
> @@ -1174,7 +1174,7 @@ static void annotate_call_site(struct ob
>  		return;
>  	}
>  
> -	if (opts.mcount && sym->fentry) {
> +	if ((opts.mcount || opts.mcount32) && sym->fentry) {
>  		if (sibling)
>  			WARN_FUNC("Tail call to __fentry__ !?!?", insn->sec, insn->offset);
>  
> @@ -3827,6 +3827,7 @@ static int validate_ibt(struct objtool_f
>  		    !strcmp(sec->name, "__ex_table")			||
>  		    !strcmp(sec->name, "__jump_table")			||
>  		    !strcmp(sec->name, "__mcount_loc")			||
> +		    !strcmp(sec->name, "__mcount_loc_32")		||
>  		    !strcmp(sec->name, "__tracepoints"))
>  			continue;
>  
> @@ -3974,7 +3975,7 @@ int check(struct objtool_file *file)
>  		warnings += ret;
>  	}
>  
> -	if (opts.mcount) {
> +	if (opts.mcount || opts.mcount32) {
>  		ret = create_mcount_loc_sections(file);
>  		if (ret < 0)
>  			goto out;
> --- a/tools/objtool/include/objtool/builtin.h
> +++ b/tools/objtool/include/objtool/builtin.h
> @@ -16,6 +16,7 @@ struct opts {
>  	bool hack_noinstr;
>  	bool ibt;
>  	bool mcount;
> +	bool mcount32;
>  	bool noinstr;
>  	bool orc;
>  	bool retpoline;
