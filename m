Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18689509A96
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386617AbiDUIWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381397AbiDUIWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:22:31 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7375F91
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:19:42 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id y11so2595180ilp.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P56/aqSXvni0QoKYoULDb5A31mpfbgt7sEmpHmoEIlc=;
        b=gIn2mMnS06epgXRLCjvtDw0+hmC9kUfx972AMTP2HYiuJPuMhetM+2OFI7uWnP+d4d
         nKqczCfnhT4SnEAPM9L7mD01JL5Vo2t75f4DvsuUActO7Dz+pqkoODU7UUXyJ2uJZtEO
         T9Gq/InZZvSYMov5dFcli+LbhIw2hZ1M/qixsQwudzF7SotQRXjxI2mTsR+fZUs2At8N
         r7bOR/0uITmjddTHz37YXO/IF3mFPCM3nLTQQeSp8BtvxUOD13uacYQUil139zpTMZsq
         5l+mS2nKKQRbfCduDTno5oNDsjp8uiOsm6R+EYmz0UhdLHD4LcnA/mXFBWaNXKd6ou/5
         Bo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P56/aqSXvni0QoKYoULDb5A31mpfbgt7sEmpHmoEIlc=;
        b=nEq7BwwY8GcooiJT92DaOrUWj4Z8rPmHKZ3+QU0DvQfXJfn0ciJGePGroHGkEDzQU9
         ypsH327/flFvn4sCQHs1BleOa7C5oUwt1GdSwgJbPY8H/kjhr9T+MVpCQq0IOXiQkDKE
         OWMlIO/csMO8ocMDCtC6veMM+j7+UHFZyUrIES7EwXfGD8x08xmn5UwW77zmJFekPyMP
         iewfFBdCoyXKR6xDGP063nbbIe/D5vuG08fwOpq9s6YoXmdroJW+8gs/rgKWsy5VSIAc
         OaX2c8OaKCDqFhoxhyaIj/4WWboPbBhGIAflWrWdAuzX8+y5vd9DPhYGiQGYXjjTZ2VH
         6B9Q==
X-Gm-Message-State: AOAM530jsZyytvxnGK8xV1FLYqAkSObUYMeRjJ+Ltcw4u5T2070DKe56
        8mBiAft0lhGy1/qxOvl8by24NA==
X-Google-Smtp-Source: ABdhPJw6Tzh8S+DTfpy5e1rXdQR4qQkWA+uh3alJlY8pBN6QySeAAm7+u/vmzg0iDamD8CnzRhBhGg==
X-Received: by 2002:a92:d7d0:0:b0:2ca:33ba:8bde with SMTP id g16-20020a92d7d0000000b002ca33ba8bdemr11313305ilq.121.1650529181878;
        Thu, 21 Apr 2022 01:19:41 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id q18-20020a92c012000000b002cac16f96cesm11828268ild.82.2022.04.21.01.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 01:19:40 -0700 (PDT)
Date:   Thu, 21 Apr 2022 08:19:37 +0000
From:   Oliver Upton <oupton@google.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        eauger@redhat.com, Jonathan.Cameron@huawei.com,
        vkuznets@redhat.com, will@kernel.org, shannon.zhaosl@gmail.com,
        james.morse@arm.com, mark.rutland@arm.com, maz@kernel.org,
        pbonzini@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v6 02/18] KVM: arm64: Route hypercalls based on their
 owner
Message-ID: <YmETmWvPPQvHpQwP@google.com>
References: <20220403153911.12332-1-gshan@redhat.com>
 <20220403153911.12332-3-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403153911.12332-3-gshan@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,

On Sun, Apr 03, 2022 at 11:38:55PM +0800, Gavin Shan wrote:
> kvm_hvc_call_handler() directly handles the incoming hypercall, or
> and routes it based on its (function) ID. kvm_psci_call() becomes
> the gate keeper to handle the hypercall that can't be handled by
> any one else. It makes kvm_hvc_call_handler() a bit messy.
> 
> This reorgnizes the code to route the hypercall to the corresponding
> handler based on its owner.

nit: write changelogs in the imperative:

Reorganize the code to ...

