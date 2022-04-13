Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328FF4FF94A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236245AbiDMOsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236235AbiDMOs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:48:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 188896353E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649861164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hNkvt/K0aQyOxX61nTzjQ7C3+Rq4NTo9lE9c4R9eKtU=;
        b=J9TV3zKnvvcAefz++NtxGanKwCpK6XqsIp+Dl4nPIEN3ry1Y0EK3MHVNlB0manOnYI5gUt
        qHPYq/SvKQsyi/3q+GMQhrpVVI550OogfTKeVc2VAYz/qrPfm0SMvJWtqcxMFOiHBWdLMG
        hXfte8QzsTetdkwS+XY1YisY656UWbk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-r2cjw3sfNXGc1lA27INdEQ-1; Wed, 13 Apr 2022 10:46:03 -0400
X-MC-Unique: r2cjw3sfNXGc1lA27INdEQ-1
Received: by mail-wm1-f72.google.com with SMTP id c62-20020a1c3541000000b0038ec265155fso2926740wma.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hNkvt/K0aQyOxX61nTzjQ7C3+Rq4NTo9lE9c4R9eKtU=;
        b=7BplGiiJLDcHuJRzjg+2yWz7FlLy2nxElfqWun4xBDERkBzJPc+zEFTuvua36IfYTB
         3dfSHSmKokDmbRP/dyYL9azbhSgtq5qZ+bomSf6yl6nPxHiSP3y8la/V08MMi5qrH/gj
         dxBvVJ++cMocgZSMOzX0454xbwZVcaPQVEbaKQHvCe0cztd4pAJ2wRm2Rp/Vzoakc+El
         faZP/kREVkL4uMGCnNcO41Ecsgg1hANFbucCZtOnSGAf7gHFofAUQfzbqq9ZEeWEZHsi
         vXedWClGTuT8Xdo8rZt95OB76tVWNc56Wu18e1Y73BdmIPRZHB6H9QzOICFmT5bNnsZn
         zzrw==
X-Gm-Message-State: AOAM531o8oPaFa5Oit8TllH9OE5EV1h/d+3AAR9Cq2rgm34SRSeQOraG
        bUmhFduulLSzV7YgnJVCLg3Ub0TJdXEOkZW4uD4My+U80Ld+zyiKu6GIf/gNyvqwbvF5Q3G9xHC
        roxqMOZxNSJDfkea73i6ePKSB
X-Received: by 2002:a5d:5187:0:b0:207:a2ae:ee49 with SMTP id k7-20020a5d5187000000b00207a2aeee49mr14648364wrv.674.1649861162451;
        Wed, 13 Apr 2022 07:46:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQkqN0BdzFrNw/NCISIUZe837OYgNk82Z8gALnFHcVWR7Q6AJHH9Ut+cAuFv/bK200d/H8bw==
X-Received: by 2002:a5d:5187:0:b0:207:a2ae:ee49 with SMTP id k7-20020a5d5187000000b00207a2aeee49mr14648345wrv.674.1649861162213;
        Wed, 13 Apr 2022 07:46:02 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id o17-20020a05600c4fd100b0038cd5074c83sm2992782wmq.34.2022.04.13.07.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 07:46:01 -0700 (PDT)
Message-ID: <d2122fb0-7327-0490-9077-c69bbfba4830@redhat.com>
Date:   Wed, 13 Apr 2022 16:46:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH V3 2/4] KVM: X86: Introduce role.glevel for level
 expanded pagetable
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org
References: <20220330132152.4568-1-jiangshanlai@gmail.com>
 <20220330132152.4568-3-jiangshanlai@gmail.com> <YlXvtMqWpyM9Bjox@google.com>
 <caffa434-5644-ee73-1636-45a87517bae2@redhat.com>
 <YlbhVov4cvM26FnC@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YlbhVov4cvM26FnC@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/22 16:42, Sean Christopherson wrote:
> On Wed, Apr 13, 2022, Paolo Bonzini wrote:
>> On 4/12/22 23:31, Sean Christopherson wrote:
>>> We don't need 4 bits for this.  Crossing our fingers that we never had to shadow
>>> a 2-level guest with a 6-level host, we can do:
>>>
>>> 		unsigned passthrough_delta:2;
>>>
>> Basically, your passthrough_delta is level - glevel in Jiangshan's patches.
>> You'll need 3 bits anyway when we remove direct later (that would be
>> passthrough_delta == level).
> 
> Are we planning on removing direct?

I think so, it's redundant and the code almost always checks 
direct||passthrough (which would be passthrough_delta > 0 with your scheme).

>> Regarding the naming:
>>
>> * If we keep Jiangshan's logic, I don't like the glevel name very much, any
>> of mapping_level, target_level or direct_level would be clearer?
> 
> I don't love any of these names, especially glevel, because the field doesn't
> strictly track the guest/mapping/target/direct level.  That could obviously be
> remedied by making it valid at all times, but then the role would truly need 3
> bits (on top of direct) to track 5-level guest paging.

Yes, it would need 3 bits but direct can be removed.

>> * If we go with yours, I would call the field "passthrough_levels".
> 
> Hmm, it's not a raw level though.

Hence the plural. :)

Paolo

