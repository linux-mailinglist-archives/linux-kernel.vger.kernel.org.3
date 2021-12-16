Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641F04766FF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 01:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbhLPAo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 19:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbhLPAo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 19:44:58 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2136AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 16:44:58 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id f18-20020a17090aa79200b001ad9cb23022so20931468pjq.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 16:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lgP+lAePXSofKYE3aYdGp9/6olKh20+ay/U/VbTNNKQ=;
        b=H+mruwPMYl/jNx1J1Ar69nxjqan9+PVoh3NO3NtMUjrgeVv10mWtdxqcwl55tvacdr
         kKC2TynwZSS5zWMCCXA9VKiIV9t4DRkGqJt3KQwo42uwcCgtoHZvvTna7fgTnbi5h38u
         JDWHUBt4WsnVeISJQO9Gu3BJEuXWbD09/KaL/w/ctRcSkmEHGpKVWaW8lSSKYrd99fC1
         NHWk+4cdMMoUVUy3YUwQogOrgmEMUQmKXBmFm/lflbx8exWAYA25HJ0LE+smYekv+GNv
         e7k2iQD0q0Wu2uqBv/C0CeqPmsXRDPpTUZJr7pVoD8yc3RcfD9fnRX9YHbw0v6nkTZXE
         VPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lgP+lAePXSofKYE3aYdGp9/6olKh20+ay/U/VbTNNKQ=;
        b=4JpZRxNTJjPXk7Zak9YcbO3kfj7vlwB49uZVHQ5KS9DxgRPy4NeCIzVvsq/5Cru1F9
         IAfTYQpXQsfQ3Z27RsA+JRlwUrqnymRZShNqOkAcY/4nJ2Bj0e4+7HF85+hsVIvTJe/S
         OhjzBVb1qq4m58LB19GX6XoB6ZpZ0/cK+jPwqzKvLsyIg5ZNLjzNMrHVBetTxgaORSvf
         xN6JsB7mZb0+xw08ByEtCoWCzUdBzxP0L2hXgXQu6YW+YebJyaAw+QPqtw+0WuCqrSUC
         HRsjmdKm5x1cR1GipygFBY9+HycfGSfQrBkG2e+w9sRsrRqqxJERDD4CU9unieLHgIN+
         8ULQ==
X-Gm-Message-State: AOAM530VPSPwJpdkuVj9EQYw9kHQaRl0TUeiTysLhA4iW018ZpUlYBE6
        iN5p0jhoNZ4uiX9wbvMLTQpUtw==
X-Google-Smtp-Source: ABdhPJyBka5szIjqwHtBv8xo5CeWpY689qbI5QqWYwG3sGyThptV2xLguH1Fx5ydbwM3tUT0LI0D9A==
X-Received: by 2002:a17:903:1109:b0:148:a2e7:fb37 with SMTP id n9-20020a170903110900b00148a2e7fb37mr7185615plh.120.1639615497329;
        Wed, 15 Dec 2021 16:44:57 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g5sm6650656pjt.15.2021.12.15.16.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 16:44:56 -0800 (PST)
Date:   Thu, 16 Dec 2021 00:44:53 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>
Subject: Re: [PATCH 0/4] KVM: x86/mmu: Zap invalid TDP MMU roots when
 unmapping
Message-ID: <YbqMBfFLjnwFL725@google.com>
References: <20211215011557.399940-1-seanjc@google.com>
 <b4295e77-aaf1-f0f5-cfd5-2a4fda923fb4@redhat.com>
 <YbpS5UZdC/a5PgoO@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbpS5UZdC/a5PgoO@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021, Sean Christopherson wrote:
