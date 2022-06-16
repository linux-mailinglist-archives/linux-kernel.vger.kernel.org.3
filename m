Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00B954DCC3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359628AbiFPIXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359377AbiFPIXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:23:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C06B23167
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 01:23:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A7C6E1FAD8;
        Thu, 16 Jun 2022 08:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655367794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AUtA210qzdZ6fUsIsgH+SNKu39X41m219nLUSwZSKSI=;
        b=x48p8S9rEBW7ROB6oU5fxO/F+ubrR2bW19nxIQ4OFVb05QFFt6UeB941rbdkiNot/Ly3MW
        a84vmC35p1IBHOPIigJm0wC1XWyBOdpw7iojpe5mD3IZTB7Pi5yH4Io2p4Bv63HdgaHOy1
        8ItwmWGf5bSJDMnPy56o+P9CSXtY1vw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655367794;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AUtA210qzdZ6fUsIsgH+SNKu39X41m219nLUSwZSKSI=;
        b=zuqSic0tew8V31tKSaYi8+u2Od5jxQ7D5n53XNn2tx9ObuOxGMIGrFGzTBVQuT1ffvaJYc
        gVqZbQm48eM0HbBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 713F21344E;
        Thu, 16 Jun 2022 08:23:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CMLvGnLoqmJYLgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 16 Jun 2022 08:23:14 +0000
Message-ID: <fe6362b2-c399-7d51-b0e4-15e6ed445767@suse.cz>
Date:   Thu, 16 Jun 2022 10:23:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 2/2] [PATCH 2/2] mm: add merging after mremap resize
Content-Language: en-US
To:     =?UTF-8?Q?Jakub_Mat=c4=9bna?= <matenajakub@gmail.com>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, mhocko@kernel.org,
        mgorman@techsingularity.net, willy@infradead.org,
        liam.howlett@oracle.com, hughd@google.com, kirill@shutemov.name,
        riel@surriel.com, rostedt@goodmis.org, peterz@infradead.org
References: <20220603145719.1012094-1-matenajakub@gmail.com>
 <20220603145719.1012094-3-matenajakub@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220603145719.1012094-3-matenajakub@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/22 16:57, Jakub Matěna wrote:
