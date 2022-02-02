Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999E44A6BC2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 07:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244698AbiBBGwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 01:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244781AbiBBGwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 01:52:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520DEC061759
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 22:12:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB002B83013
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 06:12:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C0AC340EC;
        Wed,  2 Feb 2022 06:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643782325;
        bh=6Z1LUyHDGqpVzlaGZNpCJgZiHw2AD96G0aoaSJiw7bs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SOJgsm/hkyTLZh5unQDpcOq2QZaxgqLwywMfNdSyyZeQbY6bPzFn1DF7iA0xob2ZU
         d5rJ0Vua6VoBalmLZ/sJJho7Pp02ft0s5N2SibV/SYLIvgFLtSWi/8TOphDplGDBei
         vkeumGhpF+de9+87SB+/eQBMknJdXGt6K85exYa5EgyfpZoiQ2XEcGBP6GQZZ9hSXP
         DbvJ6xN58DRKO9adAamfWignpgf2+37JN1otiTiABAdl3CMOyeKFs8TyvBzu8XDEax
         Cj5sQRugkv0YtKA3Hd/rrnwZcNmKiZxxrsLffG3rQII5s+9dWOOQ19d1RjUTLnzKE+
         SD32Vo7+2miEw==
Date:   Wed, 2 Feb 2022 08:11:56 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 3/3] userfaultfd/selftests: enable huegtlb remap and
 remove event testing
Message-ID: <YfogrMM7eiHSFhav@kernel.org>
References: <20220202014034.182008-1-mike.kravetz@oracle.com>
 <20220202014034.182008-4-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202014034.182008-4-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 05:40:34PM -0800, Mike Kravetz wrote:
> Subject: [PATCH v2 3/3] userfaultfd/selftests: enable huegtlb remap and remove event testing

Nit:                                                  ^ hugetlb

