Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935094F7EC3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238618AbiDGMOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbiDGMOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:14:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0BFF1E95E2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 05:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649333552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DGcIcM8gJ4Iu3qQi5hlBAso8Rq25Z0euqo8ngas0nfY=;
        b=QzRiiR3t0pGg9Y9OArnXVw55pTeHjQdL4sEYCq2CZq46B/kXZGP1N6m8FWol45JeQeyjvT
        adDi3V5rgnrM0KWtF/PXt6yuf3gAwGqXl23zsYj09Txf6ozbAYwHurdHaDwh0ffMQ5MeW7
        bUE4VO98rFe9lR9Xbr03C47ER5FasAk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-259-aUuK4ZNwOPeU6ZngMwthXw-1; Thu, 07 Apr 2022 08:12:31 -0400
X-MC-Unique: aUuK4ZNwOPeU6ZngMwthXw-1
Received: by mail-ed1-f69.google.com with SMTP id bc9-20020a056402204900b0041cc2b0bff3so2856551edb.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 05:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DGcIcM8gJ4Iu3qQi5hlBAso8Rq25Z0euqo8ngas0nfY=;
        b=XTx2rgNt8B1Oyi/inrZDnB93+eHwEpTwCZMreqt5Ojo4neR2Qb/l5n7YjtJqIdHgGt
         fITeiejQP28Q2fz1T7VVV11X4v08AVvnDUfGADCEpjWe4L/aYbK3HCdluHBnTeQrgAPc
         NsrNHxgIFjIMuwk9AeYN8zPhydQ1gfWGTG344GuA4saO1HOvQyRZZ/zLMB/KfUIrHyaN
         vIQC1lXNPc4urSX8LxV4b11sXWRREYTuK12D/sYTiGaMct0jLkxjSwdF40B2a7/77bG3
         Dcu3US8ynqhndxignrX0ZW5Y2yL00B6OKmaZVzaNu8Rub1jL9aKzq+HkR5ifEOXR2tmr
         UWPw==
X-Gm-Message-State: AOAM53222SAqLhHJf1Kg1VXbzG2Vv3SXWUbsmpsq5yWAYC07baj57EOv
        wxFsfklTluM4XEyXteqI73pmxxToD95OhEG/McYK7I9brP/im6ull8oiCUEAjd2mYhBSvBCMX8S
        xprEl6bh7wOW3mL8M880q16DQ
X-Received: by 2002:aa7:d311:0:b0:419:443b:6222 with SMTP id p17-20020aa7d311000000b00419443b6222mr13675488edq.161.1649333550542;
        Thu, 07 Apr 2022 05:12:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxl+xQ1ipUlMGquPKy+T2ZIFLwAwclwboSbty4izLi6yxlztoj7nwo020S5K2gVDdlVcMlaZA==
X-Received: by 2002:aa7:d311:0:b0:419:443b:6222 with SMTP id p17-20020aa7d311000000b00419443b6222mr13675475edq.161.1649333550365;
        Thu, 07 Apr 2022 05:12:30 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id k12-20020a170906054c00b006e8289dc23csm1302658eja.9.2022.04.07.05.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 05:12:29 -0700 (PDT)
Message-ID: <f13f2736-626a-267b-db38-70a81872a325@redhat.com>
Date:   Thu, 7 Apr 2022 14:12:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v5 101/104] KVM: TDX: Silently ignore INIT/SIPI
Content-Language: en-US
To:     Xiaoyao Li <xiaoyao.li@intel.com>, isaku.yamahata@intel.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@gmail.com, Jim Mattson <jmattson@google.com>,
        erdemaktas@google.com, Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <cover.1646422845.git.isaku.yamahata@intel.com>
 <d0eb8fa53e782a244397168df856f9f904e4d1cd.1646422845.git.isaku.yamahata@intel.com>
 <efbe06a7-3624-2a5a-c1c4-be86f63951e3@redhat.com>
 <48ab3a81-a353-e6ee-7718-69c260c9ea17@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <48ab3a81-a353-e6ee-7718-69c260c9ea17@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/22 13:09, Xiaoyao Li wrote:
> On 4/5/2022 11:48 PM, Paolo Bonzini wrote:
>> On 3/4/22 20:49, isaku.yamahata@intel.com wrote:
>>> +        if (kvm_init_sipi_unsupported(vcpu->kvm))
>>> +            /*
>>> +             * TDX doesn't support INIT.  Ignore INIT event.  In the
>>> +             * case of SIPI, the callback of
>>> +             * vcpu_deliver_sipi_vector ignores it.
>>> +             */
>>>               vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
>>> -        else
>>> -            vcpu->arch.mp_state = KVM_MP_STATE_INIT_RECEIVED;
>>> +        else {
>>> +            kvm_vcpu_reset(vcpu, true);
>>> +            if (kvm_vcpu_is_bsp(apic->vcpu))
>>> +                vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
>>> +            else
>>> +                vcpu->arch.mp_state = KVM_MP_STATE_INIT_RECEIVED;
>>> +        }
>>
>> Should you check vcpu->arch.guest_state_protected instead of 
>> special-casing TDX? 
> 
> We cannot use vcpu->arch.guest_state_protected because TDX supports 
> debug TD, of which the states are not protected.
> 
> At least we need another flag, I think.

Let's add .deliver_init to the kvm_x86_ops then.

Paolo

