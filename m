Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65BF48D2A4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 08:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiAMHJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 02:09:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55413 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229684AbiAMHJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 02:09:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642057788;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7V9fKZCDVzeOOG8kZLX9cFIbWO+ukoGgMFPdyggLbxc=;
        b=ImYma3jTdZqTcQRGyg2hAgTqTSsQnIoNJ4I0XeRDXnyTReT9Y3cK5xB8TygSB2Il9sZrt3
        GVJf6R5aR2xQZMy+pGEV7eyw3Cob1COECfC8bPBzywM3X4di6keEnG5Q+LvHJVXDi5upd+
        DS7DnbTw43d4uBZ7eQ7xz5b9tOVCo3M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-70-qG4GOHG_MrWKoSBuXCn5Mg-1; Thu, 13 Jan 2022 02:09:43 -0500
X-MC-Unique: qG4GOHG_MrWKoSBuXCn5Mg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA4221006AA4;
        Thu, 13 Jan 2022 07:09:41 +0000 (UTC)
Received: from [10.72.13.202] (ovpn-13-202.pek2.redhat.com [10.72.13.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 528C278DE9;
        Thu, 13 Jan 2022 07:09:37 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v4 02/21] KVM: arm64: Add SDEI virtualization
 infrastructure
To:     Shannon Zhao <shannon.zhaosl@gmail.com>,
        kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-3-gshan@redhat.com>
 <89165079-d2a6-fad8-3a9c-dcb46a8acdc7@gmail.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <41ccffa1-4094-7e71-246f-ac11023f741a@redhat.com>
Date:   Thu, 13 Jan 2022 15:09:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <89165079-d2a6-fad8-3a9c-dcb46a8acdc7@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shannon,

On 1/11/22 5:40 PM, Shannon Zhao wrote:
> On 2021/8/15 8:13, Gavin Shan wrote:
>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>> index e9a2b8f27792..2f021aa41632 100644
>> --- a/arch/arm64/kvm/arm.c
>> +++ b/arch/arm64/kvm/arm.c
>> @@ -150,6 +150,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>>       kvm_vgic_early_init(kvm);
>> +    kvm_sdei_init_vm(kvm);
>> +
>>       /* The maximum number of VCPUs is limited by the host's GIC model */
>>       kvm->arch.max_vcpus = kvm_arm_default_max_vcpus();
> Hi, Is it possible to let user space to choose whether enabling SEDI or not rather than enable it by default?
> 

It's possible, but what's the benefit to do so. I think about it for
a while and I don't think it's not necessary, at least for now. First
of all, the SDEI event is injected from individual modules in userspace
(QEMU) or host kernel (Async PF). If we really want the function to be
disabled, the individual modules can accept parameter, used to indicate
the SDEI event injection is allowed or not. In this case, SDEI is enabled
by default, but the individual modules can choose not to use it :)

Thanks,
Gavin

