Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5A24A649A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 20:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242285AbiBATG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 14:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiBATG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:06:26 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F18C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 11:06:26 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id m90so14981583uam.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 11:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qUbQ0b8ZRd0AkjeyzEsyBCt3tnTOzbqx/Ys5mz3HL90=;
        b=iy3UNgBrq5QIwft+G9BGA9Y0FZyDvqHq7QcVj2quS7jbiXUvsx8BZfCHJrbVaWNEZW
         dOGUSjaJpOAn3f8bxEnzmYZAgTD0BtXi1VVyp9IkpdXdrx0qIBRB76CNUOxZ7Eunin36
         q4umGQKhdKU0A/ygq1g4FUBc611k+BqG4skbOpIifPih6MijOW4e4NTfnKxqp/iLvcIi
         18jgnsguAdT1nm9/C4XcvT/LJgnmE0rFyGA1IOvn99NQ4SvbGHzvyK4Uq2ysj0DlO7eA
         AnXhEZ9/1c5cqw0Ek/jPeQo/UhEu1VLgQQsYso1ipCv9td44o7vDnRtddPLeRqgBDqW4
         5vNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qUbQ0b8ZRd0AkjeyzEsyBCt3tnTOzbqx/Ys5mz3HL90=;
        b=dnc/KlbOFsQZFYPs529+l7NTvAqgD//Rpyi3Y45SJjQ0AhnIUM4YAyZSDqz/1fIFke
         iWITZiduQR7ewVZpP93QrGrz6YX7YiGtJ3tPhGMuJBWRBiVvxwxwDYeX7I7iEIWRkCFt
         3SHvymJJOugwq463XGd7h0mdCeTtLLqA7MJV4loEHJkDI9xl1255pURwkCzJWq+PHbge
         nEk1KYGZjBpEYavVK1HU2mr/PUvMbNBWlxsgPVILgknXIj7MtOYsqHLeqOxAq4zPu1WI
         xq/us56946DVQ521LDhuvoKDGbxsU05qttcifwZyFVOkz4bQpUAdqfFGrh0FlEEKnWUN
         kbvw==
X-Gm-Message-State: AOAM533DUXRlQRz8Y6DJKeQShDM5e4zTunk1ISaoDlL+v0Xq4IQQkwcD
        iWZkcVb1jDzLvw94wSZgkKyOuGnxAhDNK9xhI82eSq7oaJQ=
X-Google-Smtp-Source: ABdhPJzOe1y3RAp2TcJlvoR6jIriXoQif+8Cx2+nvtnlFymktSZCJUs/LJjWSYP0MW73mpCRBbHbzLqHAnuwo9CI+gQ=
X-Received: by 2002:ab0:2092:: with SMTP id r18mr10365251uak.66.1643742385158;
 Tue, 01 Feb 2022 11:06:25 -0800 (PST)
MIME-Version: 1.0
References: <20220201033459.156944-1-mike.kravetz@oracle.com>
In-Reply-To: <20220201033459.156944-1-mike.kravetz@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 1 Feb 2022 11:06:13 -0800
Message-ID: <CAHS8izPpwNLWyebB7OxBMA4ufkS3SAwm9Qz63Yo2-t9wGF6_pg@mail.gmail.com>
Subject: Re: [PATCH] selftests/vm: cleanup hugetlb file after mremap test
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 7:35 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> The hugepage-mremap test will create a file in a hugetlb filesystem.
> In a default 'run_vmtests' run, the file will contain all the hugetlb
> pages.  After the test, the file remains and there are no free hugetlb
> pages for subsequent tests. This causes those hugetlb tests to fail.
>
> Change hugepage-mremap to take the name of the hugetlb file as an
> argument.  Unlink the file within the test, and just to be sure remove
> the file in the run_vmtests script.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Thanks Mike!

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
>  tools/testing/selftests/vm/hugepage-mremap.c | 26 ++++++++++++++------
>  tools/testing/selftests/vm/run_vmtests.sh    |  3 ++-
>  2 files changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/vm/hugepage-mremap.c b/tools/testing/selftests/vm/hugepage-mremap.c
> index 2a7c33631a29..1d689084a54b 100644
> --- a/tools/testing/selftests/vm/hugepage-mremap.c
> +++ b/tools/testing/selftests/vm/hugepage-mremap.c
> @@ -3,9 +3,10 @@
>   * hugepage-mremap:
>   *
>   * Example of remapping huge page memory in a user application using the
> - * mremap system call.  Code assumes a hugetlbfs filesystem is mounted
> - * at './huge'.  The amount of memory used by this test is decided by a command
> - * line argument in MBs. If missing, the default amount is 10MB.
> + * mremap system call.  The path to a file in a hugetlbfs filesystem must
> + * be passed as the last argument to this test.  The amount of memory used
> + * by this test in MBs can optionally be passed as an argument.  If no memory
> + * amount is passed, the default amount is 10MB.
>   *
>   * To make sure the test triggers pmd sharing and goes through the 'unshare'
>   * path in the mremap code use 1GB (1024) or more.
> @@ -25,7 +26,6 @@
>  #define DEFAULT_LENGTH_MB 10UL
>  #define MB_TO_BYTES(x) (x * 1024 * 1024)
>
> -#define FILE_NAME "huge/hugepagefile"
>  #define PROTECTION (PROT_READ | PROT_WRITE | PROT_EXEC)
>  #define FLAGS (MAP_SHARED | MAP_ANONYMOUS)
>
> @@ -107,17 +107,26 @@ static void register_region_with_uffd(char *addr, size_t len)
>
>  int main(int argc, char *argv[])
>  {
> +       size_t length;
> +
> +       if (argc != 2 && argc != 3) {
> +               printf("Usage: %s [length_in_MB] <hugetlb_file>\n", argv[0]);
> +               exit(1);
> +       }
> +
>         /* Read memory length as the first arg if valid, otherwise fallback to
> -        * the default length. Any additional args are ignored.
> +        * the default length.
>          */
> -       size_t length = argc > 1 ? (size_t)atoi(argv[1]) : 0UL;
> +       if (argc == 3)
> +               length = argc > 2 ? (size_t)atoi(argv[1]) : 0UL;
>
>         length = length > 0 ? length : DEFAULT_LENGTH_MB;
>         length = MB_TO_BYTES(length);
>
>         int ret = 0;
>
> -       int fd = open(FILE_NAME, O_CREAT | O_RDWR, 0755);
> +       /* last arg is the hugetlb file name */
> +       int fd = open(argv[argc-1], O_CREAT | O_RDWR, 0755);
>
>         if (fd < 0) {
>                 perror("Open failed");
> @@ -169,5 +178,8 @@ int main(int argc, char *argv[])
>
>         munmap(addr, length);
>
> +       close(fd);
> +       unlink(argv[argc-1]);
> +
>         return ret;
>  }
> diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
> index e09040a3dc08..e10d50e0b8e8 100755
> --- a/tools/testing/selftests/vm/run_vmtests.sh
> +++ b/tools/testing/selftests/vm/run_vmtests.sh
> @@ -111,13 +111,14 @@ fi
>  echo "-----------------------"
>  echo "running hugepage-mremap"
>  echo "-----------------------"
> -./hugepage-mremap 256
> +./hugepage-mremap $mnt/huge_mremap
>  if [ $? -ne 0 ]; then
>         echo "[FAIL]"
>         exitcode=1
>  else
>         echo "[PASS]"
>  fi
> +rm -f $mnt/huge_mremap
>
>  echo "------------------------"
>  echo "running hugepage-vmemmap"
> --
> 2.34.1
>
