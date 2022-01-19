Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA92493A47
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 13:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354469AbiASMaO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 Jan 2022 07:30:14 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4430 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbiASMaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 07:30:12 -0500
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jf4ch6gXwz685gm;
        Wed, 19 Jan 2022 20:26:12 +0800 (CST)
Received: from lhreml721-chm.china.huawei.com (10.201.108.72) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Wed, 19 Jan 2022 13:30:09 +0100
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml721-chm.china.huawei.com (10.201.108.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 19 Jan 2022 12:30:09 +0000
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2308.021; Wed, 19 Jan 2022 12:30:09 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "julien.thierry.kdev@gmail.com" <julien.thierry.kdev@gmail.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "Alexandru.Elisei@arm.com" <Alexandru.Elisei@arm.com>,
        "qperret@google.com" <qperret@google.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v4 0/4] kvm/arm: New VMID allocator based on asid
Thread-Topic: [PATCH v4 0/4] kvm/arm: New VMID allocator based on asid
Thread-Index: AQHX35sqG4N0fL5BTkOeJNZZBpVcWaxpD9KAgAFUH+CAADI2AIAAApfw
Date:   Wed, 19 Jan 2022 12:30:09 +0000
Message-ID: <ab7dc77ee8804f1e958c18cc4dac4a65@huawei.com>
References: <20211122121844.867-1-shameerali.kolothum.thodi@huawei.com>
 <Yeazd1lLuYm4k3lH@arm.com> <207f800d1a67427a9771ffb06086365b@huawei.com>
 <Yef65ng6pQK5yZDa@arm.com>
In-Reply-To: <Yef65ng6pQK5yZDa@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.82.100]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Catalin Marinas [mailto:catalin.marinas@arm.com]
> Sent: 19 January 2022 11:50
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: linux-arm-kernel@lists.infradead.org; kvmarm@lists.cs.columbia.edu;
> linux-kernel@vger.kernel.org; maz@kernel.org; will@kernel.org;
> james.morse@arm.com; julien.thierry.kdev@gmail.com;
> suzuki.poulose@arm.com; jean-philippe@linaro.org;
> Alexandru.Elisei@arm.com; qperret@google.com; Jonathan Cameron
> <jonathan.cameron@huawei.com>; Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH v4 0/4] kvm/arm: New VMID allocator based on asid
> 
> On Wed, Jan 19, 2022 at 09:23:31AM +0000, Shameerali Kolothum Thodi
> wrote:
> > > On Mon, Nov 22, 2021 at 12:18:40PM +0000, Shameer Kolothum wrote:
> > > >  -TLA+ model. Modified the asidalloc model to incorporate the new
> > > >   VMID algo. The main differences are,
> > > >   -flush_tlb_all() instead of local_tlb_flush_all() on rollover.
> > > >   -Introduced INVALID_VMID and vCPU Sched Out logic.
> > > >   -No CnP (Removed UniqueASIDAllCPUs & UniqueASIDActiveTask
> invariants).
> > > >   -Removed  UniqueVMIDPerCPU invariant for now as it looks like
> > > >    because of the speculative fetching with flush_tlb_all() there
> > > >    is a small window where this gets triggered. If I change the
> > > >    logic back to local_flush_tlb_all(), UniqueVMIDPerCPU seems to
> > > >    be fine. With my limited knowledge on TLA+ model, it is not
> > > >    clear to me whether this is a problem with the above logic
> > > >    or the VMID model implementation. Really appreciate any help
> > > >    with the model.
> > > >    The initial VMID TLA+ model is here,
> > > >
> https://github.com/shamiali2008/kernel-tla/tree/private-vmidalloc-v1
> > >
> > > I only had a brief look at the TLA+ model and I don't understand why you
> > > have a separate 'shed_out' process. It would run in parallel with the
> > > 'sched' but AFAICT you can't really schedule a guest out while you are
> > > in the middle of scheduling it in. I'd rather use the same 'sched'
> > > process and either schedule in an inactive task or schedule out an
> > > active one for a given CPU.
> > >
> > > Also active_vmids[] for example is defined on the CPUS domain but you
> > > call vcpu_sched_out() from a process that's not in the CPUS domain but
> > > the SCHED_OUT one.
> >
> > Many thanks for taking a look. My bad!. The 'sched_out' would indeed run in
> parallel
> > and defeat the purpose. I must say I was really confused by the TLA+ syntax
> and
> > is still not very confident about it.
> 
> Yeah, it can be confusing. If you have time, you could give CBMC a try
> and the 'spec' would be pretty close to your C version. Each CPU would
> be modelled as a thread with an extra thread that simulates the
> speculative TLB look-ups for all CPUS together with the asserts for the
> invariants. The spinlocks would be pthread_mutexes.

