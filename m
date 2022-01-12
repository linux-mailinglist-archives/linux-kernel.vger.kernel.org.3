Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4E148BD7C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349004AbiALC6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:58:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53017 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348722AbiALC6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641956326;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yu1Ym+x2T7q80BfcH6OCGclknqzM/xi6/S5+IsSqfEw=;
        b=ID8e8p6SV+sfshsEhssEEecYVV0mdDVptpBng58UxMRe39p85E9o063EINdcCUwipxRr1b
        uGB53YomdpPcXCAd8Q/Pmf0q+8Gmz/Eo7JhaiNi9k2o4XNlBZIizgSrG0Xq12tm2mDNAuR
        dwXAKa0RHAMw7vWz8i44p9KjF6msgZA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-RIuCibhXNgKiavnO-x1HCA-1; Tue, 11 Jan 2022 21:58:45 -0500
X-MC-Unique: RIuCibhXNgKiavnO-x1HCA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8316B801B0C;
        Wed, 12 Jan 2022 02:58:44 +0000 (UTC)
Received: from [10.72.12.29] (ovpn-12-29.pek2.redhat.com [10.72.12.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E21C3610A5;
        Wed, 12 Jan 2022 02:58:37 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v4 11/21] KVM: arm64: Support SDEI_PE_{MASK, UNMASK}
 hypercall
To:     Eric Auger <eauger@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-12-gshan@redhat.com>
 <e5acdb48-fb16-ab18-4938-c03265c4cfbf@redhat.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <60e72d4e-6002-eaac-783f-20a2cbe6f9aa@redhat.com>
Date:   Wed, 12 Jan 2022 10:58:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <e5acdb48-fb16-ab18-4938-c03265c4cfbf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 11/10/21 4:31 AM, Eric Auger wrote:
> On 8/15/21 2:13 AM, Gavin Shan wrote:
>> This supports SDEI_PE_{MASK, UNMASK} hypercall. They are used by
>> the guest to stop the specific vCPU from receiving SDEI events.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/kvm/sdei.c | 35 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>
>> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
>> index 458695c2394f..3fb33258b494 100644
>> --- a/arch/arm64/kvm/sdei.c
>> +++ b/arch/arm64/kvm/sdei.c
>> @@ -551,6 +551,37 @@ static unsigned long kvm_sdei_hypercall_route(struct kvm_vcpu *vcpu)
>>   	return ret;
>>   }
>>   
>> +static unsigned long kvm_sdei_hypercall_mask(struct kvm_vcpu *vcpu,
>> +					     bool mask)
>> +{
>> +	struct kvm *kvm = vcpu->kvm;
>> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
>> +	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
>> +	unsigned long ret = SDEI_SUCCESS;
>> +
>> +	/* Sanity check */
>> +	if (!(ksdei && vsdei)) {
>> +		ret = SDEI_NOT_SUPPORTED;
>> +		goto out;
>> +	}
>> +
>> +	spin_lock(&vsdei->lock);
>> +
>> +	/* Check the state */
>> +	if (mask == vsdei->state.masked) {
>> +		ret = SDEI_DENIED;
> are you sure? I don't this error documented in 5.1.12?
> 
> Besides the spec says:
> "
> This call can be invoked by the client to mask the PE, whether or not
> the PE is already masked."

Yep, I think this check can safely dropped.

>> +		goto unlock;
>> +	}
>> +
>> +	/* Update the state */
>> +	vsdei->state.masked = mask ? 1 : 0;
>> +
>> +unlock:
>> +	spin_unlock(&vsdei->lock);
>> +out:
>> +	return ret;
> In case of success the returned value is SUCESS for UNMASK but not for
> MASK (see table in 5.1.12).
> 
> By the way I have just noticed there is a more recent of the spec than
> the A:
> 
> ARM_DEN0054C
> 
> You should update the cover letter and [PATCH v4 02/21] KVM: arm64: Add
> SDEI virtualization infrastructure commit msg
> 

Thanks, Eric. You've looked into newer version of spec. I will update
the code and link to the spec accordingly :)

> 
>> +}
>> +
>>   int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>>   {
>>   	u32 func = smccc_get_function(vcpu);
>> @@ -588,7 +619,11 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>>   		ret = kvm_sdei_hypercall_route(vcpu);
>>   		break;
>>   	case SDEI_1_0_FN_SDEI_PE_MASK:
>> +		ret = kvm_sdei_hypercall_mask(vcpu, true);
>> +		break;
>>   	case SDEI_1_0_FN_SDEI_PE_UNMASK:
>> +		ret = kvm_sdei_hypercall_mask(vcpu, false);
>> +		break;
>>   	case SDEI_1_0_FN_SDEI_INTERRUPT_BIND:
>>   	case SDEI_1_0_FN_SDEI_INTERRUPT_RELEASE:
>>   	case SDEI_1_0_FN_SDEI_PRIVATE_RESET:
>>

Thanks,
Gavin

