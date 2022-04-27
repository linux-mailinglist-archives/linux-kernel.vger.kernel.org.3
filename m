Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F085D511F0F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243144AbiD0Q0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243075AbiD0Q0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:26:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC8FF255BE4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651076348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KCM+kR4pTupLxaN7Pzr4seAbVUE+H+zCFEJvKXyp008=;
        b=ZRfOiGashDmdovoPQIq9xI7w58h4BgeNUp/YFRBjO5HYfbZayxNnhzQdB1MTm9IsLrwBRU
        7Z0DqFrzWD/wY2vfFewNHfXv58e/ZoHklz7hbp5ZRN0XHd93Hu9ZjNLgMbPN30mmXsxoyR
        EveE9AsQa/rEcDzxo0POFoObcKDHCXE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357-dE2jykcOMJCSXUSNYwu0jg-1; Wed, 27 Apr 2022 12:19:06 -0400
X-MC-Unique: dE2jykcOMJCSXUSNYwu0jg-1
Received: by mail-ed1-f70.google.com with SMTP id ee56-20020a056402293800b00425b0f5b9c6so1256668edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KCM+kR4pTupLxaN7Pzr4seAbVUE+H+zCFEJvKXyp008=;
        b=GZ/oOxDvOABTfcikYakItw5eqALxdiBPeuu1JSD76mS4ZTQl6zVWhwHP5qNIyGOA+q
         3ZVv0YqbmHe/ZpJ8gi4NxFVy0xP78DlzluZ3nyE5+nSGyWq/TqEOWeogrhCConm7BSOm
         okma6fsFUoOJ0kccCz3irwDzuROUQdgOtb+b+yraasWzoCMHdFIgWfhNzFj2RGjItImC
         dX3ymqktYW5YKlX3wGmeh/w74GGfhwxft3MPbRSia9D7FIZ1TIBdaWg1MfuuUNM6ZpqY
         /IeavhcSoyRp2g9pSXuQknE2jtLSdVfGWys7Io3pF0MYetUEmj0x1R5reW47G6W3yrVE
         DuNg==
X-Gm-Message-State: AOAM532Jiq5/ZFcNak7jsIrmrGWLJQgIrz+grEjWEHWCxmJ5A4i1gP9P
        zSGcwGzPalF1/quFIn/PCyJO/qAYZxf9FMnh8TQvLG4dL1mmxG0AgV3lYL23+FlXUaCGdDCfRAF
        9o4zUAppAW3nI3e1Wv8sR5PT1
X-Received: by 2002:a05:6402:5201:b0:426:124:a40b with SMTP id s1-20020a056402520100b004260124a40bmr7129621edd.198.1651076345465;
        Wed, 27 Apr 2022 09:19:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoHUy4nFsODaBAroyqMZG+PQ9rRZ5tD2/3U187eXKeQcTQ49CZmgADEk7rJYMAIQsQErds4g==
X-Received: by 2002:a05:6402:5201:b0:426:124:a40b with SMTP id s1-20020a056402520100b004260124a40bmr7129587edd.198.1651076345207;
        Wed, 27 Apr 2022 09:19:05 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id mb22-20020a170906eb1600b006f38dcf211bsm4894492ejb.138.2022.04.27.09.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 09:19:04 -0700 (PDT)
Message-ID: <bfe99275-a15e-306b-d628-d68754e52c2d@redhat.com>
Date:   Wed, 27 Apr 2022 18:19:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH MANUALSEL 5.10 1/4] x86/kvm: Preserve BSP
 MSR_KVM_POLL_CONTROL across suspend/resume
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Marcelo Tosatti <mtosatti@redhat.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, kvm@vger.kernel.org
References: <20220427155435.19554-1-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220427155435.19554-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/22 17:54, Sasha Levin wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> [ Upstream commit 0361bdfddca20c8855ea3bdbbbc9c999912b10ff ]
> 
> MSR_KVM_POLL_CONTROL is cleared on reset, thus reverting guests to
> host-side polling after suspend/resume.  Non-bootstrap CPUs are
> restored correctly by the haltpoll driver because they are hot-unplugged
> during suspend and hot-plugged during resume; however, the BSP
> is not hotpluggable and remains in host-sde polling mode after
> the guest resume.  The makes the guest pay for the cost of vmexits
> every time the guest enters idle.
> 
> Fix it by recording BSP's haltpoll state and resuming it during guest
> resume.
> 
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> Message-Id: <1650267752-46796-1-git-send-email-wanpengli@tencent.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   arch/x86/kernel/kvm.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 18e952fed021..6c3d38b5a8ad 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -66,6 +66,7 @@ static DEFINE_PER_CPU_DECRYPTED(struct kvm_vcpu_pv_apf_data, apf_reason) __align
>   DEFINE_PER_CPU_DECRYPTED(struct kvm_steal_time, steal_time) __aligned(64) __visible;
>   static int has_steal_clock = 0;
>   
> +static int has_guest_poll = 0;
>   /*
>    * No need for any "IO delay" on KVM
>    */
> @@ -624,14 +625,26 @@ static int kvm_cpu_down_prepare(unsigned int cpu)
>   
>   static int kvm_suspend(void)
>   {
> +	u64 val = 0;
> +
>   	kvm_guest_cpu_offline(false);
>   
> +#ifdef CONFIG_ARCH_CPUIDLE_HALTPOLL
> +	if (kvm_para_has_feature(KVM_FEATURE_POLL_CONTROL))
> +		rdmsrl(MSR_KVM_POLL_CONTROL, val);
> +	has_guest_poll = !(val & 1);
> +#endif
>   	return 0;
>   }
>   
>   static void kvm_resume(void)
>   {
>   	kvm_cpu_online(raw_smp_processor_id());
> +
> +#ifdef CONFIG_ARCH_CPUIDLE_HALTPOLL
> +	if (kvm_para_has_feature(KVM_FEATURE_POLL_CONTROL) && has_guest_poll)
> +		wrmsrl(MSR_KVM_POLL_CONTROL, 0);
> +#endif
>   }
>   
>   static struct syscore_ops kvm_syscore_ops = {

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

