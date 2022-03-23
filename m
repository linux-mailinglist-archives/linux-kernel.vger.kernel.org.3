Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55594E51FE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 13:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbiCWMSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 08:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236959AbiCWMRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 08:17:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 698566E360
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 05:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648037784;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cKZQyQfM1SrU7UHeHhmB05DBFXftBCZkFW+SMB5Y0vI=;
        b=MlfUYzUPiCuDYqR30qpwnOhAORVLh+ihXgOag4u4vMKIe5HTeba4ZbCpLaMOpdGubw84Gb
        XM/La7p+YGfoXNPV4BjQNUr6mer6RDfW9BV7RdxJdoynuoU9lrAq6LPiXPz20KJFHFOg+0
        hTIivgSc2bBEOk03KHMRApXo0OWootQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-8NecRMKoPI-0zLlKbyh3Sg-1; Wed, 23 Mar 2022 08:16:23 -0400
X-MC-Unique: 8NecRMKoPI-0zLlKbyh3Sg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C520185A79C;
        Wed, 23 Mar 2022 12:16:22 +0000 (UTC)
Received: from [10.72.12.33] (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C88E7202699A;
        Wed, 23 Mar 2022 12:16:13 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v5 01/22] KVM: arm64: Introduce template for inline
 functions
To:     Oliver Upton <oupton@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, maz@kernel.org,
        linux-kernel@vger.kernel.org, eauger@redhat.com,
        shan.gavin@gmail.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org
References: <20220322080710.51727-1-gshan@redhat.com>
 <20220322080710.51727-2-gshan@redhat.com> <YjomvjFNjGADmu6l@google.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <7a7f2325-c9fc-7e8f-c10d-11de3ddc1a59@redhat.com>
Date:   Wed, 23 Mar 2022 20:16:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <YjomvjFNjGADmu6l@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On 3/23/22 3:42 AM, Oliver Upton wrote:
> On Tue, Mar 22, 2022 at 04:06:49PM +0800, Gavin Shan wrote:
>> The inline functions used to get the SMCCC parameters have same
>> layout. It means these functions can be presented by an unified
>> template, to make the code simplified. Besides, this adds more
>> similar inline functions like smccc_get_arg{4,5,6,7,8}() to get
>> more SMCCC arguments, which are needed by SDEI virtualization
>> support.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   include/kvm/arm_hypercalls.h | 24 ++++++++++++------------
>>   1 file changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/kvm/arm_hypercalls.h b/include/kvm/arm_hypercalls.h
>> index 0e2509d27910..d5144c852fe4 100644
>> --- a/include/kvm/arm_hypercalls.h
>> +++ b/include/kvm/arm_hypercalls.h
>> @@ -13,20 +13,20 @@ static inline u32 smccc_get_function(struct kvm_vcpu *vcpu)
>>   	return vcpu_get_reg(vcpu, 0);
>>   }
>>   
>> -static inline unsigned long smccc_get_arg1(struct kvm_vcpu *vcpu)
>> -{
>> -	return vcpu_get_reg(vcpu, 1);
>> -}
>> -
>> -static inline unsigned long smccc_get_arg2(struct kvm_vcpu *vcpu)
>> -{
>> -	return vcpu_get_reg(vcpu, 2);
>> +#define SMCCC_DECLARE_GET_ARG(reg)					\
>> +static inline unsigned long smccc_get_arg##reg(struct kvm_vcpu *vcpu)	\
>> +{									\
>> +	return vcpu_get_reg(vcpu, reg);					\
>>   }
>>   
>> -static inline unsigned long smccc_get_arg3(struct kvm_vcpu *vcpu)
>> -{
>> -	return vcpu_get_reg(vcpu, 3);
>> -}
>> +SMCCC_DECLARE_GET_ARG(1)
>> +SMCCC_DECLARE_GET_ARG(2)
>> +SMCCC_DECLARE_GET_ARG(3)
>> +SMCCC_DECLARE_GET_ARG(4)
>> +SMCCC_DECLARE_GET_ARG(5)
>> +SMCCC_DECLARE_GET_ARG(6)
>> +SMCCC_DECLARE_GET_ARG(7)
>> +SMCCC_DECLARE_GET_ARG(8)
> 
> Hmm. What if we specify a single inline function where the caller passes
> the arg # as a parameter? We really just want to abstract away the
> off-by-one difference between GP registers and SMCCC arguments.
> 
> Macros generally make me uneasy for template functions, but I may be in
> the vocal minority on this topic :)
> 

I think it's a good idea to have smccc_get_arg(unsigned char index).
However, it will cause more code changes because the following functions
have been used. Anyway, I think it's still worthy to pass @index to
differentiate the argument index. I will change it accordingly in
next respin.

    smccc_get_arg1()
    smccc_get_arg2()
    smccc_get_arg3()

Thanks,
Gavin

