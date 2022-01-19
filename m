Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831D849372A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353046AbiASJXg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 Jan 2022 04:23:36 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4429 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353032AbiASJXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:23:35 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jf0VK0HwYz67n9B;
        Wed, 19 Jan 2022 17:20:25 +0800 (CST)
Received: from lhreml721-chm.china.huawei.com (10.201.108.72) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 19 Jan 2022 10:23:32 +0100
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml721-chm.china.huawei.com (10.201.108.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 19 Jan 2022 09:23:32 +0000
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2308.021; Wed, 19 Jan 2022 09:23:31 +0000
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
Thread-Index: AQHX35sqG4N0fL5BTkOeJNZZBpVcWaxpD9KAgAFUH+A=
Date:   Wed, 19 Jan 2022 09:23:31 +0000
Message-ID: <207f800d1a67427a9771ffb06086365b@huawei.com>
References: <20211122121844.867-1-shameerali.kolothum.thodi@huawei.com>
 <Yeazd1lLuYm4k3lH@arm.com>
In-Reply-To: <Yeazd1lLuYm4k3lH@arm.com>
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

Hi Catalin,

> -----Original Message-----
> From: Catalin Marinas [mailto:catalin.marinas@arm.com]
> Sent: 18 January 2022 12:33
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: linux-arm-kernel@lists.infradead.org; kvmarm@lists.cs.columbia.edu;
> linux-kernel@vger.kernel.org; maz@kernel.org; will@kernel.org;
> james.morse@arm.com; julien.thierry.kdev@gmail.com;
> suzuki.poulose@arm.com; jean-philippe@linaro.org;
> Alexandru.Elisei@arm.com; qperret@google.com; Jonathan Cameron
> <jonathan.cameron@huawei.com>; Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH v4 0/4] kvm/arm: New VMID allocator based on asid
> 
> Hi Shameer,
> 
> On Mon, Nov 22, 2021 at 12:18:40PM +0000, Shameer Kolothum wrote:
> >  -TLA+ model. Modified the asidalloc model to incorporate the new
> >   VMID algo. The main differences are,
> >   -flush_tlb_all() instead of local_tlb_flush_all() on rollover.
> >   -Introduced INVALID_VMID and vCPU Sched Out logic.
> >   -No CnP (Removed UniqueASIDAllCPUs & UniqueASIDActiveTask
> invariants).
> >   -Removed  UniqueVMIDPerCPU invariant for now as it looks like
> >    because of the speculative fetching with flush_tlb_all() there
> >    is a small window where this gets triggered. If I change the
> >    logic back to local_flush_tlb_all(), UniqueVMIDPerCPU seems to
> >    be fine. With my limited knowledge on TLA+ model, it is not
> >    clear to me whether this is a problem with the above logic
> >    or the VMID model implementation. Really appreciate any help
> >    with the model.
> >    The initial VMID TLA+ model is here,
> >    https://github.com/shamiali2008/kernel-tla/tree/private-vmidalloc-v1
> 
> I only had a brief look at the TLA+ model and I don't understand why you
> have a separate 'shed_out' process. It would run in parallel with the
> 'sched' but AFAICT you can't really schedule a guest out while you are
> in the middle of scheduling it in. I'd rather use the same 'sched'
> process and either schedule in an inactive task or schedule out an
> active one for a given CPU.
> 
> Also active_vmids[] for example is defined on the CPUS domain but you
> call vcpu_sched_out() from a process that's not in the CPUS domain but
> the SCHED_OUT one.

Many thanks for taking a look. My bad!. The 'sched_out' would indeed run in parallel
and defeat the purpose. I must say I was really confused by the TLA+ syntax and
is still not very confident about it.

Based on the above suggestion, I have modified it as below,

\* vCPU is scheduled out by KVM
macro vcpu_sched_out() {
        active_kvm[self].task := 0;
        active_vmids[self] := INVALID_VMID;
}
....

\* About to run a Guest VM
process (sched \in CPUS)
{
sched_loop:
        while (TRUE) {
                with (t \in TASKS) {
                        if (t # ActiveTask(self))
                                call kvm_arm_vmid_update(t);
                        else
                                vcpu_sched_out();
                }
        }
}

Please let me know if this is ok.

> Regarding UniqueVMIDPerCPU, I think we need to figure out why it
> happens. The fact that flush_tlb_all() was made to simulate the
> speculative TLB loads is not relevant. In a different spec I have,
> arm64kpti.tla, I just used another process that invokes an update_tlbs()
> macro so that it can happen at any time. I didn't bother to update the
> ASID spec in a similar way but it may be useful.

Ok. I will take a look at that and try that.

 The corresponding
> UniqueASIDPerCPU meant that for any two TLB entries on a single CPU, if
> they correspond to different tasks (pgd), they should have different
> ASIDs. That's a strong requirement, otherwise we end up with the wrong
> translation.

Yes, I understand that it is a strong requirement. Also, I thought this is something
that will trigger easily with the test setup I had with the real hardware. But testing
stayed on for days, so I was not sure it is a problem with the TLA+ implementation
or not.  

> 
> Why did you remove the CnP? Do we have this disabled for KVM guests?

I removed CnP related Invariants to simplify things for the first version. Also not sure
what specific changes we need to do for CnP here. Do we still need that switching to 
global pg_dir to prevent any speculative reading? I didn't see that being done in KVM 
anywhere at the moment. Maybe I am missing something.

On a side note, In my setup, the CnP=TRUE case for asidalloc.tla now fails with,
"Error: Invariant TLBEmptyInvalPTE is violated.". Please check.

Thanks,
Shameer 

> --
> Catalin
