Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE8D48AA76
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 10:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349285AbiAKJZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 04:25:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34072 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237101AbiAKJZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 04:25:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641893123;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NIOLB34hJ7NrgadAdzd+FzQSHzDK7thVWV6D0ErLYoo=;
        b=PpqDNjJI7XI0QDXtkgpyl1gS9RwZ0/0LQH+7xW5f6cobjxOZf774py8zIiFdVxtTnLxiv3
        BOPNUpnzzu5ErvVf6F/bH19m2o7HNzKmtHZ6F33N3mh+dQ5KUIlQQivmmemWyBsnndudky
        e0Wbdv77NnDCfHVHAGx3sqzd9emZQFk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-IiEpoNaMMVSnAgUuqAzCYg-1; Tue, 11 Jan 2022 04:25:21 -0500
X-MC-Unique: IiEpoNaMMVSnAgUuqAzCYg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1598C802CA0;
        Tue, 11 Jan 2022 09:25:20 +0000 (UTC)
Received: from [10.72.14.32] (ovpn-14-32.pek2.redhat.com [10.72.14.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EED567AB4D;
        Tue, 11 Jan 2022 09:25:16 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v4 03/21] KVM: arm64: Support SDEI_VERSION hypercall
To:     Eric Auger <eauger@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-4-gshan@redhat.com>
 <3160dd62-1d96-7dcb-e99a-7ac923abc2c7@redhat.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <be1955d3-4a67-9219-64fa-3dfd46a9eee0@redhat.com>
Date:   Tue, 11 Jan 2022 17:25:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <3160dd62-1d96-7dcb-e99a-7ac923abc2c7@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 11/9/21 11:26 PM, Eric Auger wrote:
> On 8/15/21 2:13 AM, Gavin Shan wrote:
>> This supports SDEI_VERSION hypercall by returning v1.0.0 simply
> s/This supports/Add Support. I think this is the prefered way to start
> the commit msg. Here and elsewhere.

Ok.

>> when the functionality is supported on the VM and vCPU.
> Can you explain when the functionality isn't supported on either. From
> the infra patch I have the impression that an allocation failure is the
> sole cause of lack of support?

Yes, it's the only reason that SDEI isn't supported. I will
mention this in the commit log in next respin.

>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/kvm/sdei.c | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
>> index ab330b74a965..aa9485f076a9 100644
>> --- a/arch/arm64/kvm/sdei.c
>> +++ b/arch/arm64/kvm/sdei.c
>> @@ -70,6 +70,22 @@ static void kvm_sdei_remove_vcpu_events(struct kvm_vcpu *vcpu)
>>   	}
>>   }
>>   
>> +static unsigned long kvm_sdei_hypercall_version(struct kvm_vcpu *vcpu)
>> +{
>> +	struct kvm *kvm = vcpu->kvm;
>> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
>> +	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
>> +	unsigned long ret = SDEI_NOT_SUPPORTED;
> nit: I would remove ret local variable

Ok.

>> +
>> +	if (!(ksdei && vsdei))
>> +		return ret;
>> +
>> +	/* v1.0.0 */
>> +	ret = (1UL << SDEI_VERSION_MAJOR_SHIFT);
>> +
>> +	return ret;
>> +}
>> +
>>   int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>>   {
>>   	u32 func = smccc_get_function(vcpu);
>> @@ -78,6 +94,8 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>>   
>>   	switch (func) {
>>   	case SDEI_1_0_FN_SDEI_VERSION:
>> +		ret = kvm_sdei_hypercall_version(vcpu);
>> +		break;
>>   	case SDEI_1_0_FN_SDEI_EVENT_REGISTER:
>>   	case SDEI_1_0_FN_SDEI_EVENT_ENABLE:
>>   	case SDEI_1_0_FN_SDEI_EVENT_DISABLE:
>>

Thanks,
Gavin

