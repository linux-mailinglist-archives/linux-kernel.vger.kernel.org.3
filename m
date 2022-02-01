Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A314A5DE9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 15:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239062AbiBAOEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 09:04:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58468 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239058AbiBAOEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 09:04:31 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211DIk5S009092;
        Tue, 1 Feb 2022 14:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=qxhZ1AsImON7C2c6HO4KQ77oAoo7bJmdnRDuAtedL5A=;
 b=Duh0JVXlaYWaOVIaaHhjWO8IOXOQjNWLo4JiGY6uMRyeyokuHmYVMXwm2Ywcqc8OTBDi
 icYVSlUocR2a294MAjHAtSVUG4rQyF48qm5VXqwmVQmq2ZEMnJA4wzXE18kZ0cCvlPwF
 2M+F4dtmiJLehn/vULl3EuNLeggfU25FmK3HkOneslotT3EMB+tooOgnV3yDQ6M6y58C
 LMCkqKspZgk1yQWPa5vZqIIZtSYNTi/risqmK9YoW/82NxTNBdzfu6tKsDiXdtlHv5DB
 7xc3/Gw2egh4w1Ej6fsroQX86J8b1G02kvxfuNlamsimF/SPBof7cTuB86Qrc2iXhC5T /A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dxw1mtdre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 14:02:44 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 211Dwqds035534;
        Tue, 1 Feb 2022 14:02:43 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dxw1mtdpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 14:02:43 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 211Dqubs011561;
        Tue, 1 Feb 2022 14:02:40 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3dvw793ykp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 14:02:40 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 211DqkkZ49480180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Feb 2022 13:52:46 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A51E4C046;
        Tue,  1 Feb 2022 14:02:35 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B431F4C050;
        Tue,  1 Feb 2022 14:02:33 +0000 (GMT)
Received: from [9.171.76.125] (unknown [9.171.76.125])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Feb 2022 14:02:33 +0000 (GMT)
Message-ID: <980279cc-7836-e330-e435-4fbe5c361e0d@linux.ibm.com>
Date:   Tue, 1 Feb 2022 15:02:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 0/5] kvm: fix latent guest entry/exit bugs
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Cc:     aleksandar.qemu.devel@gmail.com, alexandru.elisei@arm.com,
        anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org,
        benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
        chenhuacai@kernel.org, dave.hansen@linux.intel.com,
        frederic@kernel.org, hca@linux.ibm.com, james.morse@arm.com,
        jmattson@google.com, joro@8bytes.org, maz@kernel.org,
        mingo@redhat.com, mpe@ellerman.id.au, nsaenzju@redhat.com,
        palmer@dabbelt.com, paulmck@kernel.org, paulus@samba.org,
        paul.walmsley@sifive.com, pbonzini@redhat.com, seanjc@google.com,
        suzuki.poulose@arm.com, svens@linux.ibm.com, tglx@linutronix.de,
        tsbogend@alpha.franken.de, vkuznets@redhat.com,
        wanpengli@tencent.com, will@kernel.org
References: <20220201132926.3301912-1-mark.rutland@arm.com>
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20220201132926.3301912-1-mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4yg0fk-s8t-JVpqs1yE5YsmWutHObSSY
X-Proofpoint-GUID: Sl98YnSCQkGDvBMF8d4AQgGXcjHEjbDQ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_06,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010078
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 01.02.22 um 14:29 schrieb Mark Rutland:
> Several architectures have latent bugs around guest entry/exit,
> including:

Thanks for looking into this.

> 
> 1) Enabling interrupts during an RCU EQS, allowing interrupt handlers to
>     run without RCU watching.
> 
> 2) Using (potentially) instrumented code between guest_enter() and
>     guest_exit(), allowing instrumentation handlers to run without RCU
>     watching.
> 
> 3) Not informing lockdep and tracing about interrupt masking, or
>     informing in an incorrect order (e.g. relative to entering/exiting an
>     RCU EQS).
> 
> 4) Unbalanced entry/exit accounting in some cases (which may or may not
>     result in functional problems).
> 
> Overall, the architectures affected are:
> 
>    arm64, mips, powerpc, riscv, s390, x86
> 
> This series reworks the common code to make handling these issues
> earier, and for the following architectures fixes those issues by
> conversion to new helper functions:
> 
>    arm64, mips, riscv, x86
> 
> The core, arm64, and x86 patches have reviews from the relevant
> maintainers, and I think those are good-to-go. I have not yet had
> acks/reviews for the mips and riscv patches. I'm fairly certain the
> riscv patch is correct by virtue of it being so simple, and I'm
> relatively confident that the mips patch is correct (though I may have
> missed additional issues), but I have no way of testing either so I've
> placed them at the end of the series where they can easily be dropped if
> necessary.
> 
> This series does NOT fix the following architectures, which will need
> more substantial changes to architecture-specific entry logic and/or
> sequencing:
> 
>    powerpc, s390

Right, s390 is more complicated as we need to modify the page fault handling.
For the time being we should be as bad/good as before with the deprecated old
guest_enter/exit_irqoff. I will test this to be sure.


> 
> ... and I assume it would be preferable to fix the common code and
> simple cases now, such that those can be addressed in subsequent
> follow-ups.
> 
> Since v1 [1]:
> * Add arch_in_rcu_eqs()
> * Convert s390
> * Rename exit_to_guest_mode() -> guest_state_enter_irqoff()
> * Rename enter_from_guest_mode() -> guest_state_exit_irqoff()
> * Various commit message cleanups
> 
> Since v2 [2]:
> * Rebase to v5.17-rc2
> * Fixup mips exit handling
> * Drop arch_in_rcu_eqs() & s390 patches
> 
> I've pushed the series (based on v5.17-rc2) to my kvm/entry-rework branch:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=kvm/entry-rework
>    git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git kvm/entry-rework
> 
> This version of the series is tagged as kvm-entry-rework-20220201.
> 
> [1] https://lore.kernel.org/r/20220111153539.2532246-1-mark.rutland@arm.com/
> [2] https://lore.kernel.org/r/20220119105854.3160683-1-mark.rutland@arm.com/
> 
> Thanks,
> 
> 
> Mark Rutland (5):
>    kvm: add guest_state_{enter,exit}_irqoff()
>    kvm/arm64: rework guest entry logic
>    kvm/x86: rework guest entry logic
>    kvm/riscv: rework guest entry logic
>    kvm/mips: rework guest entry logic
> 
>   arch/arm64/kvm/arm.c     |  51 +++++++++++-------
>   arch/mips/kvm/mips.c     |  50 +++++++++++++++--
>   arch/riscv/kvm/vcpu.c    |  44 +++++++++------
>   arch/x86/kvm/svm/svm.c   |   4 +-
>   arch/x86/kvm/vmx/vmx.c   |   4 +-
>   arch/x86/kvm/x86.c       |   4 +-
>   arch/x86/kvm/x86.h       |  45 ----------------
>   include/linux/kvm_host.h | 112 +++++++++++++++++++++++++++++++++++++--
>   8 files changed, 222 insertions(+), 92 deletions(-)
> 
