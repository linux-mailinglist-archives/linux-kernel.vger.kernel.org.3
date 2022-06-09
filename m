Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1199A544702
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236500AbiFIJNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbiFIJN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:13:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5430C16595
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 02:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654766006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SZw+ycfYF9t98F3LaguYuBwfxvvxqsS7Jsc/OX/XJJk=;
        b=bEpzTYvplZhdM8jUHSUQ5/c6x+zOuhvB3ROyiPryGhUckoRzGIz4UpPHe10jbWo97Ral6W
        YdAjoyuIpW57FkSx3MD5SKbK76DZkk6/GE+lRTR6GSdiGqa+SUUYmorn+lrKEvyREr4UeB
        iUGfewqI3K8oI/BjKars0Gx91H5D0o0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-WJ4kA6YNMZGgwH9lXvKOYg-1; Thu, 09 Jun 2022 05:13:25 -0400
X-MC-Unique: WJ4kA6YNMZGgwH9lXvKOYg-1
Received: by mail-wm1-f70.google.com with SMTP id k32-20020a05600c1ca000b0039c4cf75023so6741040wms.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 02:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=SZw+ycfYF9t98F3LaguYuBwfxvvxqsS7Jsc/OX/XJJk=;
        b=7Ikx8X7rOXZkur4/NLznMsbaqSgk0kuO+qi52Ie8+aJb4+0IFZmXx0HjPc/iu/fx7f
         Oi+stFMzsO/Rb6NDqNjPG3Y8CbbIsgOiHhgI/joYZHk5PDXjlwy9WTONj/+1GrI6Y3ai
         GkjrZNOs69JPGZsIaOEi2pj87xj8qcDUDDPNq13/rNK6VaH+SbGLPN+GpA6dOgFt1OWc
         sVC6rSxkjZO5PR1r0Aq6FzHcYoWeZj90xrHPSpEjCG6yurymR/XytbeFNlaGiDu74io7
         NjdtP9IEX+/ri6AWS6djFQDL0fia3swNwOFu7c26nTyqJbgHlFb+0mg20Xemw7gLTdg/
         vZFw==
X-Gm-Message-State: AOAM531PaeId0CaYk5XE43tVhbuCMy8p5KTdaxaPNROb1JI8ufG/qfyl
        saqatGQVMy86srCn5zjLXKfECwkWc33l9Ku6Zy8ENuPXRPbkINx9iVP03mjvGGA5TwwwIFoy0YU
        h1qbVvU9RrvR2ZTLRSjZ1VJ+IfQUO31SJZxIIZ0KdTpONxWMxYXEwkF17JdFRA3JfWbq/+rQSoE
        Lz
X-Received: by 2002:a5d:59ae:0:b0:217:2519:8a0f with SMTP id p14-20020a5d59ae000000b0021725198a0fmr24488080wrr.383.1654766003880;
        Thu, 09 Jun 2022 02:13:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcUBuhoKwLjJ6mWqe98WIBEEI8GOuoODhLbQKu8EN525WWKpyuiTaaM6te1qxMrPbqqr4EMg==
X-Received: by 2002:a5d:59ae:0:b0:217:2519:8a0f with SMTP id p14-20020a5d59ae000000b0021725198a0fmr24488042wrr.383.1654766003547;
        Thu, 09 Jun 2022 02:13:23 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id n20-20020a7bc5d4000000b0039aef592ca0sm26677815wmk.35.2022.06.09.02.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 02:13:22 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Yuan Yao <yuan.yao@linux.intel.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 05/38] KVM: x86: hyper-v: Handle
 HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST{,EX} calls gently
In-Reply-To: <20220608101847.63xavwsgfdprpaes@yy-desk-7060>
References: <20220606083655.2014609-1-vkuznets@redhat.com>
 <20220606083655.2014609-6-vkuznets@redhat.com>
 <20220608101847.63xavwsgfdprpaes@yy-desk-7060>
Date:   Thu, 09 Jun 2022 11:13:22 +0200
Message-ID: <87o7z2kxn1.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yuan Yao <yuan.yao@linux.intel.com> writes:

