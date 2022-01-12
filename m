Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819DB48BEC8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 08:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351086AbiALHDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 02:03:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45286 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232181AbiALHDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 02:03:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641971016;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J3LSL1gU8SJwYaXJ+vLXFoAHO4dJGzEvNDddl0YaMTk=;
        b=F4RNgT9dlOfHwWi6ra+ao5IsLi7Fg2NImmwwptd6dVu7YjOkQRIoHgCBMMg/VEAnV8LLpl
        htdcB+qHO7UsGpYWkuMPykyEKj/8AWUc1KvVSVLnuIF7WJSaEVXTAlwnORCLArKO7PDba/
        BRSN2b+bvZGKOXy1r9Z5eQKWBEgv+eA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-3No6FUU9PgOMW4ziBpJcMQ-1; Wed, 12 Jan 2022 02:03:33 -0500
X-MC-Unique: 3No6FUU9PgOMW4ziBpJcMQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0997344B0;
        Wed, 12 Jan 2022 07:03:31 +0000 (UTC)
Received: from [10.72.12.204] (ovpn-12-204.pek2.redhat.com [10.72.12.204])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CDC835E4B0;
        Wed, 12 Jan 2022 07:03:27 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v4 16/21] KVM: arm64: Support SDEI ioctl commands on VM
To:     Eric Auger <eauger@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-17-gshan@redhat.com>
 <6a4f1736-3af0-ccaa-e8a0-242759610430@redhat.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <96776800-d6fd-757b-348b-e566f068ed2a@redhat.com>
Date:   Wed, 12 Jan 2022 15:03:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <6a4f1736-3af0-ccaa-e8a0-242759610430@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 11/10/21 9:48 PM, Eric Auger wrote:
> On 8/15/21 2:13 AM, Gavin Shan wrote:
>> This supports ioctl commands on VM to manage the various objects.
>> It's primarily used by VMM to accomplish live migration. The ioctl
>> commands introduced by this are highlighted as blow:
> below
>>
>>     * KVM_SDEI_CMD_GET_VERSION
>>       Retrieve the version of current implementation
> which implementation, SDEI?
>>     * KVM_SDEI_CMD_SET_EVENT
>>       Add event to be exported from KVM so that guest can register
>>       against it afterwards
>>     * KVM_SDEI_CMD_GET_KEVENT_COUNT
>>       Retrieve number of registered SDEI events
>>     * KVM_SDEI_CMD_GET_KEVENT
>>       Retrieve the state of the registered SDEI event
>>     * KVM_SDEI_CMD_SET_KEVENT
>>       Populate the registered SDEI event
> I think we really miss the full picture of what you want to achieve with
> those IOCTLs or at least I fail to get it. Please document the UAPI
> separately including the structs and IOCTLs.

The commit log will be improved accordingly in next revision. Yep, I will
add document for UAPI and IOCTLs :)

