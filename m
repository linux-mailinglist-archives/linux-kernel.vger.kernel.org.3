Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D659F5089A4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379124AbiDTNtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379053AbiDTNs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:48:57 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60F921E1F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:46:09 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d14so965398qtw.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GosYDcJgtMrsftMvH3Y58AihAnlBxVmr34TSBnjx9ig=;
        b=4L2nW6v25/9Iw/fDPrW7D1VyCQ1X6RF0In68PidB2OAVPhIH2BwYxs53oVY1gCR8FK
         81gD526lZt/oeg5x1g3+/Zw3Adlu89tECD0UckefNuYemIgWnYwPo6Z9AUC+Llst09CX
         EIZf8pHm+hHO+4diZX/C1cbkDcKQ7d+1UgGhrW5uYv/eo9IWdQtdoF/ESnCVSR+X4aEv
         r/GxqIH5A1w+YgVmOc3S9tG1iXGmigwV6juvCpT8lG2ovgD1bf+kBVK3itmvgrEU5nTi
         v/DKLmVQPGqc6JxwEBS8opR6//Qhf6p/BcHGQEl6WzQTjqAfqiGktXfpN4Xs7SLliEKb
         IrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GosYDcJgtMrsftMvH3Y58AihAnlBxVmr34TSBnjx9ig=;
        b=6eDAd28vpXaH+wiINKK3oxfWzrI+1TxJBUxbiUeQymABDOpNh04FECj9bkFWVAuvB8
         hLQMRLvJQXzE7kLuhhFmDNj4lBTAtjWupexZk3Zx+7xyZhnDughjdJvbXo6WzQ+h71GH
         2XhgQqEM3dO6H4hEjl3daEfRHcbQMUNmT9QOEY1NaWWXaFsThW/jaHi73KsVpC+0piRS
         u7D/9hOkivsE36USBiHpx3pZbhKU6H3lWRhsfh1aZ9j2yvgYd+Tr8PqGegZxmyXNwjA8
         i3yX4pA3+qKrFt4ti7xC7Xp0rruBblff9SoA9anlkle3F0Nn3+Wi6tVBFKZEbsKhQRAd
         B/Pg==
X-Gm-Message-State: AOAM5300fcEzeR/sTt84c00+fe2bdskipVVrYT8SP5M2ON52BoIMgOh/
        QgNpH1CDLo03+yXItW2tDrDFJw==
X-Google-Smtp-Source: ABdhPJzWkRKYL9NG9HhkssRbVKMx6I0rU+4Y+C9XeoMWvhciqnlXtZWvpXG872CNOWNDuy/uATGsAA==
X-Received: by 2002:a05:622a:1213:b0:2e0:5fe8:542a with SMTP id y19-20020a05622a121300b002e05fe8542amr13790687qtx.347.1650462368804;
        Wed, 20 Apr 2022 06:46:08 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id bp37-20020a05622a1ba500b002f1f9a0d79asm1736733qtb.11.2022.04.20.06.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 06:46:08 -0700 (PDT)
Date:   Wed, 20 Apr 2022 09:46:07 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH v8 22/23] mm: Enable PTE markers by default
Message-ID: <YmAOn75O7zOOioXQ@cmpxchg.org>
References: <20220405014646.13522-1-peterx@redhat.com>
 <20220405014929.15158-1-peterx@redhat.com>
 <Yl7RrKV5mXtNAAzi@cmpxchg.org>
 <Yl8UmWQodLX+JkZ7@xz-m1.local>
 <Yl8YE+w+OWz5RNOL@cmpxchg.org>
 <Yl8bYKOJGW2py7Q0@xz-m1.local>
 <Yl8ojDwxsD/wqWM4@cmpxchg.org>
 <Yl8xKh9Dc+nPr30a@xz-m1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl8xKh9Dc+nPr30a@xz-m1.local>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 06:01:14PM -0400, Peter Xu wrote:
