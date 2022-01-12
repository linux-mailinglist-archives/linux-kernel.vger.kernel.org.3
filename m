Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B444048BEB1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 07:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347502AbiALGsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 01:48:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51892 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237061AbiALGsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 01:48:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641970129;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j3vZpy1v43MCXzCf8RgSiN5mYO8Oebbulqjm86kYz9w=;
        b=RD+Qc6dSmThrwg2Iwok1BJDroorgJdKeZc2FoBSY9Umruaf9BxtIX298WNEM4oUH2JHNwV
        +r6Hsm6SD/h6HNS5v+rJxDmFchYj3lFr1joaO5A2MihIv5EAI6Zjj4J5Lx7wEWHVbdLaQe
        IHcsntf6an5LJ0UgF1C0NYRkzYFRaeE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-IoTo8QhUNrSgpRdwlrL_dw-1; Wed, 12 Jan 2022 01:48:46 -0500
X-MC-Unique: IoTo8QhUNrSgpRdwlrL_dw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71EFB2F25;
        Wed, 12 Jan 2022 06:48:44 +0000 (UTC)
Received: from [10.72.12.204] (ovpn-12-204.pek2.redhat.com [10.72.12.204])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8190A795A1;
        Wed, 12 Jan 2022 06:48:40 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v4 15/21] KVM: arm64: Support SDEI event notifier
To:     Eric Auger <eauger@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-16-gshan@redhat.com>
 <a5a9f99b-d919-e381-f4f0-45a1db417843@redhat.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <a00b94cd-6d31-a180-a929-4c2929b939e8@redhat.com>
Date:   Wed, 12 Jan 2022 14:48:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <a5a9f99b-d919-e381-f4f0-45a1db417843@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 11/10/21 7:35 PM, Eric Auger wrote:
> On 8/15/21 2:13 AM, Gavin Shan wrote:
>> The owner of the SDEI event, like asynchronous page fault, need
> owner is not a terminology used in the SDEI spec
>> know the state of injected SDEI event. This supports SDEI event
> s/need know the state of injected/to know the state of the injected
>> state updating by introducing notifier mechanism. It's notable
> a notifier mechanism
>> the notifier (handler) should be capable of migration.
> I don't understand the last sentence

Thanks, Eric. The commit log will be improved accordingly in next
revision.