>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/include/asm/kvm_sdei.h      |   1 +
>>   arch/arm64/include/uapi/asm/kvm_sdei.h |  17 +++
>>   arch/arm64/kvm/arm.c                   |   3 +
>>   arch/arm64/kvm/sdei.c                  | 171 +++++++++++++++++++++++++
>>   include/uapi/linux/kvm.h               |   3 +
>>   5 files changed, 195 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/kvm_sdei.h b/arch/arm64/include/asm/kvm_sdei.h
>> index 19f2d9b91f85..8f5ea947ed0e 100644
>> --- a/arch/arm64/include/asm/kvm_sdei.h
>> +++ b/arch/arm64/include/asm/kvm_sdei.h
>> @@ -125,6 +125,7 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu);
>>   int kvm_sdei_register_notifier(struct kvm *kvm, unsigned long num,
>>   			       kvm_sdei_notifier notifier);
>>   void kvm_sdei_deliver(struct kvm_vcpu *vcpu);
>> +long kvm_sdei_vm_ioctl(struct kvm *kvm, unsigned long arg);
>>   void kvm_sdei_destroy_vcpu(struct kvm_vcpu *vcpu);
>>   void kvm_sdei_destroy_vm(struct kvm *kvm);
>>   
>> diff --git a/arch/arm64/include/uapi/asm/kvm_sdei.h b/arch/arm64/include/uapi/asm/kvm_sdei.h
>> index 4ef661d106fe..35ff05be3c28 100644
>> --- a/arch/arm64/include/uapi/asm/kvm_sdei.h
>> +++ b/arch/arm64/include/uapi/asm/kvm_sdei.h
>> @@ -57,5 +57,22 @@ struct kvm_sdei_vcpu_state {
>>   	struct kvm_sdei_vcpu_regs	normal_regs;
>>   };
>>   
>> +#define KVM_SDEI_CMD_GET_VERSION		0
>> +#define KVM_SDEI_CMD_SET_EVENT			1
>> +#define KVM_SDEI_CMD_GET_KEVENT_COUNT		2
>> +#define KVM_SDEI_CMD_GET_KEVENT			3
>> +#define KVM_SDEI_CMD_SET_KEVENT			4
>> +
>> +struct kvm_sdei_cmd {
>> +	__u32						cmd;
>> +	union {
>> +		__u32					version;
>> +		__u32					count;
>> +		__u64					num;
>> +		struct kvm_sdei_event_state		kse_state;
>> +		struct kvm_sdei_kvm_event_state		kske_state;
>> +	};
>> +};
>> +
>>   #endif /* !__ASSEMBLY__ */
>>   #endif /* _UAPI__ASM_KVM_SDEI_H */
>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>> index 0c3db1ef1ba9..8d61585124b2 100644
>> --- a/arch/arm64/kvm/arm.c
>> +++ b/arch/arm64/kvm/arm.c
>> @@ -1389,6 +1389,9 @@ long kvm_arch_vm_ioctl(struct file *filp,
>>   			return -EFAULT;
>>   		return kvm_vm_ioctl_mte_copy_tags(kvm, &copy_tags);
>>   	}
>> +	case KVM_ARM_SDEI_COMMAND: {
>> +		return kvm_sdei_vm_ioctl(kvm, arg);
>> +	}
>>   	default:
>>   		return -EINVAL;
>>   	}
>> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
>> index 5f7a37dcaa77..bdd76c3e5153 100644
>> --- a/arch/arm64/kvm/sdei.c
>> +++ b/arch/arm64/kvm/sdei.c
>> @@ -931,6 +931,177 @@ void kvm_sdei_create_vcpu(struct kvm_vcpu *vcpu)
>>   	vcpu->arch.sdei = vsdei;
>>   }
>>   
>> +static long kvm_sdei_set_event(struct kvm *kvm,
>> +			       struct kvm_sdei_event_state *kse_state)
>> +{
>> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
>> +	struct kvm_sdei_event *kse = NULL;
>> +
>> +	if (!kvm_sdei_is_valid_event_num(kse_state->num))
>> +		return -EINVAL;
>> +
>> +	if (!(kse_state->type == SDEI_EVENT_TYPE_SHARED ||
>> +	      kse_state->type == SDEI_EVENT_TYPE_PRIVATE))
>> +		return -EINVAL;
>> +
>> +	if (!(kse_state->priority == SDEI_EVENT_PRIORITY_NORMAL ||
>> +	      kse_state->priority == SDEI_EVENT_PRIORITY_CRITICAL))
>> +		return -EINVAL;
>> +
>> +	kse = kvm_sdei_find_event(kvm, kse_state->num);
>> +	if (kse)
>> +		return -EEXIST;
>> +
>> +	kse = kzalloc(sizeof(*kse), GFP_KERNEL);
>> +	if (!kse)
>> +		return -ENOMEM;
> userspace can exhaust the mem since there is no limit. There must be a max.
> 

Ok. I think it's minor or corner case. For now, the number of defined SDEI
events are only one. I leave it for something to be improved in future.

>> +
>> +	kse->state = *kse_state;
>> +	kse->kvm = kvm;
>> +	list_add_tail(&kse->link, &ksdei->events);
>> +
>> +	return 0;
>> +}
>> +
>> +static long kvm_sdei_get_kevent_count(struct kvm *kvm, int *count)
>> +{
>> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
>> +	struct kvm_sdei_kvm_event *kske = NULL;
>> +	int total = 0;
>> +
>> +	list_for_each_entry(kske, &ksdei->kvm_events, link) {
>> +		total++;
>> +	}
>> +
>> +	*count = total;
>> +	return 0;
>> +}
>> +
>> +static long kvm_sdei_get_kevent(struct kvm *kvm,
>> +				struct kvm_sdei_kvm_event_state *kske_state)
>> +{
>> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
>> +	struct kvm_sdei_kvm_event *kske = NULL;
>> +
>> +	/*
>> +	 * The first entry is fetched if the event number is invalid.
>> +	 * Otherwise, the next entry is fetched.
> why don't we return an error? What is the point returning the next entry?

The SDEI events attached to the KVM are migrated one by one. Thoese attached
SDEI events are linked through a linked list:

     (1) on !kvm_sdei_is_valid_event_num(kske_state->num), the first SDEI event
         in the linked list is retrieved from source VM and will be restored on
         the destination VM.

     (2) Otherwise, the next SDEI event in the linked list will be retrieved
         from source VM and restored on the destination VM.

Another option is to introduce additional struct like below. In this way, all
the attached SDEI events are retrieved and restored once. In this way, the
memory block used for storing @kvm_sdei_kvm_event_state should be allocated
and released by QEMU. Please let me know your preference:

     struct xxx {
            __u64                              count;
            struct kvm_sdei_kvm_event_state    events;
     }

>> +	 */
>> +	if (!kvm_sdei_is_valid_event_num(kske_state->num)) {
>> +		kske = list_first_entry_or_null(&ksdei->kvm_events,
>> +				struct kvm_sdei_kvm_event, link);
>> +	} else {
>> +		kske = kvm_sdei_find_kvm_event(kvm, kske_state->num);
>> +		if (kske && !list_is_last(&kske->link, &ksdei->kvm_events))
>> +			kske = list_next_entry(kske, link);
> Sorry I don't get why we return the next one?

Please refer to the explanation above.

>> +		else
>> +			kske = NULL;
>> +	}
>> +
>> +	if (!kske)
>> +		return -ENOENT;
>> +
>> +	*kske_state = kske->state;
>> +
>> +	return 0;
>> +}
>> +
>> +static long kvm_sdei_set_kevent(struct kvm *kvm,
>> +				struct kvm_sdei_kvm_event_state *kske_state)
>> +{
>> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
>> +	struct kvm_sdei_event *kse = NULL;
>> +	struct kvm_sdei_kvm_event *kske = NULL;
>> +
>> +	/* Sanity check */
>> +	if (!kvm_sdei_is_valid_event_num(kske_state->num))
>> +		return -EINVAL;
>> +
>> +	if (!(kske_state->route_mode == SDEI_EVENT_REGISTER_RM_ANY ||
>> +	      kske_state->route_mode == SDEI_EVENT_REGISTER_RM_PE))
>> +		return -EINVAL;
>> +
>> +	/* Check if the event number is valid */
>> +	kse = kvm_sdei_find_event(kvm, kske_state->num);
>> +	if (!kse)
>> +		return -ENOENT;
>> +
>> +	/* Check if the event has been populated */
>> +	kske = kvm_sdei_find_kvm_event(kvm, kske_state->num);
>> +	if (kske)
>> +		return -EEXIST;
>> +
>> +	kske = kzalloc(sizeof(*kske), GFP_KERNEL);
> userspace can exhaust the mem since there is no limit

Ok.

>> +	if (!kske)
>> +		return -ENOMEM;
>> +
>> +	kske->state = *kske_state;
>> +	kske->kse   = kse;
>> +	kske->kvm   = kvm;
>> +	list_add_tail(&kske->link, &ksdei->kvm_events);
>> +
>> +	return 0;
>> +}
>> +
>> +long kvm_sdei_vm_ioctl(struct kvm *kvm, unsigned long arg)
>> +{
>> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
>> +	struct kvm_sdei_cmd *cmd = NULL;
>> +	void __user *argp = (void __user *)arg;
>> +	bool copy = false;
>> +	long ret = 0;
>> +
>> +	/* Sanity check */
>> +	if (!ksdei) {
>> +		ret = -EPERM;
>> +		goto out;
>> +	}
>> +
>> +	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
>> +	if (!cmd) {
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
>> +
>> +	if (copy_from_user(cmd, argp, sizeof(*cmd))) {
>> +		ret = -EFAULT;
>> +		goto out;
>> +	}
>> +
>> +	spin_lock(&ksdei->lock);
>> +
>> +	switch (cmd->cmd) {
>> +	case KVM_SDEI_CMD_GET_VERSION:
>> +		copy = true;
>> +		cmd->version = (1 << 16);       /* v1.0.0 */
>> +		break;
>> +	case KVM_SDEI_CMD_SET_EVENT:
>> +		ret = kvm_sdei_set_event(kvm, &cmd->kse_state);
>> +		break;
>> +	case KVM_SDEI_CMD_GET_KEVENT_COUNT:
>> +		copy = true;
>> +		ret = kvm_sdei_get_kevent_count(kvm, &cmd->count);
>> +		break;
>> +	case KVM_SDEI_CMD_GET_KEVENT:
>> +		copy = true;
>> +		ret = kvm_sdei_get_kevent(kvm, &cmd->kske_state);
>> +		break;
>> +	case KVM_SDEI_CMD_SET_KEVENT:
>> +		ret = kvm_sdei_set_kevent(kvm, &cmd->kske_state);
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
>> +	}
>> +
>> +	spin_unlock(&ksdei->lock);
>> +out:
>> +	if (!ret && copy && copy_to_user(argp, cmd, sizeof(*cmd)))
>> +		ret = -EFAULT;
>> +
>> +	kfree(cmd);
>> +	return ret;
>> +}
>> +
>>   void kvm_sdei_destroy_vcpu(struct kvm_vcpu *vcpu)
>>   {
>>   	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index d9e4aabcb31a..8cf41fd4bf86 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -1679,6 +1679,9 @@ struct kvm_xen_vcpu_attr {
>>   #define KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_DATA	0x4
>>   #define KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_ADJUST	0x5
>>   
>> +/* Available with KVM_CAP_ARM_SDEI */
>> +#define KVM_ARM_SDEI_COMMAND	_IOWR(KVMIO, 0xce, struct kvm_sdei_cmd)
>> +
>>   /* Secure Encrypted Virtualization command */
>>   enum sev_cmd_id {
>>   	/* Guest initialization commands */
>>

Thanks,
Gavin