> The hypercall may be handled directly
> in the handler or routed further to the corresponding functionality.
> The (function) ID is always verified before it's routed to the
> corresponding functionality. By the way, @func_id is repalced by
> @func, to be consistent with by smccc_get_function().
> 
> PSCI is the only exception, those hypercalls defined by 0.2 or
> beyond are routed to the handler for Standard Secure Service, but
> those defined in 0.1 are routed to the handler for Standard
> Hypervisor Service.
> 
> Suggested-by: Oliver Upton <oupton@google.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/kvm/hypercalls.c | 199 +++++++++++++++++++++++-------------
>  1 file changed, 127 insertions(+), 72 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
> index 8438fd79e3f0..b659387d8919 100644
> --- a/arch/arm64/kvm/hypercalls.c
> +++ b/arch/arm64/kvm/hypercalls.c

[...]

> +static int kvm_hvc_standard(struct kvm_vcpu *vcpu, u32 func)
> +{
> +	u64 val = SMCCC_RET_NOT_SUPPORTED;
> +
> +	switch (func) {
> +	case ARM_SMCCC_TRNG_VERSION ... ARM_SMCCC_TRNG_RND32:
> +	case ARM_SMCCC_TRNG_RND64:
> +		return kvm_trng_call(vcpu);
> +	case PSCI_0_2_FN_PSCI_VERSION ... PSCI_0_2_FN_SYSTEM_RESET:
> +	case PSCI_0_2_FN64_CPU_SUSPEND ... PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU:
> +	case PSCI_1_0_FN_PSCI_FEATURES ... PSCI_1_0_FN_SET_SUSPEND_MODE:
> +	case PSCI_1_0_FN64_SYSTEM_SUSPEND:
> +	case PSCI_1_1_FN_SYSTEM_RESET2:
> +	case PSCI_1_1_FN64_SYSTEM_RESET2:

Isn't it known from the SMCCC what range of hypercall numbers PSCI and
TRNG fall under, respectively?

https://developer.arm.com/documentation/den0028/e/

See sections 6.3 and 6.4.

> +		return kvm_psci_call(vcpu);
> +	}
> +
> +	smccc_set_retval(vcpu, val, 0, 0, 0);
> +	return 1;

I don't think any cases of the switch statement change val, could you
just use SMCCC_RET_NOT_SUPPORTED here?

> +}
> +
> +static int kvm_hvc_standard_hyp(struct kvm_vcpu *vcpu, u32 func)
> +{
> +	u64 val = SMCCC_RET_NOT_SUPPORTED;
> +	gpa_t gpa;
> +
> +	switch (func) {
>  	case ARM_SMCCC_HV_PV_TIME_FEATURES:
> -		val[0] = kvm_hypercall_pv_features(vcpu);
> +		val = kvm_hypercall_pv_features(vcpu);
>  		break;
>  	case ARM_SMCCC_HV_PV_TIME_ST:
>  		gpa = kvm_init_stolen_time(vcpu);
>  		if (gpa != GPA_INVALID)
> -			val[0] = gpa;
> +			val = gpa;
>  		break;
> +	case KVM_PSCI_FN_CPU_SUSPEND ... KVM_PSCI_FN_MIGRATE:
> +		return kvm_psci_call(vcpu);

You might want to handle these from the main call handler with a giant
disclaimer that these values predate SMCCC and therefore collide with
the standard hypervisor service range.

[...]

> +
> +int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
> +{
> +	u32 func = smccc_get_function(vcpu);
> +	u64 val = SMCCC_RET_NOT_SUPPORTED;
> +
> +	switch (ARM_SMCCC_OWNER_NUM(func)) {
> +	case ARM_SMCCC_OWNER_ARCH:
> +		return kvm_hvc_arch(vcpu, func);
> +	case ARM_SMCCC_OWNER_STANDARD:
> +		return kvm_hvc_standard(vcpu, func);
> +	case ARM_SMCCC_OWNER_STANDARD_HYP:
> +		return kvm_hvc_standard_hyp(vcpu, func);
> +	case ARM_SMCCC_OWNER_VENDOR_HYP:
> +		return kvm_hvc_vendor_hyp(vcpu, func);
> +	}
> +
> +	smccc_set_retval(vcpu, val, 0, 0, 0);

Same here, avoid indirecting the return value through a local variable.

--
Thanks,
Oliver
