Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A13516982
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 04:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357013AbiEBC7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 22:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245246AbiEBC7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 22:59:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 311C5DEEE
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 19:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651460165;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NGrvaoQnB+WDFfZErhtm13zCdjhlGof9BLg4Q1WShAo=;
        b=MsmceqkSz7CVt5mJT6TPWaUrmffTthkgy7m6mOgbuS8PPwYDdWKJ6xuw/P5ewrQWOG7+/z
        sjrPT5rS0BbFSeaq7a2hdNtpMQVNCBIimCBbm+6AIkP5+VyC11fqnVqX9JvBHMoUYubawC
        fYWHA0nF5brOrPsRqdfPsZ3Bxcbamec=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-2zOJRDJYNA6WS2DmvQbokw-1; Sun, 01 May 2022 22:56:02 -0400
X-MC-Unique: 2zOJRDJYNA6WS2DmvQbokw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6273E8002B2;
        Mon,  2 May 2022 02:56:01 +0000 (UTC)
Received: from [10.72.12.86] (ovpn-12-86.pek2.redhat.com [10.72.12.86])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 09B971469399;
        Mon,  2 May 2022 02:55:54 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v6 04/18] KVM: arm64: Support SDEI_EVENT_REGISTER
 hypercall
To:     Oliver Upton <oupton@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        eauger@redhat.com, Jonathan.Cameron@huawei.com,
        vkuznets@redhat.com, will@kernel.org, shannon.zhaosl@gmail.com,
        james.morse@arm.com, mark.rutland@arm.com, maz@kernel.org,
        pbonzini@redhat.com, shan.gavin@gmail.com
References: <20220403153911.12332-1-gshan@redhat.com>
 <20220403153911.12332-5-gshan@redhat.com> <Ym1Nsaq/ERUx/ebD@google.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <6e7cb20d-24c4-b357-8830-a68ff05638fe@redhat.com>
Date:   Mon, 2 May 2022 10:55:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <Ym1Nsaq/ERUx/ebD@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On 4/30/22 10:54 PM, Oliver Upton wrote:
> On Sun, Apr 03, 2022 at 11:38:57PM +0800, Gavin Shan wrote:
>> This supports SDEI_EVENT_REGISTER hypercall, which is used by guest
>> to register event. The event won't be raised until it's registered
>> and enabled. For those KVM owned events, they can't be registered
>> if they aren't exposed.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/kvm/sdei.c | 78 +++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 78 insertions(+)
>>
>> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
>> index 3507e33ec00e..89c1b231cb60 100644
>> --- a/arch/arm64/kvm/sdei.c
>> +++ b/arch/arm64/kvm/sdei.c
>> @@ -25,6 +25,81 @@ static struct kvm_sdei_exposed_event exposed_events[] = {
>>   	for (idx = 0, event = &exposed_events[0];	\
>>   	     idx < ARRAY_SIZE(exposed_events);		\
>>   	     idx++, event++)
>> +#define kvm_sdei_for_each_event(vsdei, event, idx)	\
>> +	for (idx = 0, event = &vsdei->events[0];	\
>> +	     idx < ARRAY_SIZE(exposed_events);		\
>> +	     idx++, event++)
>> +
>> +static struct kvm_sdei_event *find_event(struct kvm_vcpu *vcpu,
>> +					 unsigned int num)
>> +{
>> +	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
>> +	struct kvm_sdei_event *event;
>> +	int i;
>> +
>> +	kvm_sdei_for_each_event(vsdei, event, i) {
>> +		if (event->exposed_event->num == num)
>> +			return event;
>> +	}
>> +
>> +	return NULL;
>> +}
> 
> I imagine you'll drop this hunk in the next spin.
> 

Yes, I will :)

>> +static unsigned long hypercall_register(struct kvm_vcpu *vcpu)
> 
> Hmm, hypercall_ is not a very descriptive scope. Could you instead do
> something like kvm_sdei_?
> 
> so for this one, kvm_sdei_event_register()? Provides decent context
> clues to connect back to the spec as well.
> 

Sure. I will revise the names of all functions for hypercalls and
remove "hypercall" prefix. For this particular case, I would use
event_register() because "kvm_sdei_" prefix has been reserved for
those global scoped functions :)

>> +{
>> +	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
>> +	struct kvm_sdei_event *event;
>> +	unsigned int num = smccc_get_arg(vcpu, 1);
>> +	unsigned long ep_address = smccc_get_arg(vcpu, 2);
>> +	unsigned long ep_arg = smccc_get_arg(vcpu, 3);
> 
> We discussed using some structure to track the registered context of an
> event. Maybe just build it on the stack then assign it in the array?
> 

Yes, It will be something like below:

      struct kvm_sdei_event_handler handler = {
             .ep_address = smccc_get_arg(vcpu, 2),
             .ep_arg     = smccc_get_arg(vcpu, 3),
      };

>> +	unsigned long route_mode = smccc_get_arg(vcpu, 4);
> 
> This is really 'flags'. route_mode is bit[0]. I imagine we don't want to
> support relative mode, so bit[1] is useless for us in that case too.
> 
> The spec is somewhat imprecise on what happens for reserved flags. The
> prototype in section 5.1.2 of [1] suggests that reserved bits must be
> zero, but 5.1.2.3 'Client responsibilities' does not state that invalid
> flags result in an error.
> 
> Arm TF certainly rejects unexpected flags [2].
> 
> [1]: DEN0054C https://developer.arm.com/documentation/den0054/latest
> [2]: https://github.com/ARM-software/arm-trusted-firmware/blob/66c3906e4c32d675eb06bd081de8a3359f76b84c/services/std_svc/sdei/sdei_main.c#L260
> 

Yes, This chunk of code is still stick to old specification. Lets
improve in next respin:

    - Rename @route_mode to @flags
    - Reject if the reserved bits are set.
    - Reject if relative mode (bit#1) is selected.
    - Reject if routing mode (bit#0) isn't RM_ANY (0).
    - @route_affinity will be dropped.

Thanks,
Gavin

