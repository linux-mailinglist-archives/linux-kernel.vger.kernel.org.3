Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244DE484AC8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 23:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbiADWgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 17:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbiADWgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 17:36:11 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18C1C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 14:36:10 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id c4so23074441iln.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 14:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w5fZWjxZytWYgEfRaIbCOR3pKkORbuk2tIeGiAzSEz8=;
        b=g0Ug35FR7BFCsy10bzpvXNSXSLV69DW69tDI+MuX5oQOp12iyvaas6GybXLCKQWkiO
         x5okUkt3Hb+i9uPwF2fXOec3qqn0diBAFmi0Ee3+sC9TjYutDo1zFNu5tC1kjgrrdfM2
         nc4vLlCXL5YMtlnEPCAeDQ9ljFiEusXSQiYevSciCNUoB8OaeftCuev4A7cuaKbkQHtr
         10dHORcesjJwspNbJE+0L/qXrwX7EXpDWiiJpk0dd7xwLycyBKB8EehjDmN11fSO5MKt
         ZkzPHI/t3uXoqEZoxfh4YvlCF1v7rCopMZCQha5DPCKoVQ1eAwRsIw3sp66Hj1GzrQO3
         AP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w5fZWjxZytWYgEfRaIbCOR3pKkORbuk2tIeGiAzSEz8=;
        b=7WdcIbsD5CImw1aicl94T/X8896kvHBxro4AF9FPudTgCgvtFrpqoC8w+EmyOoOzia
         E+yWsbEA3WMsSwnJfHXsDUX9HQJ5eMrK2/7i4E42xpjjmJ60vR6xZZf2rFTZSb9mgcIx
         xGBznRsceihTmaJ+CMNwr1mJR1FLMohuEQ7SZm12ycQiIHKIa6cEBEDTc1j66Zzr6zF4
         7lBCGEynMFoVpN75WtaHD9aMALw9qooXCRe11nTc6DbObEkEcBdAx91QyzXO27TojJpt
         HkNrJg24aQ9cvN1PoDXRdNUlbriNhhSSH6fcrbnCX+8cQ7UebrcceUorLMCKN1/jq6Vh
         KfzQ==
X-Gm-Message-State: AOAM532Jx8Uzetv9MBpdJ15RhZig2PdK/wcud4S7cdj8YrhV2KrY2yiN
        59M9hxWzCpehUN3BkopBIUmkmzunJDB0HzIM1gk/Zw==
X-Google-Smtp-Source: ABdhPJxLuecusT5Dfedn3h+ku4lyG4NJKWirHZCPO3j03JObwhPWOtcq2hHNj7Ji3YYtiz/TOo1kTRt2GePi77LJwsA=
X-Received: by 2002:a05:6e02:1d9d:: with SMTP id h29mr25025527ila.247.1641335770119;
 Tue, 04 Jan 2022 14:36:10 -0800 (PST)
MIME-Version: 1.0
References: <20220104021729.111006-1-mike.kravetz@oracle.com>
In-Reply-To: <20220104021729.111006-1-mike.kravetz@oracle.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 4 Jan 2022 14:35:34 -0800
Message-ID: <CAJHvVci5sSC-1TEiCBKe8uKQ=0uwCsoBJT_fsG1Rfq6ffy6Obg@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd/selftests: clean up hugetlb allocation code
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 3, 2022 at 6:17 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> The message for commit f5c73297181c ("userfaultfd/selftests: fix hugetlb
> area allocations") says there is no need to create a hugetlb file in the
> non-shared testing case.  However, the commit did not actually change
> the code to prevent creation of the file.
>
> While it is technically true that there is no need to create and use a
> hugetlb file in the case of non-shared-testing, it is useful.  This is
> because 'hole punching' of a hugetlb file has the potentially incorrect
> side effect of also removing pages from private mappings.  The
> userfaultfd test relies on this side effect for removing pages from the
> destination buffer during rounds of stress testing.
>
> Remove the incomplete code that was added to deal with no hugetlb file.
> Just keep the code that prevents reserves from being created for the
> destination area.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  tools/testing/selftests/vm/userfaultfd.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index 9354a5e0321c..0b543a9a42b2 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -87,7 +87,7 @@ static bool test_uffdio_minor = false;
>
>  static bool map_shared;
>  static int shm_fd;
> -static int huge_fd = -1;       /* only used for hugetlb_shared test */
> +static int huge_fd;
>  static char *huge_fd_off0;
>  static unsigned long long *count_verify;
>  static int uffd = -1;
> @@ -223,9 +223,6 @@ static void noop_alias_mapping(__u64 *start, size_t len, unsigned long offset)
>
>  static void hugetlb_release_pages(char *rel_area)
>  {
> -       if (huge_fd == -1)
> -               return;
> -
>         if (fallocate(huge_fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
>                       rel_area == huge_fd_off0 ? 0 : nr_pages * page_size,
>                       nr_pages * page_size))
> @@ -238,17 +235,17 @@ static void hugetlb_allocate_area(void **alloc_area)
>         char **alloc_area_alias;
>
>         *alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
> -                          map_shared ? MAP_SHARED :
> -                          MAP_PRIVATE | MAP_HUGETLB |
> +                          (map_shared ? MAP_SHARED : MAP_PRIVATE) |
> +                          MAP_HUGETLB |
>                            (*alloc_area == area_src ? 0 : MAP_NORESERVE),
> -                          huge_fd,
> -                          *alloc_area == area_src ? 0 : nr_pages * page_size);
> +                          huge_fd, *alloc_area == area_src ? 0 :
> +                          nr_pages * page_size);

Sorry to nitpick, but I think it was slightly more readable when the
ternary was all on one line.

>         if (*alloc_area == MAP_FAILED)
>                 err("mmap of hugetlbfs file failed");
>
>         if (map_shared) {
>                 area_alias = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
> -                                 MAP_SHARED,
> +                                 MAP_SHARED | MAP_HUGETLB,
>                                   huge_fd, *alloc_area == area_src ? 0 :
>                                   nr_pages * page_size);
>                 if (area_alias == MAP_FAILED)
> --
> 2.33.1
>

Looks functionally correct to me besides the one style gripe,

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
