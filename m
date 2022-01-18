Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E374925BE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 13:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbiARMdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 07:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiARMdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 07:33:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21349C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 04:33:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D462AB8169D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 12:33:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF26C00446;
        Tue, 18 Jan 2022 12:32:58 +0000 (UTC)
Date:   Tue, 18 Jan 2022 12:32:55 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, maz@kernel.org, will@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com, jean-philippe@linaro.org,
        Alexandru.Elisei@arm.com, qperret@google.com,
        jonathan.cameron@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH v4 0/4] kvm/arm: New VMID allocator based on asid
Message-ID: <Yeazd1lLuYm4k3lH@arm.com>
References: <20211122121844.867-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211122121844.867-1-shameerali.kolothum.thodi@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shameer,

On Mon, Nov 22, 2021 at 12:18:40PM +0000, Shameer Kolothum wrote:
>  -TLA+ model. Modified the asidalloc model to incorporate the new
>   VMID algo. The main differences are,
>   -flush_tlb_all() instead of local_tlb_flush_all() on rollover.
>   -Introduced INVALID_VMID and vCPU Sched Out logic.
>   -No CnP (Removed UniqueASIDAllCPUs & UniqueASIDActiveTask invariants).
>   -Removed  UniqueVMIDPerCPU invariant for now as it looks like
>    because of the speculative fetching with flush_tlb_all() there
>    is a small window where this gets triggered. If I change the
>    logic back to local_flush_tlb_all(), UniqueVMIDPerCPU seems to
>    be fine. With my limited knowledge on TLA+ model, it is not
>    clear to me whether this is a problem with the above logic
>    or the VMID model implementation. Really appreciate any help
>    with the model.
>    The initial VMID TLA+ model is here,
>    https://github.com/shamiali2008/kernel-tla/tree/private-vmidalloc-v1

I only had a brief look at the TLA+ model and I don't understand why you
have a separate 'shed_out' process. It would run in parallel with the
'sched' but AFAICT you can't really schedule a guest out while you are
in the middle of scheduling it in. I'd rather use the same 'sched'
process and either schedule in an inactive task or schedule out an
active one for a given CPU.

Also active_vmids[] for example is defined on the CPUS domain but you
call vcpu_sched_out() from a process that's not in the CPUS domain but
the SCHED_OUT one.

Regarding UniqueVMIDPerCPU, I think we need to figure out why it
happens. The fact that flush_tlb_all() was made to simulate the
speculative TLB loads is not relevant. In a different spec I have,
arm64kpti.tla, I just used another process that invokes an update_tlbs()
macro so that it can happen at any time. I didn't bother to update the
ASID spec in a similar way but it may be useful. The corresponding
UniqueASIDPerCPU meant that for any two TLB entries on a single CPU, if
they correspond to different tasks (pgd), they should have different
ASIDs. That's a strong requirement, otherwise we end up with the wrong
translation.

Why did you remove the CnP? Do we have this disabled for KVM guests?

-- 
Catalin