>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/include/asm/kvm_sdei.h      | 12 +++++++
>>   arch/arm64/include/uapi/asm/kvm_sdei.h |  1 +
>>   arch/arm64/kvm/sdei.c                  | 45 +++++++++++++++++++++++++-
>>   3 files changed, 57 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/kvm_sdei.h b/arch/arm64/include/asm/kvm_sdei.h
>> index 7f5f5ad689e6..19f2d9b91f85 100644
>> --- a/arch/arm64/include/asm/kvm_sdei.h
>> +++ b/arch/arm64/include/asm/kvm_sdei.h
>> @@ -16,6 +16,16 @@
>>   #include <linux/list.h>
>>   #include <linux/spinlock.h>
>>   
>> +struct kvm_vcpu;
>> +
>> +typedef void (*kvm_sdei_notifier)(struct kvm_vcpu *vcpu,
>> +				  unsigned long num,
>> +				  unsigned int state);
>> +enum {
>> +	KVM_SDEI_NOTIFY_DELIVERED,
>> +	KVM_SDEI_NOTIFY_COMPLETED,
>> +};
>> +
>>   struct kvm_sdei_event {
>>   	struct kvm_sdei_event_state		state;
>>   	struct kvm				*kvm;
>> @@ -112,6 +122,8 @@ KVM_SDEI_FLAG_FUNC(enabled)
>>   void kvm_sdei_init_vm(struct kvm *kvm);
>>   void kvm_sdei_create_vcpu(struct kvm_vcpu *vcpu);
>>   int kvm_sdei_hypercall(struct kvm_vcpu *vcpu);
>> +int kvm_sdei_register_notifier(struct kvm *kvm, unsigned long num,
>> +			       kvm_sdei_notifier notifier);
>>   void kvm_sdei_deliver(struct kvm_vcpu *vcpu);
>>   void kvm_sdei_destroy_vcpu(struct kvm_vcpu *vcpu);
>>   void kvm_sdei_destroy_vm(struct kvm *kvm);
>> diff --git a/arch/arm64/include/uapi/asm/kvm_sdei.h b/arch/arm64/include/uapi/asm/kvm_sdei.h
>> index 8928027023f6..4ef661d106fe 100644
>> --- a/arch/arm64/include/uapi/asm/kvm_sdei.h
>> +++ b/arch/arm64/include/uapi/asm/kvm_sdei.h
>> @@ -23,6 +23,7 @@ struct kvm_sdei_event_state {
>>   	__u8	type;
>>   	__u8	signaled;
>>   	__u8	priority;
>> +	__u64	notifier;
> why is the notifier attached to the exposed event and not to the
> registered or even vcpu event? This needs to be motivated.
> 
> Also as commented earlier I really think we first need to agree on the
> uapi and get a consensus on it as it must be right on the 1st shot. In
> that prospect maybe introduce a patch dedicated to the uapi and document
> it properly, including the way the end user is supposed to use it.
> 
> Another way to proceed would be to not support migration at the moment,
> mature the API and then introduce migration support later. Would it make
> sense? For instance, in the past in-kernel ITS emulation was first
> introduced without migration support.
> 

You're correct that @notifier needs to be migrated. I perfer to drop the
migration support at first, and then add the support when the APIs become
mature. However, the only user of SDEI would be Async PF, which is used in
migration scenario. So I will think about how to reorgnize the code and have
separate patch for the UAPI stuff, including the document.


>>   };
>>   
>>   struct kvm_sdei_kvm_event_state {
>> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
>> index 1e8e213c9d70..5f7a37dcaa77 100644
>> --- a/arch/arm64/kvm/sdei.c
>> +++ b/arch/arm64/kvm/sdei.c
>> @@ -314,9 +314,11 @@ static unsigned long kvm_sdei_hypercall_complete(struct kvm_vcpu *vcpu,
>>   	struct kvm *kvm = vcpu->kvm;
>>   	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
>>   	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
>> +	struct kvm_sdei_event *kse = NULL;
>>   	struct kvm_sdei_kvm_event *kske = NULL;
>>   	struct kvm_sdei_vcpu_event *ksve = NULL;
>>   	struct kvm_sdei_vcpu_regs *regs;
>> +	kvm_sdei_notifier notifier;
>>   	unsigned long ret = SDEI_SUCCESS;
>>   	int index;
>>   
>> @@ -349,6 +351,13 @@ static unsigned long kvm_sdei_hypercall_complete(struct kvm_vcpu *vcpu,
>>   	*vcpu_cpsr(vcpu) = regs->pstate;
>>   	*vcpu_pc(vcpu) = regs->pc;
>>   
>> +	/* Notifier */
>> +	kske = ksve->kske;
>> +	kse = kske->kse;
>> +	notifier = (kvm_sdei_notifier)(kse->state.notifier);
>> +	if (notifier)
>> +		notifier(vcpu, kse->state.num, KVM_SDEI_NOTIFY_COMPLETED);
>> +
>>   	/* Inject interrupt if needed */
>>   	if (resume)
>>   		kvm_inject_irq(vcpu);
>> @@ -358,7 +367,6 @@ static unsigned long kvm_sdei_hypercall_complete(struct kvm_vcpu *vcpu,
>>   	 * event state as it's not destroyed because of the reference
>>   	 * count.
>>   	 */
>> -	kske = ksve->kske;
>>   	ksve->state.refcount--;
>>   	kske->state.refcount--;
>>   	if (!ksve->state.refcount) {
>> @@ -746,6 +754,35 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>>   	return 1;
>>   }
>>   
>> +int kvm_sdei_register_notifier(struct kvm *kvm,
>> +			       unsigned long num,
>> +			       kvm_sdei_notifier notifier)
>> +{
>> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
>> +	struct kvm_sdei_event *kse = NULL;
>> +	int ret = 0;
>> +
>> +	if (!ksdei) {
>> +		ret = -EPERM;
>> +		goto out;
>> +	}
>> +
>> +	spin_lock(&ksdei->lock);
>> +
>> +	kse = kvm_sdei_find_event(kvm, num);
>> +	if (!kse) {
>> +		ret = -EINVAL;
>> +		goto unlock;
>> +	}
>> +
>> +	kse->state.notifier = (unsigned long)notifier;
>> +
>> +unlock:
>> +	spin_unlock(&ksdei->lock);
>> +out:
>> +	return ret;
>> +}
>> +
>>   void kvm_sdei_deliver(struct kvm_vcpu *vcpu)
>>   {
>>   	struct kvm *kvm = vcpu->kvm;
>> @@ -755,6 +792,7 @@ void kvm_sdei_deliver(struct kvm_vcpu *vcpu)
>>   	struct kvm_sdei_kvm_event *kske = NULL;
>>   	struct kvm_sdei_vcpu_event *ksve = NULL;
>>   	struct kvm_sdei_vcpu_regs *regs = NULL;
>> +	kvm_sdei_notifier notifier;
>>   	unsigned long pstate;
>>   	int index = 0;
>>   
>> @@ -826,6 +864,11 @@ void kvm_sdei_deliver(struct kvm_vcpu *vcpu)
>>   	*vcpu_cpsr(vcpu) = pstate;
>>   	*vcpu_pc(vcpu) = kske->state.entries[index];
>>   
>> +	/* Notifier */
>> +	notifier = (kvm_sdei_notifier)(kse->state.notifier);
>> +	if (notifier)
>> +		notifier(vcpu, kse->state.num, KVM_SDEI_NOTIFY_DELIVERED);
>> +
>>   unlock:
>>   	spin_unlock(&vsdei->lock);
>>   }
>>
> 

Thanks,
Gavin

