Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBBC507C56
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 00:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242118AbiDSWEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 18:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbiDSWEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:04:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 874EF3DDFD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 15:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650405679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZOf+5gwAGn9Ts5LxNHedJ7Kx9vDnu9lMiJ3VpD8HDhA=;
        b=MI+89Dk4S2HZ/xEYp25hYi784sd9K5hvGzODaIbfCcTIk2lYNZuPVvpOv5bHGr8ZwpxyDc
        xVlnt2jFI/M3RSG57W1CcMjJfEWIKrhen0U/Y77g3rsKpaKtf3SV6iaxA9OSDTOYmqM6u4
        r+7hm8mgIzX/3CbB2BRXeMDan8KkZ0M=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-JfSZzH6IPm6YoEwZL5UmBQ-1; Tue, 19 Apr 2022 18:01:18 -0400
X-MC-Unique: JfSZzH6IPm6YoEwZL5UmBQ-1
Received: by mail-il1-f199.google.com with SMTP id h1-20020a056e021b8100b002cbec2c4261so7620619ili.16
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 15:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZOf+5gwAGn9Ts5LxNHedJ7Kx9vDnu9lMiJ3VpD8HDhA=;
        b=xcep2sqdV4R2bgo6geIaCO39jHgpPh3pQ7StMEVgKAnoEhAngq44i9TpPp9kEBlcoI
         nFdv8PAWoUfuasW3Cwj18E7I6AzAkjCmeeY/bd3KwyEAUn5kcTMT64ANl75RsNjEKTFd
         IwB2nKaGrUWPjvLtV8KjJsDa5VB9nii94jeaZXMTBwvEdUuQ+zdrSWlk4hufvNMIngi8
         vj05JYd518hUJxQ9MATgXTdJ1DwYCUlGxPaPuX6YHCf7gKOLHCLLHaTU4ssrcu/4WQN/
         wOaHDV/iekCDknyMHY53bY4XuFwJGGh/mud/TNHJEicy1jqkXU35smy/WF159KU+1gDc
         VQBw==
X-Gm-Message-State: AOAM5327qFQqw7SyrCkqn62C+qsUEwL58KIWUkU2n95XtZo5Q75r9qfT
        hrfI0k3jQrmvV9bIcPIgmeP1mtksXtFMV9SpQAxI5rq4KlEXFH/ZvQi9JJUz9re+e+BK72pYO3b
        7MKLwjjj6wyiCtdHEVMmbeqxM
X-Received: by 2002:a05:6638:22c6:b0:328:71e2:82ae with SMTP id j6-20020a05663822c600b0032871e282aemr6878465jat.53.1650405677507;
        Tue, 19 Apr 2022 15:01:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysIQX/isqxiYMJbIumIYuEy9U9dE8+h3bDbqGUIUbOg8yZ0lTGpnjp1xu/9nv2HyYaRHJhwA==
X-Received: by 2002:a05:6638:22c6:b0:328:71e2:82ae with SMTP id j6-20020a05663822c600b0032871e282aemr6878446jat.53.1650405677186;
        Tue, 19 Apr 2022 15:01:17 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id x186-20020a6bc7c3000000b00648deae6630sm10979284iof.54.2022.04.19.15.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 15:01:16 -0700 (PDT)
Date:   Tue, 19 Apr 2022 18:01:14 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
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
Message-ID: <Yl8xKh9Dc+nPr30a@xz-m1.local>
References: <20220405014646.13522-1-peterx@redhat.com>
 <20220405014929.15158-1-peterx@redhat.com>
 <Yl7RrKV5mXtNAAzi@cmpxchg.org>
 <Yl8UmWQodLX+JkZ7@xz-m1.local>
 <Yl8YE+w+OWz5RNOL@cmpxchg.org>
 <Yl8bYKOJGW2py7Q0@xz-m1.local>
 <Yl8ojDwxsD/wqWM4@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yl8ojDwxsD/wqWM4@cmpxchg.org>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 05:24:28PM -0400, Johannes Weiner wrote:
