Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FF64A78CA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 20:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346923AbiBBTfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 14:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiBBTfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 14:35:12 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DFFC061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 11:35:12 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id e28so173545pfj.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 11:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ry7R53YO4Swsz3TJJ6ZarkYxXNRWHuwvQe9nMVYuVs0=;
        b=r6cB2T4aE39Ps0ylMioXXq9SALw1BvuPcBWEl/4H+cg6K2WdOmWY3GiourqMvhuoI3
         ULxM7VP9jzNXG2kVx/TABeBX0aUCadg0GWzT41WL7+qV2CSMsVgMX3FIhP7zYNCwA6Tn
         iTelUp1Kq2301f3uyu5kCxv78/fVy9NagOvDYXjiPpXK5MS6V8GtQk9+BLFISiICTktF
         QvIb9kkKijBrMw2i3JfwdmlnDLBqZYDW7zeNca5BlMqjRXksT2mhO/3WI7vZPvSwE083
         +8Vj/94qedsElVZUXu2ZIvSqLmtMm6C7tp+dpxTVPmLbOE1iaz00HogzVyUWlu9QZL3a
         Uo0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ry7R53YO4Swsz3TJJ6ZarkYxXNRWHuwvQe9nMVYuVs0=;
        b=B/fIal1f+Whw/+YYOQ8Xja99KyrAUr/fy3n6IwTBJ3JrstjJRTIprLm06crdr9sj9h
         MCATeEbz5XvJ6N0KZLW6NkpcBVKxA+NN9Fexs4P0QoKXW/a88py/z3yAGSGUoPMyXXEk
         o9h8F37GETPxdkMUC2rlE0Cwt4bC7fxg5x0JjTS8Xwvx6quP395GAP+hSRYysFWnoBAq
         hzzQajO2LsVVkA6i+xHzjFvfj1aypkhD4PyFOMrozhRGssRRxP9CRen+uqNj5/M7mYeA
         KVjh09RVqHc2HURRXqAL6Ay0D9Ymr3x4XA7VZtNCtlckdGa8xNlB0sqrCyG3h67g2mLc
         qDyQ==
X-Gm-Message-State: AOAM531Hi7Pg2qezBR3e12PpzEuCm8I85ochSFf6TrBCHTWHm+xCwNZH
        SQKcoR3/pmak1QCBws3cLgFgvQJdJcs20a18/sUWhA==
X-Google-Smtp-Source: ABdhPJzb95+FoAtSkMReBfzCigoxXQ3Bj6IuL4csArRCLMMY0YQ6crm3Cj55TtssS2otEMUnlAFXR6PXN7s3YXzrslc=
X-Received: by 2002:a63:2d86:: with SMTP id t128mr25717072pgt.200.1643830511679;
 Wed, 02 Feb 2022 11:35:11 -0800 (PST)
MIME-Version: 1.0
References: <20220201033459.156944-1-mike.kravetz@oracle.com>
In-Reply-To: <20220201033459.156944-1-mike.kravetz@oracle.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 2 Feb 2022 11:34:35 -0800
Message-ID: <CAJD7tkYOa-GF+sg9sSkyNOsNnvJPwmb4sBZzS=8kunaQBa9_yg@mail.gmail.com>
Subject: Re: [PATCH] selftests/vm: cleanup hugetlb file after mremap test
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mina Almasry <almasrymina@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Mike for working on this!

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

The hugepage-mmap test also uses a hugetlb file in the same fashion. I
think the missing close() and unlink() calls were the only difference
(thanks for catching that).
I would suggest for consistency purposes to either make both tests
take the filename as an argument or not, fine either way.

> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
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

I think the ternary operator is not needed here as it will always be
true if we enter the if block.

Otherwise, LGTM.

Acked-by: Yosry Ahmed <yosryahmed@google.com>
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
