Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50BAA48D28D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 08:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiAMHCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 02:02:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41328 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229684AbiAMHCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 02:02:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642057361;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wa1b8MmKgX3tm872f9qab+x44K+GoLAvtcl9qdRW4BA=;
        b=DcIX1a4g46TBzFYiGgzHM7IEZqh8OzEViTQdVdZgtQQVYKgUcBnvDZhQzDFcis2jNXyvc/
        wARAxIp6Fk8sndl5gDYlPLnq4QUvgZYQ5LM360e1pciE7FtwrB8kMZO1wxYnxGnuD0raLS
        VNWv0naQG9TC47CfdoS5Xjt06/RdK4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-ODlie5dgMVCGAC5FglCJow-1; Thu, 13 Jan 2022 02:02:38 -0500
X-MC-Unique: ODlie5dgMVCGAC5FglCJow-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06D7C8042DB;
        Thu, 13 Jan 2022 07:02:37 +0000 (UTC)
Received: from [10.72.13.202] (ovpn-13-202.pek2.redhat.com [10.72.13.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F3656784A;
        Thu, 13 Jan 2022 07:02:21 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v4 06/21] KVM: arm64: Support SDEI_EVENT_CONTEXT hypercall
To:     Shannon Zhao <shannon.zhaosl@gmail.com>,
        kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-7-gshan@redhat.com>
 <40d818a2-0c91-e06e-6ce8-ac8123b8d1d4@gmail.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <798ecbb0-f369-f3e7-ad50-78acfd902d1d@redhat.com>
Date:   Thu, 13 Jan 2022 15:02:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <40d818a2-0c91-e06e-6ce8-ac8123b8d1d4@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shannon,

On 1/11/22 5:43 PM, Shannon Zhao wrote:
> On 2021/8/15 8:13, Gavin Shan wrote:
>> +static unsigned long kvm_sdei_hypercall_context(struct kvm_vcpu *vcpu)
>> +{
>> +    struct kvm *kvm = vcpu->kvm;
>> +    struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
>> +    struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
>> +    struct kvm_sdei_vcpu_regs *regs;
>> +    unsigned long index = smccc_get_arg1(vcpu);
>> +    unsigned long ret = SDEI_SUCCESS;
>> +
>> +    /* Sanity check */
>> +    if (!(ksdei && vsdei)) {
>> +        ret = SDEI_NOT_SUPPORTED;
>> +        goto out;
>> +    }
> Maybe we could move these common sanity check codes to kvm_sdei_hypercall to save some lines.
> 

Not all hypercalls need this check. For example, COMPLETE/COMPLETE_RESUME/CONTEXT don't
have SDEI event number as the argument. If we really want move this check into function
kvm_sdei_hypercall(), we would have code like below. Too much duplicated snippets will
be seen. I don't think it's better than what we have if I fully understand your comments.

       switch (...) {
       case REGISTER:
            if (!(ksdei && vsdei)) {
                ret = SDEI_NOT_SUPPORTED;
                break;
            }

            ret = kvm_sdei_hypercall_register(vcpu);
            break;
       case UNREGISTER:
            if (!(ksdei && vsdei)) {
                ret = SDEI_NOT_SUPPORTED;
                break;
            }

            ret = kvm_sdei_hypercall_unregister(vcpu);
            break;
      case CONTEXT:
            ret = kvm_sdei_hypercall_context(vcpu);
            break;
        :
     }

Thanks,
Gavin

