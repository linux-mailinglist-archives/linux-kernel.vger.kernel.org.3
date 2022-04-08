Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838F94F9A1F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 18:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237933AbiDHQKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 12:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237917AbiDHQKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 12:10:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A78D347FA0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 09:08:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F382B113E;
        Fri,  8 Apr 2022 09:08:05 -0700 (PDT)
Received: from [10.1.196.218] (eglon.cambridge.arm.com [10.1.196.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 034B13F73B;
        Fri,  8 Apr 2022 09:08:04 -0700 (PDT)
Subject: Re: arm64 spectre-bhb backports break boot on stable kernels <= v5.4
To:     Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        maz@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
References: <20220408120041.GB27685@willie-the-truck>
From:   James Morse <james.morse@arm.com>
Message-ID: <1a44f42c-0391-7428-ac85-1e27aaf0be14@arm.com>
Date:   Fri, 8 Apr 2022 17:08:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220408120041.GB27685@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 08/04/2022 13:00, Will Deacon wrote:
> Booting stable kernels <= v5.4 on arm64 with CONFIG_HARDEN_BRANCH_PREDICTOR=n
> results in a NULL pointer dereference during boot due to kvm_get_hyp_vector()
> dereferencing a NULL pointer from arm64_get_bp_hardening_data():
> 
> [    2.384444] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [    2.384461] pstate: 20400085 (nzCv daIf +PAN -UAO)
> [    2.384472] pc : cpu_hyp_reinit+0x114/0x30c
> [    2.384476] lr : cpu_hyp_reinit+0x80/0x30c
> [    2.384477] sp : ffff800010013e20
> [    2.384479] x29: ffff800010013e20 x28: ffff0000df033f00
> [    2.384484] x27: ffff800011caa000 x26: ffff0000de58e000
> [    2.384487] x25: ffff800011e57000 x24: ffff800011caad90
> [    2.384490] x23: ffff800011c778e0 x22: ffff800011a56000
> [    2.384494] x21: ffff800011a56000 x20: 0000b471121a6000
> [    2.384497] x19: 00000000de588000 x18: 0000000000000000
> [    2.384500] x17: 0000000000000000 x16: 0000000000000400
> [    2.384503] x15: 0000000000001000 x14: 00000000000007f2
> [    2.384507] x13: 0000000000000004 x12: 0000000000000002
> [    2.384510] x11: 0000000000000000 x10: 00000000121a6000
> [    2.384513] x9 : ffff800011c77fd8 x8 : 0000000000000010
> [    2.384516] x7 : 4f422effff306b64 x6 : 0000008080000000
> [    2.384519] x5 : 0000008080000000 x4 : ffff800011fabc94
> [    2.384522] x3 : ffff800011f5bde0 x2 : 0000000000000001
> [    2.384526] x1 : 00000000121a0000 x0 : ffff8000118f962d
> [    2.384529] Call trace:
> [    2.384533]  cpu_hyp_reinit+0x114/0x30c
> [    2.384537]  _kvm_arch_hardware_enable+0x30/0x54
> [    2.384541]  flush_smp_call_function_queue+0xe4/0x154
> [    2.384544]  generic_smp_call_function_single_interrupt+0x10/0x18
> [    2.384549]  ipi_handler+0x170/0x2b0
> [    2.384555]  handle_percpu_devid_fasteoi_ipi+0x120/0x1cc
> [    2.384560]  __handle_domain_irq+0x9c/0xf4
> [    2.384563]  gic_handle_irq+0x6c/0xe4
> [    2.384566]  el1_irq+0xf0/0x1c0
> [    2.384570]  arch_cpu_idle+0x28/0x44
> [    2.384574]  do_idle+0x100/0x2a8
> [    2.384577]  cpu_startup_entry+0x20/0x24
> [    2.384581]  secondary_start_kernel+0x1b0/0x1cc
> [    2.384589] Code: b9469d08 7100011f 540003ad 52800208 (f9400108)
> [    2.384600] ---[ end trace 266d08dbf96ff143 ]---
> [    2.385171] Kernel panic - not syncing: Fatal exception in interrupt

Yikes!

Interesting to know that stuff behind CONFIG_EXPERT has someone who cares about it.
(I was going to propose dropping the Kconfig option after a while).


> The faulting load is the access to 'data->template_start', for which the
> compiler emits the hilarious:
> 
> 	mov	w8, #0x10
> 	ldr	x8, [x8]

This is nasal-daemon territory, so I guess the compiler can do whatever it likes.


> I can bodge this as below (untested), but it's pretty grotty.

I wanted to keep the detection code even if the feature is disabled so the sysfs reporting
is always correct.


> Please can you take a look?

Ugh, arm64_get_bp_hardening_data() returns NULL with that Kconfig setup.


For v5.4, this fixes it for me:
--------------------%<--------------------
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 78d110667c0c..ffe0aad96b17 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -479,7 +479,8 @@ static inline void *kvm_get_hyp_vector(void)
        int slot = -1;

        if ((cpus_have_const_cap(ARM64_HARDEN_BRANCH_PREDICTOR) ||
-            cpus_have_const_cap(ARM64_SPECTRE_BHB)) && data->template_start) {
+            cpus_have_const_cap(ARM64_SPECTRE_BHB)) &&
+           data && data->template_start) {
                vect = kern_hyp_va(kvm_ksym_ref(__bp_harden_hyp_vecs_start));
                slot = data->hyp_vectors_slot;
        }

--------------------%<--------------------

I'll check the other versions and post patches to the stable list. Earlier stable
backports grew a dependency between these features as it wasn't possible to unpick the
dependencies.


Thanks,

James
