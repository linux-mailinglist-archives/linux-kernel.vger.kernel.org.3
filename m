Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A58463C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 18:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244646AbhK3RLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 12:11:34 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:47464 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbhK3RLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 12:11:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C7077CE1864
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:08:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68072C53FC1;
        Tue, 30 Nov 2021 17:08:10 +0000 (UTC)
Date:   Tue, 30 Nov 2021 12:08:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yinan Liu <yinan@linux.alibaba.com>
Cc:     peterz@infradead.org, mark-pk.tsai@mediatek.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] scripts: ftrace - move the sort-processing in
 ftrace_init to compile time
Message-ID: <20211130120808.0db8af81@gandalf.local.home>
In-Reply-To: <20211123105404.22166-2-yinan@linux.alibaba.com>
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
        <20211123105404.22166-1-yinan@linux.alibaba.com>
        <20211123105404.22166-2-yinan@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 18:54:04 +0800
Yinan Liu <yinan@linux.alibaba.com> wrote:

> When the kernel starts, the initialization of ftrace takes
> up a portion of the time (approximately 6~8ms) to sort mcount
> addresses. We can save this time by moving mcount-sorting to
> compile time.
> 

Hmm, this depends on CONFIG_BUILDTIME_TABLE_SORT, and not every
architecture that defines CONFIG_HAVE_DYNAMIC_FTRACE also defines
CONFIG_BUILDTIME_TABLE_SORT. So this will break those architectures.

