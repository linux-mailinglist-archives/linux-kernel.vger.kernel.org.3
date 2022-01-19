Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FA34939B4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 12:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354238AbiASLiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 06:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354216AbiASLit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 06:38:49 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE68C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 03:38:49 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id m90so3964157uam.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 03:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xpBnSyjweN7WnT6qOco7rvIixglPL3EZOP790L3l2OQ=;
        b=nqSYS3nslqfVnD9HrnEY2yC+c+62Z0xBRFtV/SPgbCcgkoRJEwN9gdSFO+xyUnEsh9
         odi2q7y1GpFzRGEaGc/JS0wVtFdj7vZqD1bR1uO8r5TIx4QVqybZlfbzFGUV3C4sz1rc
         TyCayMCdkyJ2qoXlnPCFgcKVbTxtn+aeRcW8QztTEJrWWwTTgZ9wEd0ilZtIMq37P3yH
         NkThHsYu0noq7OL52aM8/USIirpAw/g0hz3uiQGFH1jif+W4iJQFPBNlW8jUFqW9gSTD
         fbkK7/4xxlXfxh/Zo+T2buwivtueVJAi4Il1wyidlqz+yHltFKYuH9h+5Q/PjMaqv+jU
         ivLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xpBnSyjweN7WnT6qOco7rvIixglPL3EZOP790L3l2OQ=;
        b=nJ5elzuZmiAB342mItSgLiDWHpzTaHVxWCbnDNMOkziKqZoerwJGLzdJl+CexS2RBv
         Sr/IDWy5aDdQ0x+czCaPkefrZ/28n+5NVICAYjfQs5iinYQKDg4DIu0PHXnLRAlpoiqN
         ZY7aAFI+z2frXtGrq8PdtzIgfuxYrVaZG13bJoha7v1rp5J6h1CHAYSyuCv+1r/Tg+aS
         5lZx2mg3ruGYcGwoZlWfns6wisLB1RzoUz+K5ceTQ2V5d3x71rcKF7ePtKbRWyxenro2
         rUA+YRvtbl4D2RWuTLYf+r9aFbbVZ6y3Us8pGF0AGsONCYYapyUt67byRAggSfh7+/od
         +7ow==
X-Gm-Message-State: AOAM532Jb7XQ850ubcdccNVFsSiRpj35/w/ld8+IMePvDs38zoDB4NSM
        vi/k3lWFYFao8OCLhviVcuWMPjgAA2u9ij1za4LWtvSR+6c=
X-Google-Smtp-Source: ABdhPJydS2dd4midyt1oITSx41wQnXRpFBWM6yazmZEuLEwIaUX7GL8/g9AwJ01SS7myzs7e2VSE6BASG8EwAJOLma0=
X-Received: by 2002:a67:c28b:: with SMTP id k11mr9195420vsj.25.1642592328107;
 Wed, 19 Jan 2022 03:38:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1642526745.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1642526745.git.khalid.aziz@oracle.com>
From:   Mark Hemment <markhemm@googlemail.com>
Date:   Wed, 19 Jan 2022 11:38:37 +0000
Message-ID: <CANe_+UhrcQO0mwB2KJtm69+MDVJuD-r5Cbyqt8AkWdtfY55CCQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        longpeng2@huawei.com, arnd@arndb.de, dave.hansen@linux.intel.com,
        david@redhat.com, rppt@kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2022 at 21:20, Khalid Aziz <khalid.aziz@oracle.com> wrote:
