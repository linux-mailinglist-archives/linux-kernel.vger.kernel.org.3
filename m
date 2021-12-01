Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE52A46588B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 22:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353197AbhLAVtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 16:49:46 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:34826 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245737AbhLAVtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 16:49:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AAB73CE1DC7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 21:45:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F22AC53FCC;
        Wed,  1 Dec 2021 21:45:54 +0000 (UTC)
Date:   Wed, 1 Dec 2021 16:45:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yinan Liu <yinan@linux.alibaba.com>
Cc:     peterz@infradead.org, mark-pk.tsai@mediatek.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] scripts: ftrace - move the sort-processing in
 ftrace_init to compile time
Message-ID: <20211201164552.5a933d23@gandalf.local.home>
In-Reply-To: <20211201053207.32339-2-yinan@linux.alibaba.com>
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
        <20211201053207.32339-1-yinan@linux.alibaba.com>
        <20211201053207.32339-2-yinan@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 Dec 2021 13:32:06 +0800
Yinan Liu <yinan@linux.alibaba.com> wrote:

>  
>  #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
>  /* ORC unwinder only support X86_64 */
> -#include <errno.h>
> -#include <pthread.h>
>  #include <asm/orc_types.h>
>  
>  #define ERRSTR_MAXSZ	256
> @@ -191,7 +198,64 @@ static int compare_extable(const void *a, const void *b)
>  		return 1;
>  	return 0;
>  }
> +#if defined CONFIG_FUNCTION_TRACER

Note, "defined" is best used with parenthesis, but if it's for only a
single define, we usually just use:

#ifdef CONFIG_FUNCTION_TRACER

Same for all he below.

-- Steve


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
>  
> +	pclose(file_start);
> +	pclose(file_stop);
> +}
> +#endif
>  static int do_sort(Elf_Ehdr *ehdr,
>  		   char const *const fname,
>  		   table_sort_t custom_sort)
> @@ -217,6 +281,12 @@ static int do_sort(Elf_Ehdr *ehdr,
>  	int idx;
>  	unsigned int shnum;
>  	unsigned int shstrndx;
> +#if defined CONFIG_FUNCTION_TRACER
> +	struct elf_mcount_loc mstruct;
> +	uint_t _start_mcount_loc = 0;
> +	uint_t _stop_mcount_loc = 0;
> +	pthread_t mcount_sort_thread;
> +#endif
>  #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
>  	unsigned int orc_ip_size = 0;
>  	unsigned int orc_size = 0;
> @@ -253,6 +323,17 @@ static int do_sort(Elf_Ehdr *ehdr,
>  			symtab_shndx = (Elf32_Word *)((const char *)ehdr +
>  						      _r(&s->sh_offset));
>  
> +#if defined CONFIG_FUNCTION_TRACER
> +		/* locate the .init.data section in vmlinux */
> +		if (!strcmp(secstrings + idx, ".init.data")) {
> +			get_mcount_loc(&_start_mcount_loc, &_stop_mcount_loc);
> +			mstruct.ehdr = ehdr;
> +			mstruct.init_data_sec = s;
> +			mstruct.start_mcount_loc = _start_mcount_loc;
> +			mstruct.stop_mcount_loc = _stop_mcount_loc;
> +		}
> +#endif
> +
>  #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
>  		/* locate the ORC unwind tables */
>  		if (!strcmp(secstrings + idx, ".orc_unwind_ip")) {
> @@ -294,6 +375,23 @@ static int do_sort(Elf_Ehdr *ehdr,
>  		goto out;
>  	}
>  #endif
> +
> +#if defined CONFIG_FUNCTION_TRACER
> +	if (!mstruct.init_data_sec || !_start_mcount_loc || !_stop_mcount_loc) {
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
> +#endif
>  	if (!extab_sec) {
>  		fprintf(stderr,	"no __ex_table in file: %s\n", fname);
>  		goto out;
> @@ -376,5 +474,23 @@ static int do_sort(Elf_Ehdr *ehdr,
>  		}
>  	}
>  #endif
> +
> +#if defined CONFIG_FUNCTION_TRACER
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
> +#endif
>  	return rc;
>  }

