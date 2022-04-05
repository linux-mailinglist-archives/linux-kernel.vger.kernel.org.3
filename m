Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282084F46A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348316AbiDEUik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457201AbiDEQCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:02:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 353632A727
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649172764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RVunoBqxd/XMcSCf/aNcM3Bo2FCKUnhDjeaR63SyLgs=;
        b=EjgC4JahvU1MDFciY2tmV2yHDJmiSxYWZtD1/Dr8ukcbqHZ61Qdyy6iaWBiVNuFXzqd9nl
        WRjIMLbBGW8i5Ksyf2MOVMLC0EH1WA5bPts6Drqajk5CdVMyzLApw7yjGFqxeCUbpuD3jm
        69kJag1BByaBnfjHXwSo1w7Jp6TzWv4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-212-xm9I_fGBPwCe8hkKiUjZ9Q-1; Tue, 05 Apr 2022 11:32:43 -0400
X-MC-Unique: xm9I_fGBPwCe8hkKiUjZ9Q-1
Received: by mail-wm1-f72.google.com with SMTP id r19-20020a7bc093000000b0038e706da7c0so1401286wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 08:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RVunoBqxd/XMcSCf/aNcM3Bo2FCKUnhDjeaR63SyLgs=;
        b=Tdl7Xiikdpo3YeICgS/uMYYmbVkcaZw2gurWQCm3oJ8AOUh/TBNSOsGYKke7elUVX2
         8CstJsxN0u6E7FV0lR/J3wvud7/1klca93vXbSsIMZuoCZmC58yOFbqsY9Kxkqarq29d
         8rOn1Zxdhdcxag4zDSOQyrhoF3dXdrFFs2vQ1t20kWHYozsKBmL/GXGKxUfEjlPPwnBS
         hwYfHuntky3nzaJ/6onmbXVAo3wTjjEvf5I67/a7WDuRibWDWN/AWi7TbSuWV6S7/vYU
         bu6o+Ahpuh7t1J0rhRRAfMrXAbSglVDM6jCkc/Y33LT4vkCgVOw7+NwRSXmDGeXNKxWN
         Ht1g==
X-Gm-Message-State: AOAM531Z3vcTgxyx8vP06bR9KHYpH/vR+Cl8lmgRFpMk/cXDVRZ+rPZs
        NnzW2dmdXa6SVNU96dEfl9fO4inIpcRHixxom2ruU6uymTlevY8HwrIXU9a+KJJ/sHgIQHIjz9t
        crmRBms81FkuXo19pCwrPlaCy
X-Received: by 2002:adf:f481:0:b0:205:b814:887b with SMTP id l1-20020adff481000000b00205b814887bmr3197546wro.472.1649172761890;
        Tue, 05 Apr 2022 08:32:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxk0EshXz5dy68LFNeLcoRvlMOAY0pRMlD9cxw8B09LYKsaas8YLt1BZFcNUhoqfeEeSL3uHw==
X-Received: by 2002:adf:f481:0:b0:205:b814:887b with SMTP id l1-20020adff481000000b00205b814887bmr3197534wro.472.1649172761674;
        Tue, 05 Apr 2022 08:32:41 -0700 (PDT)
Received: from [10.32.181.87] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.googlemail.com with ESMTPSA id p30-20020a05600c1d9e00b0038cc9d6ff0bsm2637394wms.33.2022.04.05.08.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 08:32:40 -0700 (PDT)
Message-ID: <ea136ac6-53cf-cdc5-a741-acfb437819b1@redhat.com>
Date:   Tue, 5 Apr 2022 17:32:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v5 074/104] KVM: x86: Add a switch_db_regs flag to
 handle TDX's auto-switched behavior
Content-Language: en-US
To:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@gmail.com, Jim Mattson <jmattson@google.com>,
        erdemaktas@google.com, Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>
References: <cover.1646422845.git.isaku.yamahata@intel.com>
 <76c87a1d33bb3ec4a68fe3db2a840b6ddc951929.1646422845.git.isaku.yamahata@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <76c87a1d33bb3ec4a68fe3db2a840b6ddc951929.1646422845.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/22 20:49, isaku.yamahata@intel.com wrote:
>   	vcpu->arch.efer = EFER_SCE | EFER_LME | EFER_LMA | EFER_NX;
>   
> +	vcpu->arch.switch_db_regs = KVM_DEBUGREG_AUTO_SWITCH;
>   	vcpu->arch.cr0_guest_owned_bits = -1ul;
>   	vcpu->arch.cr4_guest_owned_bits = -1ul;
>   
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 45e8a02e99bf..89d04cd64cd0 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10084,7 +10084,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>   	if (vcpu->arch.guest_fpu.xfd_err)
>   		wrmsrl(MSR_IA32_XFD_ERR, vcpu->arch.guest_fpu.xfd_err);
>   
> -	if (unlikely(vcpu->arch.switch_db_regs)) {
> +	if (unlikely(vcpu->arch.switch_db_regs & ~KVM_DEBUGREG_AUTO_SWITCH)) {
>   		set_debugreg(0, 7);
>   		set_debugreg(vcpu->arch.eff_db[0], 0);
>   		set_debugreg(vcpu->arch.eff_db[1], 1);

I'm confused.  I'm probably missing something obvious, but where does
KVM_DEBUGREG_AUTO_SWITCH affect the behavior of KVM?  vcpu_enter_guest
would still write %db0-%db3 if KVM_DEBUGREG_BP_ENABLED is set, for
example.

Do you mean:

	if (unlikely(vcpu->arch.switch_db_regs) &&
	    !unlikely(vcpu->arch.switch_db_regs & KVM_DEBUGREG_AUTO_SWITCH)) {

?

Paolo
  
> @@ -10126,6 +10126,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>   	 */
>   	if (unlikely(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT)) {
>   		WARN_ON(vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP);
> +		WARN_ON(vcpu->arch.switch_db_regs & KVM_DEBUGREG_AUTO_SWITCH);
>   		static_call(kvm_x86_sync_dirty_debug_regs)(vcpu);
>   		kvm_update_dr0123(vcpu);
>   		kvm_update_dr7(vcpu);