>
> Page tables in kernel consume some of the memory and as long as
> number of mappings being maintained is small enough, this space
> consumed by page tables is not objectionable. When very few memory
> pages are shared between processes, the number of page table entries
> (PTEs) to maintain is mostly constrained by the number of pages of
> memory on the system. As the number of shared pages and the number
> of times pages are shared goes up, amount of memory consumed by page
> tables starts to become significant.
>
> Some of the field deployments commonly see memory pages shared
> across 1000s of processes. On x86_64, each page requires a PTE that
> is only 8 bytes long which is very small compared to the 4K page
> size. When 2000 processes map the same page in their address space,
> each one of them requires 8 bytes for its PTE and together that adds
> up to 8K of memory just to hold the PTEs for one 4K page. On a
> database server with 300GB SGA, a system carsh was seen with
> out-of-memory condition when 1500+ clients tried to share this SGA
> even though the system had 512GB of memory. On this server, in the
> worst case scenario of all 1500 processes mapping every page from
> SGA would have required 878GB+ for just the PTEs. If these PTEs
> could be shared, amount of memory saved is very significant.
>
> This is a proposal to implement a mechanism in kernel to allow
> userspace processes to opt into sharing PTEs. The proposal is to add
> a new system call - mshare(), which can be used by a process to
> create a region (we will call it mshare'd region) which can be used
> by other processes to map same pages using shared PTEs. Other
> process(es), assuming they have the right permissions, can then make
> the mashare() system call to map the shared pages into their address
> space using the shared PTEs.  When a process is done using this
> mshare'd region, it makes a mshare_unlink() system call to end its
> access. When the last process accessing mshare'd region calls
> mshare_unlink(), the mshare'd region is torn down and memory used by
> it is freed.
>
>
> API Proposal
> ============
>
> The mshare API consists of two system calls - mshare() and mshare_unlink()
>
> --
> int mshare(char *name, void *addr, size_t length, int oflags, mode_t mode)
>
> mshare() creates and opens a new, or opens an existing mshare'd
> region that will be shared at PTE level. "name" refers to shared object
> name that exists under /sys/fs/mshare. "addr" is the starting address
> of this shared memory area and length is the size of this area.
> oflags can be one of:
>
> - O_RDONLY opens shared memory area for read only access by everyone
> - O_RDWR opens shared memory area for read and write access
> - O_CREAT creates the named shared memory area if it does not exist
> - O_EXCL If O_CREAT was also specified, and a shared memory area
>   exists with that name, return an error.
>
> mode represents the creation mode for the shared object under
> /sys/fs/mshare.
>
> mshare() returns an error code if it fails, otherwise it returns 0.
>
> PTEs are shared at pgdir level and hence it imposes following
> requirements on the address and size given to the mshare():
>
> - Starting address must be aligned to pgdir size (512GB on x86_64)
> - Size must be a multiple of pgdir size
> - Any mappings created in this address range at any time become
>   shared automatically
> - Shared address range can have unmapped addresses in it. Any access
>   to unmapped address will result in SIGBUS
>
> Mappings within this address range behave as if they were shared
> between threads, so a write to a MAP_PRIVATE mapping will create a
> page which is shared between all the sharers. The first process that
> declares an address range mshare'd can continue to map objects in
> the shared area. All other processes that want mshare'd access to
> this memory area can do so by calling mshare(). After this call, the
> address range given by mshare becomes a shared range in its address
> space. Anonymous mappings will be shared and not COWed.
>
> A file under /sys/fs/mshare can be opened and read from. A read from
> this file returns two long values - (1) starting address, and (2)
> size of the mshare'd region.
>
> --
> int mshare_unlink(char *name)
>
> A shared address range created by mshare() can be destroyed using
> mshare_unlink() which removes the  shared named object. Once all
> processes have unmapped the shared object, the shared address range
> references are de-allocated and destroyed.
>
> mshare_unlink() returns 0 on success or -1 on error.
>
>
> Example Code
> ============
>
> Snippet of the code that a donor process would run looks like below:
>
> -----------------
>         addr = mmap((void *)TB(2), GB(512), PROT_READ | PROT_WRITE,
>                         MAP_SHARED | MAP_ANONYMOUS, 0, 0);
>         if (addr == MAP_FAILED)
>                 perror("ERROR: mmap failed");
>
>         err = syscall(MSHARE_SYSCALL, "testregion", (void *)TB(2),
>                         GB(512), O_CREAT|O_RDWR|O_EXCL, 600);
>         if (err < 0) {
>                 perror("mshare() syscall failed");
>                 exit(1);
>         }
>
>         strncpy(addr, "Some random shared text",
>                         sizeof("Some random shared text"));
> -----------------
>
> Snippet of code that a consumer process would execute looks like:
>
> -----------------
>         fd = open("testregion", O_RDONLY);
>         if (fd < 0) {
>                 perror("open failed");
>                 exit(1);
>         }
>
>         if ((count = read(fd, &mshare_info, sizeof(mshare_info)) > 0))
>                 printf("INFO: %ld bytes shared at addr %lx \n",
>                                 mshare_info[1], mshare_info[0]);
>         else
>                 perror("read failed");
>
>         close(fd);
>
>         addr = (char *)mshare_info[0];
>         err = syscall(MSHARE_SYSCALL, "testregion", (void *)mshare_info[0],
>                         mshare_info[1], O_RDWR, 600);
>         if (err < 0) {
>                 perror("mshare() syscall failed");
>                 exit(1);
>         }
>
>         printf("Guest mmap at %px:\n", addr);
>         printf("%s\n", addr);
>         printf("\nDone\n");
>
>         err = syscall(MSHARE_UNLINK_SYSCALL, "testregion");
>         if (err < 0) {
>                 perror("mshare_unlink() failed");
>                 exit(1);
>         }
> -----------------
...
Hi Khalid,

The proposed mshare() appears to be similar to POSIX shared memory,
but with two extra (related) attributes;
a) Internally, uses shared page tables.
b) Shared memory is mapped at same address for all users.

Rather than introduce two new system calls, along with /sys/ file to
communicate global addresses, could mshare() be built on top of shmem
API?  Thinking of something like the below;
1) For shm_open(3), add a new oflag to indicate the properties needed
for mshare() (say, O_SHARED_PTE - better name?)
2) For ftruncate(2), objects created with O_SHARED_PTE are constrained
in the sizes which can be set.
3) For mmap(2), NULL is always passed as the address for O_SHARED_PTE
objects.  On first mmap()ing an appropiate address is assigned,
otherwise the current 'global' address is used.
4) shm_unlink(3) destroys the object when last reference is dropped.

For 3), might be able to weaken the NULL requirement and validate a
given address on first mapping to ensure it is correctly aligned.
shm_open(3) sets FD_CLOEXEC on the file descriptor, which might not be
the default behaviour you require.

Internally, the handling of mshare()/O_SHARED_PTE memory might be
sufficiently different to shmem that there is not much code sharing
between the two (I haven't thought this through, but the object
naming/refcounting should be similiar), but using shmem would be a
familiar API.

Any thoughts?

Cheers,
Mark