> When mremap call results in expansion, it might be possible to merge the
> VMA with the next VMA which might become adjacent. This patch adds
> vma_merge call after the expansion is done to try and merge.
> 
> Signed-off-by: Jakub Matěna <matenajakub@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/mremap.c                              | 19 +++++++++-
>  tools/testing/selftests/vm/mremap_test.c | 47 +++++++++++++++++++++++-
>  2 files changed, 63 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 0b93fac76851..66970dcd636a 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -9,6 +9,7 @@
>   */
>  
>  #include <linux/mm.h>
> +#include <linux/mm_inline.h>
>  #include <linux/hugetlb.h>
>  #include <linux/shm.h>
>  #include <linux/ksm.h>
> @@ -23,6 +24,7 @@
>  #include <linux/mmu_notifier.h>
>  #include <linux/uaccess.h>
>  #include <linux/userfaultfd_k.h>
> +#include <linux/mempolicy.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/tlb.h>
> @@ -1014,6 +1016,9 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  		/* can we just expand the current mapping? */
>  		if (vma_expandable(vma, new_len - old_len)) {
>  			long pages = (new_len - old_len) >> PAGE_SHIFT;
> +			unsigned long extension_start = addr + old_len;
> +			unsigned long extension_end = addr + new_len;
> +			pgoff_t extension_pgoff = vma->vm_pgoff + (old_len >> PAGE_SHIFT);
>  
>  			if (vma->vm_flags & VM_ACCOUNT) {
>  				if (security_vm_enough_memory_mm(mm, pages)) {
> @@ -1022,8 +1027,18 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  				}
>  			}
>  
> -			if (vma_adjust(vma, vma->vm_start, addr + new_len,
> -				       vma->vm_pgoff, NULL)) {
> +			/*
> +			 * Function vma_merge() is called on the extension we are adding to
> +			 * the already existing vma, vma_merge() will merge this extension with
> +			 * the already existing vma (expand operation itself) and possibly also
> +			 * with the next vma if it becomes adjacent to the expanded vma and
> +			 * otherwise compatible.
> +			 */
> +			vma = vma_merge(mm, vma, extension_start, extension_end,
> +					vma->vm_flags, vma->anon_vma, vma->vm_file,
> +					extension_pgoff, vma_policy(vma),
> +					vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> +			if (!vma) {
>  				vm_unacct_memory(pages);
>  				ret = -ENOMEM;
>  				goto out;
> diff --git a/tools/testing/selftests/vm/mremap_test.c b/tools/testing/selftests/vm/mremap_test.c
> index db0270127aeb..0865a6cb5bdb 100644
> --- a/tools/testing/selftests/vm/mremap_test.c
> +++ b/tools/testing/selftests/vm/mremap_test.c
> @@ -118,6 +118,48 @@ static unsigned long long get_mmap_min_addr(void)
>  	return addr;
>  }
>  
> +/*
> + * This test validates that merge is called when expanding a mapping.
> + * Mapping containing three pages is created, middle page is unmapped
> + * and then the mapping containing the first page is expanded so that
> + * it fills the created hole. The two parts should merge creating
> + * single mapping with three pages.
> + */
> +static void mremap_expand_merge(unsigned long page_size)
> +{
> +	char *test_name = "mremap expand merge";
> +	FILE *fp;
> +	char *line = NULL;
> +	size_t len = 0;
> +	bool success = false;
> +
> +	char *start = mmap(NULL, 3 * page_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	munmap(start + page_size, page_size);
> +	mremap(start, page_size, 2 * page_size, 0);
> +
> +	fp = fopen("/proc/self/maps", "r");
> +	if (fp == NULL) {
> +		ksft_test_result_fail("%s\n", test_name);
> +		return;
> +	}
> +
> +	while(getline(&line, &len, fp) != -1) {
> +		char *first = strtok(line,"- ");
> +		void *first_val = (void *) strtol(first, NULL, 16);
> +		char *second = strtok(NULL,"- ");
> +		void *second_val = (void *) strtol(second, NULL, 16);
> +		if (first_val == start && second_val == start + 3 * page_size) {
> +			success = true;
> +			break;
> +		}
> +	}
> +	if (success)
> +		ksft_test_result_pass("%s\n", test_name);
> +	else
> +		ksft_test_result_fail("%s\n", test_name);
> +	fclose(fp);
> +}
> +
>  /*
>   * Returns the start address of the mapping on success, else returns
>   * NULL on failure.
> @@ -336,6 +378,7 @@ int main(int argc, char **argv)
>  	int i, run_perf_tests;
>  	unsigned int threshold_mb = VALIDATION_DEFAULT_THRESHOLD;
>  	unsigned int pattern_seed;
> +	int num_expand_tests = 1;
>  	struct test test_cases[MAX_TEST];
>  	struct test perf_test_cases[MAX_PERF_TEST];
>  	int page_size;
> @@ -407,12 +450,14 @@ int main(int argc, char **argv)
>  				(threshold_mb * _1MB >= _1GB);
>  
>  	ksft_set_plan(ARRAY_SIZE(test_cases) + (run_perf_tests ?
> -		      ARRAY_SIZE(perf_test_cases) : 0));
> +		      ARRAY_SIZE(perf_test_cases) : 0) + num_expand_tests);
>  
>  	for (i = 0; i < ARRAY_SIZE(test_cases); i++)
>  		run_mremap_test_case(test_cases[i], &failures, threshold_mb,
>  				     pattern_seed);
>  
> +	mremap_expand_merge(page_size);
> +
>  	if (run_perf_tests) {
>  		ksft_print_msg("\n%s\n",
>  		 "mremap HAVE_MOVE_PMD/PUD optimization time comparison for 1GB region:");

