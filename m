Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86955487A60
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 17:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240133AbiAGQbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 11:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239847AbiAGQbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 11:31:38 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADA2C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 08:31:38 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 8so5828515pgc.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 08:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8x5aau+9GId4X1fkS/Ix8Wi9zq+PLZoxIQ2oHrW+IM8=;
        b=L9AJlkClDBCQp2d0qcZIwYZbbM0UJrWK7mAnAs7XoHi5p3eXECQk/DT7ZPdJL6dOLF
         jIWwg4D0FCWGc+KY752pSLb0iqOUgyV4ueCX1tRs0iyIihUOfu+/nrN1UnQgQtHzU6Q9
         E2bh0Vzff3Bi2MgEvD6x1btKH7Hj+ZDktF1TswaiGXH2itZ6sMNFH0eff2bzCSZIUzPx
         Ljeu9mMpDh9SifesE99f/y4hFJusqSEbqQ+3QYY58RlPh7erzlf6CgVoHjBTmnzEr0gg
         cXvZjK196zShjNX+a2OopX31KfOYlHQPnp5tpCH8PJpwA4n+VcXTb4X9AGr99mUZ2sKJ
         dpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8x5aau+9GId4X1fkS/Ix8Wi9zq+PLZoxIQ2oHrW+IM8=;
        b=WZkbkHkxobgw5+LXXpXSg8GVF/fvDJGeL463yVLWeqPBehoMmkUxcwhaWvilYCAZpV
         xQwovYuDmhc9NkXvBkSMHfTfOCuajE06v6+JZWswy5duT0rfrDvl4K4kcLcetqV9D+E9
         F07Y1QWEBXLmWG9nGDb+bFyMc8PTEGYzoyZwxjlSOQjHC2eKXN4mknwBWhAhjNND8Nhh
         3fawinRty0x9rSPt3dOlVxBGydP3ALo1bmJ5rpA7Y0fZjOSMWKmujXCIl9jMNesG+BZw
         4nmOCWAUwIGVms3HNHynr1TBNwgYLm2yooJ14veXvcOXeL+0ezeZHeMlAcXAIqahbZBC
         Drig==
X-Gm-Message-State: AOAM533txzlfIkwPLApJJum1/lEII4TcSFgsHpcj9FYjWVbMjALGXi+i
        NvOQgTu8T/qGItXxDFKmFQc7XQ==
X-Google-Smtp-Source: ABdhPJzgG47GKpuKWTf6oJSn9E2fBwBv84lP3oKIaE8NOaZd04A6CCABm5d7mq013onV7fWVKolFbQ==
X-Received: by 2002:a63:3f88:: with SMTP id m130mr5233049pga.413.1641573097689;
        Fri, 07 Jan 2022 08:31:37 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id v128sm4290920pfc.36.2022.01.07.08.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 08:31:37 -0800 (PST)
Date:   Fri, 7 Jan 2022 16:31:33 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Stevens <stevensd@chromium.org>
Cc:     Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Chia-I Wu <olv@chromium.org>
Subject: Re: [PATCH v5 4/4] KVM: mmu: remove over-aggressive warnings
Message-ID: <Ydhq5aHW+JFo15UF@google.com>
References: <20211129034317.2964790-1-stevensd@google.com>
 <20211129034317.2964790-5-stevensd@google.com>
 <Yc4G23rrSxS59br5@google.com>
 <CAD=HUj5Q6rW8UyxAXUa3o93T0LBqGQb7ScPj07kvuM3txHMMrQ@mail.gmail.com>
 <YdXrURHO/R82puD4@google.com>
 <YdXvUaBUvaRPsv6m@google.com>
 <CAD=HUj736L5oxkzeL2JoPV8g1S6Rugy_TquW=PRt73YmFzP6Jw@mail.gmail.com>
 <YdcpIQgMZJrqswKU@google.com>
 <CAD=HUj5v37wZ9NuNC4QBDvCGO2SyNG2KAiTc9Jxfg=R7neCuTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=HUj5v37wZ9NuNC4QBDvCGO2SyNG2KAiTc9Jxfg=R7neCuTw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022, David Stevens wrote:
> > > These are the type of pages which KVM is currently rejecting. Is this
> > > something that KVM can support?
> >
> > I'm not opposed to it.  My complaint is that this series is incomplete in that it
> > allows mapping the memory into the guest, but doesn't support accessing the memory
> > from KVM itself.  That means for things to work properly, KVM is relying on the
> > guest to use the memory in a limited capacity, e.g. isn't using the memory as
> > general purpose RAM.  That's not problematic for your use case, because presumably
> > the memory is used only by the vGPU, but as is KVM can't enforce that behavior in
> > any way.
> >
> > The really gross part is that failures are not strictly punted to userspace;
> > the resulting error varies significantly depending on how the guest "illegally"
> > uses the memory.
> >
> > My first choice would be to get the amdgpu driver "fixed", but that's likely an
> > unreasonable request since it sounds like the non-KVM behavior is working as intended.
> >
> > One thought would be to require userspace to opt-in to mapping this type of memory
> > by introducing a new memslot flag that explicitly states that the memslot cannot
> > be accessed directly by KVM, i.e. can only be mapped into the guest.  That way,
> > KVM has an explicit ABI with respect to how it handles this type of memory, even
> > though the semantics of exactly what will happen if userspace/guest violates the
> > ABI are not well-defined.  And internally, KVM would also have a clear touchpoint
> > where it deliberately allows mapping such memslots, as opposed to the more implicit
> > behavior of bypassing ensure_pfn_ref().
> 
> Is it well defined when KVM needs to directly access a memslot?

Not really, there's certainly no established rule.

> At least for x86, it looks like most of the use cases are related to nested
> virtualization, except for the call in emulator_cmpxchg_emulated.

The emulator_cmpxchg_emulated() will hopefully go away in the nearish future[*].
Paravirt features that communicate between guest and host via memory is the other
case that often maps a pfn into KVM.

> Without being able to specifically state what should be avoided, a flag like
> that would be difficult for userspace to use.

Yeah :-(  I was thinking KVM could state the flag would be safe to use if and only
if userspace could guarantee that the guest would use the memory for some "special"
use case, but hadn't actually thought about how to word things.

The best thing to do is probably to wait for for kvm_vcpu_map() to be eliminated,
as described in the changelogs for commits:

  357a18ad230f ("KVM: Kill kvm_map_gfn() / kvm_unmap_gfn() and gfn_to_pfn_cache")
  7e2175ebd695 ("KVM: x86: Fix recording of guest steal time / preempted status")

Once that is done, everything in KVM will either access guest memory through the
userspace hva, or via a mechanism that is tied into the mmu_notifier, at which
point accessing non-refcounted struct pages is safe and just needs to worry about
not corrupting _refcount.
