Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04CB48BEF5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 08:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351175AbiALHWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 02:22:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28074 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237408AbiALHWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 02:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641972163;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SozMMaXUKHvJpCmWVV67dCSZEl8d23MxU5rvzgWoya8=;
        b=i+n3bDrzpsbmPeLTQrR2IKRyzu592AZ/HNxFGRhIb8Z43p50xRo1/30sd96JpXaSC6//qm
        tN+4XXcwvFzHz9HmZNm/fCsD2Sx5t1rHSSj7NL6DDfPOwnUar3nakjbGXyi2Irc7OEIBK8
        ffGn3GO7CggTBQnwPwWU0vI+uBPFRO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-9c7H-I3-PXyJH_JF4GvA4Q-1; Wed, 12 Jan 2022 02:20:52 -0500
X-MC-Unique: 9c7H-I3-PXyJH_JF4GvA4Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15EFB100C611;
        Wed, 12 Jan 2022 07:20:51 +0000 (UTC)
Received: from [10.72.12.204] (ovpn-12-204.pek2.redhat.com [10.72.12.204])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F363A5E4B7;
        Wed, 12 Jan 2022 07:20:47 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v4 20/21] KVM: arm64: Export SDEI capability
To:     Eric Auger <eauger@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-21-gshan@redhat.com>
 <90fd5226-0889-6a7c-1586-732015943863@redhat.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <29ff20b5-2395-2f2e-3c5c-6061c9a00716@redhat.com>
Date:   Wed, 12 Jan 2022 15:20:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <90fd5226-0889-6a7c-1586-732015943863@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/21 9:55 PM, Eric Auger wrote:
> On 8/15/21 2:13 AM, Gavin Shan wrote:
>> The SDEI functionality is ready to be exported so far. This adds
>> new capability (KVM_CAP_ARM_SDEI) and exports it.
> 
> Need to be documented in
> kvm/api.rst
> as the rest of the API
> 

Ok, Thanks, Eric :)


>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/kvm/arm.c     | 3 +++
>>   include/uapi/linux/kvm.h | 1 +
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>> index 215cdbeb272a..7d9bbc888ae5 100644
>> --- a/arch/arm64/kvm/arm.c
>> +++ b/arch/arm64/kvm/arm.c
>> @@ -278,6 +278,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>   	case KVM_CAP_ARM_PTRAUTH_GENERIC:
>>   		r = system_has_full_ptr_auth();
>>   		break;
>> +	case KVM_CAP_ARM_SDEI:
>> +		r = 1;
>> +		break;
>>   	default:
>>   		r = 0;
>>   	}
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index 8cf41fd4bf86..2aa748fd89c7 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -1112,6 +1112,7 @@ struct kvm_ppc_resize_hpt {
>>   #define KVM_CAP_BINARY_STATS_FD 203
>>   #define KVM_CAP_EXIT_ON_EMULATION_FAILURE 204
>>   #define KVM_CAP_ARM_MTE 205
>> +#define KVM_CAP_ARM_SDEI 206
>>   
>>   #ifdef KVM_CAP_IRQ_ROUTING
>>   
>>
> Eric
> 