> On Tue, Apr 19, 2022 at 04:28:16PM -0400, Peter Xu wrote:
> > On Tue, Apr 19, 2022 at 04:14:11PM -0400, Johannes Weiner wrote:
> > > On Tue, Apr 19, 2022 at 03:59:21PM -0400, Peter Xu wrote:
> > > > @@ -910,16 +910,16 @@ config ANON_VMA_NAME
> > > Btw, this doesn't do much without userfaultfd being enabled in
> > > general, right?
> > 
> > So far yes, but I'm thinking there can be potential other users of
> > PTE_MARKERS from mm world.  The most close discussion is on the swap read
> > failures and this patch proposed by Miaohe:
> > 
> > https://lore.kernel.org/lkml/20220416030549.60559-1-linmiaohe@huawei.com/
> >
> > So I hope we can still keep them around here under mm/ if possible, and
> > from the gut feeling it really should..
> 
> Agreed, mm/ seems a good fit for PTE_MARKER.
> 
> If it's invisible and gets selected as needed, it's less of a concern,
> IMO. I'm somewhat worried about when and how the user-visible options
> show up right now, though...
> 
> > > Would it make sense to have it next to 'config USERFAULTFD' as a
> > > sub-option?
> > 
> > Yes another good question. :)
> > 
> > IIUC CONFIG_USERFAULTFD resides in init/Kconfig because it introduces a new
> > syscall.  Same to the rest of the bits for uffd since then, namely:
> > 
> >   - USERFAULTFD_WP
> >   - USERFAULTFD_MINOR
> > 
> > What I am thinking now is the other way round of your suggestion: whether
> > we should move most of them out, at least the _WP and _MINOR configs into
> > mm/?  Because IMHO they are really pure mm ideas and they're irrelevant to
> > syscalls and init.
> 
> I'm thinking the MM submenu would probably be a better fit for all
> user-visible userfaultfd options, including the syscall. Like you say,
> it's an MM concept.
> 
> But if moving the syscall knob out from init isn't popular, IMO it
> would be better to add the new WP option to init as well. This ensures
> that when somebody selects userfaultfd, they also see the relevant
> suboptions and don't have to chase them down across multiple submenus.
> 
> Conversely, they should also have the necessary depend clauses so that
> suboptions aren't visible without the main feature. E.g. it asked me
> for userfaultd options even though I have CONFIG_USERFAULTFD=n.

Hmm, this is a bit weird... since we do have that dependency chain for
PTE_MARKER_UFFD_WP -> HAVE_ARCH_USERFAULTFD_WP -> USERFAULTFD:

  in arch/x86/Kconfig:
  config X86
          ...
          select HAVE_ARCH_USERFAULTFD_WP         if X86_64 && USERFAULTFD

  in mm/Kconfig (with/without the "mm/uffd: Hide PTE_MARKER" patch applied):
  config PTE_MARKER_UFFD_WP
          ...
          depends on HAVE_ARCH_USERFAULTFD_WP

So logically if !USERFAULTFD we shouldn't see PTE_MARKER_UFFD_WP at all?

That's also what I got when I tried it out for either !USERFAULTFD on x86,
or any non-x86 platforms (because there we have !HAVE_ARCH_USERFAULTFD_WP
constantly irrelevant of USERFAULTFD).  Though I could have missed
something..

> 
> What do you think?

I don't have a strong preference here, I think it's okay if it's preferred
that we only put user-visible configs into mm/Kconfig.  It's just that I
see we have tons of user-invisible configs already in mm/Kconfig, to list
some:

        config ARCH_HAS_HUGEPD
        config MAPPING_DIRTY_HELPERS
        config KMAP_LOCAL
        config KMAP_LOCAL_NON_LINEAR_PTE_ARRAY

But I'm not sure whether it's a rule of thumb somewhere else.

At the meantime, I also looked at whether syscall configs are always and
only be put under init/, and funnily I got:

$ find . -name Kconfig | xargs grep --color -E "\".*syscall.*\""
./init/Kconfig: bool "Enable process_vm_readv/writev syscalls"
./init/Kconfig: bool "uselib syscall"
./init/Kconfig: bool "sgetmask/ssetmask syscalls support" if EXPERT
./init/Kconfig: bool "Sysfs syscall support" if EXPERT
./init/Kconfig: bool "open by fhandle syscalls" if EXPERT
./init/Kconfig: bool "Enable madvise/fadvise syscalls" if EXPERT
./arch/xtensa/Kconfig:  bool "Enable fast atomic syscalls"
./arch/xtensa/Kconfig:  bool "Enable spill registers syscall"
./arch/powerpc/Kconfig: bool "Support setting protections for 4k subpages (subpage_prot syscall)"
./arch/powerpc/Kconfig: bool "Enable filtering of RTAS syscalls"
./arch/Kconfig: bool "Support for randomizing kernel stack offset on syscall entry" if EXPERT
./arch/s390/Kconfig:    bool "Verify kernel signature during kexec_file_load() syscall"
./arch/sh/mm/Kconfig:   bool "Support vsyscall page"
./arch/x86/Kconfig:     bool "Enable vsyscall emulation" if EXPERT
./arch/x86/Kconfig:     bool "Verify kernel signature during kexec_file_load() syscall"
./arch/x86/Kconfig:     bool "Require a valid signature in kexec_file_load() syscall"
./arch/x86/Kconfig:     prompt "vsyscall table for legacy applications"
./arch/arm64/Kconfig:   bool "Verify kernel signature during kexec_file_load() syscall"
./arch/arm64/Kconfig:   bool "Enable the tagged user addresses syscall ABI"
./kernel/trace/Kconfig: bool "Trace syscalls"
./kernel/trace/Kconfig: bool "Run selftest on syscall events"

So let's put aside arch specific lines, ftrace does have FTRACE_SYSCALLS
that lies in the kernel/trace/ dir.. not sure whether we could move
USERFAULTFD and all the rest into mm/ as well?  Or perhaps that's just a
bad example? :)

Thanks,

-- 
Peter Xu