Ok, will take a look.

> > Based on the above suggestion, I have modified it as below,
> >
> > \* vCPU is scheduled out by KVM
> > macro vcpu_sched_out() {
> >         active_kvm[self].task := 0;
> >         active_vmids[self] := INVALID_VMID;
> > }
> 
> Could you call cpu_switch_kvm(0, INVALID_VMID) instead? You could do
> this directly below and avoid another macro. Well, whatever you find
> clearer.

Sure, will change that.

> What confuses me is that your INVALID_VMID looks like a valid one: vmid
> 0, generation 1. Do you ensure that you never allocate VMID 0?

This is same as in asidalloc wherein the cur_idx starts at 1 for any new
allocation. I think that guarantees VMID 0 is never allocated.  

> 
> > \* About to run a Guest VM
> > process (sched \in CPUS)
> > {
> > sched_loop:
> >         while (TRUE) {
> >                 with (t \in TASKS) {
> >                         if (t # ActiveTask(self))
> >                                 call kvm_arm_vmid_update(t);
> >                         else
> >                                 vcpu_sched_out();
> >                 }
> >         }
> > }
> 
> Yes, that's what I meant.

Ok.

> 
> > > The corresponding
> > > UniqueASIDPerCPU meant that for any two TLB entries on a single CPU, if
> > > they correspond to different tasks (pgd), they should have different
> > > ASIDs. That's a strong requirement, otherwise we end up with the wrong
> > > translation.
> >
> > Yes, I understand that it is a strong requirement. Also, I thought this is
> something
> > that will trigger easily with the test setup I had with the real hardware. But
> testing
> > stayed on for days, so I was not sure it is a problem with the TLA+
> implementation
> > or not.
> 
> Well, you'd have to check the TLA+ state trace and see how it got
> there, whether the last state would be a valid one. It's either
> something missing in the spec that the hardware enforces or the
> algorithm is wrong and just hard to hit in practice. If this condition
> is violated in hardware for a very brief period, e.g. due to some TLBI,
> you'd not notice an issue under normal circumstances. But it's still
> incorrect.

Hmm..I had a quick implementation with a separate thread for speculative
load as done in the arm64kpti.tla, but still get the UniqueVMIDPerCPU violation
error. I will go through the state trace and see whether I can interpret something :) 
 
> > > Why did you remove the CnP? Do we have this disabled for KVM guests?
> >
> > I removed CnP related Invariants to simplify things for the first version. Also
> not sure
> > what specific changes we need to do for CnP here. Do we still need that
> switching to
> > global pg_dir to prevent any speculative reading? I didn't see that being
> done in KVM
> > anywhere at the moment. Maybe I am missing something.
> 
> It make sense to ignore CnP for now. Maybe KVM doesn't even bother and
> sets VTTBR_EL2.CnP to 0 (I haven't checked).

I think KVM sets the CnP here,
https://elixir.bootlin.com/linux/latest/source/arch/arm64/include/asm/kvm_mmu.h#L264

But I haven't figured out what else we need to do in this new VMID allocator for
CnP case. 

Marc, Will?

> 
> > On a side note, In my setup, the CnP=TRUE case for asidalloc.tla now fails
> with,
> > "Error: Invariant TLBEmptyInvalPTE is violated.". Please check.
> 
> This was added later as part of try-to-unmap and I only checked this
> with CnP = FALSE. I'll need to look into, it's possible that
> flush_tlb_all() doesn't take into account that the pte is unmapped (as
> cpu_switch_mm() does). I'll add a separate thread for speculative TLB
> loads, it's easier to have them in one place. Thanks.

Ok.

Thanks,
Shameer