> On Tue, Apr 19, 2022 at 05:24:28PM -0400, Johannes Weiner wrote:
> > On Tue, Apr 19, 2022 at 04:28:16PM -0400, Peter Xu wrote:
> > > On Tue, Apr 19, 2022 at 04:14:11PM -0400, Johannes Weiner wrote:
> > > > On Tue, Apr 19, 2022 at 03:59:21PM -0400, Peter Xu wrote:
> > > > > @@ -910,16 +910,16 @@ config ANON_VMA_NAME
> > > > Btw, this doesn't do much without userfaultfd being enabled in
> > > > general, right?
> > > 
> > > So far yes, but I'm thinking there can be potential other users of
> > > PTE_MARKERS from mm world.  The most close discussion is on the swap read
> > > failures and this patch proposed by Miaohe:
> > > 
> > > https://lore.kernel.org/lkml/20220416030549.60559-1-linmiaohe@huawei.com/
> > >
> > > So I hope we can still keep them around here under mm/ if possible, and
> > > from the gut feeling it really should..
> > 
> > Agreed, mm/ seems a good fit for PTE_MARKER.
> > 
> > If it's invisible and gets selected as needed, it's less of a concern,
> > IMO. I'm somewhat worried about when and how the user-visible options
> > show up right now, though...
> > 
> > > > Would it make sense to have it next to 'config USERFAULTFD' as a
> > > > sub-option?
> > > 
> > > Yes another good question. :)
> > > 
> > > IIUC CONFIG_USERFAULTFD resides in init/Kconfig because it introduces a new
> > > syscall.  Same to the rest of the bits for uffd since then, namely:
> > > 
> > >   - USERFAULTFD_WP
> > >   - USERFAULTFD_MINOR
> > > 
> > > What I am thinking now is the other way round of your suggestion: whether
> > > we should move most of them out, at least the _WP and _MINOR configs into
> > > mm/?  Because IMHO they are really pure mm ideas and they're irrelevant to
> > > syscalls and init.
> > 
> > I'm thinking the MM submenu would probably be a better fit for all
> > user-visible userfaultfd options, including the syscall. Like you say,
> > it's an MM concept.
> > 
> > But if moving the syscall knob out from init isn't popular, IMO it
> > would be better to add the new WP option to init as well. This ensures
> > that when somebody selects userfaultfd, they also see the relevant
> > suboptions and don't have to chase them down across multiple submenus.
> > 
> > Conversely, they should also have the necessary depend clauses so that
> > suboptions aren't visible without the main feature. E.g. it asked me
> > for userfaultd options even though I have CONFIG_USERFAULTFD=n.
> 
> Hmm, this is a bit weird... since we do have that dependency chain for
> PTE_MARKER_UFFD_WP -> HAVE_ARCH_USERFAULTFD_WP -> USERFAULTFD:
> 
>   in arch/x86/Kconfig:
>   config X86
>           ...
>           select HAVE_ARCH_USERFAULTFD_WP         if X86_64 && USERFAULTFD
> 
>   in mm/Kconfig (with/without the "mm/uffd: Hide PTE_MARKER" patch applied):
>   config PTE_MARKER_UFFD_WP
>           ...
>           depends on HAVE_ARCH_USERFAULTFD_WP
> 
> So logically if !USERFAULTFD we shouldn't see PTE_MARKER_UFFD_WP at all?
> 
> That's also what I got when I tried it out for either !USERFAULTFD on x86,
> or any non-x86 platforms (because there we have !HAVE_ARCH_USERFAULTFD_WP
> constantly irrelevant of USERFAULTFD).  Though I could have missed
> something..

Sorry, it asked me about PTE_MARKERS, and that conclusion got stuck in
my head. Indeed, once that symbol is invisible we should be good.

> > What do you think?
> 
> I don't have a strong preference here, I think it's okay if it's preferred
> that we only put user-visible configs into mm/Kconfig.  It's just that I
> see we have tons of user-invisible configs already in mm/Kconfig, to list
> some:
> 
>         config ARCH_HAS_HUGEPD
>         config MAPPING_DIRTY_HELPERS
>         config KMAP_LOCAL
>         config KMAP_LOCAL_NON_LINEAR_PTE_ARRAY
> 
> But I'm not sure whether it's a rule of thumb somewhere else.

I wasn't objecting to invisible symbols in mm/.

My point was simply that for the user it might be easiest and most
intuitive if userfaultfd and its related suboptions are 1) grouped
together and 2) in the MM submenu.

> At the meantime, I also looked at whether syscall configs are always and
> only be put under init/, and funnily I got:
> 
> $ find . -name Kconfig | xargs grep --color -E "\".*syscall.*\""
> ./init/Kconfig: bool "Enable process_vm_readv/writev syscalls"
> ./init/Kconfig: bool "uselib syscall"
> ./init/Kconfig: bool "sgetmask/ssetmask syscalls support" if EXPERT
> ./init/Kconfig: bool "Sysfs syscall support" if EXPERT
> ./init/Kconfig: bool "open by fhandle syscalls" if EXPERT
> ./init/Kconfig: bool "Enable madvise/fadvise syscalls" if EXPERT
> ./arch/xtensa/Kconfig:  bool "Enable fast atomic syscalls"
> ./arch/xtensa/Kconfig:  bool "Enable spill registers syscall"
> ./arch/powerpc/Kconfig: bool "Support setting protections for 4k subpages (subpage_prot syscall)"
> ./arch/powerpc/Kconfig: bool "Enable filtering of RTAS syscalls"
> ./arch/Kconfig: bool "Support for randomizing kernel stack offset on syscall entry" if EXPERT
> ./arch/s390/Kconfig:    bool "Verify kernel signature during kexec_file_load() syscall"
> ./arch/sh/mm/Kconfig:   bool "Support vsyscall page"
> ./arch/x86/Kconfig:     bool "Enable vsyscall emulation" if EXPERT
> ./arch/x86/Kconfig:     bool "Verify kernel signature during kexec_file_load() syscall"
> ./arch/x86/Kconfig:     bool "Require a valid signature in kexec_file_load() syscall"
> ./arch/x86/Kconfig:     prompt "vsyscall table for legacy applications"
> ./arch/arm64/Kconfig:   bool "Verify kernel signature during kexec_file_load() syscall"
> ./arch/arm64/Kconfig:   bool "Enable the tagged user addresses syscall ABI"
> ./kernel/trace/Kconfig: bool "Trace syscalls"
> ./kernel/trace/Kconfig: bool "Run selftest on syscall events"
> 
> So let's put aside arch specific lines, ftrace does have FTRACE_SYSCALLS
> that lies in the kernel/trace/ dir.. not sure whether we could move
> USERFAULTFD and all the rest into mm/ as well?  Or perhaps that's just a
> bad example? :)

Yeah it looks like there is a healthy mix ;) To add to the list:

- mm/Kconfig has CONFIG_SWAP for the swapon/swapoff syscalls.
- fs/Kconfig has CONFIG_FILE_LOCKING, which adds the flock() syscall.
- Interestingly, fs/Kconfig has CONFIG_MEMFD_CREATE for memfd_create()
  which is implemented in mm/memfd.c.

It seems reasonable to me to move the userfaultfd stuff to mm as well,
especially when it's becoming more than just a single binary question
on whether you want a syscall or not, and has MM-specific suboptions.
