Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF204A0473
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 00:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344571AbiA1XqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 18:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344531AbiA1XqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:46:09 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CC3C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 15:46:09 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id e81so15360932oia.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 15:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B5hC0FTzaQ4C/HLjOrYxMJLcGZpjby+vGwB2uMVqqvk=;
        b=ScCeZsyiLKCvNerQ2Jov/+4+9gNVh7q0Hr/IMMhihxUNPfrh8xFKrqAHAJdksgPu6n
         ZyVyzJbNjvU3bb3rHEkQViLNkDvsMkUZLsCwXB66GE5neI7g/kPbKVzKr7srNFnzyTzE
         wjVhCo3OkXEBCaFdwUmjCkhWDqAyMlzoIpoRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B5hC0FTzaQ4C/HLjOrYxMJLcGZpjby+vGwB2uMVqqvk=;
        b=ScJF3vAGMua3ALmwS3EpPyR4YxfbYz8M/sJTTkoIqDkx7gacp5blBovOV/pu6Dva1T
         HxJ5Z35NBHSQnDq9XLuZwuBTutLIclxa9aBEOb/Emz818Vp0QRRd+MRcjgpT+op5R6LG
         MxG+vRRj6o5DYmDTwDz4VrKNl4XxV5S312rrWtTT9Nu5RloIYshQRnUwcSeuDcLyY/Q+
         6LPChD8MhUG1RyQoqfExzm3DDtC63wW0H/HN4DE0ZinOS6rxIrOmroaG9qdXDOanD7Ng
         o287OJXdGlZvOkYGBYApXmbXeYk4PZIXPFV/XoY4u9VKDLcuUYTyhy2A19L7nUctF26V
         aBRQ==
X-Gm-Message-State: AOAM530UHY/smdegKBjTv88JfHfgQ7Z+0MELBZtk0d9TxBmITrbo9cKf
        BiV0djcCEVeb2/26ql9uW/JdnA==
X-Google-Smtp-Source: ABdhPJxjoq/fNEd7xA7Pg106D8QnjQO7Ze6uOC3mWRbu9hgPszKePFkA7GLc7gbUKueapCJz9WzfuQ==
X-Received: by 2002:a05:6808:10c2:: with SMTP id s2mr11418232ois.65.1643413568318;
        Fri, 28 Jan 2022 15:46:08 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id y3sm12433380oix.41.2022.01.28.15.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 15:46:07 -0800 (PST)
Subject: Re: [PATCH 2/3] selftests/vm: add hugetlb madvise MADV_DONTNEED
 MADV_REMOVE test
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220128222605.66828-1-mike.kravetz@oracle.com>
 <20220128222605.66828-3-mike.kravetz@oracle.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <901f1117-e1ba-d5f3-f711-b3b581bce6cb@linuxfoundation.org>
Date:   Fri, 28 Jan 2022 16:46:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220128222605.66828-3-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/22 3:26 PM, Mike Kravetz wrote:
> Now that MADV_DONTNEED support for hugetlb is enabled, add corresponding
> tests.  MADV_REMOVE has been enabled for some time, but no tests exist
> so add them as well.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   tools/testing/selftests/vm/Makefile          |   1 +
>   tools/testing/selftests/vm/hugetlb-madvise.c | 401 +++++++++++++++++++
>   tools/testing/selftests/vm/run_vmtests.sh    |  12 +
>   3 files changed, 414 insertions(+)
>   create mode 100644 tools/testing/selftests/vm/hugetlb-madvise.c
> 
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index 1607322a112c..f60cf43bbf61 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -28,6 +28,7 @@ LDLIBS = -lrt -lpthread
>   TEST_GEN_FILES = compaction_test
>   TEST_GEN_FILES += gup_test
>   TEST_GEN_FILES += hmm-tests
> +TEST_GEN_FILES += hugetlb-madvise

Please update .gitignore with the new binary.