> With MADV_DONTNEED support added to hugetlb mappings, mremap testing
> can also be enabled for hugetlb.
> 
> Modify the tests to use madvise MADV_DONTNEED and MADV_REMOVE instead of
> fallocate hole puch for releasing hugetlb pages.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  tools/testing/selftests/vm/run_vmtests.sh |  3 +-
>  tools/testing/selftests/vm/userfaultfd.c  | 69 ++++++++++++-----------
>  2 files changed, 36 insertions(+), 36 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
> index ff901ee66838..7178d6fa8c92 100755
> --- a/tools/testing/selftests/vm/run_vmtests.sh
> +++ b/tools/testing/selftests/vm/run_vmtests.sh
> @@ -207,14 +207,13 @@ echo "running userfaultfd_hugetlb"
>  echo "---------------------------"
>  # Test requires source and destination huge pages.  Size of source
>  # (half_ufd_size_MB) is passed as argument to test.
> -./userfaultfd hugetlb $half_ufd_size_MB 32 $mnt/ufd_test_file
> +./userfaultfd hugetlb $half_ufd_size_MB 32
>  if [ $? -ne 0 ]; then
>  	echo "[FAIL]"
>  	exitcode=1
>  else
>  	echo "[PASS]"
>  fi
> -rm -f $mnt/ufd_test_file
>  
>  echo "-------------------------"
>  echo "running userfaultfd_shmem"
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index d2480ab93037..c18beebc0dd6 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -88,7 +88,6 @@ static bool test_uffdio_minor = false;
>  static bool map_shared;
>  static int shm_fd;
>  static int huge_fd;
> -static char *huge_fd_off0;
>  static unsigned long long *count_verify;
>  static int uffd = -1;
>  static int uffd_flags, finished, *pipefd;
> @@ -127,9 +126,9 @@ const char *examples =
>      "./userfaultfd anon 100 99999\n\n"
>      "# Run share memory test on 1GiB region with 99 bounces:\n"
>      "./userfaultfd shmem 1000 99\n\n"
> -    "# Run hugetlb memory test on 256MiB region with 50 bounces (using /dev/hugepages/hugefile):\n"
> -    "./userfaultfd hugetlb 256 50 /dev/hugepages/hugefile\n\n"
> -    "# Run the same hugetlb test but using shmem:\n"
> +    "# Run hugetlb memory test on 256MiB region with 50 bounces:\n"
> +    "./userfaultfd hugetlb 256 50\n\n"
> +    "# Run the same hugetlb test but using shared file:\n"
>      "./userfaultfd hugetlb_shared 256 50 /dev/hugepages/hugefile\n\n"
>      "# 10MiB-~6GiB 999 bounces anonymous test, "
>      "continue forever unless an error triggers\n"
> @@ -226,10 +225,13 @@ static void noop_alias_mapping(__u64 *start, size_t len, unsigned long offset)
>  
>  static void hugetlb_release_pages(char *rel_area)
>  {
> -	if (fallocate(huge_fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> -		      rel_area == huge_fd_off0 ? 0 : nr_pages * page_size,
> -		      nr_pages * page_size))
> -		err("fallocate() failed");
> +	if (!map_shared) {
> +		if (madvise(rel_area, nr_pages * page_size, MADV_DONTNEED))
> +			err("madvise(MADV_DONTNEED) failed");
> +	} else {
> +		if (madvise(rel_area, nr_pages * page_size, MADV_REMOVE))
> +			err("madvise(MADV_REMOVE) failed");
> +	}
>  }
>  
>  static void hugetlb_allocate_area(void **alloc_area)
> @@ -237,26 +239,37 @@ static void hugetlb_allocate_area(void **alloc_area)
>  	void *area_alias = NULL;
>  	char **alloc_area_alias;
>  
> -	*alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
> -			   (map_shared ? MAP_SHARED : MAP_PRIVATE) |
> -			   MAP_HUGETLB |
> -			   (*alloc_area == area_src ? 0 : MAP_NORESERVE),
> -			   huge_fd, *alloc_area == area_src ? 0 :
> -			   nr_pages * page_size);
> +	if (!map_shared)
> +		*alloc_area = mmap(NULL,
> +			nr_pages * page_size,
> +			PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB |
> +				(*alloc_area == area_src ? 0 : MAP_NORESERVE),
> +			-1,
> +			0);
> +	else
> +		*alloc_area = mmap(NULL,
> +			nr_pages * page_size,
> +			PROT_READ | PROT_WRITE,
> +			MAP_SHARED |
> +				(*alloc_area == area_src ? 0 : MAP_NORESERVE),
> +			huge_fd,
> +			*alloc_area == area_src ? 0 : nr_pages * page_size);
>  	if (*alloc_area == MAP_FAILED)
>  		err("mmap of hugetlbfs file failed");
>  
>  	if (map_shared) {
> -		area_alias = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
> -				  MAP_SHARED | MAP_HUGETLB,
> -				  huge_fd, *alloc_area == area_src ? 0 :
> -				  nr_pages * page_size);
> +		area_alias = mmap(NULL,
> +			nr_pages * page_size,
> +			PROT_READ | PROT_WRITE,
> +			MAP_SHARED,
> +			huge_fd,
> +			*alloc_area == area_src ? 0 : nr_pages * page_size);
>  		if (area_alias == MAP_FAILED)
>  			err("mmap of hugetlb file alias failed");
>  	}
>  
>  	if (*alloc_area == area_src) {
> -		huge_fd_off0 = *alloc_area;
>  		alloc_area_alias = &area_src_alias;
>  	} else {
>  		alloc_area_alias = &area_dst_alias;
> @@ -269,12 +282,7 @@ static void hugetlb_alias_mapping(__u64 *start, size_t len, unsigned long offset
>  {
>  	if (!map_shared)
>  		return;
> -	/*
> -	 * We can't zap just the pagetable with hugetlbfs because
> -	 * MADV_DONTEED won't work. So exercise -EEXIST on a alias
> -	 * mapping where the pagetables are not established initially,
> -	 * this way we'll exercise the -EEXEC at the fs level.
> -	 */
> +
>  	*start = (unsigned long) area_dst_alias + offset;
>  }
>  
> @@ -427,7 +435,6 @@ static void uffd_test_ctx_clear(void)
>  		uffd = -1;
>  	}
>  
> -	huge_fd_off0 = NULL;
>  	munmap_area((void **)&area_src);
>  	munmap_area((void **)&area_src_alias);
>  	munmap_area((void **)&area_dst);
> @@ -925,10 +932,7 @@ static int faulting_process(int signal_test)
>  	struct sigaction act;
>  	unsigned long signalled = 0;
>  
> -	if (test_type != TEST_HUGETLB)
> -		split_nr_pages = (nr_pages + 1) / 2;
> -	else
> -		split_nr_pages = nr_pages;
> +	split_nr_pages = (nr_pages + 1) / 2;
>  
>  	if (signal_test) {
>  		sigbuf = &jbuf;
> @@ -985,9 +989,6 @@ static int faulting_process(int signal_test)
>  	if (signal_test)
>  		return signalled != split_nr_pages;
>  
> -	if (test_type == TEST_HUGETLB)
> -		return 0;
> -
>  	area_dst = mremap(area_dst, nr_pages * page_size,  nr_pages * page_size,
>  			  MREMAP_MAYMOVE | MREMAP_FIXED, area_src);
>  	if (area_dst == MAP_FAILED)
> @@ -1670,7 +1671,7 @@ int main(int argc, char **argv)
>  	}
>  	nr_pages = nr_pages_per_cpu * nr_cpus;
>  
> -	if (test_type == TEST_HUGETLB) {
> +	if (test_type == TEST_HUGETLB && map_shared) {
>  		if (argc < 5)
>  			usage();
>  		huge_fd = open(argv[4], O_CREAT | O_RDWR, 0755);
> -- 
> 2.34.1
> 
> 

-- 
Sincerely yours,
Mike.
