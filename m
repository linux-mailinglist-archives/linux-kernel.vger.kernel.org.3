Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A314FE956
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 22:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbiDLUL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 16:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiDLULq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 16:11:46 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80618A5E9A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 13:06:00 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id b16so23588652ioz.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 13:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jDie0cHXEVZ1CQFcE6OjZwMu1GMQ+1k6NOBNMk+4KFE=;
        b=gJlgEhx9Af7sHJeilYxdeA7Co9OYBzPUZ2vZVqaFGx0B6MaYRAuoe3cB2sJoWw85o6
         i8dCbzYcpEtHHb3K4SINbaOcE0WtASyznwUejlns9b/G/shHmrBTJN+4U3mGo3rixb+N
         mjkl20VkMlEFbBK2ZqhveWz1e9O51yoP4Jbt8F1dcYxSkUE4/yUXlWtd72XygiEw3Zf6
         ezkYOoVkM8sfSG6ZEvXGF+0MYWtpV63DnIW35FQp83Z8y32ge0f4559/21hoVWk4g50U
         NrR04m9xLMC4M4nyu2t6RuCNVmarpGzFKKHSoHwWNTMUs4nCxQtpS3xCRs1BVER5Frxu
         xRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jDie0cHXEVZ1CQFcE6OjZwMu1GMQ+1k6NOBNMk+4KFE=;
        b=4ZVWm9hE9q7J/vtyL3TV30rz+znYWpCiVAaDu0LpeeYvfHxI0kWMVT2MoSiuvhQ+9e
         ZkCpDN6sG7+EhbV36cHwoewwZ7p9WALqJ8d9sQNLk9UIqGxepG/vgJGTKXonpTHtBnOM
         LZUbs7KIHWZQBICcniDjGAQDu8LZScEEGGcbAs8HSEfm7pJjTwdCWZ534HaAgDqL3C4U
         BNPy6yg7ujXy/y5sD4SsQc4QanQ1sNQUtMpOZPR8NZT3bznRSuOxWxNDsuRYsiJ2M5EB
         IFw/QH1+30N1pA5W4I2ZI3vnsU28FbiFSc0Z3ywpdeLFWtUAEfdOWDr3uJLA/6WeDpyI
         0b8Q==
X-Gm-Message-State: AOAM531ab8Ug3cR4B3374cDM9sbjVfE44jp379KIR3rBogd3MMo44GBI
        Ycg2yc1aSCHmm88fHW3D23ky/nu+GgFXfG8LsUJ1qg==
X-Google-Smtp-Source: ABdhPJxCvGyBsz/aSd5oFPWDIGTUifUq6LRnowGmfmGnnVd9x88qEzuL5pDeIuUSxbd/ngmc0or8My/M2KWYzmBYv+I=
X-Received: by 2002:a05:6602:168b:b0:646:3bbb:7db4 with SMTP id
 s11-20020a056602168b00b006463bbb7db4mr16329108iow.134.1649793957452; Tue, 12
 Apr 2022 13:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220412195631.282237-1-axelrasmussen@google.com>
In-Reply-To: <20220412195631.282237-1-axelrasmussen@google.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 12 Apr 2022 13:05:21 -0700
Message-ID: <CAJHvVchQ0a51+vh3Oran+Zhru1rj3nzBiFEYH2SuisSP_eyO5g@mail.gmail.com>
Subject: Re: [PATCH v4] ioctl_userfaultfd.2, userfaultfd.2: add minor fault mode
To:     Alejandro Colomar <alx.manpages@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-man@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whoops, I ought to have removed this part of the commit message, since
I updated the commit to mention shmem as well:

"This patch covers just the hugetlbfs implementation (in 5.13). Support
for shmem is forthcoming, but as it has not yet made it into a kernel
release candidate, it will be added in a future commit."