>   TEST_GEN_FILES += hugepage-mmap
>   TEST_GEN_FILES += hugepage-mremap
>   TEST_GEN_FILES += hugepage-shm
> diff --git a/tools/testing/selftests/vm/hugetlb-madvise.c b/tools/testing/selftests/vm/hugetlb-madvise.c
> new file mode 100644
> index 000000000000..31c302528f2c
> --- /dev/null
> +++ b/tools/testing/selftests/vm/hugetlb-madvise.c
> @@ -0,0 +1,401 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * hugepage-madvise:
> + *
> + * Basic functional testing of madvise MADV_DONTNEED and MADV_REMOVE
> + * on hugetlb mappings.
> + *
> + * Before running this test, make sure the administrator has pre-allocated
> + * at least MIN_FREE_PAGES hugetlb pages and they are free.  In addition,
> + * the test takes an argument that is the path to a file in a hugetlbfs
> + * filesystem.  Therefore, a hugetlbfs filesystem must be mounted on some
> + * directory.
> + */
> +
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <sys/mman.h>
> +#define __USE_GNU
> +#include <fcntl.h>
> +
> +#define USAGE	"USAGE: %s <hugepagefile_name>\n"
> +#define MIN_FREE_PAGES	20
> +
> +#define validate_free_pages(exp_free)					\
> +	do {								\
> +		int fhp = get_free_hugepages();				\
> +		if (fhp != (exp_free)) {				\
> +			printf("Unexpected number of free huge "	\
> +				"pages line %d\n", __LINE__);		\
> +			exit(1);					\
> +		}							\
> +	} while (0)
> +
> +unsigned long huge_page_size;
> +unsigned long base_page_size;
> +
> +/*
> + * default_huge_page_size copied from mlock2-tests.c
> + */
> +unsigned long default_huge_page_size(void)
> +{
> +	unsigned long hps = 0;
> +	char *line = NULL;
> +	size_t linelen = 0;
> +	FILE *f = fopen("/proc/meminfo", "r");
> +
> +	if (!f)
> +		return 0;
> +	while (getline(&line, &linelen, f) > 0) {
> +		if (sscanf(line, "Hugepagesize:       %lu kB", &hps) == 1) {
> +			hps <<= 10;
> +			break;
> +		}
> +	}
> +
> +	free(line);
> +	fclose(f);
> +	return hps;
> +}
> +
> +unsigned long get_free_hugepages(void)
> +{
> +	unsigned long fhp = 0;
> +	char *line = NULL;
> +	size_t linelen = 0;
> +	FILE *f = fopen("/proc/meminfo", "r");
> +
> +	if (!f)
> +		return fhp;
> +	while (getline(&line, &linelen, f) > 0) {
> +		if (sscanf(line, "HugePages_Free:      %lu", &fhp) == 1)
> +			break;
> +	}
> +
> +	free(line);
> +	fclose(f);
> +	return fhp;
> +}
> +
> +void write_fault_pages(void *addr, unsigned long nr_pages)
> +{
> +	unsigned long i;
> +
> +	for (i = 0; i < nr_pages; i++)
> +		*((unsigned long *)(addr + (i * huge_page_size))) = i;
> +}
> +
> +void read_fault_pages(void *addr, unsigned long nr_pages)
> +{
> +	unsigned long i, tmp;
> +
> +	for (i = 0; i < nr_pages; i++)
> +		tmp += *((unsigned long *)(addr + (i * huge_page_size)));
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	unsigned long free_hugepages;
> +	void *addr, *addr2;
> +	int fd;
> +	int ret;
> +
> +	if (argc != 2) {
> +		printf(USAGE, argv[0]);
> +		exit(1);
> +	}
> +
> +	huge_page_size = default_huge_page_size();
> +	if (!huge_page_size) {
> +		printf("Unable to determine huge page size, exiting!\n");
> +		exit(1);
> +	}
> +	base_page_size = sysconf(_SC_PAGE_SIZE);
> +	if (!huge_page_size) {
> +		printf("Unable to determine base page size, exiting!\n");
> +		exit(1);
> +	}
> +
> +	free_hugepages = get_free_hugepages();
> +	if (free_hugepages < MIN_FREE_PAGES) {
> +		printf("Not enough free huge pages to test, exiting!\n");
> +		exit(1);
> +	}
> +
> +	fd = open(argv[1], O_CREAT | O_RDWR, 0755);
> +	if (fd < 0) {
> +		perror("Open failed");
> +		exit(1);
> +	}
> +
> +	/*
> +	 * Test validity of MADV_DONTNEED addr and length arguments
> +	 */
> +	addr = mmap(NULL, 12 * huge_page_size, PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
> +			-1, 0);

What is 12 here? Any significance to this value? Add a define for it
so it it clear why it is used.

> +	if (addr == MAP_FAILED) {
> +		perror("mmap");
> +		exit(1);
> +	}
> +	/* unmap first and last page so we know nothing is mapped there */
> +	if (munmap(addr, huge_page_size) ||
> +			munmap(addr + 11 * huge_page_size, huge_page_size)) {
> +		perror("munmap");
> +		exit(1);
> +	}
> +	addr = addr + huge_page_size;
> +
> +	write_fault_pages(addr, 10);

What is 10 here? Any significance to this value? Add a define for it
so it it clear why it is used.

> +	validate_free_pages(free_hugepages - 10);
> +
> +	/* addr before mapping should fail */
> +	ret = madvise(addr - base_page_size, 10 * huge_page_size,
> +		MADV_DONTNEED);
> +	if (!ret) {
> +		printf("Unexpected success of madvise call with invalid addr line %d\n",
> +				__LINE__);
> +			exit(1);
> +	}
> +
> +	/* addr + length after mapping should fail */
> +	ret = madvise(addr, (10 * huge_page_size) + base_page_size,
> +		MADV_DONTNEED);
> +	if (!ret) {
> +		printf("Unexpected success of madvise call with invalid length line %d\n",
> +				__LINE__);
> +			exit(1);
> +	}
> +
> +	(void)munmap(addr, 10 * huge_page_size);

Same comment on use of 10.

> +
> +	/*
> +	 * Test alignment of MADV_DONTNEED addr and length arguments
> +	 */
> +	addr = mmap(NULL, 10 * huge_page_size, PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
> +			-1, 0);
> +	if (addr == MAP_FAILED) {
> +		perror("mmap");
> +		exit(1);
> +	}
> +	write_fault_pages(addr, 10);

Ditto

> +	validate_free_pages(free_hugepages - 10);

Ditto

> +
> +	/* addr should be aligned down to huge page size */
> +	if (madvise(addr + base_page_size,
> +			10 * huge_page_size - base_page_size, MADV_DONTNEED)) {
> +		perror("madvise");
> +		exit(1);
> +	}
> +
> +	/* should free all pages in mapping */
> +	validate_free_pages(free_hugepages);
> +
> +	write_fault_pages(addr, 10);
> +	validate_free_pages(free_hugepages - 10);
> +
> +	/* addr + length should be aligned up to huge page size */
> +	if (madvise(addr, (10 * huge_page_size) - base_page_size,
> +			MADV_DONTNEED)) {
> +		perror("madvise");
> +		exit(1);
> +	}
> +
> +	/* should free all pages in mapping */
> +	validate_free_pages(free_hugepages);
> +
> +	(void)munmap(addr, 10 * huge_page_size);
> +
> +	/*
> +	 * Test MADV_DONTNEED on anonymous private mapping
> +	 */
> +	addr = mmap(NULL, 10 * huge_page_size, PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
> +			-1, 0);
> +	if (addr == MAP_FAILED) {
> +		perror("mmap");
> +		exit(1);
> +	}
> +	write_fault_pages(addr, 10);
> +	validate_free_pages(free_hugepages - 10);
> +
> +	if (madvise(addr, 10 * huge_page_size, MADV_DONTNEED)) {
> +		perror("madvise");
> +		exit(1);
> +	}
> +
> +	/* should free all pages in mapping */
> +	validate_free_pages(free_hugepages);
> +
> +	(void)munmap(addr, 10 * huge_page_size);
> +
> +	/*
> +	 * Test MADV_DONTNEED on private mapping of hugetlb file
> +	 */
> +	if (fallocate(fd, 0, 0, 10 * huge_page_size)) {
> +		perror("fallocate");
> +		exit(1);
> +	}
> +	validate_free_pages(free_hugepages - 10);
> +
> +	addr = mmap(NULL, 10 * huge_page_size, PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE, fd, 0);
> +	if (addr == MAP_FAILED) {
> +		perror("mmap");
> +		exit(1);
> +	}
> +
> +	/* read should not consume any pages */
> +	read_fault_pages(addr, 10);
> +	validate_free_pages(free_hugepages - 10);
> +
> +	/* madvise should not free any pages */
> +	if (madvise(addr, 10 * huge_page_size, MADV_DONTNEED)) {
> +		perror("madvise");
> +		exit(1);
> +	}
> +	validate_free_pages(free_hugepages - 10);
> +
> +	/* writes should allocate private pages */
> +	write_fault_pages(addr, 10);
> +	validate_free_pages(free_hugepages - 20);
> +
> +	/* madvise should free private pages */
> +	if (madvise(addr, 10 * huge_page_size, MADV_DONTNEED)) {
> +		perror("madvise");
> +		exit(1);
> +	}
> +	validate_free_pages(free_hugepages - 10);
> +
> +	/* writes should allocate private pages */
> +	write_fault_pages(addr, 10);
> +	validate_free_pages(free_hugepages - 20);
> +
> +	/*
> +	 * The fallocate below certainly should free the pages associated
> +	 * with the file.  However, pages in the private mapping are also
> +	 * freed.  This is not the 'correct' behavior, but is expected
> +	 * because this is how it has worked since the initial hugetlb
> +	 * implementation.
> +	 */
> +	if (fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> +						0, 10 * huge_page_size)) {
> +		perror("fallocate");
> +		exit(1);
> +	}
> +	validate_free_pages(free_hugepages);
> +
> +	(void)munmap(addr, 10 * huge_page_size);
> +
> +	/*
> +	 * Test MADV_DONTNEED on shared mapping of hugetlb file
> +	 */
> +	if (fallocate(fd, 0, 0, 10 * huge_page_size)) {
> +		perror("fallocate");
> +		exit(1);
> +	}
> +	validate_free_pages(free_hugepages - 10);
> +
> +	addr = mmap(NULL, 10 * huge_page_size, PROT_READ | PROT_WRITE,
> +			MAP_SHARED, fd, 0);
> +	if (addr == MAP_FAILED) {
> +		perror("mmap");
> +		exit(1);
> +	}
> +
> +	/* write should not consume any pages */
> +	write_fault_pages(addr, 10);
> +	validate_free_pages(free_hugepages - 10);
> +
> +	/* madvise should not free any pages */
> +	if (madvise(addr, 10 * huge_page_size, MADV_DONTNEED)) {
> +		perror("madvise");
> +		exit(1);
> +	}
> +	validate_free_pages(free_hugepages - 10);
> +
> +	/*
> +	 * Test MADV_REMOVE on shared mapping of hugetlb file
> +	 *
> +	 * madvise is same as hole punch and should free all pages.
> +	 */
> +	if (madvise(addr, 10 * huge_page_size, MADV_REMOVE)) {
> +		perror("madvise");
> +		exit(1);
> +	}
> +	validate_free_pages(free_hugepages);
> +	(void)munmap(addr, 10 * huge_page_size);
> +
> +	/*
> +	 * Test MADV_REMOVE on shared and private mapping of hugetlb file
> +	 */
> +	if (fallocate(fd, 0, 0, 10 * huge_page_size)) {
> +		perror("fallocate");
> +		exit(1);
> +	}
> +	validate_free_pages(free_hugepages - 10);
> +
> +	addr = mmap(NULL, 10 * huge_page_size, PROT_READ | PROT_WRITE,
> +			MAP_SHARED, fd, 0);
> +	if (addr == MAP_FAILED) {
> +		perror("mmap");
> +		exit(1);
> +	}
> +
> +	/* shared write should not consume any additional pages */
> +	write_fault_pages(addr, 10);
> +	validate_free_pages(free_hugepages - 10);
> +
> +	addr2 = mmap(NULL, 10 * huge_page_size, PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE, fd, 0);
> +	if (addr2 == MAP_FAILED) {
> +		perror("mmap");
> +		exit(1);
> +	}
> +
> +	/* private read should not consume any pages */
> +	read_fault_pages(addr2, 10);
> +	validate_free_pages(free_hugepages - 10);
> +
> +	/* private write should consume additional pages */
> +	write_fault_pages(addr2, 10);
> +	validate_free_pages(free_hugepages - 20);
> +
> +	/* madvise of shared mapping should not free any pages */
> +	if (madvise(addr, 10 * huge_page_size, MADV_DONTNEED)) {
> +		perror("madvise");
> +		exit(1);
> +	}
> +	validate_free_pages(free_hugepages - 20);
> +
> +	/* madvise of private mapping should free private pages */
> +	if (madvise(addr2, 10 * huge_page_size, MADV_DONTNEED)) {
> +		perror("madvise");
> +		exit(1);
> +	}
> +	validate_free_pages(free_hugepages - 10);
> +
> +	/* private write should consume additional pages again */
> +	write_fault_pages(addr2, 10);
> +	validate_free_pages(free_hugepages - 20);
> +
> +	/*
> +	 * madvise should free both file and private pages although this is
> +	 * not correct.  private pages should not be freed, but this is
> +	 * expected.  See comment associated with FALLOC_FL_PUNCH_HOLE call.
> +	 */
> +	if (madvise(addr, 10 * huge_page_size, MADV_REMOVE)) {
> +		perror("madvise");
> +		exit(1);
> +	}
> +	validate_free_pages(free_hugepages);
> +
> +	(void)munmap(addr, 10 * huge_page_size);
> +	(void)munmap(addr2, 10 * huge_page_size);
> +
> +	close(fd);
> +	unlink(argv[1]);
> +	return 0;
> +}

Same comment on all usages of value 10

> diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
> index 75d401741394..e0daf9ff0cbe 100755
> --- a/tools/testing/selftests/vm/run_vmtests.sh
> +++ b/tools/testing/selftests/vm/run_vmtests.sh
> @@ -119,6 +119,18 @@ else
>   	echo "[PASS]"
>   fi
>   
> +echo "-----------------------"
> +echo "running hugetlb-madvise"
> +echo "-----------------------"
> +./hugetlb-madvise $mnt/madvise-test
> +if [ $? -ne 0 ]; then
> +	echo "[FAIL]"
> +	exitcode=1
> +else
> +	echo "[PASS]"
> +fi
> +rm -f $mnt/madvise-test
> +
>   echo "NOTE: The above hugetlb tests provide minimal coverage.  Use"
>   echo "      https://github.com/libhugetlbfs/libhugetlbfs.git for"
>   echo "      hugetlb regression testing."
> 

With these comments addressed/explained

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
