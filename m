Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5533D5156BC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237943AbiD2VYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238374AbiD2VYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:24:04 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE921F61B
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:20:26 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id cx11-20020a17090afd8b00b001d9fe5965b3so9645696pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mv9DFGVUjNjUvqKoeugVcxd/ako81vZgq6bN3/Q4KTM=;
        b=YX11bDowuMsHld0w/gipG/XgdOmxj1kgDmE5tMo2jIz8rxGjO3VsQu7T2QXaz7Z6sU
         PU4lSh1a1owSkqGU5yW8N7tGu8dmUCxKlHQhHr3na2wPJCn6XVK1+FZ5r7A87VV+t1XC
         6xreO4ia6lTVzLB3JRtX+S0Ii6yWsnWGHOjJIZCvthh4xw8WKIrfUn1WeS7ACEdVrqrj
         NJ2+i2MNj93Wv7koCo0IleJIU0EZLKguMx0uvsSan1YJLoPw5lWGC3m7BHKy/9jTfEoF
         Ra2cLQQ090Awym3IrQCdk+fev3rLdz+kEfX/tl7cRaKOF6g6gIEMQuEMOeIWJYFnB8CQ
         RL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mv9DFGVUjNjUvqKoeugVcxd/ako81vZgq6bN3/Q4KTM=;
        b=LOuy08AV5dbfUl/mFjGhsserD7C+gK0ZC+ZMGa0uVfZ/kBOgSNeoX+dcQtZyWyVkcr
         Sxgqx3KFSGnhBeGtRiMekXUzoQaFyq1jUKnlt9HjgOzEx0/Fg/i85nnQT2EdGWiH1qgf
         OLUWvoYoZe7kXZP0vFogPmORNRZHNUD68v+Yri6Xp6dGkIX2htqeYMszBudy9S9irzlw
         yo1vYPFThN1zJD2I2aYMKLyGJWKAPzUadRpzCphMOysgEqXs5DMlYWUrOxEnY1wmCEJO
         j2OZwXTzuuWYGeqIwLlCFtcxif67uZT/Kqh/IA6FNfmeD4yszAFvXP8W9UqMHHZjpEl0
         imSg==
X-Gm-Message-State: AOAM531N0T96eKDQtnTCzcxGj4s7RA7SFhWB7uMfWskXUwbiuUyvliI9
        nXiFBUVDvgcH5Kpc24tK/iNDjQ543N9AZaemtihLAQ==
X-Google-Smtp-Source: ABdhPJxOI015Sua0vDUUKeCI4dI8/hOf+yDLEE38Ku6igW+0R2tZGclgp0+NOE/F4FBVFyUgX/Ne2S2gL7vatmBgrHc=
X-Received: by 2002:a17:902:da81:b0:15d:37b9:70df with SMTP id
 j1-20020a170902da8100b0015d37b970dfmr1257018plx.34.1651267222305; Fri, 29 Apr
 2022 14:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1649219184.git.kai.huang@intel.com> <522e37eb-68fc-35db-44d5-479d0088e43f@intel.com>
 <CAPcyv4g5E_TOow=3pFJXyFr=KLV9pTSnDthgz6TuXvru4xDzaQ@mail.gmail.com>
 <de9b8f4cef5da03226158492988956099199aa60.camel@intel.com>
 <CAPcyv4iGsXkHAVgf+JZ4Pah_fkCZ=VvUmj7s3C6Rkejtdw_sgQ@mail.gmail.com>
 <92af7b22-fa8a-5d42-ae15-8526abfd2622@intel.com> <CAPcyv4iG977DErCfYTqhVzuZqjtqFHK3smnaOpO3p+EbxfvXcQ@mail.gmail.com>
 <4a5143cc-3102-5e30-08b4-c07e44f1a2fc@intel.com> <CAPcyv4i6X6ODNbOnT7+NEzpicLS4m9bNDybZLvN3gqXFTTf=mg@mail.gmail.com>
 <4d0c7316-3564-ef27-1113-042019d583dc@intel.com> <CAPcyv4gYw3k4YMEV1E26fMx-GNCNCb+zJDERfhieCrROWv_Jxg@mail.gmail.com>
 <73ed1e55-7e7c-2995-b411-8e26b711cc22@intel.com>
