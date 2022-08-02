Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB58D587CAD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 14:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbiHBMxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 08:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiHBMxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:53:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD55CDFC5
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 05:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659444779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5ikm4kV/UdS8r7b2LACfyNidZ5DHXkyUZcz44yJZqUQ=;
        b=MBFC1JyE3HldgwuJ/+T5PlLxgyNMTbAVyP8/XqBkV9AVsdDEcIwMzGbxmlcBav46DFbH0a
        AmDlEeyIZiTqizfdi3kPgWstRtx3I51Der8ETMCPyxvWkmNsM9JKx2Q3C59mxTB/b+x5v6
        JlrfAM6dawMUjtOzG4iOL8/HRRrcrlU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-36-iEzSi1o5NMq4fevjeTPzdA-1; Tue, 02 Aug 2022 08:52:58 -0400
X-MC-Unique: iEzSi1o5NMq4fevjeTPzdA-1
Received: by mail-wm1-f72.google.com with SMTP id p2-20020a05600c1d8200b003a3262d9c51so9466080wms.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 05:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=5ikm4kV/UdS8r7b2LACfyNidZ5DHXkyUZcz44yJZqUQ=;
        b=M5LqHr3O8alBftWwZcQzxGiuk/1Oi+7RfUn/S0jiVMtqwCMw8K46NoadMX+Rrn04BV
         pyY7pK+adjXaqIUKREm8KrcZhKZMuGe7QzWCI8c99xQ8ei6ZvxHOGjjsHWlly3pI0Dbp
         CXH+PnaPIe1U/DznzJGG3TlumC1Iq4HAYmrkgwmkppNKpNSuMU8uc/yDtT4/ELJN2Xrq
         WkePwJ64f4ydSLg0ET/k2Jsz/YIa7eHxFAt4c8FaA5Fk+qkNZPvrRX4OrIQycaUOJJWF
         L3lFzUwshxV0pJjHWR41QvnAHky19MGrXHfenG4TDF4msiyCL4j7dr1bjmMixUU+mBHY
         t8Hw==
X-Gm-Message-State: ACgBeo0duJI+fSXiPRo0aREjTXUblK6eUKs5OUiYwv5UGboa7zZzp0lm
        i2vAjl/+2MuJBmQoB+/HDm1nHUJLX05bhJ+tG6epuljA1m2LggPlYImEqj46c74z3Zlb5o6exZy
        9hAH0EatPpfEJDIXsdHGBktxUf9/qN+FBXnJTq5O7CRfkX49CJ+TqBEnZx/xXuBeH7S3/ImD0FT
        Tc
X-Received: by 2002:adf:efc3:0:b0:21f:15aa:1b40 with SMTP id i3-20020adfefc3000000b0021f15aa1b40mr11167765wrp.159.1659444777681;
        Tue, 02 Aug 2022 05:52:57 -0700 (PDT)
X-Google-Smtp-Source: AA6agR53vslDjhAhACNp2Z0SdysXb8V4ku9F/Q9BfjcKTCX8Mhagp7O22Wv6hJv6kZKMItFdg5F7vg==
X-Received: by 2002:adf:efc3:0:b0:21f:15aa:1b40 with SMTP id i3-20020adfefc3000000b0021f15aa1b40mr11167735wrp.159.1659444777341;
        Tue, 02 Aug 2022 05:52:57 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id ba4-20020a0560001c0400b002205f0890eesm8621527wrb.77.2022.08.02.05.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 05:52:56 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/25] KVM: VMX: Tweak the special handling of
 SECONDARY_EXEC_ENCLS_EXITING in setup_vmcs_config()
In-Reply-To: <YtnPEem7q1i+4VBN@google.com>
References: <20220714091327.1085353-1-vkuznets@redhat.com>
 <20220714091327.1085353-15-vkuznets@redhat.com>
 <YtnPEem7q1i+4VBN@google.com>
Date:   Tue, 02 Aug 2022 14:52:55 +0200
Message-ID: <87o7x224ew.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Jul 14, 2022, Vitaly Kuznetsov wrote:
>> SECONDARY_EXEC_ENCLS_EXITING is conditionally added to the 'optional'
>> checklist in setup_vmcs_config() but there's little value in doing so.
>> First, as the control is optional, we can always check for its
>> presence, no harm done. Second, the only real value cpu_has_sgx() check
>> gives is that on the CPUs which support SECONDARY_EXEC_ENCLS_EXITING but
>> don't support SGX, the control is not getting enabled. It's highly unlikely
>> such CPUs exist but it's possible that some hypervisors expose broken vCPU
>> models.
>
> It's not just broken vCPU models, SGX can be "soft-disabled" on bare metal, e.g. if
> software writes MCE control MSRs or there's an uncorrectable #MC (may not be the
> case on all platforms).  This is architectural behavior and needs to be handled in
> KVM.  Obviously if SGX gets disabled after KVM is loaded then we're out of luck, but
> having the ENCL-exiting control without SGX being enabled is 100% valid.
>
> As for why KVM bothers with the check, it's to work around a suspected hardware
> or XuCode bug (I'm still a bit shocked that's public now :-) ) where SGX got
> _hard_ disabled across S3 on some CPUs and made the fields magically disappear.
> The workaround was to soft-disable SGX in BIOS so that KVM wouldn't attempt to
> enable the ENCLS-exiting control

Oh, thanks for this insight, I had no idea! I'll adjust my commit
message accordingly.

>
>> Preserve cpu_has_sgx() check but filter the result of adjust_vmx_controls()
>> instead of the input.
>> 
>> Reviewed-by: Jim Mattson <jmattson@google.com>
>> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/kvm/vmx/vmx.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>> 
>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>> index ce54f13d8da1..566be73c6509 100644
>> --- a/arch/x86/kvm/vmx/vmx.c
>> +++ b/arch/x86/kvm/vmx/vmx.c
>> @@ -2528,9 +2528,9 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>>  			SECONDARY_EXEC_PT_CONCEAL_VMX |
>>  			SECONDARY_EXEC_ENABLE_VMFUNC |
>>  			SECONDARY_EXEC_BUS_LOCK_DETECTION |
>> -			SECONDARY_EXEC_NOTIFY_VM_EXITING;
>> -		if (cpu_has_sgx())
>> -			opt2 |= SECONDARY_EXEC_ENCLS_EXITING;
>> +			SECONDARY_EXEC_NOTIFY_VM_EXITING |
>> +			SECONDARY_EXEC_ENCLS_EXITING;
>> +
>>  		if (adjust_vmx_controls(min2, opt2,
>>  					MSR_IA32_VMX_PROCBASED_CTLS2,
>>  					&_cpu_based_2nd_exec_control) < 0)
>> @@ -2577,6 +2577,9 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>>  		vmx_cap->vpid = 0;
>>  	}
>>  
>> +	if (!cpu_has_sgx())
>> +		_cpu_based_2nd_exec_control &= ~SECONDARY_EXEC_ENCLS_EXITING;
>> +
>>  	if (_cpu_based_exec_control & CPU_BASED_ACTIVATE_TERTIARY_CONTROLS) {
>>  		u64 opt3 = TERTIARY_EXEC_IPI_VIRT;
>>  
>> -- 
>> 2.35.3
>> 
>

-- 
Vitaly

