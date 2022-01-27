Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8728849E210
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240945AbiA0MJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:09:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35821 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233669AbiA0MJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:09:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643285380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fTqZt884WZtYjSkHFUTp/xYLpzbmKVXoB4/TFN3fjvc=;
        b=H+zv/9mfZhojZkJa0KzEAWYnB5N0txpZ6GGaS4baHJvtc/TfD2wGL86lZRt9aAtiT6w6Rl
        iQQvORWRsga1yNloDq3d8cvSj4bIKvxg8M3rxq5JOMuhL31RVo1ye3xZcCSQGDmb4lQuIU
        jwEjEs/L39A5dHwLw3XinTWM3BAbVoU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-103-KOVISIK0PkSCJX0dyHjhAw-1; Thu, 27 Jan 2022 07:09:39 -0500
X-MC-Unique: KOVISIK0PkSCJX0dyHjhAw-1
Received: by mail-ej1-f70.google.com with SMTP id la22-20020a170907781600b006a7884de505so1247735ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 04:09:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fTqZt884WZtYjSkHFUTp/xYLpzbmKVXoB4/TFN3fjvc=;
        b=rBwrqJ34YDIHw9qCQsoW38nyvKu7jK8XqPmTTtjL7OFVrxcTTqhDwJbWXRoDISLXO5
         qchOPFXbNDqMYUql5izRqoJayZ9sthQ0SunHMERn6XV/Rnhh/QgQBkgEBFDv/l1KhRrt
         BZyjG6/pIAaZigI+2rwQS3SCOO4JaIFqD/z6UH1zFTcGUlzG+IfXOk4xpSowi+S90k7x
         cWwQ5wv0sfRwUzr2M6Kc6bFXZoWxU40plT3zR7ziVpO+py5o+Zq3qx0IRWSkLC+3V6d2
         3ShLw2LQVQbyelGVjChLUqsIwv/SHOx3f/p8BLgBjlga92Ummz4cJhcIU+HK8XHgghQG
         PeYg==
X-Gm-Message-State: AOAM532BpODRHSCZgVYCyJ2mixAIzMXyTLahnhDfLh6SXiuSoYCtY4WK
        Dbha2DxsQNRBlusTSSAkVwosId1DgLRStiZZIwBvOejoimQCMVvEeVti2tR04WGmGgCkKzBnBZS
        mCCett+gGItTUjYN5UbprtH/d
X-Received: by 2002:a17:907:213c:: with SMTP id qo28mr2767158ejb.325.1643285377182;
        Thu, 27 Jan 2022 04:09:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxdjtSTQuT34lnadYHAKjV7guxXdfhPztA2UVo8aBshyS9c/eR8574mDC/GaWlfoarTCyx9PQ==
X-Received: by 2002:a17:907:213c:: with SMTP id qo28mr2767138ejb.325.1643285376888;
        Thu, 27 Jan 2022 04:09:36 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id s19sm7135825ejn.6.2022.01.27.04.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 04:09:36 -0800 (PST)
Message-ID: <f1389ace-6f5d-9f48-bb12-4835c29e6402@redhat.com>
Date:   Thu, 27 Jan 2022 13:09:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 0/3] KVM: x86: XSS and XCR0 fixes
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
        Like Xu <likexu@tencent.com>
References: <20220126172226.2298529-1-seanjc@google.com>
 <3e978189-4c9a-53c3-31e7-c8ac1c51af31@redhat.com>
 <YfGJWNVuFYZ8kl2I@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YfGJWNVuFYZ8kl2I@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/22 18:48, Sean Christopherson wrote:
> On Wed, Jan 26, 2022, Paolo Bonzini wrote:
>> On 1/26/22 18:22, Sean Christopherson wrote:
>>> For convenience, Like's patch split up and applied on top of Xiaoyao.
>>> Tagged all for @stable, probably want to (retroactively?) get Xiaoyao's
>>> patch tagged too?
>>> Like Xu (2):
>>>     KVM: x86: Update vCPU's runtime CPUID on write to MSR_IA32_XSS
>>>     KVM: x86: Sync the states size with the XCR0/IA32_XSS at, any time
>>>
>>> Xiaoyao Li (1):
>>>     KVM: x86: Keep MSR_IA32_XSS unchanged for INIT
>>>
>>>    arch/x86/kvm/x86.c | 6 +++---
>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>>
>>> base-commit: e2e83a73d7ce66f62c7830a85619542ef59c90e4
>>
>> Queued, though I'll note that I kinda disagree with the stable@ marking of
>> patch 1 (and therefore with the patch order) as it has no effect in
>> practice.
> 
> Hmm, that's not a given, is it?  E.g. the guest can configure XSS early on and
> then expect the configured value to live across INIT-SIPI-SIPI.  I agree it's
> highly unlikely for any guest to actually do that, but I don't like assuming all
> guests will behave a certain way.

No, I meant in the sense that supported_xss is always zero right now, 
and therefore so is MSR_IA32_XSS.

Paolo

