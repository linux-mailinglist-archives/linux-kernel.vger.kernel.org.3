Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5EF54B045
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356812AbiFNMMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356740AbiFNMMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:12:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44BA923BDC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 05:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655208741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d25xRoBQKRAgDG7iS47n8JHMGxyJKkyKtJs+59Z9jLk=;
        b=b8VFeUd9emjza7UkBh4RnmFJ9W9xFqpUdqoZ9r2/74MtUxy8q+I6T7kX8NcxoPZRHGUlAq
        T5kMYXNo9rzfESQydzm5DGdPEsJTlVwsP0pxZUkaNVQpDZhZTNj3KUvFaYMsbqDIpI9Agb
        ESG+5tVe3LTTp1coOue95uOhuivoZeM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-VjvkTzQ8PTOEym4gZjJ2kg-1; Tue, 14 Jun 2022 08:12:14 -0400
X-MC-Unique: VjvkTzQ8PTOEym4gZjJ2kg-1
Received: by mail-ed1-f72.google.com with SMTP id x15-20020a05640226cf00b004318eab9feaso6059914edd.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 05:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=d25xRoBQKRAgDG7iS47n8JHMGxyJKkyKtJs+59Z9jLk=;
        b=6c4UzeXV/r132OXYiA51V692vR4MuKDNw/LQ2O0bvrsc6H0XNwKmVgLWeK+0SuCYFI
         dK57KiUm3ZmNOx3Wlv3HzectrbjqPcDVDyT/hh7WbX3uuZ87++pDENMjyMcdCWY7GV8P
         meVlP9JOFeQoyqqT9kOMV7RPSCo0+ZemKUJgtBTBOwOeQVsW3OJz0wJz4eBYBGHOLaZv
         6dBrbNZycYDvnErcRCLTxOqQAOhkggnsGtAAXplIdQ1L5RT6zY1WHwSva4w6/Vsl2OOg
         WQwSwvRfDPT1OtH7uvZ4h8TUhliZURmnRkGWaHmYYNyjG4bxxe428aYOuNcWbgRvGMze
         NtPw==
X-Gm-Message-State: AJIora//C++FeKR+9ulTuwhvE2f75VkA7cX9C/kdvSwWUqqqPY5zDuOc
        GBTvISzoW9VBhGK+GhkDSFyh9U93UeqtcdrCECMI4dsZDCqm7ncoNsWRRmGPTmcF1OqUV3aRCu1
        uussrSWPvaZK3P9eBR+w9CQU0
X-Received: by 2002:a17:906:6a1a:b0:711:ec13:b7bc with SMTP id qw26-20020a1709066a1a00b00711ec13b7bcmr3968817ejc.688.1655208733223;
        Tue, 14 Jun 2022 05:12:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vwaLRxXVn7myO45bdvHsZKXRkI9DCKejCwsiPHmTwtfJ4ri3r55aSyki+hrnXTHrc4Vxdijw==
X-Received: by 2002:a17:906:6a1a:b0:711:ec13:b7bc with SMTP id qw26-20020a1709066a1a00b00711ec13b7bcmr3968803ejc.688.1655208732976;
        Tue, 14 Jun 2022 05:12:12 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id j10-20020a50d00a000000b004319b12371asm7035004edf.47.2022.06.14.05.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 05:12:12 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>
Cc:     mail@anirudhrb.com, kumarpraveen@linux.microsoft.com,
        wei.liu@kernel.org, robert.bradford@intel.com, liuwe@microsoft.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Ilias Stamatis <ilstam@amazon.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH] KVM: nVMX: Don't expose TSC scaling to L1 when on Hyper-V
In-Reply-To: <592ab920-51f3-4794-331f-8737e1f5b20a@redhat.com>
References: <20220613161611.3567556-1-anrayabh@linux.microsoft.com>
 <592ab920-51f3-4794-331f-8737e1f5b20a@redhat.com>
Date:   Tue, 14 Jun 2022 14:12:11 +0200
Message-ID: <87v8t3igv8.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 6/13/22 18:16, Anirudh Rayabharam wrote:
>> +	if (!kvm_has_tsc_control)
>> +		msrs->secondary_ctls_high &= ~SECONDARY_EXEC_TSC_SCALING;
>> +
>>   	msrs->secondary_ctls_low = 0;
>>   	msrs->secondary_ctls_high &=
>>   		SECONDARY_EXEC_DESC |
>> @@ -6667,8 +6670,7 @@ void nested_vmx_setup_ctls_msrs(struct nested_vmx_msrs *msrs, u32 ept_caps)
>>   		SECONDARY_EXEC_RDRAND_EXITING |
>>   		SECONDARY_EXEC_ENABLE_INVPCID |
>>   		SECONDARY_EXEC_RDSEED_EXITING |
>> -		SECONDARY_EXEC_XSAVES |
>> -		SECONDARY_EXEC_TSC_SCALING;
>> +		SECONDARY_EXEC_XSAVES;
>>   
>>   	/*
>
> This is wrong because it _always_ disables SECONDARY_EXEC_TSC_SCALING,
> even if kvm_has_tsc_control == true.
>
> That said, I think a better implementation of this patch is to just add
> a version of evmcs_sanitize_exec_ctrls that takes a struct
> nested_vmx_msrs *, and call it at the end of nested_vmx_setup_ctl_msrs like
>
> 	evmcs_sanitize_nested_vmx_vsrs(msrs);
>
> Even better (but I cannot "mentally test it" offhand) would be just
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index e802f71a9e8d..b3425ce835c5 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1862,7 +1862,7 @@ int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>   		 * sanity checking and refuse to boot. Filter all unsupported
>   		 * features out.
>   		 */
> -		if (!msr_info->host_initiated &&
> +		if (static_branch_unlikely(&enable_evmcs) ||
>   		    vmx->nested.enlightened_vmcs_enabled)
>   			nested_evmcs_filter_control_msr(msr_info->index,
>   							&msr_info->data);
>
> I cannot quite understand the host_initiated check, so I'll defer to
> Vitaly on why it is needed. Most likely, removing it would cause some
> warnings in QEMU with e.g. "-cpu Haswell,+vmx"; but I think it's a
> userspace bug and we should remove that part of the condition. 

I forgot the details, of course, but 31de3d2500e4 says:

```
    With fine grained VMX feature enablement QEMU>=4.2 tries to do KVM_SET_MSRS
    with default (matching CPU model) values and in case eVMCS is also enabled,
    fails.
```

so it certainly was a workaround for QEMU.

-- 
Vitaly

