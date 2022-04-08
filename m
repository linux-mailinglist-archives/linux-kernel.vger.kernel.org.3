Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B144F9AD0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 18:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbiDHQk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 12:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbiDHQkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 12:40:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B823212220F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 09:38:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CAD21042;
        Fri,  8 Apr 2022 09:38:20 -0700 (PDT)
Received: from [10.1.196.218] (eglon.cambridge.arm.com [10.1.196.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E8AC3F73B;
        Fri,  8 Apr 2022 09:38:19 -0700 (PDT)
Subject: Re: arm64 spectre-bhb backports break boot on stable kernels <= v5.4
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, maz@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com
References: <20220408120041.GB27685@willie-the-truck>
 <1a44f42c-0391-7428-ac85-1e27aaf0be14@arm.com>
 <20220408162139.GB28108@willie-the-truck>
From:   James Morse <james.morse@arm.com>
Message-ID: <d3d1c89e-82d7-6894-5bc0-3a0bbf367b8f@arm.com>
Date:   Fri, 8 Apr 2022 17:38:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220408162139.GB28108@willie-the-truck>
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

On 08/04/2022 17:21, Will Deacon wrote:
> On Fri, Apr 08, 2022 at 05:08:00PM +0100, James Morse wrote:
>> On 08/04/2022 13:00, Will Deacon wrote:
>>> Booting stable kernels <= v5.4 on arm64 with CONFIG_HARDEN_BRANCH_PREDICTOR=n
>>> results in a NULL pointer dereference during boot due to kvm_get_hyp_vector()
>>> dereferencing a NULL pointer from arm64_get_bp_hardening_data():
>>>
>>> [    2.384444] Internal error: Oops: 96000004 [#1] PREEMPT SMP
>>> [    2.384461] pstate: 20400085 (nzCv daIf +PAN -UAO)
>>> [    2.384472] pc : cpu_hyp_reinit+0x114/0x30c
>>> [    2.384476] lr : cpu_hyp_reinit+0x80/0x30c

>>> [    2.385171] Kernel panic - not syncing: Fatal exception in interrupt
>>
>> Yikes!
>>
>> Interesting to know that stuff behind CONFIG_EXPERT has someone who cares about it.
>> (I was going to propose dropping the Kconfig option after a while).

> Yup! FWIW, the hardening options are enabled in Android (GKI), but this was
> reported to us externally by somebody using a custom config.

>>> I can bodge this as below (untested), but it's pretty grotty.
>>
>> I wanted to keep the detection code even if the feature is disabled so the sysfs reporting
>> is always correct.
> 
> Makes sense. Another option is to check for ARM64_HARDEN_BRANCH_PREDICTOR in
> spectre_bhb_enable_mitigation(), but then I think the KVM code would need
> to query the mitigation state rather than just the cap.

It already does, but as you say KVM is only using the cap here.


>>> Please can you take a look?
>>
>> Ugh, arm64_get_bp_hardening_data() returns NULL with that Kconfig setup.
>>
>>
>> For v5.4, this fixes it for me:
>> --------------------%<--------------------
>> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
>> index 78d110667c0c..ffe0aad96b17 100644
>> --- a/arch/arm64/include/asm/kvm_mmu.h
>> +++ b/arch/arm64/include/asm/kvm_mmu.h
>> @@ -479,7 +479,8 @@ static inline void *kvm_get_hyp_vector(void)
>>         int slot = -1;
>>
>>         if ((cpus_have_const_cap(ARM64_HARDEN_BRANCH_PREDICTOR) ||
>> -            cpus_have_const_cap(ARM64_SPECTRE_BHB)) && data->template_start) {
>> +            cpus_have_const_cap(ARM64_SPECTRE_BHB)) &&
>> +           data && data->template_start) {
>>                 vect = kern_hyp_va(kvm_ksym_ref(__bp_harden_hyp_vecs_start));
>>                 slot = data->hyp_vectors_slot;
>>         }
> 
> That'll work, but will sysfs report that BHB is mitigated even if
> !ARM64_HARDEN_BRANCH_PREDICTOR?

The (!IS_ENABLED(CONFIG_HARDEN_BRANCH_PREDICTOR) in check_branch_predictor() will set
__hardenbp_enab to false, which get_spectre_v2_workaround_state() picks up and causes
spectre_bhb_enable_mitigation() to skip all the mitigations, leaving state =
SPECTRE_VULNERABLE.

(The interactions with the other Spectre mitigations across the stable kernels
were/continue-to-be a pain in the neck)


>> --------------------%<--------------------
>>
>> I'll check the other versions and post patches to the stable list. Earlier stable
>> backports grew a dependency between these features as it wasn't possible to unpick the
>> dependencies.
> 
> Cheers. I know 4.19 is busted too, but I didn't check 4.14.

Yup, I've just reproduced that one. I suspect v4.14 is where I added the Kconfig dependency.


Thanks,

James