On Tue, Apr 12, 2022 at 12:56 PM Axel Rasmussen
<axelrasmussen@google.com> wrote:
>
> Userfaultfd minor fault mode is supported starting from Linux 5.13.
>
> This commit adds a description of the new mode, as well as the new ioctl
> used to resolve such faults. The two go hand-in-hand: one can't resolve
> a minor fault without continue, and continue can't be used to resolve
> any other kind of fault.
>
> This patch covers just the hugetlbfs implementation (in 5.13). Support
> for shmem is forthcoming, but as it has not yet made it into a kernel
> release candidate, it will be added in a future commit.
>
> v1->v2:
> - Some spelling / phrasing improvements
> v2->v3:
> - Improved line wrapping in man2/ioctl_userfaultfd.2
> v3->v4:
> - Rebased onto http://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/ main
> - Mentioned minor fault shmem support
> - Improved line wrapping in man2/userfaultfd.2
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  man2/ioctl_userfaultfd.2 | 142 ++++++++++++++++++++++++++++++++++++---
>  man2/userfaultfd.2       |  95 ++++++++++++++++++++++----
>  2 files changed, 215 insertions(+), 22 deletions(-)
>
> diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
> index 15a681164c..d0cb0c9c8e 100644
> --- a/man2/ioctl_userfaultfd.2
> +++ b/man2/ioctl_userfaultfd.2
> @@ -197,6 +197,16 @@ memory accesses to the regions registered with userfaultfd.
>  If this feature bit is set,
>  .I uffd_msg.pagefault.feat.ptid
>  will be set to the faulted thread ID for each page-fault message.
> +.TP
> +.BR UFFD_FEATURE_MINOR_HUGETLBFS " (since Linux 5.13)"
> +If this feature bit is set,
> +the kernel supports registering userfaultfd ranges
> +in minor mode on hugetlbfs-backed memory areas.
> +.TP
> +.BR UFFD_FEATURE_MINOR_SHMEM " (since Linux 5.14)"
> +If this feature bit is set,
> +the kernel supports registering userfaultfd ranges
> +in minor mode on shmem-backed memory areas.
>  .PP
>  The returned
>  .I ioctls
> @@ -256,14 +266,8 @@ by the current kernel version.
>  (Since Linux 4.3.)
>  Register a memory address range with the userfaultfd object.
>  The pages in the range must be "compatible".
> -.PP
> -Up to Linux kernel 4.11,
> -only private anonymous ranges are compatible for registering with
> -.BR UFFDIO_REGISTER .
> -.PP
> -Since Linux 4.11,
> -hugetlbfs and shared memory ranges are also compatible with
> -.BR UFFDIO_REGISTER .
> +Please refer to the list of register modes below
> +for the compatible memory backends for each mode.
>  .PP
>  The
>  .I argp
> @@ -302,9 +306,22 @@ the specified range:
>  .TP
>  .B UFFDIO_REGISTER_MODE_MISSING
>  Track page faults on missing pages.
> +Since Linux 4.3,
> +only private anonymous ranges are compatible.
> +Since Linux 4.11,
> +hugetlbfs and shared memory ranges are also compatible.
>  .TP
>  .B UFFDIO_REGISTER_MODE_WP
>  Track page faults on write-protected pages.
> +Since Linux 5.7,
> +only private anonymous ranges are compatible.
> +.TP
> +.B UFFDIO_REGISTER_MODE_MINOR
> +Track minor page faults.
> +Since Linux 5.13,
> +only hugetlbfs ranges are compatible.
> +Since Linux 5.14,
> +compatiblity with shmem ranges was added.
>  .PP
>  If the operation is successful, the kernel modifies the
>  .I ioctls
> @@ -331,6 +348,11 @@ The
>  The
>  .B UFFDIO_ZEROPAGE
>  operation is supported.
> +.TP
> +.B 1 << _UFFDIO_CONTINUE
> +The
> +.B UFFDIO_CONTINUE
> +operation is supported.
>  .PP
>  This
>  .BR ioctl (2)
> @@ -731,6 +753,110 @@ or not registered with userfaultfd write-protect mode.
>  .TP
>  .B EFAULT
>  Encountered a generic fault during processing.
> +.\"
> +.SS UFFDIO_CONTINUE
> +(Since Linux 5.13.)
> +Resolve a minor page fault
> +by installing page table entries
> +for existing pages in the page cache.
> +.PP
> +The
> +.I argp
> +argument is a pointer to a
> +.I uffdio_continue
> +structure as shown below:
> +.PP
> +.in +4n
> +.EX
> +struct uffdio_continue {
> +    struct uffdio_range range; /* Range to install PTEs for and continue */
> +    __u64 mode;                /* Flags controlling the behavior of continue */
> +    __s64 mapped;              /* Number of bytes mapped, or negated error */
> +};
> +.EE
> +.in
> +.PP
> +The following value may be bitwise ORed in
> +.IR mode
> +to change the behavior of the
> +.B UFFDIO_CONTINUE
> +operation:
> +.TP
> +.B UFFDIO_CONTINUE_MODE_DONTWAKE
> +Do not wake up the thread that waits for page-fault resolution.
> +.PP
> +The
> +.I mapped
> +field is used by the kernel
> +to return the number of bytes that were actually mapped,
> +or an error in the same manner as
> +.BR UFFDIO_COPY .
> +If the value returned in the
> +.I mapped
> +field doesn't match the value that was specified in
> +.IR range.len ,
> +the operation fails with the error
> +.BR EAGAIN .
> +The
> +.I mapped
> +field is output-only;
> +it is not read by the
> +.B UFFDIO_CONTINUE
> +operation.
> +.PP
> +This
> +.BR ioctl (2)
> +operation returns 0 on success.
> +In this case,
> +the entire area was mapped.
> +On error, \-1 is returned and
> +.I errno
> +is set to indicate the error.
> +Possible errors include:
> +.TP
> +.B EAGAIN
> +The number of bytes mapped
> +(i.e., the value returned in the
> +.I mapped
> +field)
> +does not equal the value that was specified in the
> +.I range.len
> +field.
> +.TP
> +.B EINVAL
> +Either
> +.I range.start
> +or
> +.I range.len
> +was not a multiple of the system page size; or
> +.I range.len
> +was zero; or the range specified was invalid.
> +.TP
> +.B EINVAL
> +An invalid bit was specified in the
> +.IR mode
> +field.
> +.TP
> +.B EEXIST
> +One or more pages were already mapped in the given range.
> +.TP
> +.B ENOENT
> +The faulting process has changed its virtual memory layout simultaneously with
> +an outstanding
> +.B UFFDIO_CONTINUE
> +operation.
> +.TP
> +.B ENOMEM
> +Allocating memory needed to setup the page table mappings failed.
> +.TP
> +.B EFAULT
> +No existing page could be found in the page cache for the given range.
> +.TP
> +.BR ESRCH
> +The faulting process has exited at the time of a
> +.B UFFDIO_CONTINUE
> +operation.
> +.\"
>  .SH RETURN VALUE
>  See descriptions of the individual operations, above.
>  .SH ERRORS
> diff --git a/man2/userfaultfd.2 b/man2/userfaultfd.2
> index 41741b4d88..f8dc4766b1 100644
> --- a/man2/userfaultfd.2
> +++ b/man2/userfaultfd.2
> @@ -65,7 +65,7 @@ all memory ranges that were registered with the object are unregistered
>  and unread events are flushed.
>  .\"
>  .PP
> -Userfaultfd supports two modes of registration:
> +Userfaultfd supports three modes of registration:
>  .TP
>  .BR UFFDIO_REGISTER_MODE_MISSING " (since 4.10)"
>  When registered with
> @@ -79,6 +79,18 @@ or an
>  .B UFFDIO_ZEROPAGE
>  ioctl.
>  .TP
> +.BR UFFDIO_REGISTER_MODE_MINOR " (since 5.13)"
> +When registered with
> +.B UFFDIO_REGISTER_MODE_MINOR
> +mode, user-space will receive a page-fault notification
> +when a minor page fault occurs.
> +That is, when a backing page is in the page cache, but
> +page table entries don't yet exist.
> +The faulted thread will be stopped from execution
> +until the page fault is resolved from user-space by an
> +.B UFFDIO_CONTINUE
> +ioctl.
> +.TP
>  .BR UFFDIO_REGISTER_MODE_WP " (since 5.7)"
>  When registered with
>  .B UFFDIO_REGISTER_MODE_WP
> @@ -199,9 +211,10 @@ a page fault occurring in the requested memory range, and satisfying
>  the mode defined at the registration time, will be forwarded by the kernel to
>  the user-space application.
>  The application can then use the
> -.B UFFDIO_COPY
> +.B UFFDIO_COPY ,
> +.B UFFDIO_ZEROPAGE ,
>  or
> -.B UFFDIO_ZEROPAGE
> +.B UFFDIO_CONTINUE
>  .BR ioctl (2)
>  operations to resolve the page fault.
>  .PP
> @@ -305,6 +318,59 @@ should have the flag
>  cleared upon the faulted page or range.
>  .PP
>  Write-protect mode supports only private anonymous memory.
> +.\"
> +.SS Userfaultfd minor fault mode (since 5.13)
> +Since Linux 5.13,
> +userfaultfd supports minor fault mode.
> +In this mode,
> +fault messages are produced not for major faults
> +(where the page was missing),
> +but rather for minor faults,
> +where a page exists in the page cache,
> +but the page table entries are not yet present.
> +The user needs to first check availability of this feature using the
> +.B UFFDIO_API
> +ioctl with the appropriate feature bits set before using this feature:
> +.B UFFD_FEATURE_MINOR_HUGETLBFS
> +since Linux 5.13,
> +or
> +.B UFFD_FEATURE_MINOR_SHMEM
> +since Linux 5.14.
> +.PP
> +To register with userfaultfd minor fault mode,
> +the user needs to initiate the
> +.B UFFDIO_REGISTER
> +ioctl with mode
> +.B UFFD_REGISTER_MODE_MINOR
> +set.
> +.PP
> +When a minor fault occurs,
> +user-space will receive a page-fault notification
> +whose
> +.I uffd_msg.pagefault.flags
> +will have the
> +.B UFFD_PAGEFAULT_FLAG_MINOR
> +flag set.
> +.PP
> +To resolve a minor page fault,
> +the handler should decide whether or not
> +the existing page contents need to be modified first.
> +If so,
> +this should be done in-place via a second,
> +non-userfaultfd-registered mapping
> +to the same backing page
> +(e.g., by mapping the shmem or hugetlbfs file twice).
> +Once the page is considered "up to date",
> +the fault can be resolved by initiating an
> +.B UFFDIO_CONTINUE
> +ioctl,
> +which installs the page table entries and
> +(by default)
> +wakes up the faulting thread(s).
> +.PP
> +Minor fault mode supports only hugetlbfs-backed (since Linux 5.13)
> +and shmem-backed (since Linux 5.14) memory.
> +.\"
>  .SS Reading from the userfaultfd structure
>  Each
>  .BR read (2)
> @@ -443,19 +509,20 @@ For
>  the following flag may appear:
>  .RS
>  .TP
> -.B UFFD_PAGEFAULT_FLAG_WRITE
> -If the address is in a range that was registered with the
> -.B UFFDIO_REGISTER_MODE_MISSING
> -flag (see
> -.BR ioctl_userfaultfd (2))
> -and this flag is set, this a write fault;
> -otherwise it is a read fault.
> +.B UFFD_PAGEFAULT_FLAG_WP
> +If this flag is set, then the fault was a write-protect fault.
> +.TP
> +.B UFFD_PAGEFAULT_FLAG_MINOR
> +If this flag is set, then the fault was a minor fault.
>  .TP
> +.B UFFD_PAGEFAULT_FLAG_WRITE
> +If this flag is set, then the fault was a write fault.
> +.PP
> +If neither
>  .B UFFD_PAGEFAULT_FLAG_WP
> -If the address is in a range that was registered with the
> -.B UFFDIO_REGISTER_MODE_WP
> -flag, when this bit is set, it means it is a write-protect fault.
> -Otherwise it is a page-missing fault.
> +nor
> +.B UFFD_PAGEFAULT_FLAG_MINOR
> +are set, then the fault was a missing fault.
>  .RE
>  .TP
>  .I pagefault.feat.pid
> --
> 2.35.1.1178.g4f1659d476-goog
>
