Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC2548BD82
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 04:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349034AbiALDBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 22:01:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52901 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348722AbiALDBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 22:01:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641956495;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Px8A9P7U9czmho9d1U1W2Flg3AM5I9Spb1vc2Lsv4b8=;
        b=D/XaYiqoAbSoL6at18+Z9+m227z0SrSPthfd3iNn/lfo7JGquPEzKCLdLz5Qsk4s8L6JGJ
        lIu6jVgi9t7WdpR/j3Km2QiptlYBhL3MUxLc6/Wv1Mcsyr81m9pVOoev3rAUPvZsXWbfXe
        xL0vhE3tB+Rk2/G6MquFbMsXBklk0/A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-hG2yBNBbNHSJnnSOLMFK2w-1; Tue, 11 Jan 2022 22:01:32 -0500
X-MC-Unique: hG2yBNBbNHSJnnSOLMFK2w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEEBA8042E1;
        Wed, 12 Jan 2022 03:01:30 +0000 (UTC)
Received: from [10.72.12.29] (ovpn-12-29.pek2.redhat.com [10.72.12.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4283E5BE27;
        Wed, 12 Jan 2022 03:01:24 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v4 12/21] KVM: arm64: Support SDEI_{PRIVATE, SHARED}_RESET
 hypercall
To:     Eric Auger <eauger@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-13-gshan@redhat.com>
 <a4b91fa5-12b0-afeb-4449-c2acb59e8cd7@redhat.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <d163631c-6e66-f7a1-6eea-3bc000e771ca@redhat.com>
Date:   Wed, 12 Jan 2022 11:01:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <a4b91fa5-12b0-afeb-4449-c2acb59e8cd7@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 11/10/21 4:37 AM, Eric Auger wrote:
> On 8/15/21 2:13 AM, Gavin Shan wrote:
>> This supports SDEI_{PRIVATE, SHARED}_RESET. They are used by the
>> guest to purge the private or shared SDEI events, which are registered
> to reset all private SDEI event registrations of the calling PE (resp.
> PRIVATE or SHARED)

Ok.

>> previously.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/kvm/sdei.c | 29 +++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
>> index 3fb33258b494..62efee2b67b8 100644
>> --- a/arch/arm64/kvm/sdei.c
>> +++ b/arch/arm64/kvm/sdei.c
>> @@ -582,6 +582,29 @@ static unsigned long kvm_sdei_hypercall_mask(struct kvm_vcpu *vcpu,
>>   	return ret;
>>   }
>>   
>> +static unsigned long kvm_sdei_hypercall_reset(struct kvm_vcpu *vcpu,
>> +					      bool private)
>> +{
>> +	struct kvm *kvm = vcpu->kvm;
>> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
>> +	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
>> +	unsigned int mask = private ? (1 << SDEI_EVENT_TYPE_PRIVATE) :
>> +				      (1 << SDEI_EVENT_TYPE_SHARED);
>> +	unsigned long ret = SDEI_SUCCESS;
>> +
>> +	/* Sanity check */
>> +	if (!(ksdei && vsdei)) {
>> +		ret = SDEI_NOT_SUPPORTED;
>> +		goto out;
>> +	}
>> +
>> +	spin_lock(&ksdei->lock);
>> +	kvm_sdei_remove_kvm_events(kvm, mask, false);
> With kvm_sdei_remove_kvm_events() implementation, why do you make sure
> that events which have a running handler get unregistered once the
> handler completes? I just see the refcount check that prevents the "KVM
> event object" from being removed.

Good point. I think here we need enhancement to cancel the pending
events prior to destroying them. I will think about it :)

>> +	spin_unlock(&ksdei->lock);
>> +out:
>> +	return ret;
>> +}
>> +
>>   int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>>   {
>>   	u32 func = smccc_get_function(vcpu);
>> @@ -626,8 +649,14 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>>   		break;
>>   	case SDEI_1_0_FN_SDEI_INTERRUPT_BIND:
>>   	case SDEI_1_0_FN_SDEI_INTERRUPT_RELEASE:
>> +		ret = SDEI_NOT_SUPPORTED;
>> +		break;
>>   	case SDEI_1_0_FN_SDEI_PRIVATE_RESET:
>> +		ret = kvm_sdei_hypercall_reset(vcpu, true);
>> +		break;
>>   	case SDEI_1_0_FN_SDEI_SHARED_RESET:
>> +		ret = kvm_sdei_hypercall_reset(vcpu, false);
>> +		break;
>>   	default:
>>   		ret = SDEI_NOT_SUPPORTED;
>>   	}
>>

Thanks,
Gavin

