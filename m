Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970AF4C66BF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 11:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbiB1KD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 05:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbiB1KCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 05:02:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E77336E0E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646042321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aa8PdEAcGufSdiHlrYI98SIoUuXszzG1ntEv83vyr9M=;
        b=X88bSKZ0dUPx/jinNxV3kPxpsPC9dMuHnljPWj6hfrT1+KGO0bEkgTJ+jESX1l3spakOKL
        7hveRbYfbi4/MmoPGheoXJm4mJO67hWZJiPXAQj42yvBqM1jWeH0be5V6PO2QASjLNVwvu
        AUgJzcKuq1V1207Nosnaz7AxOG71bcg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-CNBit3fmMSa6u1fpQRtFXA-1; Mon, 28 Feb 2022 04:58:37 -0500
X-MC-Unique: CNBit3fmMSa6u1fpQRtFXA-1
Received: by mail-qv1-f69.google.com with SMTP id d15-20020a0cb2cf000000b00432e2ddeefaso6015407qvf.23
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:58:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=aa8PdEAcGufSdiHlrYI98SIoUuXszzG1ntEv83vyr9M=;
        b=NMudYajA697tOocKns35wiFdD8q9waQt64qpYTpfWXpvssUA+w3s32muEzN2lodc+f
         lFmjZnHkU+e81CkfWqxpq794DBvzR0/E//zQtp23QdFEi4LzmMMSiywsPVg+9d2spIwD
         gN+x1EFFo4IMMBgd5w9EejS8kFzDEZgViT97936IylHJboozt+BCfmNlcS5Yv20QMPpf
         LwRlyXFZc6cigP4ZxSUeH8QZmPTt0DzXQf4Ch4EzNsKPshIU3AS54fTVc+a60mIcNbv4
         hbq+gBq3Wy5RO7YlJOeyRbZL/eOf6tBRQyqJKRq4Kng2gczbSdK0uJzCRQ5AjyUIP3lY
         0SgA==
X-Gm-Message-State: AOAM530M6He6pXeyTAe2buCmxC+gXfmRmjKgQmqNs4vdPL+WwZ+BTO3R
        JeClIiCQ4l5zyBQdtHSI6YW2TyKTYzfN62SxjGX6JH+9pixXPAMsKc1IAtDUkcuRt664IJtPGtn
        BO9HscJl21CC010UEDcVenszE
X-Received: by 2002:a0c:cdc9:0:b0:42d:b04:4d9e with SMTP id a9-20020a0ccdc9000000b0042d0b044d9emr13580299qvn.64.1646042317395;
        Mon, 28 Feb 2022 01:58:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyo4xrAts4HPJKrn8HlYd8J0DNmB0KTGjISkhsfaMgrIblP695pg/lQKPjldmsC5IyKfzlgSA==
X-Received: by 2002:a0c:cdc9:0:b0:42d:b04:4d9e with SMTP id a9-20020a0ccdc9000000b0042d0b044d9emr13580292qvn.64.1646042317153;
        Mon, 28 Feb 2022 01:58:37 -0800 (PST)
Received: from fedora (ec2-3-80-233-239.compute-1.amazonaws.com. [3.80.233.239])
        by smtp.gmail.com with ESMTPSA id v72-20020a37614b000000b00648ebe9d4a5sm4879265qkb.116.2022.02.28.01.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 01:58:36 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/4] KVM: x86: hyper-v: Drop redundant 'ex' parameter
 from kvm_hv_send_ipi()
In-Reply-To: <506c34bc80d1bb740ddf38e6476ad0e16c097282.camel@redhat.com>
References: <20220222154642.684285-1-vkuznets@redhat.com>
 <20220222154642.684285-2-vkuznets@redhat.com>
 <506c34bc80d1bb740ddf38e6476ad0e16c097282.camel@redhat.com>
Date:   Mon, 28 Feb 2022 10:58:33 +0100
Message-ID: <87y21vcnxy.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxim Levitsky <mlevitsk@redhat.com> writes:

> On Tue, 2022-02-22 at 16:46 +0100, Vitaly Kuznetsov wrote:
>> 'struct kvm_hv_hcall' has all the required information already,
>> there's no need to pass 'ex' additionally.
>> 
>> No functional change intended.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/kvm/hyperv.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>> 
>> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
>> index 6e38a7d22e97..15b6a7bd2346 100644
>> --- a/arch/x86/kvm/hyperv.c
>> +++ b/arch/x86/kvm/hyperv.c
>> @@ -1875,7 +1875,7 @@ static void kvm_send_ipi_to_many(struct kvm *kvm, u32 vector,
>>  	}
>>  }
>>  
>> -static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool ex)
>> +static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
>>  {
>>  	struct kvm *kvm = vcpu->kvm;
>>  	struct hv_send_ipi_ex send_ipi_ex;
>> @@ -1889,7 +1889,7 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
>>  	u32 vector;
>>  	bool all_cpus;
>>  
>> -	if (!ex) {
>> +	if (hc->code == HVCALL_SEND_IPI) {
>
> I am thinking, if we already touch this code,
> why not to use switch here instead on the hc->code,
> so that we can catch this function being called with something else than
> HVCALL_SEND_IPI_EX

I'm not against this second line of defense but kvm_hv_send_ipi() is
only called explicitly from kvm_hv_hypercall()'s switch so something is
really screwed up if we end up seeing something different from
HVCALL_SEND_IPI_EX/HVCALL_SEND_IPI here.

I'm now working on a bigger series for TLB flush improvements, will use
your suggestion there, thanks!

>
>>  		if (!hc->fast) {
>>  			if (unlikely(kvm_read_guest(kvm, hc->ingpa, &send_ipi,
>>  						    sizeof(send_ipi))))
>> @@ -2279,14 +2279,14 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
>>  			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
>>  			break;
>>  		}
>> -		ret = kvm_hv_send_ipi(vcpu, &hc, false);
>> +		ret = kvm_hv_send_ipi(vcpu, &hc);
>>  		break;
>>  	case HVCALL_SEND_IPI_EX:
>>  		if (unlikely(hc.fast || hc.rep)) {
>>  			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
>>  			break;
>>  		}
>> -		ret = kvm_hv_send_ipi(vcpu, &hc, true);
>> +		ret = kvm_hv_send_ipi(vcpu, &hc);
>>  		break;
>>  	case HVCALL_POST_DEBUG_DATA:
>>  	case HVCALL_RETRIEVE_DEBUG_DATA:
>
>
>
> Other than this minor nitpick:
>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
>
>
> Best regards,
> 	Maxim Levitsky
>

-- 
Vitaly