> On Mon, Jun 06, 2022 at 10:36:22AM +0200, Vitaly Kuznetsov wrote:
>> Currently, HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST{,EX} calls are handled
>> the exact same way as HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE{,EX}: by
>> flushing the whole VPID and this is sub-optimal. Switch to handling
>> these requests with 'flush_tlb_gva()' hooks instead. Use the newly
>> introduced TLB flush fifo to queue the requests.
>>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/kvm/hyperv.c | 100 +++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 88 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
>> index 762b0b699fdf..956072592e2f 100644
>> --- a/arch/x86/kvm/hyperv.c
>> +++ b/arch/x86/kvm/hyperv.c
>> @@ -1806,32 +1806,82 @@ static u64 kvm_get_sparse_vp_set(struct kvm *kvm, struct kvm_hv_hcall *hc,
>>  				  sparse_banks, consumed_xmm_halves, offset);
>>  }
>>
>> -static void hv_tlb_flush_enqueue(struct kvm_vcpu *vcpu)
>> +static int kvm_hv_get_tlb_flush_entries(struct kvm *kvm, struct kvm_hv_hcall *hc, u64 entries[],
>> +					int consumed_xmm_halves, gpa_t offset)
>> +{
>> +	return kvm_hv_get_hc_data(kvm, hc, hc->rep_cnt, hc->rep_cnt,
>> +				  entries, consumed_xmm_halves, offset);
>> +}
>> +
>> +static void hv_tlb_flush_enqueue(struct kvm_vcpu *vcpu, u64 *entries, int count)
>>  {
>>  	struct kvm_vcpu_hv_tlb_flush_fifo *tlb_flush_fifo;
>>  	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
>>  	u64 entry = KVM_HV_TLB_FLUSHALL_ENTRY;
>> +	unsigned long flags;
>>
>>  	if (!hv_vcpu)
>>  		return;
>>
>>  	tlb_flush_fifo = &hv_vcpu->tlb_flush_fifo;
>>
>> -	kfifo_in_spinlocked(&tlb_flush_fifo->entries, &entry, 1, &tlb_flush_fifo->write_lock);
>> +	spin_lock_irqsave(&tlb_flush_fifo->write_lock, flags);
>> +
>> +	/*
>> +	 * All entries should fit on the fifo leaving one free for 'flush all'
>> +	 * entry in case another request comes in. In case there's not enough
>> +	 * space, just put 'flush all' entry there.
>> +	 */
>> +	if (count && entries && count < kfifo_avail(&tlb_flush_fifo->entries)) {
>> +		WARN_ON(kfifo_in(&tlb_flush_fifo->entries, entries, count) != count);
>> +		goto out_unlock;
>> +	}
>> +
>> +	/*
>> +	 * Note: full fifo always contains 'flush all' entry, no need to check the
>> +	 * return value.
>> +	 */
>> +	kfifo_in(&tlb_flush_fifo->entries, &entry, 1);
>> +
>> +out_unlock:
>> +	spin_unlock_irqrestore(&tlb_flush_fifo->write_lock, flags);
>>  }
>>
>>  void kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu)
>>  {
>>  	struct kvm_vcpu_hv_tlb_flush_fifo *tlb_flush_fifo;
>>  	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
>> +	u64 entries[KVM_HV_TLB_FLUSH_FIFO_SIZE];
>> +	int i, j, count;
>> +	gva_t gva;
>>
>> -	kvm_vcpu_flush_tlb_guest(vcpu);
>> -
>> -	if (!hv_vcpu)
>> +	if (!tdp_enabled || !hv_vcpu) {
>> +		kvm_vcpu_flush_tlb_guest(vcpu);
>>  		return;
>> +	}
>>
>>  	tlb_flush_fifo = &hv_vcpu->tlb_flush_fifo;
>>
>> +	count = kfifo_out(&tlb_flush_fifo->entries, entries, KVM_HV_TLB_FLUSH_FIFO_SIZE);
>
> Writers are protected by the fifo lock so only 1 writer VS 1 reader on
> this kfifo (at least so far), it shuold be safe but I'm not sure
> whether some unexpected cases there, e.g. KVM flushs another VCPU's
> kfifo while that VCPU is doing same thing for itself yet.
>

TLB is always flushed by the vCPU itself, here we just queue for it to
do so. Over-flushing is possible of course (e.g. the vCPU just flushed
and didn't even enter the guest but we're going to queue flush work for
it from other vCPUs), but that's nothing new even with the current
'dumb' implementation which always flushes everything.

The main concern should be that we never under-flush, i.e. return to the
caller while TLB on some target vCPUs was not flushed *and* target vCPUs
are running the guest.

-- 
Vitaly

