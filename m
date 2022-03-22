Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C3E4E443F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 17:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236508AbiCVQd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 12:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbiCVQdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:33:53 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9627089300
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 09:32:23 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e18so3868718ilr.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 09:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6XFrkUqilSisWIfvcCS//vd/VqvVcQbmQau1/MQLBq0=;
        b=X+T9S624IO/gTOnYsGoO1Wg8gPmh7jSn6CKH3kVTLLb/WRim4o5iWzuGF/tKRjXYdh
         1mcb3AunHf/7L6gSPYPGketrJ9ZACmQkEHxP9+9GrtOSwdwjPJJNoiASWlJYdsApjVV7
         bcsplE8O/O0R6cDz3Mn7pb2KGz4NhK0kiYBhYQxTyUMbjRJeR5swWX0qfdbz54RDm4OD
         FsWJTjCg1Jey+xwgEVP+c4EwohhJg+KZ/zvI7FUsEbKyKLJO2DyjEjiSygewP/ljhFAG
         adq9sbyZ1hUEr4IemVhMgme5g0VduLa7ByJP9fx3NToskf/VxXfMIBel9PRDkAtjN3in
         OcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6XFrkUqilSisWIfvcCS//vd/VqvVcQbmQau1/MQLBq0=;
        b=cptrTQMyHnZsvltV7sAKjf7ZVOGqa9MJYcymBD/YsyROMx3Z1BKCvc0shbsCV4/VFc
         o6ogOiMEUNJ4kHwwgb26tUnpYyMSxmRnO3QoHT3hf/8GxT6yMNRRY4QIcjpivacCD2Qi
         87ikPqR9zoJoRLcCVm/ArReIoOt9RyCzvjEUnq6dAP7ftqUA3c4uhhTmA0G7c4FM6dmH
         CHqwQwEtPTBqd8oTmvNhgqh8y1tngLgkbwwOLkR6QfH9gQ4w1sPOLrHQhezKDp4W8qUn
         oCFSACKI3JLUqzZVmSL6shIo3oHOxbGqPWEH+v2SDcfcBrkqsw/GrP73QlUL8j8F1s4L
         jrBg==
X-Gm-Message-State: AOAM531oIUXC4Ft06EtoHq7K+rP76Ed6Hyha2F80THQMVP/V9qKiU0uy
        XePpvbnP0wBQvQv/ObTwTzWyQt9hSeLRYjtfx4c+oA==
X-Google-Smtp-Source: ABdhPJwVbs029XbC2NIcp/TwwLnBBI88WNY0K71UwDTtjr4YgJ3tldckDsFNDE+HP3SeoVWTLiN3XtKO5no+ELGQsmw=
X-Received: by 2002:a05:6e02:1a82:b0:2c8:1ce0:6f64 with SMTP id
 k2-20020a056e021a8200b002c81ce06f64mr6471674ilv.239.1647966742642; Tue, 22
 Mar 2022 09:32:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210604195622.1249588-1-axelrasmussen@google.com>
 <CAJHvVcjzi-7Wvrho1LqWiQC2WNbtg0XGf6-JBRcDZS1=banbVA@mail.gmail.com>
 <YQfVRuV2Ab2rlKVI@kernel.org> <1add2552-ea36-12a2-b3b1-6e97f6f84e00@gmail.com>
