Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F144A0443
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 00:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347866AbiA1XfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 18:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiA1XfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:35:04 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2974FC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 15:35:04 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id s18so9666759ioa.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 15:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JpxTvdtKkLVFIRueCOXz6q3rm9liXhmMzUpLMlmCnLU=;
        b=g7/+yn+1wuV/EnT2ud8bvqTF+w10NI6OEzAsSl22TTd5ghnv4EncSe/8gGllBy0rVZ
         Q62XSk5EQ6GfQwP0muWw+uvAAXSc31tPIev3WiOaXTLLtnYW9pnVG+LlI1Bd1Jl6eo9L
         1LCDO3Z0/zb7TtpfkucaBFtyVTqZG+PxbqpM8/Ww+Pc7kh7yBeJ+/wqOCiJtb5NyL9Hh
         x03Ifmpv6zWzidSFG/zSX/BFFT3X7uVVF2B0o2xDbLOruEgDl0uOXk439QUGaKnFYSr+
         xhexMcQqGzNUo2DbX3ttUiEH90YR3qvrsXF7WRt42klLthjuw6ylUIHqVb1eg2t7uNcZ
         T8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JpxTvdtKkLVFIRueCOXz6q3rm9liXhmMzUpLMlmCnLU=;
        b=zGwIdZ9IEjAwXVbPy1je1+CvHJtJveuIMkfLEGaoRHeutXp+mEWbOijmFMHAyS8HqC
         EUolUyp7hUHAStcHQzL5fL2DDTiSWHHWzwtyBh6Jy8Xi2ekrJe6cKY53b3P7iu1I4U+m
         YB06AFnnjti1VtF8TZWMjoR8fK8upCtFBywXIK4gV0w2wDIt/pqbi5+kIYoBwDx2/Rml
         JrAEI+q7v3jTb+nmZgPbeSipP4EkXYtLa4DyGpTIThd2TXHT4YU248DhdszdVQkRDRzV
         8gLqYSAiUC+EwkQYZr7fhCZCFLgSZ/o/osN25I4ZH1yOvQxIczVuTWVPsRE445cYnkY7
         4xCg==
X-Gm-Message-State: AOAM531qXwIszo6Yq8FIs/sfd6vor4VUQay1yAlDqfmix1v21geJ+hml
        OXyDgGcxPNc7LC4R8MF0vIygsgwComyLMKcjQM9kgQ==
X-Google-Smtp-Source: ABdhPJwWUB5cbdyBGAqxyMyGHOnbfYZPcT4OjPCpBoMeE03TcdvaUaIgTMJv3osnClnOWBdt7NXijWYqK9dvzOoSVoc=
X-Received: by 2002:a6b:bf81:: with SMTP id p123mr6645468iof.171.1643412903171;
 Fri, 28 Jan 2022 15:35:03 -0800 (PST)
MIME-Version: 1.0
References: <20220128222605.66828-1-mike.kravetz@oracle.com> <20220128222605.66828-4-mike.kravetz@oracle.com>
In-Reply-To: <20220128222605.66828-4-mike.kravetz@oracle.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 28 Jan 2022 15:34:27 -0800
Message-ID: <CAJHvVcgjJNN81bAhsANccqsdYv3Xt5rMxH6i=JtHxijch55WFQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] userfaultfd/selftests: enable huegtlb remap and
 remove event testing
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Besides the help text, looks correct to me. I applied the patches and
ran the userfaultfd selftests, and everything seems to work properly.

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

On Fri, Jan 28, 2022 at 2:26 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> With MADV_DONTNEED support added to hugetlb mappings, mremap testing
> can also be enabled for hugetlb.
>
> Modify the tests to use madvise MADV_DONTNEED and MADV_REMOVE instead of
> fallocate hole puch for releasing hugetlb pages.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  tools/testing/selftests/vm/userfaultfd.c | 67 ++++++++++++------------
>  1 file changed, 34 insertions(+), 33 deletions(-)
>
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index d3fd24f9fae8..f5578ef85560 100644
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
> @@ -124,9 +123,9 @@ const char *examples =
>      "./userfaultfd anon 100 99999\n\n"
>      "# Run share memory test on 1GiB region with 99 bounces:\n"
>      "./userfaultfd shmem 1000 99\n\n"
> -    "# Run hugetlb memory test on 256MiB region with 50 bounces (using /dev/hugepages/hugefile):\n"
> +    "# Run hugetlb memory test on 256MiB region with 50 bounces:\n"
>      "./userfaultfd hugetlb 256 50 /dev/hugepages/hugefile\n\n"

We should remove the path from the line above here as well, right?
Since for the hugetlb test type, we now just MAP_ANONYMOUS |
MAP_HUGETLB, we don't open a file descriptor.

