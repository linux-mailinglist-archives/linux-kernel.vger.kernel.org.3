Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65544E6E1E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 07:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358417AbiCYGNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 02:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234571AbiCYGNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 02:13:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93618B8216
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 23:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648188696;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wuTRsT/Tz6ofz67ssIJ6RwjRRnXFcLV1cw3Q00t4VHc=;
        b=UmF0es09wHszL1zoLFWytDwFpRGyYm8j1oIVn+IaMQR5EPMJ2rbpayzDEApnQWHG7c5oan
        26bsnvclkC7hL8qqILEgN/OmFoFXn6kjqfVcLFWsmV0hTxDYqsn7sbtIRQzxEC4pZq5wcE
        FOU+DXFWnB43GALjdG/x/pO6uQySwE0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-LzbVV2nSPrSAJp3HCQboTA-1; Fri, 25 Mar 2022 02:11:33 -0400
X-MC-Unique: LzbVV2nSPrSAJp3HCQboTA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4883801E67;
        Fri, 25 Mar 2022 06:11:22 +0000 (UTC)
Received: from [10.72.12.33] (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B6273401053;
        Fri, 25 Mar 2022 06:11:14 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v5 03/22] KVM: arm64: Support SDEI_VERSION hypercall
To:     Oliver Upton <oupton@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, maz@kernel.org,
        linux-kernel@vger.kernel.org, eauger@redhat.com,
        shan.gavin@gmail.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org
References: <20220322080710.51727-1-gshan@redhat.com>
 <20220322080710.51727-4-gshan@redhat.com> <YjoPxLAMIPobBzS0@google.com>
 <d8e151e5-080b-dc87-b7e0-9031a7928853@redhat.com>
 <YjtLVqBbL0jyFFZy@google.com>
 <6f217836-45fb-8833-7bb1-5dc822826f56@redhat.com>
 <YjwiQ10CE5AtoM4Y@google.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <09814baf-3107-5fa9-f92c-cc271f384c4a@redhat.com>
Date:   Fri, 25 Mar 2022 14:11:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <YjwiQ10CE5AtoM4Y@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
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

On 3/24/22 3:48 PM, Oliver Upton wrote:
> On Thu, Mar 24, 2022 at 12:07:34PM +0800, Gavin Shan wrote:
> 
> [...]
> 
>>>> Yeah, I was sticky to the pattern of "KVM". However, I think it's good
>>>> to reuse the existing one. Lets use ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_2
>>>> if you agree. Its first two characters are "VM" at least.
>>>
>>> Sounds fine to me. The only other nit I'd say is we should define a
>>> macro for it too, something like:
>>>
>>>     #define KVM_SDEI_VENDOR	ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_2
>>>
>>
>> Agreed, and the macro will be put into arch/arm64/include/asm/kvm_sdei.h.
>> arch/arm64/include/uapi/asm/kvm_sdei_state.h isn't the right place because
>> the dependent macro ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_2 isn't exposed by
>> ABI.
> 
> The argument could definitely be made that our vendor ID should be
> promoted to UAPI. Even though linux is the only known user of our
> vendor-specific hypercalls, nothing is stopping other software from
> using them. Beyond that, these values should really never change anyway.
> 
> It isn't a big deal if you add it to internal headers, either, as the
> only known consumer will be the kernel.
> 

Sure. Lets add it into include/asm/kvm_sdei.h in next respin. We can
expose it when it is needed. For now, I do think Linux is the only
user.

Thanks,
Gavin