In-Reply-To: <73ed1e55-7e7c-2995-b411-8e26b711cc22@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 29 Apr 2022 14:20:11 -0700
Message-ID: <CAPcyv4gzEvMA4F5ncuhVenRDuz7Tq6aCSJR=z7wVqNGOYGS5Kw@mail.gmail.com>
Subject: Re: [PATCH v3 00/21] TDX host kernel support
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kai Huang <kai.huang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Brown, Len" <len.brown@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 12:20 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 4/29/22 11:47, Dan Williams wrote:
> > On Fri, Apr 29, 2022 at 11:34 AM Dave Hansen <dave.hansen@intel.com> wrote:
> >>
> >> On 4/29/22 10:48, Dan Williams wrote:
> >>>> But, neither of those really help with, say, a device-DAX mapping of
> >>>> TDX-*IN*capable memory handed to KVM.  The "new syscall" would just
> >>>> throw up its hands and leave users with the same result: TDX can't be
> >>>> used.  The new sysfs ABI for NUMA nodes wouldn't clearly apply to
> >>>> device-DAX because they don't respect the NUMA policy ABI.
> >>> They do have "target_node" attributes to associate node specific
> >>> metadata, and could certainly express target_node capabilities in its
> >>> own ABI. Then it's just a matter of making pfn_to_nid() do the right
> >>> thing so KVM kernel side can validate the capabilities of all inbound
> >>> pfns.
> >>
> >> Let's walk through how this would work with today's kernel on tomorrow's
> >> hardware, without KVM validating PFNs:
> >>
> >> 1. daxaddr mmap("/dev/dax1234")
> >> 2. kvmfd = open("/dev/kvm")
> >> 3. ioctl(KVM_SET_USER_MEMORY_REGION, { daxaddr };
> >
> > At least for a file backed mapping the capability lookup could be done
> > here, no need to wait for the fault.
>
> For DAX mappings, sure.  But, anything that's backed by page cache, you
> can't know until the RAM is allocated.
>
> ...
> >> Those pledges are hard for anonymous memory though.  To fulfill the
> >> pledge, we not only have to validate that the NUMA policy is compatible
> >> at KVM_SET_USER_MEMORY_REGION, we also need to decline changes to the
> >> policy that might undermine the pledge.
> >
> > I think it's less that the kernel needs to enforce a pledge and more
> > that an interface is needed to communicate the guest death reason.
> > I.e. "here is the impossible thing you asked for, next time set this
> > policy to avoid this problem".
>
> IF this code is booted on a system where non-TDX-capable memory is
> discovered, do we:
> 1. Disable TDX, printk() some nasty message, then boot as normal
> or,
> 2a. Boot normally with TDX enabled
> 2b. Add enhanced error messages in case of TDH.MEM.PAGE.AUG/ADD failure
>     (the "SEAMCALLs" which are the last line of defense and will reject
>      the request to add non-TDX-capable memory to a guest).  Or maybe
>     an even earlier message.
>
> For #1, if TDX is on, we are quite sure it will work.  But, it will
> probably throw up its hands on tomorrow's hardware.  (This patch set).
>
> For #2, TDX might break (guests get killed) at runtime on tomorrow's
> hardware, but it also might be just fine.  Users might be able to work
> around things by, for instance, figuring out a NUMA policy which
> excludes TDX-incapable memory. (I think what Dan is looking for)
>
> Is that a fair summary?

Yes, just the option for TDX and non-TDX to live alongside each
other... although in the past I have argued to do option-1 and enforce
it at the lowest level [1]. Like platform BIOS is responsible to
disable CXL if CXL support for a given CPU security feature is
missing. However, I think end users will want to have their
confidential computing and capacity too. As long as that is not
precluded to be added after the fact, option-1 can be a way forward
until a concrete user for mixed mode shows up.

Is there something already like this today for people that, for
example, attempt to use PCI BAR mappings as memory? Or does KVM simply
allow for garbage-in garbage-out?

In the end the patches shouldn't talk about whether or not PMEM is
supported on a platform or not, that's irrelevant. What matters is
that misconfigurations can happen, should be rare to non-existent on
current platforms, and if it becomes a problem the kernel can grow ABI
to let userspace enumerate the conflicts.

[1]: https://lore.kernel.org/linux-cxl/CAPcyv4jMQbHYQssaDDDQFEbOR1v14VUnejcSwOP9VGUnZSsCKw@mail.gmail.com/