> -    "# Run the same hugetlb test but using shmem:\n"
> +    "# Run the same hugetlb test but using shared file:\n"
>      "./userfaultfd hugetlb_shared 256 50 /dev/hugepages/hugefile\n\n"
>      "# 10MiB-~6GiB 999 bounces anonymous test, "
>      "continue forever unless an error triggers\n"
> @@ -223,10 +222,13 @@ static void noop_alias_mapping(__u64 *start, size_t len, unsigned long offset)
>
>  static void hugetlb_release_pages(char *rel_area)
>  {
> -       if (fallocate(huge_fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> -                     rel_area == huge_fd_off0 ? 0 : nr_pages * page_size,
> -                     nr_pages * page_size))
> -               err("fallocate() failed");
> +       if (!map_shared) {
> +               if (madvise(rel_area, nr_pages * page_size, MADV_DONTNEED))
> +                       err("madvise(MADV_DONTNEED) failed");
> +       } else {
> +               if (madvise(rel_area, nr_pages * page_size, MADV_REMOVE))
> +                       err("madvise(MADV_REMOVE) failed");
> +       }
>  }
>
>  static void hugetlb_allocate_area(void **alloc_area)
> @@ -234,26 +236,37 @@ static void hugetlb_allocate_area(void **alloc_area)
>         void *area_alias = NULL;
>         char **alloc_area_alias;
>
> -       *alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
> -                          (map_shared ? MAP_SHARED : MAP_PRIVATE) |
> -                          MAP_HUGETLB |
> -                          (*alloc_area == area_src ? 0 : MAP_NORESERVE),
> -                          huge_fd, *alloc_area == area_src ? 0 :
> -                          nr_pages * page_size);
> +       if (!map_shared)
> +               *alloc_area = mmap(NULL,
> +                       nr_pages * page_size,
> +                       PROT_READ | PROT_WRITE,
> +                       MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB |
> +                               (*alloc_area == area_src ? 0 : MAP_NORESERVE),
> +                       -1,
> +                       0);
> +       else
> +               *alloc_area = mmap(NULL,
> +                       nr_pages * page_size,
> +                       PROT_READ | PROT_WRITE,
> +                       MAP_SHARED |
> +                               (*alloc_area == area_src ? 0 : MAP_NORESERVE),
> +                       huge_fd,
> +                       *alloc_area == area_src ? 0 : nr_pages * page_size);
>         if (*alloc_area == MAP_FAILED)
>                 err("mmap of hugetlbfs file failed");
>
>         if (map_shared) {
> -               area_alias = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
> -                                 MAP_SHARED | MAP_HUGETLB,
> -                                 huge_fd, *alloc_area == area_src ? 0 :
> -                                 nr_pages * page_size);
> +               area_alias = mmap(NULL,
> +                       nr_pages * page_size,
> +                       PROT_READ | PROT_WRITE,
> +                       MAP_SHARED,
> +                       huge_fd,
> +                       *alloc_area == area_src ? 0 : nr_pages * page_size);
>                 if (area_alias == MAP_FAILED)
>                         err("mmap of hugetlb file alias failed");
>         }
>
>         if (*alloc_area == area_src) {
> -               huge_fd_off0 = *alloc_area;
>                 alloc_area_alias = &area_src_alias;
>         } else {
>                 alloc_area_alias = &area_dst_alias;
> @@ -266,12 +279,7 @@ static void hugetlb_alias_mapping(__u64 *start, size_t len, unsigned long offset
>  {
>         if (!map_shared)
>                 return;
> -       /*
> -        * We can't zap just the pagetable with hugetlbfs because
> -        * MADV_DONTEED won't work. So exercise -EEXIST on a alias
> -        * mapping where the pagetables are not established initially,
> -        * this way we'll exercise the -EEXEC at the fs level.
> -        */
> +
>         *start = (unsigned long) area_dst_alias + offset;
>  }
>
> @@ -424,7 +432,6 @@ static void uffd_test_ctx_clear(void)
>                 uffd = -1;
>         }
>
> -       huge_fd_off0 = NULL;
>         munmap_area((void **)&area_src);
>         munmap_area((void **)&area_src_alias);
>         munmap_area((void **)&area_dst);
> @@ -922,10 +929,7 @@ static int faulting_process(int signal_test)
>         struct sigaction act;
>         unsigned long signalled = 0;
>
> -       if (test_type != TEST_HUGETLB)
> -               split_nr_pages = (nr_pages + 1) / 2;
> -       else
> -               split_nr_pages = nr_pages;
> +       split_nr_pages = (nr_pages + 1) / 2;
>
>         if (signal_test) {
>                 sigbuf = &jbuf;
> @@ -982,9 +986,6 @@ static int faulting_process(int signal_test)
>         if (signal_test)
>                 return signalled != split_nr_pages;
>
> -       if (test_type == TEST_HUGETLB)
> -               return 0;
> -
>         area_dst = mremap(area_dst, nr_pages * page_size,  nr_pages * page_size,
>                           MREMAP_MAYMOVE | MREMAP_FIXED, area_src);
>         if (area_dst == MAP_FAILED)
> @@ -1667,7 +1668,7 @@ int main(int argc, char **argv)
>         }
>         nr_pages = nr_pages_per_cpu * nr_cpus;
>
> -       if (test_type == TEST_HUGETLB) {
> +       if (test_type == TEST_HUGETLB && map_shared) {
>                 if (argc < 5)
>                         usage();
>                 huge_fd = open(argv[4], O_CREAT | O_RDWR, 0755);
> --
> 2.34.1
>