In-Reply-To: <1add2552-ea36-12a2-b3b1-6e97f6f84e00@gmail.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 22 Mar 2022 09:31:46 -0700
Message-ID: <CAJHvVcggpJ7hE8VbhL09mT0=eJ5C+iH1poi_-V2v_dMLjSbVnQ@mail.gmail.com>
Subject: Re: [PATCH v2] ioctl_userfaultfd.2, userfaultfd.2: add minor fault mode
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-man@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 2, 2021 at 5:21 AM Alejandro Colomar (man-pages)
<alx.manpages@gmail.com> wrote:
>
> Hi Mike, Axel,
>
> On 8/2/21 1:21 PM, Mike Rapoport wrote:
> > (added man-pages maintainers)
>
> Thanks!  If I'm not CCed, I may not notice the email, depending on the
> traffic of the lists, and the amount of time I have ;)
>
> >
> > On Tue, Jul 27, 2021 at 09:32:34AM -0700, Axel Rasmussen wrote:
> >> Any remaining issues with this patch? I just realized today it was
> >> never merged. 5.13 (which contains this new feature) was released some
> >> weeks ago.
>
> Please see some minor formatting issues I commented below.
> Other than that, it looks good to me.
>
> Thanks,
>
> Alex
>
> >>
> >> On Fri, Jun 4, 2021 at 12:56 PM Axel Rasmussen <axelrasmussen@google.c=
om> wrote:
> >>>
> >>> Userfaultfd minor fault mode is supported starting from Linux 5.13.
> >>>
> >>> This commit adds a description of the new mode, as well as the new io=
ctl
> >>> used to resolve such faults. The two go hand-in-hand: one can't resol=
ve
> >>> a minor fault without continue, and continue can't be used to resolve
> >>> any other kind of fault.
> >>>
> >>> This patch covers just the hugetlbfs implementation (in 5.13). Suppor=
t
> >>> for shmem is forthcoming, but as it has not yet made it into a kernel
> >>> release candidate, it will be added in a future commit.
> >>>
> >>> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> >>> ---
> >>>   man2/ioctl_userfaultfd.2 | 125 ++++++++++++++++++++++++++++++++++++=
---
> >>>   man2/userfaultfd.2       |  79 ++++++++++++++++++++-----
> >>>   2 files changed, 182 insertions(+), 22 deletions(-)
> >>>
> >>> diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
> >>> index 504f61d4b..7b990c24a 100644
> >>> --- a/man2/ioctl_userfaultfd.2
> >>> +++ b/man2/ioctl_userfaultfd.2
> >>> @@ -214,6 +214,10 @@ memory accesses to the regions registered with u=
serfaultfd.
> >>>   If this feature bit is set,
> >>>   .I uffd_msg.pagefault.feat.ptid
> >>>   will be set to the faulted thread ID for each page-fault message.
> >>> +.TP
> >>> +.BR UFFD_FEATURE_MINOR_HUGETLBFS " (since Linux 5.13)"
> >>> +If this feature bit is set, the kernel supports registering userfaul=
tfd ranges
> >>> +in minor mode on hugetlbfs-backed memory areas.
>
> See the folowing extract from man-pages(7):
>
>     Use semantic newlines
>         In the source of a manual page,  new  sentences  should  be
>         started  on  new  lines, and long sentences should be split
>         into lines at clause breaks  (commas,  semicolons,  colons,
>         and  so on).  This convention, sometimes known as "semantic
>         newlines", makes it easier to see the  effect  of  patches,
>         which often operate at the level of individual sentences or
>         sentence clauses.
>
> A trick to check if some text is correct at first glance, is that the
> following regex should rarely match:
> [,;:.] \+\w
>
> Multi-sentence parenthetical expressions should also go on separate
> lines normally.
>
> I'd for example break the above text into:
>
> [
> If this feature bit is set,
> the kernel supports registering userfaultfd ranges
> in minor mode on hugetlbfs-backed memory areas
> ]
>
> Note the break after the comma, and another break at a sensible point
> (you already did that one correctly in this example, but some below don't=
).
>
>
> >>>   .PP
> >>>   The returned
> >>>   .I ioctls
> >>> @@ -240,6 +244,11 @@ operation is supported.
> >>>   The
> >>>   .B UFFDIO_WRITEPROTECT
> >>>   operation is supported.
> >>> +.TP
> >>> +.B 1 << _UFFDIO_CONTINUE
> >>> +The
> >>> +.B UFFDIO_CONTINUE
> >>> +operation is supported.
> >>>   .PP
> >>>   This
> >>>   .BR ioctl (2)
> >>> @@ -278,14 +287,8 @@ by the current kernel version.
> >>>   (Since Linux 4.3.)
> >>>   Register a memory address range with the userfaultfd object.
> >>>   The pages in the range must be "compatible".
> >>> -.PP
> >>> -Up to Linux kernel 4.11,
> >>> -only private anonymous ranges are compatible for registering with
> >>> -.BR UFFDIO_REGISTER .
> >>> -.PP
> >>> -Since Linux 4.11,
> >>> -hugetlbfs and shared memory ranges are also compatible with
> >>> -.BR UFFDIO_REGISTER .
> >>> +Please refer to the list of register modes below for the compatible =
memory
> >>> +backends for each mode.
>
> Regarding semantic newlines mentioned above:
>
> Here for example, a more sensible point to break the line would be just
> after (or maybe before, up to you) the first "for".
>
> >>>   .PP
> >>>   The
> >>>   .I argp
> >>> @@ -324,9 +327,16 @@ the specified range:
> >>>   .TP
> >>>   .B UFFDIO_REGISTER_MODE_MISSING
> >>>   Track page faults on missing pages.
> >>> +Since Linux 4.3, only private anonymous ranges are compatible.
> >>> +Since Linux 4.11, hugetlbfs and shared memory ranges are also compat=
ible.
> >>>   .TP
> >>>   .B UFFDIO_REGISTER_MODE_WP
> >>>   Track page faults on write-protected pages.
> >>> +Since Linux 5.7, only private anonymous ranges are compatible.
> >>> +.TP
> >>> +.B UFFDIO_REGISTER_MODE_MINOR
> >>> +Track minor page faults.
> >>> +Since Linux 5.13, only hugetlbfs ranges are compatible.
> >>>   .PP
> >>>   If the operation is successful, the kernel modifies the
> >>>   .I ioctls
> >>> @@ -735,6 +745,105 @@ or not registered with userfaultfd write-protec=
t mode.
> >>>   .TP
> >>>   .B EFAULT
> >>>   Encountered a generic fault during processing.
> >>> +.\"
> >>> +.SS UFFDIO_CONTINUE
> >>> +(Since Linux 5.13.)
> >>> +Resolve a minor page fault by installing page table entries for exis=
ting pages
> >>> +in the page cache.
> >>> +.PP
> >>> +The
> >>> +.I argp
> >>> +argument is a pointer to a
> >>> +.I uffdio_continue
> >>> +structure as shown below:
> >>> +.PP
> >>> +.in +4n
> >>> +.EX
> >>> +struct uffdio_continue {
> >>> +    struct uffdio_range range; /* Range to install PTEs for and cont=
inue */
> >>> +    __u64 mode;                /* Flags controlling the behavior of =
continue */
> >>> +    __s64 mapped;              /* Number of bytes mapped, or negated=
 error */
> >>> +};
> >>> +.EE
> >>> +.in
> >>> +.PP
> >>> +The following value may be bitwise ORed in
> >>> +.IR mode
> >>> +to change the behavior of the
> >>> +.B UFFDIO_CONTINUE
> >>> +operation:
> >>> +.TP
> >>> +.B UFFDIO_CONTINUE_MODE_DONTWAKE
> >>> +Do not wake up the thread that waits for page-fault resolution.
> >>> +.PP
> >>> +The
> >>> +.I mapped
> >>> +field is used by the kernel to return the number of bytes
> >>> +that were actually mapped, or an error in the same manner as
> >>> +.BR UFFDIO_COPY .
> >>> +If the value returned in the
> >>> +.I mapped
> >>> +field doesn't match the value that was specified in
> >>> +.IR range.len ,
> >>> +the operation fails with the error
> >>> +.BR EAGAIN .
> >>> +The
> >>> +.I mapped
> >>> +field is output-only;
> >>> +it is not read by the
> >>> +.B UFFDIO_CONTINUE
> >>> +operation.
> >>> +.PP
> >>> +This
> >>> +.BR ioctl (2)
> >>> +operation returns 0 on success.
> >>> +In this case, the entire area was mapped.
> >>> +On error, \-1 is returned and
> >>> +.I errno
> >>> +is set to indicate the error.
> >>> +Possible errors include:
> >>> +.TP
> >>> +.B EAGAIN
> >>> +The number of bytes mapped (i.e., the value returned in the
> >>> +.I mapped
> >>> +field) does not equal the value that was specified in the
> >>> +.I range.len
> >>> +field.
> >>> +.TP
> >>> +.B EINVAL
> >>> +Either
> >>> +.I range.start
> >>> +or
> >>> +.I range.len
> >>> +was not a multiple of the system page size; or
> >>> +.I range.len
> >>> +was zero; or the range specified was invalid.
> >>> +.TP
> >>> +.B EINVAL
> >>> +An invalid bit was specified in the
> >>> +.IR mode
> >>> +field.
> >>> +.TP
> >>> +.B EEXIST
> >>> +One or more pages were already mapped in the given range.
> >>> +.TP
> >>> +.B ENOENT
> >>> +The faulting process has changed its virtual memory layout simultane=
ously with
> >>> +an outstanding
> >>> +.B UFFDIO_CONTINUE
> >>> +operation.
> >>> +.TP
> >>> +.B ENOMEM
> >>> +Allocating memory needed to setup the page table mappings failed.
> >>> +.TP
> >>> +.B EFAULT
> >>> +No existing page could be found in the page cache for the given rang=
e.
> >>> +.TP
> >>> +.BR ESRCH
> >>> +The faulting process has exited at the time of a
> >>> +.B UFFDIO_CONTINUE
> >>> +operation.
> >>> +.\"
> >>>   .SH RETURN VALUE
> >>>   See descriptions of the individual operations, above.
> >>>   .SH ERRORS
> >>> diff --git a/man2/userfaultfd.2 b/man2/userfaultfd.2
> >>> index 593c189d8..07f53c6ff 100644
> >>> --- a/man2/userfaultfd.2
> >>> +++ b/man2/userfaultfd.2
> >>> @@ -78,7 +78,7 @@ all memory ranges that were registered with the obj=
ect are unregistered
> >>>   and unread events are flushed.
> >>>   .\"
> >>>   .PP
> >>> -Userfaultfd supports two modes of registration:
> >>> +Userfaultfd supports three modes of registration:
> >>>   .TP
> >>>   .BR UFFDIO_REGISTER_MODE_MISSING " (since 4.10)"
> >>>   When registered with
> >>> @@ -92,6 +92,18 @@ or an
> >>>   .B UFFDIO_ZEROPAGE
> >>>   ioctl.
> >>>   .TP
> >>> +.BR UFFDIO_REGISTER_MODE_MINOR " (since 5.13)"
> >>> +When registered with
> >>> +.B UFFDIO_REGISTER_MODE_MINOR
> >>> +mode, user-space will receive a page-fault notification
>
> s/user-space/user space/
>
> See the following extract from man-pages(7):
>
>     Preferred terms
>         The  following  table  lists some preferred terms to use in
>         man pages, mainly to ensure consistency across pages.
>
>         Term                 Avoid using              Notes
>         =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80
>         [...]
>         user space           userspace
>
> However, when user space is used as an adjective, per the usual English
> rules, we write "user-space".  Example: "a user-space program".

