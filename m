Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161DE58E3F2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 01:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiHIX5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 19:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiHIX5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 19:57:44 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB58380487
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 16:57:42 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id by6so6150005ljb.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 16:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=ZbqTbaXWd/Bj5BMjd3dqX6jTh0Tp2n0ayotMyOw0NOs=;
        b=pZyKrLhPvmleL69wqPqzryGUpBIZ+9IqLPQc896uhVbmWYsVj/54Sok/OUij48RenF
         PymqGYujgef9tO++QpzqfCBFhPvQSrWUZmskgm3SA82+LEWTwNgXy8ei/YVAkMK6hlDB
         DzfVKUcUI6DdCH/3dV1VQlgha+f5IPMiLJlGCTyifxOiShj6X5QVXOzodBlXDNgUiZiH
         XOL8nI7TdqQFcS5gyzMQ4AtAXf1u1XB5K5vjZTKgTsN7LrKHlLMEEpkdoFYiZkm66gv1
         JwXKGJsWvQnIvVOfQ0Sx85zgQgS3a7nXXDxAUuW3xfkHQvDYP9OIF84HCjlXFd5sffKC
         IeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=ZbqTbaXWd/Bj5BMjd3dqX6jTh0Tp2n0ayotMyOw0NOs=;
        b=IFsX0uz+5GUkkrC1Jo87KHDQ+q2A/Sgg7JJkAFInPEDHwhxzKawwT5rpS4fhe8R3Eg
         8m8N3GWYN6ahZS+AIujVUnppLoMOBc2jeae9Kgycfuppp3Lm23tWQ0gq1ZE3ZiIZ1lUT
         99m0pgAeYdH4T4Oh5oDxbH99LNX0afSOySJ/ZYSKJUxfqYIOtxyJTjJZ1xLZSY6xPVHy
         m21PcT5obQLkQiEEGd0vMPvJsUVwwqcCiGNjfXTo39dYkBtUkXMhR8Wpd1IDWtKQzcdr
         L0FLYvCigFlmwN0n9GjqN528WptmSgHpsnLHn4fK9ULj+XBxH3kdkQ7oXdW+1YYQ+QYv
         hB5g==
X-Gm-Message-State: ACgBeo1aPgOF+Vtwg07vC9CcRi3QpnbbX04gWZuyvibxuXKKJqc77t2n
        BJ4S7Vd9vGPawbearr2Qm877Cg==
X-Google-Smtp-Source: AA6agR4gSdzegAdFtDDPFuCu0UTkWoMQ1IVFDR0kvz4aVgObkpg1QuQHXTxC5gb+kaar6OrNVE2IPA==
X-Received: by 2002:a2e:b750:0:b0:25e:71da:5baf with SMTP id k16-20020a2eb750000000b0025e71da5bafmr8268833ljo.166.1660089461060;
        Tue, 09 Aug 2022 16:57:41 -0700 (PDT)
Received: from ?IPv6:2a02:a31b:33d:9c00:463a:87e3:44fc:2b2f? ([2a02:a31b:33d:9c00:463a:87e3:44fc:2b2f])
        by smtp.gmail.com with ESMTPSA id c5-20020a056512324500b0048abf3a550asm125471lfr.224.2022.08.09.16.57.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 16:57:40 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] KVM: irqfd: Postpone resamplefd notify for oneshot
 interrupts
To:     eric.auger@redhat.com, Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Rong L Liu <rong.l.liu@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>, upstream@semihalf.com,
        Dmitry Torokhov <dtor@google.com>,
        Marc Zyngier <maz@kernel.org>
References: <20220805193919.1470653-1-dmy@semihalf.com>
 <20220805193919.1470653-4-dmy@semihalf.com>
 <56ab2bc2-378b-3ece-2d45-e0f484087aa7@redhat.com>