> Signed-off-by: Yinan Liu <yinan@linux.alibaba.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  kernel/trace/ftrace.c   |   6 ++-
>  scripts/Makefile        |   2 +-
>  scripts/link-vmlinux.sh |   6 +--
>  scripts/sorttable.c     |   2 +
>  scripts/sorttable.h     | 113 ++++++++++++++++++++++++++++++++++++++++++++++--
>  5 files changed, 119 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 7b180f6..f5af419 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6189,8 +6189,10 @@ static int ftrace_process_locs(struct module *mod,
>  	if (!count)
>  		return 0;
>  
> -	sort(start, count, sizeof(*start),
> -	     ftrace_cmp_ips, NULL);

Should have a comment:

	/* Modules can not be sorted at build time */
> +	if (mod) {

And perhaps even add:

	if (!IS_ENABLED(CONFIG_BUILDTIME_TABLE_SORT) || mod) {

> +		sort(start, count, sizeof(*start),
> +		     ftrace_cmp_ips, NULL);
> +	}
>  
>  	start_pg = ftrace_allocate_pages(count);
>  	if (!start_pg)
> diff --git a/scripts/Makefile b/scripts/Makefile
> index 9adb6d2..b286e11 100644
> --- a/scripts/Makefile
> +++ b/scripts/Makefile
> @@ -17,6 +17,7 @@ hostprogs-always-$(CONFIG_SYSTEM_EXTRA_CERTIFICATE)	+= insert-sys-cert
>  hostprogs-always-$(CONFIG_SYSTEM_REVOCATION_LIST)	+= extract-cert
>  
>  HOSTCFLAGS_sorttable.o = -I$(srctree)/tools/include
> +HOSTLDLIBS_sorttable = -lpthread
>  HOSTCFLAGS_asn1_compiler.o = -I$(srctree)/include
>  HOSTCFLAGS_sign-file.o = $(CRYPTO_CFLAGS)
>  HOSTLDLIBS_sign-file = $(CRYPTO_LIBS)
> @@ -29,7 +30,6 @@ ARCH := x86
>  endif
>  HOSTCFLAGS_sorttable.o += -I$(srctree)/tools/arch/x86/include
>  HOSTCFLAGS_sorttable.o += -DUNWINDER_ORC_ENABLED
> -HOSTLDLIBS_sorttable = -lpthread
>  endif
>  
>  # The following programs are only built on demand
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 36ef7b3..e2e1a8f 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -422,6 +422,9 @@ if [ -n "${CONFIG_DEBUG_INFO_BTF}" -a -n "${CONFIG_BPF}" ]; then
>  	${RESOLVE_BTFIDS} vmlinux
>  fi
>  
> +info SYSMAP System.map
> +mksysmap vmlinux System.map
> +
>  if [ -n "${CONFIG_BUILDTIME_TABLE_SORT}" ]; then
>  	info SORTTAB vmlinux
>  	if ! sorttable vmlinux; then
> @@ -430,9 +433,6 @@ if [ -n "${CONFIG_BUILDTIME_TABLE_SORT}" ]; then
>  	fi
>  fi
>  
> -info SYSMAP System.map
> -mksysmap vmlinux System.map
> -
>  # step a (see comment above)
>  if [ -n "${CONFIG_KALLSYMS}" ]; then
>  	mksysmap ${kallsyms_vmlinux} .tmp_System.map
> diff --git a/scripts/sorttable.c b/scripts/sorttable.c
> index 0ef3abf..11a595c 100644
> --- a/scripts/sorttable.c
> +++ b/scripts/sorttable.c
> @@ -30,6 +30,8 @@
>  #include <stdlib.h>
>  #include <string.h>
>  #include <unistd.h>
> +#include <errno.h>
> +#include <pthread.h>
>  
>  #include <tools/be_byteshift.h>
>  #include <tools/le_byteshift.h>
> diff --git a/scripts/sorttable.h b/scripts/sorttable.h
> index a2baa2f..81dbf37 100644
> --- a/scripts/sorttable.h
> +++ b/scripts/sorttable.h
> @@ -19,6 +19,9 @@
>  
>  #undef extable_ent_size
>  #undef compare_extable
> +#undef get_mcount_loc
> +#undef sort_mcount_loc
> +#undef elf_mcount_loc
>  #undef do_sort
>  #undef Elf_Addr
>  #undef Elf_Ehdr
> @@ -41,6 +44,9 @@
>  #ifdef SORTTABLE_64
>  # define extable_ent_size	16
>  # define compare_extable	compare_extable_64
> +# define get_mcount_loc		get_mcount_loc_64
> +# define sort_mcount_loc	sort_mcount_loc_64
> +# define elf_mcount_loc		elf_mcount_loc_64
>  # define do_sort		do_sort_64
>  # define Elf_Addr		Elf64_Addr
>  # define Elf_Ehdr		Elf64_Ehdr
> @@ -62,6 +68,9 @@
>  #else
>  # define extable_ent_size	8
>  # define compare_extable	compare_extable_32
> +# define get_mcount_loc		get_mcount_loc_32
> +# define sort_mcount_loc	sort_mcount_loc_32
> +# define elf_mcount_loc		elf_mcount_loc_32
>  # define do_sort		do_sort_32
>  # define Elf_Addr		Elf32_Addr
>  # define Elf_Ehdr		Elf32_Ehdr
> @@ -84,8 +93,6 @@
>  
>  #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
>  /* ORC unwinder only support X86_64 */
> -#include <errno.h>
> -#include <pthread.h>
>  #include <asm/orc_types.h>
>  
>  #define ERRSTR_MAXSZ	256
> @@ -191,6 +198,62 @@ static int compare_extable(const void *a, const void *b)
>  		return 1;
>  	return 0;
>  }
> +struct elf_mcount_loc {
> +	Elf_Ehdr *ehdr;
> +	Elf_Shdr *init_data_sec;
> +	uint_t start_mcount_loc;
> +	uint_t stop_mcount_loc;
> +};
> +
> +/* Sort the addresses stored between __start_mcount_loc to __stop_mcount_loc in vmlinux */
> +static void *sort_mcount_loc(void *arg)
> +{
> +	struct elf_mcount_loc *emloc = (struct elf_mcount_loc *)arg;
> +	uint_t offset = emloc->start_mcount_loc - _r(&(emloc->init_data_sec)->sh_addr)
> +					+ _r(&(emloc->init_data_sec)->sh_offset);
> +	uint_t count = emloc->stop_mcount_loc - emloc->start_mcount_loc;
> +	unsigned char *start_loc = (void *)emloc->ehdr + offset;
> +
> +	qsort(start_loc, count/sizeof(uint_t), sizeof(uint_t), compare_extable);
> +	return NULL;
> +}
> +
> +/* Get the address of __start_mcount_loc and __stop_mcount_loc in System.map */
> +static void get_mcount_loc(uint_t *_start, uint_t *_stop)
> +{
> +	FILE *file_start, *file_stop;
> +	char start_buff[20];
> +	char stop_buff[20];
> +	int len = 0;
> +
> +	file_start = popen(" grep start_mcount System.map | awk '{print $1}' ", "r");
> +	if (!file_start) {
> +		fprintf(stderr, "get start_mcount_loc error!");
> +		return;
> +	}
> +
> +	file_stop = popen(" grep stop_mcount System.map | awk '{print $1}' ", "r");
> +	if (!file_stop) {
> +		fprintf(stderr, "get stop_mcount_loc error!");
> +		pclose(file_start);
> +		return;
> +	}
> +
> +	while (fgets(start_buff, sizeof(start_buff), file_start) != NULL) {
> +		len = strlen(start_buff);
> +		start_buff[len - 1] = '\0';
> +	}
> +	*_start = strtoul(start_buff, NULL, 16);
> +
> +	while (fgets(stop_buff, sizeof(stop_buff), file_stop) != NULL) {
> +		len = strlen(stop_buff);
> +		stop_buff[len - 1] = '\0';
> +	}
> +	*_stop = strtoul(stop_buff, NULL, 16);
> +
> +	pclose(file_start);
> +	pclose(file_stop);
> +}
>  
>  static int do_sort(Elf_Ehdr *ehdr,
>  		   char const *const fname,
> @@ -217,6 +280,10 @@ static int do_sort(Elf_Ehdr *ehdr,
>  	int idx;
>  	unsigned int shnum;
>  	unsigned int shstrndx;
> +	struct elf_mcount_loc mstruct;
> +	uint_t _start_mcount_loc = 0;
> +	uint_t _stop_mcount_loc = 0;
> +	pthread_t mcount_sort_thread;
>  #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
>  	unsigned int orc_ip_size = 0;
>  	unsigned int orc_size = 0;
> @@ -253,6 +320,14 @@ static int do_sort(Elf_Ehdr *ehdr,
>  			symtab_shndx = (Elf32_Word *)((const char *)ehdr +
>  						      _r(&s->sh_offset));
>  
> +		/* locate the .init.data section in vmlinux */
> +		if (!strcmp(secstrings + idx, ".init.data")) {
> +			get_mcount_loc(&_start_mcount_loc, &_stop_mcount_loc);
> +			mstruct.ehdr = ehdr;
> +			mstruct.init_data_sec = s;
> +			mstruct.start_mcount_loc = _start_mcount_loc;
> +			mstruct.stop_mcount_loc = _stop_mcount_loc;
> +		}
>  #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
>  		/* locate the ORC unwind tables */
>  		if (!strcmp(secstrings + idx, ".orc_unwind_ip")) {
> @@ -294,6 +369,21 @@ static int do_sort(Elf_Ehdr *ehdr,
>  		goto out;
>  	}
>  #endif
> +	if (!mstruct.init_data_sec || !_start_mcount_loc || !_stop_mcount_loc) {

This is triggered when CONFIG_FUNCTION_TRACER is not defined.

In other words, do not fail if mcount section does not exist.


> +		fprintf(stderr,
> +			"incomplete mcount's sort in file: %s\n",
> +			fname);
> +		goto out;
> +	}
> +
> +	/* create thread to sort mcount_loc concurrently */
> +	if (pthread_create(&mcount_sort_thread, NULL, &sort_mcount_loc, &mstruct)) {
> +		fprintf(stderr,
> +			"pthread_create mcount_sort_thread failed '%s': %s\n",
> +			strerror(errno), fname);
> +		goto out;
> +	}
> +
>  	if (!extab_sec) {
>  		fprintf(stderr,	"no __ex_table in file: %s\n", fname);
>  		goto out;
> @@ -364,11 +454,11 @@ static int do_sort(Elf_Ehdr *ehdr,
>  		void *retval = NULL;
>  		/* wait for ORC tables sort done */
>  		rc = pthread_join(orc_sort_thread, &retval);
> -		if (rc)
> +		if (rc) {
>  			fprintf(stderr,
>  				"pthread_join failed '%s': %s\n",
>  				strerror(errno), fname);
> -		else if (retval) {
> +		} else if (retval) {
>  			rc = -1;
>  			fprintf(stderr,
>  				"failed to sort ORC tables '%s': %s\n",

Looks like you added parenthesis that was not yours. I would ignore this
for your patch, but feel free to send a separate clean up patch.

> @@ -376,5 +466,20 @@ static int do_sort(Elf_Ehdr *ehdr,
>  		}
>  	}
>  #endif
> +	if (mcount_sort_thread) {
> +		void *retval = NULL;
> +		/* wait for mcount sort done */
> +		rc = pthread_join(mcount_sort_thread, &retval);
> +		if (rc) {
> +			fprintf(stderr,
> +				"pthread_join failed '%s': %s\n",
> +				strerror(errno), fname);
> +		} else if (retval) {
> +			rc = -1;
> +			fprintf(stderr,
> +				"failed to sort mcount '%s': %s\n",
> +				(char *)retval, fname);
> +		}
> +	}
>  	return rc;
>  }

-- Steve
