Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B467A4E5271
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 13:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243184AbiCWMsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 08:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236374AbiCWMsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 08:48:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B57477C141
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 05:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648039611;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DTnFtVcodyoIwIXV9QxS/vo7a2K9rOATfHER2lAcBYs=;
        b=D5udak05osjVDH0IED2H5KlgJOUVIUbQkmRl7cKZGMMj2dNvJlcj6PIenAZun/gHqmQ2UN
        WNzXXQPwPEXLJW9XX6gmfTl5DbTVRV6fs5iMAJbvkGprMynRvW5m7bqqd9LvyAu9ALyCbd
        cCPMw4zf+TpTwzpUhiOHGiyebh1ytPY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-gHMvhEejPxqhMi7HhzDauQ-1; Wed, 23 Mar 2022 08:46:48 -0400
X-MC-Unique: gHMvhEejPxqhMi7HhzDauQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0BD23810D56;
        Wed, 23 Mar 2022 12:46:47 +0000 (UTC)
Received: from [10.72.12.33] (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 66F2C401E78;
        Wed, 23 Mar 2022 12:46:43 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v5 03/22] KVM: arm64: Support SDEI_VERSION hypercall
To:     Oliver Upton <oupton@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, maz@kernel.org,
        linux-kernel@vger.kernel.org, eauger@redhat.com,
        shan.gavin@gmail.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org
References: <20220322080710.51727-1-gshan@redhat.com>
 <20220322080710.51727-4-gshan@redhat.com> <YjoPxLAMIPobBzS0@google.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <d8e151e5-080b-dc87-b7e0-9031a7928853@redhat.com>
Date:   Wed, 23 Mar 2022 20:46:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <YjoPxLAMIPobBzS0@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
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

On 3/23/22 2:04 AM, Oliver Upton wrote:
> On Tue, Mar 22, 2022 at 04:06:51PM +0800, Gavin Shan wrote:
>> This supports SDEI_VERSION hypercall by returning v1.1, which is
>> the specification version we're following. The vendor is set to
>> 'KVM'.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/kvm/sdei.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
>> index 8a9b477b8977..5a3a64cd6e84 100644
>> --- a/arch/arm64/kvm/sdei.c
>> +++ b/arch/arm64/kvm/sdei.c
>> @@ -118,6 +118,14 @@ static bool remove_all_vcpu_events(struct kvm_vcpu *vcpu,
>>   	return pending;
>>   }
>>   
>> +static unsigned long hypercall_version(struct kvm_vcpu *vcpu)
>> +{
>> +	/* v1.1 and the vendor is KVM */
>> +	return (1UL << SDEI_VERSION_MAJOR_SHIFT) |
>> +	       (1UL << SDEI_VERSION_MINOR_SHIFT) |
>> +	       0x4b564d;
> 
> It looks like the SDEI specification states that the vendor-defined
> version number is 32 bits. Could we just use one of the
> ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_{0,3} values instead?
> 
> ASCII 'KVM' is neat, but in reality guest software will just throw it in
> a macro regardless. Might as well use one of the values we've already
> trained it to use :-)
> 
> Also, it would appear that guest discovery of SDEI relies upon KVM
> reporting a valid SDEI version. IMO, this patch should come at the very
> end when KVM actually implements SDEI.
> 

Yeah, I was sticky to the pattern of "KVM". However, I think it's good
to reuse the existing one. Lets use ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_2
if you agree. Its first two characters are "VM" at least.

It's fine to return the version here because the SDEI capability isn't
exposed yet. It means no events have been exposed and able to be
registered. However, It's also fine to move this patch after the
following one:

[PATCH v5 16/22] KVM: arm64: Support SDEI_EVENT_{COMPLETE, COMPLETE_AND_RESUME} hypercall

Thanks,
Gavin

