Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11564E5285
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 13:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243330AbiCWMx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 08:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbiCWMx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 08:53:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E2D57B552
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 05:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648039947;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kP4WEdqICDi/tswpTgBElOvFLSzQdggSOHSaXzbd4xY=;
        b=FqqphEo69+G0o8F/xtq7Q6pf+9RyJ8KyHyXkfVVD71+tDjN/eJzF6b2RQDnYHNfxlJdatp
        jHM/7QaJ9fVhYSgGuQNsAfGGzG0aQaWt/qK4JvLRFm1m29EZ8PMqNSSNSmE23hSt0JILjy
        5GlKPqOK28ymTBQ+VOaoLYxXsD3Skcg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-X4vk_0kdNPmY1lciXFhZUw-1; Wed, 23 Mar 2022 08:52:24 -0400
X-MC-Unique: X4vk_0kdNPmY1lciXFhZUw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9BD21064C8B;
        Wed, 23 Mar 2022 12:52:23 +0000 (UTC)
Received: from [10.72.12.33] (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE046C07F5B;
        Wed, 23 Mar 2022 12:52:18 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v5 15/22] KVM: arm64: Support SDEI_EVENT_SIGNAL hypercall
To:     Oliver Upton <oupton@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, maz@kernel.org,
        linux-kernel@vger.kernel.org, eauger@redhat.com,
        shan.gavin@gmail.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org
References: <20220322080710.51727-1-gshan@redhat.com>
 <20220322080710.51727-16-gshan@redhat.com> <YjpWXGIoaXUVjXQW@google.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <cfd58d73-ada1-8c42-1d3e-794766dd86d5@redhat.com>
Date:   Wed, 23 Mar 2022 20:52:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <YjpWXGIoaXUVjXQW@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On 3/23/22 7:06 AM, Oliver Upton wrote:
> On Tue, Mar 22, 2022 at 04:07:03PM +0800, Gavin Shan wrote:
>> This supports SDEI_EVENT_SIGNAL hypercall. It's used by the guest
>> to inject SDEI event, whose number must be zero to the specified
>> vCPU. As the routing mode and affinity isn't supported yet, the
>> calling vCPU is assumed to be the target.
>>
>> The SDEI event 0x0 is a private one, with normal priority. It's
>> usually used for testing.
> 
> I don't know if that is actually the case. One real use that immediately
> comes to mind is doing an NMI on a wedged CPU. KVM probably shouldn't
> glean at how the guest may use a particular call, so at most we should
> just point at the spec and state that event 0 is for software signaled
> events.
> 

Yes, I agree. I will amend the change log in next respin, to make it
clear. As you said, it really depend on how the event is used by
the guest. We can't assume its usage.

>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/kvm/sdei.c | 64 ++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 63 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
>> index a24270378305..ba2ca65c871b 100644
>> --- a/arch/arm64/kvm/sdei.c
>> +++ b/arch/arm64/kvm/sdei.c
>> @@ -726,6 +726,66 @@ static int do_inject_event(struct kvm_vcpu *vcpu,
>>   	return 0;
>>   }
>>   
>> +static unsigned long hypercall_signal(struct kvm_vcpu *vcpu)
>> +{
>> +	struct kvm *kvm = vcpu->kvm;
>> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
>> +	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
>> +	struct kvm_sdei_exposed_event *exposed_event;
>> +	struct kvm_sdei_registered_event *registered_event;
>> +	unsigned long event_num = smccc_get_arg1(vcpu);
>> +	int index;
>> +	unsigned long ret = SDEI_SUCCESS;
>> +
>> +	/* @event_num must be zero */
>> +	if (!kvm_sdei_is_default(event_num)) {
> 
> 0 isn't KVM's default event. I'd argue KVM doesn't have a default event
> to begin with. This has a precise definition coming from the spec. In
> fact, 'KVM_SDEI_DEFAULT_EVENT' should probably be eliminated, and any
> missing SDEI definitions should be added to include/uapi/linux/arm_sdei.h.
> 
> That goes for any values coming from the specification. KVM's
> implementation details belong in a KVM header :)
> 

Indeed. include/uapi/linux/arm_sdei.h is the right place to define
the software signaled event number. The function to validate/check
on it is still part of kvm_sdei.h, but its name would be something
like kvm_sdei_is_sw_signaled() or kvm_sdei_is_signaled_event().

Thanks,
Gavin