> On Wed, Dec 15, 2021, Paolo Bonzini wrote:
> > On 12/15/21 02:15, Sean Christopherson wrote:
> > > Patches 01-03 implement a bug fix by ensuring KVM zaps both valid and
> > > invalid roots when unmapping a gfn range (including the magic "all" range).
> > > Failure to zap invalid roots means KVM doesn't honor the mmu_notifier's
> > > requirement that all references are dropped.
> > > 
> > > set_nx_huge_pages() is the most blatant offender, as it doesn't elevate
> > > mm_users and so a VM's entire mm can be released, but the same underlying
> > > bug exists for any "unmap" command from the mmu_notifier in combination
> > > with a memslot update.  E.g. if KVM is deleting a memslot, and a
> > > mmu_notifier hook acquires mmu_lock while it's dropped by
> > > kvm_mmu_zap_all_fast(), the mmu_notifier hook will see the to-be-deleted
> > > memslot but won't zap entries from the invalid roots.
> > > 
> > > Patch 04 is cleanup to reuse the common iterator for walking _only_
> > > invalid roots.
> > > 
> > > Sean Christopherson (4):
> > >    KVM: x86/mmu: Use common TDP MMU zap helper for MMU notifier unmap
> > >      hook
> > >    KVM: x86/mmu: Move "invalid" check out of kvm_tdp_mmu_get_root()
> > >    KVM: x86/mmu: Zap _all_ roots when unmapping gfn range in TDP MMU
> > >    KVM: x86/mmu: Use common iterator for walking invalid TDP MMU roots
> > > 
> > >   arch/x86/kvm/mmu/tdp_mmu.c | 116 +++++++++++++++++--------------------
> > >   arch/x86/kvm/mmu/tdp_mmu.h |   3 -
> > >   2 files changed, 53 insertions(+), 66 deletions(-)
> > > 
> > 
> > Queued 1-3 for 5.16 and 4 for 5.17.
> 
> Actually, can you please unqueue patch 4?  I think we can actually kill off
> kvm_tdp_mmu_zap_invalidated_roots() entirely.  I don't know if that code will be
> ready for 5.17, but if it is then this patch is unnecesary.  And if not, it
> shouldn't be difficult to re-queue this a bit later.

Cancel that request, the comment above kvm_tdp_mmu_zap_invalidated_roots() lies,
as do the changelogs for commits b7cccd397f31 ("KVM: x86/mmu: Fast invalidation
for TDP MMU") and 4c6654bd160d ("KVM: x86/mmu: Tear down roots before
kvm_mmu_zap_all_fast returns"), and the fact that they are even separate commits.

KVM _must_ zap invalid roots before returning from kvm_mmu_zap_all_fast(), because
when it's called from kvm_mmu_invalidate_zap_pages_in_memslot(), KVM is relying on
it to fully remove all references to the memslot.  Once the memslot is gone, KVM's
mmu_notifier hooks will be unable to find the stale references as the hva=>gfn
translation is done via the memslots.   If userspace unmaps a range after deleting
a memslot, KVM will fail to zap in response to the mmu_notifier due to not finding
a memslot corresponding to the notifier's range, which leads to another variation
of the splat I've come to know and love.

  WARNING: CPU: 33 PID: 44927 at arch/x86/kvm/../../../virt/kvm/kvm_main.c:173
  RIP: 0010:kvm_is_zone_device_pfn+0x96/0xa0 [kvm]
   kvm_set_pfn_dirty+0xa8/0xe0 [kvm]
   __handle_changed_spte+0x2f7/0x5b0 [kvm]
   __handle_changed_spte+0x2f7/0x5b0 [kvm]
   __tdp_mmu_set_spte+0x64/0x170 [kvm]
   tdp_mmu_zap_root+0x1f5/0x220 [kvm]
   kvm_tdp_mmu_zap_all+0x47/0x60 [kvm]
   kvm_mmu_zap_all+0xf0/0x100 [kvm]
   kvm_mmu_notifier_release+0x2b/0x60 [kvm]
   mmu_notifier_unregister+0x48/0xe0
   kvm_destroy_vm+0x129/0x2a0 [kvm]
   kvm_vm_release+0x1d/0x30 [kvm]
   __fput+0x82/0x240
   task_work_run+0x5c/0x90
   exit_to_user_mode_prepare+0x114/0x120
   syscall_exit_to_user_mode+0x1d/0x40
   do_syscall_64+0x48/0xc0
   entry_SYSCALL_64_after_hwframe+0x44/0xae

I'll include a patch in my flush+zap rework series to reword that comment, because
it is very, very misleading.