100% agreed that "user space" is more correct, but this man page
already has many instances of "user-space" in it. I'd suggest we
either fix all of them, or just follow the existing convention within
this page.

How about, leaving this as-is for this patch, to keep the diff tidy,
and I can send a follow-up patch to fix all the instances of this in
this page?

>
> >>> +when a minor page fault occurs.
> >>> +That is, when a backing page is in the page cache, but
> >>> +page table entries don't yet exist.
> >>> +The faulted thread will be stopped from execution until the page fau=
lt is
> >>> +resolved from user-space by an
> >>> +.B UFFDIO_CONTINUE
> >>> +ioctl.
> >>> +.TP
> >>>   .BR UFFDIO_REGISTER_MODE_WP " (since 5.7)"
> >>>   When registered with
> >>>   .B UFFDIO_REGISTER_MODE_WP
> >>> @@ -212,9 +224,10 @@ a page fault occurring in the requested memory r=
ange, and satisfying
> >>>   the mode defined at the registration time, will be forwarded by the=
 kernel to
> >>>   the user-space application.
> >>>   The application can then use the
> >>> -.B UFFDIO_COPY
> >>> +.B UFFDIO_COPY ,
> >>> +.B UFFDIO_ZEROPAGE ,
> >>>   or
> >>> -.B UFFDIO_ZEROPAGE
> >>> +.B UFFDIO_CONTINUE
> >>>   .BR ioctl (2)
> >>>   operations to resolve the page fault.
> >>>   .PP
> >>> @@ -318,6 +331,43 @@ should have the flag
> >>>   cleared upon the faulted page or range.
> >>>   .PP
> >>>   Write-protect mode supports only private anonymous memory.
> >>> +.\"
> >>> +.SS Userfaultfd minor fault mode (since 5.13)
> >>> +Since Linux 5.13, userfaultfd supports minor fault mode.
> >>> +In this mode, fault messages are produced not for major faults (wher=
e the
> >>> +page was missing), but rather for minor faults, where a page exists =
in the page
> >>> +cache, but the page table entries are not yet present.
> >>> +The user needs to first check availability of this feature using
> >>> +.B UFFDIO_API
> >>> +ioctl against the feature bit
> >>> +.B UFFD_FEATURE_MINOR_HUGETLBFS
> >>> +before using this feature.
> >>> +.PP
> >>> +To register with userfaultfd minor fault mode, the user needs to ini=
tiate the
> >>> +.B UFFDIO_REGISTER
> >>> +ioctl with mode
> >>> +.B UFFD_REGISTER_MODE_MINOR
> >>> +set.
> >>> +.PP
> >>> +When a minor fault occurs, user-space will receive a page-fault noti=
fication
> >>> +whose
> >>> +.I uffd_msg.pagefault.flags
> >>> +will have the
> >>> +.B UFFD_PAGEFAULT_FLAG_MINOR
> >>> +flag set.
> >>> +.PP
> >>> +To resolve a minor page fault, the handler should decide whether or =
not the
> >>> +existing page contents need to be modified first.
> >>> +If so, this should be done in-place via a second, non-userfaultfd-re=
gistered
> >>> +mapping to the same backing page (e.g., by mapping the hugetlbfs fil=
e twice).
> >>> +Once the page is considered "up to date", the fault can be resolved =
by
> >>> +initiating an
> >>> +.B UFFDIO_CONTINUE
> >>> +ioctl, which installs the page table entries and (by default) wakes =
up the
> >>> +faulting thread(s).
> >>> +.PP
> >>> +Minor fault mode supports only hugetlbfs-backed memory.
> >>> +.\"
> >>>   .SS Reading from the userfaultfd structure
> >>>   Each
> >>>   .BR read (2)
> >>> @@ -456,19 +506,20 @@ For
> >>>   the following flag may appear:
> >>>   .RS
> >>>   .TP
> >>> -.B UFFD_PAGEFAULT_FLAG_WRITE
> >>> -If the address is in a range that was registered with the
> >>> -.B UFFDIO_REGISTER_MODE_MISSING
> >>> -flag (see
> >>> -.BR ioctl_userfaultfd (2))
> >>> -and this flag is set, this a write fault;
> >>> -otherwise it is a read fault.
> >>> +.B UFFD_PAGEFAULT_FLAG_WP
> >>> +If this flag is set, then the fault was a write-protect fault.
> >>>   .TP
> >>> +.B UFFD_PAGEFAULT_FLAG_MINOR
> >>> +If this flag is set, then the fault was a minor fault.
> >>> +.TP
> >>> +.B UFFD_PAGEFAULT_FLAG_WRITE
> >>> +If this flag is set, then the fault was a write fault.
> >>> +.HP
>
> See the following extract from groff_man(7):
>
>     Deprecated features
>         Use of the following is discouraged.
>
>         [...]
>
>         .HP [indent]
>                Set up a paragraph with a hanging left  indentation.
>                The  indent argument, if present, is handled as with
>                .TP.
>
>                Use of this presentation=E2=80=90level macro is  deprecate=
d.
>                While it is universally portable to legacy Unix sys=E2=80=
=90
>                tems, a hanging indentation cannot be expressed nat=E2=80=
=90
>                urally  under HTML, and many HTML=E2=80=90based manual vie=
w=E2=80=90
>                ers simply interpret it as a starter  for  a  normal
>                paragraph.  Thus, any information or distinction you
>                tried to express with the indentation may be lost.
>
> I'd just use .PP here, I think.
>
>
> >>> +If neither
> >>>   .B UFFD_PAGEFAULT_FLAG_WP
> >>> -If the address is in a range that was registered with the
> >>> -.B UFFDIO_REGISTER_MODE_WP
> >>> -flag, when this bit is set, it means it is a write-protect fault.
> >>> -Otherwise it is a page-missing fault.
> >>> +nor
> >>> +.B UFFD_PAGEFAULT_FLAG_MINOR
> >>> +are set, then the fault was a missing fault.
> >>>   .RE
> >>>   .TP
> >>>   .I pagefault.feat.pid
> >>> --
> >>> 2.32.0.rc1.229.g3e70b5a671-goog
> >>>
> >>
> >
>
>
> --
> Alejandro Colomar
> Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
> http://www.alejandro-colomar.es/