From:   Dmytro Maluka <dmy@semihalf.com>
Message-ID: <6ecd1bcc-0f5d-8183-615a-037a9670e136@semihalf.com>
Date:   Wed, 10 Aug 2022 01:57:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <56ab2bc2-378b-3ece-2d45-e0f484087aa7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/22 10:45 PM, Eric Auger wrote:
> Hi Dmytro,
> 
> On 8/5/22 21:39, Dmytro Maluka wrote:
>> The existing KVM mechanism for forwarding of level-triggered interrupts
>> using resample eventfd doesn't work quite correctly in the case of
>> interrupts that are handled in a Linux guest as oneshot interrupts
>> (IRQF_ONESHOT). Such an interrupt is acked to the device in its
>> threaded irq handler, i.e. later than it is acked to the interrupt
>> controller (EOI at the end of hardirq), not earlier.
>>
>> Linux keeps such interrupt masked until its threaded handler finishes,
>> to prevent the EOI from re-asserting an unacknowledged interrupt.
>> However, with KVM + vfio (or whatever is listening on the resamplefd)
>> we don't check that the interrupt is still masked in the guest at the
>> moment of EOI. Resamplefd is notified regardless, so vfio prematurely
>> unmasks the host physical IRQ, thus a new (unwanted) physical interrupt
>> is generated in the host and queued for injection to the guest.
>>
>> The fact that the virtual IRQ is still masked doesn't prevent this new
>> physical IRQ from being propagated to the guest, because:
>>
>> 1. It is not guaranteed that the vIRQ will remain masked by the time
>>    when vfio signals the trigger eventfd.
>> 2. KVM marks this IRQ as pending (e.g. setting its bit in the virtual
>>    IRR register of IOAPIC on x86), so after the vIRQ is unmasked, this
>>    new pending interrupt is injected by KVM to the guest anyway.
>>
>> There are observed at least 2 user-visible issues caused by those
>> extra erroneous pending interrupts for oneshot irq in the guest:
>>
>> 1. System suspend aborted due to a pending wakeup interrupt from
>>    ChromeOS EC (drivers/platform/chrome/cros_ec.c).
>> 2. Annoying "invalid report id data" errors from ELAN0000 touchpad
>>    (drivers/input/mouse/elan_i2c_core.c), flooding the guest dmesg
>>    every time the touchpad is touched.
>>
>> This patch fixes the issue on x86 by checking if the interrupt is
>> unmasked when we receive irq ack (EOI) and, in case if it's masked,
>> postponing resamplefd notify until the guest unmasks it.
>>
>> It doesn't fix the issue for other archs yet, since it relies on KVM
>> irq mask notifiers functionality which currently works only on x86.
>> On other archs we can register mask notifiers but they are never called.
>> So on other archs resampler->masked is always false, so the behavior is
>> the same as before this patch.
>>
>> Link: https://lore.kernel.org/kvm/31420943-8c5f-125c-a5ee-d2fde2700083@semihalf.com/
>> Suggested-by: Sean Christopherson <seanjc@google.com>
>> Signed-off-by: Dmytro Maluka <dmy@semihalf.com>
>> ---
>>  include/linux/kvm_irqfd.h | 14 ++++++++++
>>  virt/kvm/eventfd.c        | 56 +++++++++++++++++++++++++++++++++++----
>>  2 files changed, 65 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/kvm_irqfd.h b/include/linux/kvm_irqfd.h
>> index dac047abdba7..01754a1abb9e 100644
>> --- a/include/linux/kvm_irqfd.h
>> +++ b/include/linux/kvm_irqfd.h
>> @@ -19,6 +19,16 @@
>>   * resamplefd.  All resamplers on the same gsi are de-asserted
>>   * together, so we don't need to track the state of each individual
>>   * user.  We can also therefore share the same irq source ID.
>> + *
>> + * A special case is when the interrupt is still masked at the moment
>> + * an irq ack is received. That likely means that the interrupt has
>> + * been acknowledged to the interrupt controller but not acknowledged
>> + * to the device yet, e.g. it might be a Linux guest's threaded
>> + * oneshot interrupt (IRQF_ONESHOT). In this case notifying through
>> + * resamplefd is postponed until the guest unmasks the interrupt,
>> + * which is detected through the irq mask notifier. This prevents
>> + * erroneous extra interrupts caused by premature re-assert of an
>> + * unacknowledged interrupt by the resamplefd listener.
>>   */
>>  struct kvm_kernel_irqfd_resampler {
>>  	struct kvm *kvm;
>> @@ -28,6 +38,10 @@ struct kvm_kernel_irqfd_resampler {
>>  	 */
>>  	struct list_head list;
>>  	struct kvm_irq_ack_notifier notifier;
>> +	struct kvm_irq_mask_notifier mask_notifier;
>> +	bool masked;
>> +	bool pending;
>> +	spinlock_t lock;
>>  	/*
>>  	 * Entry in list of kvm->irqfd.resampler_list.  Use for sharing
>>  	 * resamplers among irqfds on the same gsi.
>> diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
>> index 3007d956b626..f98dcce3959c 100644
>> --- a/virt/kvm/eventfd.c
>> +++ b/virt/kvm/eventfd.c
>> @@ -67,6 +67,7 @@ irqfd_resampler_ack(struct kvm_irq_ack_notifier *kian)
>>  	struct kvm *kvm;
>>  	struct kvm_kernel_irqfd *irqfd;
>>  	int idx;
>> +	bool notify = true;
>>  
>>  	resampler = container_of(kian,
>>  			struct kvm_kernel_irqfd_resampler, notifier);
>> @@ -75,13 +76,52 @@ irqfd_resampler_ack(struct kvm_irq_ack_notifier *kian)
>>  	kvm_set_irq(kvm, KVM_IRQFD_RESAMPLE_IRQ_SOURCE_ID,
>>  		    resampler->notifier.gsi, 0, false);
>>  
>> -	idx = srcu_read_lock(&kvm->irq_srcu);
>> +	spin_lock(&resampler->lock);
>> +	if (resampler->masked) {
>> +		notify = false;
>> +		resampler->pending = true;
>> +	}
>> +	spin_unlock(&resampler->lock);
>> +
>> +	if (notify) {
>> +		idx = srcu_read_lock(&kvm->irq_srcu);
>>  
>> -	list_for_each_entry_srcu(irqfd, &resampler->list, resampler_link,
>> -	    srcu_read_lock_held(&kvm->irq_srcu))
>> -		eventfd_signal(irqfd->resamplefd, 1);
>> +		list_for_each_entry_srcu(irqfd, &resampler->list, resampler_link,
>> +		    srcu_read_lock_held(&kvm->irq_srcu))
>> +			eventfd_signal(irqfd->resamplefd, 1);
> nit: you may introduce a helper for above code as the code is duplicated.

Ack.

>>  
>> -	srcu_read_unlock(&kvm->irq_srcu, idx);
>> +		srcu_read_unlock(&kvm->irq_srcu, idx);
>> +	}
>> +}
>> +
>> +static void irqfd_resampler_mask_notify(struct kvm_irq_mask_notifier *kimn,
>> +					bool masked)
>> +{
>> +	struct kvm_kernel_irqfd_resampler *resampler;
>> +	struct kvm *kvm;
>> +	struct kvm_kernel_irqfd *irqfd;
>> +	int idx;
>> +	bool notify;
>> +
>> +	resampler = container_of(kimn,
>> +			struct kvm_kernel_irqfd_resampler, mask_notifier);
>> +	kvm = resampler->kvm;
>> +
>> +	spin_lock(&resampler->lock);
>> +	notify = !masked && resampler->pending;
>> +	resampler->masked = masked;
>> +	resampler->pending = false;
>> +	spin_unlock(&resampler->lock);
>> +
>> +	if (notify) {
>> +		idx = srcu_read_lock(&kvm->irq_srcu);
>> +
>> +		list_for_each_entry_srcu(irqfd, &resampler->list, resampler_link,
>> +		    srcu_read_lock_held(&kvm->irq_srcu))
>> +			eventfd_signal(irqfd->resamplefd, 1);
>> +
>> +		srcu_read_unlock(&kvm->irq_srcu, idx);
>> +	}
>>  }
>>  
>>  static void
>> @@ -98,6 +138,8 @@ irqfd_resampler_shutdown(struct kvm_kernel_irqfd *irqfd)
>>  	if (list_empty(&resampler->list)) {
>>  		list_del(&resampler->link);
>>  		kvm_unregister_irq_ack_notifier(kvm, &resampler->notifier);
>> +		kvm_unregister_irq_mask_notifier(kvm, resampler->mask_notifier.irq,
>> +						 &resampler->mask_notifier);
>>  		kvm_set_irq(kvm, KVM_IRQFD_RESAMPLE_IRQ_SOURCE_ID,
>>  			    resampler->notifier.gsi, 0, false);
>>  		kfree(resampler);
>> @@ -367,9 +409,13 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
>>  			INIT_LIST_HEAD(&resampler->list);
>>  			resampler->notifier.gsi = irqfd->gsi;
>>  			resampler->notifier.irq_acked = irqfd_resampler_ack;
>> +			resampler->mask_notifier.func = irqfd_resampler_mask_notify;
>> +			spin_lock_init(&resampler->lock);
>>  			INIT_LIST_HEAD(&resampler->link);
>>  
>>  			list_add(&resampler->link, &kvm->irqfds.resampler_list);
>> +			kvm_register_and_fire_irq_mask_notifier(kvm, irqfd->gsi,
>> +								&resampler->mask_notifier);
>>  			kvm_register_irq_ack_notifier(kvm,
>>  						      &resampler->notifier);
>>  			irqfd->resampler = resampler;
> Adding Marc in CC
> 
> Thanks
> 
> Eric
> 
