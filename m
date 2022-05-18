Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A8F52BAA6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 14:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbiERM0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 08:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236532AbiERM0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 08:26:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C522A1180E
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 05:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652876762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ag47svcSletw0D4Eogws0bEKxZvRytmFQIh9SFkLfx4=;
        b=QCkJApX+Q5QgZBI8RGvYMzgbJBh9PYz5FKOjS96wCFNvQIT0iRq0MWOMXrdOa+kNZFLsiL
        nZhEpS7eAzawdzdTk/MVBF1vRmOq+jEO4oTXTpHMQe4Zff7a9q9HTLzeLuaA8+IZiRFYFo
        7mtbH5CRydG875vVxv+nFTx/RQ7T14w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-xy30N_oqOX63Plw2T9GrUQ-1; Wed, 18 May 2022 08:26:02 -0400
X-MC-Unique: xy30N_oqOX63Plw2T9GrUQ-1
Received: by mail-wr1-f69.google.com with SMTP id bv12-20020a0560001f0c00b0020e359b3852so532012wrb.14
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 05:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ag47svcSletw0D4Eogws0bEKxZvRytmFQIh9SFkLfx4=;
        b=ca8Wja65uATYwaNfE+XHBMROOa3MbC8uauMh1wZ+T/Z+oQ83uYeJcyN0/A1DfoMJAk
         gX7kh39L9x2xgHEQlKC2TLEG5E0bXMkJPV1+isor+hQuKsyR4CiffWsUPr/9IpJNUHjn
         TcwudQgyw/BR7eTRHJ8nN4u7rvGb+l4cWqrkqYT/hK2RmsA3Ghrnv0dY8xNctDldXzfa
         9y1QaVZKBCPjvKfoQjFXMyGZQGNylG9Wwj7pXgAAFjWHn7rp4sYILbWjzLjHlC6K+qxa
         KBECWx6hvSrsGk0aygDhvon7roSzEGi976HlYud68VYS7255nT9RSTxhwI3oo9UqpCYo
         LNnQ==
X-Gm-Message-State: AOAM532hh2CCmcVypWhvUKFVx95o+PK5THNqDFvXobEw+hmLYb50dG+0
        VeSuoosJ7i5n2XcexRoEjyotWkO876Qdcn971zR7041h8Ci4NTqb9C0Ie/+CqlACPHBWX+0qQ9p
        Hnp3iFYp/Jrqs7a63fuDjbkM1kjkgmMFk1tqsOungigHiYuYNKHHV4SA9krNqFO/2MiYXEOBdpK
        qZ
X-Received: by 2002:adf:a3c2:0:b0:20c:fecc:8885 with SMTP id m2-20020adfa3c2000000b0020cfecc8885mr17227574wrb.463.1652876760725;
        Wed, 18 May 2022 05:26:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyFe+DsM9kcPagpIFfjB+7zvo4FOC76fHVKjk0i0QZnOytmXb9D8WdrAJ15H8IDDhLd4O/kw==
X-Received: by 2002:adf:a3c2:0:b0:20c:fecc:8885 with SMTP id m2-20020adfa3c2000000b0020cfecc8885mr17227532wrb.463.1652876760300;
        Wed, 18 May 2022 05:26:00 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id c13-20020adfc04d000000b0020d0351dbb6sm1964394wrf.80.2022.05.18.05.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 05:25:59 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 13/34] KVM: nSVM: Keep track of Hyper-V
 hv_vm_id/hv_vp_id
In-Reply-To: <30b0e63c0a2d3c3c40edb47af6d80e452f1e69fa.camel@redhat.com>
References: <20220414132013.1588929-1-vkuznets@redhat.com>
 <20220414132013.1588929-14-vkuznets@redhat.com>
 <30b0e63c0a2d3c3c40edb47af6d80e452f1e69fa.camel@redhat.com>
Date:   Wed, 18 May 2022 14:25:59 +0200
Message-ID: <874k1nuiw8.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxim Levitsky <mlevitsk@redhat.com> writes:

> On Thu, 2022-04-14 at 15:19 +0200, Vitaly Kuznetsov wrote:
>> Similar to nSVM, KVM needs to know L2's VM_ID/VP_ID and Partition
>> assist page address to handle L2 TLB flush requests.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/kvm/svm/hyperv.h | 16 ++++++++++++++++
>>  arch/x86/kvm/svm/nested.c |  2 ++
>>  2 files changed, 18 insertions(+)
>> 
>> diff --git a/arch/x86/kvm/svm/hyperv.h b/arch/x86/kvm/svm/hyperv.h
>> index 7d6d97968fb9..8cf702fed7e5 100644
>> --- a/arch/x86/kvm/svm/hyperv.h
>> +++ b/arch/x86/kvm/svm/hyperv.h
>> @@ -9,6 +9,7 @@
>>  #include <asm/mshyperv.h>
>>  
>>  #include "../hyperv.h"
>> +#include "svm.h"
>>  
>>  /*
>>   * Hyper-V uses the software reserved 32 bytes in VMCB
>> @@ -32,4 +33,19 @@ struct hv_enlightenments {
>>   */
>>  #define VMCB_HV_NESTED_ENLIGHTENMENTS VMCB_SW
>>  
>> +static inline void nested_svm_hv_update_vm_vp_ids(struct kvm_vcpu *vcpu)
>> +{
>> +	struct vcpu_svm *svm = to_svm(vcpu);
>> +	struct hv_enlightenments *hve =
>> +		(struct hv_enlightenments *)svm->nested.ctl.reserved_sw;
>
> Small nitpick:
>
> Can we use this as an opportunity to rename the 'reserved_sw' to \
> 'hv_enlightenments' or something, because that is what it is?
>
> Also the reserved_sw is an array, which is confusing, since from first look,
> it looks like we have a pointer dereference here.
>

Well, that's what it is in Hyper-V world and so far we didn't give it
another meaning in KVM but in theory it is not impossible, e.g. we can
use this area to speed up nested KVM on KVM.

AMD calls this "Reserved for Host usage" so we can probably rename it to 
'reserved_host' but I'm not sure it's worth the hassle...

>
>
>> +	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
>> +
>> +	if (!hv_vcpu)
>> +		return;
>> +
>> +	hv_vcpu->nested.pa_page_gpa = hve->partition_assist_page;
>> +	hv_vcpu->nested.vm_id = hve->hv_vm_id;
>> +	hv_vcpu->nested.vp_id = hve->hv_vp_id;
>> +}
>> +
>>  #endif /* __ARCH_X86_KVM_SVM_HYPERV_H__ */
>> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
>> index bed5e1692cef..2d1a76343404 100644
>> --- a/arch/x86/kvm/svm/nested.c
>> +++ b/arch/x86/kvm/svm/nested.c
>> @@ -826,6 +826,8 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
>>  
>>  	svm->nested.nested_run_pending = 1;
>>  
>> +	nested_svm_hv_update_vm_vp_ids(vcpu);
>> +
>>  	if (enter_svm_guest_mode(vcpu, vmcb12_gpa, vmcb12, true))
>>  		goto out_exit_err;
>>  
>
> That won't work after migration, since this won't be called
> if we migrate with nested guest running.
>
>
> I think that nested_svm_hv_update_vm_vp_ids should be called 
> from enter_svm_guest_mode.
>

Oh that's a good one, thanks! This could've been a hard to debug issue.

-- 
Vitaly

