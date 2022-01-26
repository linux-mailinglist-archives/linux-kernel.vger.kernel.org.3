Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778DA49D113
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243865AbiAZRnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:43:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44996 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231546AbiAZRnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643219020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7LmRcM3oOywyD4WcSEs68i+HAwbzXKDVMeR2HY4Bz8Q=;
        b=OHZAPEF0YCKOGtuNzAPM95AMdB+rxrAxe5CIM/VspBavEb7RIQi1pxUh9eEB/7qL+tZdFv
        HkuUqwmtrvAOOiP0uPIXIvWAHkSWyiAwRJN5IkTDRoX6oi8XwOZenPVVFYLVOu4F8pTrJg
        of2cOdPOR67+5G6tWuL+ZABzxpzxwGc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-470-VkscbC-rOO2qJC8RlZ3Dng-1; Wed, 26 Jan 2022 12:43:39 -0500
X-MC-Unique: VkscbC-rOO2qJC8RlZ3Dng-1
Received: by mail-wr1-f72.google.com with SMTP id s25-20020adfa299000000b001d8d032255fso65372wra.14
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:43:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7LmRcM3oOywyD4WcSEs68i+HAwbzXKDVMeR2HY4Bz8Q=;
        b=Cd0MgzP4Z/HiXy9+iZhRgS/eaAGRPBNONRaGIskmAH028/XHOx6Si9/Yrgq56SwsKX
         8Ra1MI8vaUSpDUDmScgvlfioIAaO0qYa9EGZzVxcfDXtng7GS+3I+eBSH7P70NBeqtm+
         Kft1Ghg81g6KrwjvKkDaXlVR7qJqSC79IuC9MBB1+hiG+G91C4mCw9RFXX2b01JfuzCd
         /Z7PahHMDVUvx9fcJvRlEhXQkeL+POqco3oth9pwyKOobs1sxrp/4JB6BthPN8MGlLvJ
         FzVQe4kFJqTHNFgxa2RL2qgZUHFfH6UOdlgcE0pmpMc8qnSDUQ6RsTNzz9+nFhNYwGoy
         P1cA==
X-Gm-Message-State: AOAM531cauAgyOo0EVZ8FULDJPY7eE8Q0+LQl71T5ghUw/K3eGlA5OJ0
        98PM1xFMaX5pdRmU/lEuj/3ICBNVqzDPNq4d1aADxzjiyy/YMZrjJFUzNqbDE6o6qNBmJTeOYw+
        5zTKgcQGs8VAfTVfVht9h+Gp/
X-Received: by 2002:a1c:256:: with SMTP id 83mr8502296wmc.89.1643219017168;
        Wed, 26 Jan 2022 09:43:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxkX6l8iYrRkIpopYI00Hyq6o9wmikSAL4sFrhwF12Qem5QO771vGwWeuh+9gQvmxZHFciyhA==
X-Received: by 2002:a1c:256:: with SMTP id 83mr8502274wmc.89.1643219016890;
        Wed, 26 Jan 2022 09:43:36 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id f6sm19859506wrj.26.2022.01.26.09.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 09:43:36 -0800 (PST)
Message-ID: <3e978189-4c9a-53c3-31e7-c8ac1c51af31@redhat.com>
Date:   Wed, 26 Jan 2022 18:43:35 +0100
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
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220126172226.2298529-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/22 18:22, Sean Christopherson wrote:
> For convenience, Like's patch split up and applied on top of Xiaoyao.
> Tagged all for @stable, probably want to (retroactively?) get Xiaoyao's
> patch tagged too?
>   
> Like Xu (2):
>    KVM: x86: Update vCPU's runtime CPUID on write to MSR_IA32_XSS
>    KVM: x86: Sync the states size with the XCR0/IA32_XSS at, any time
> 
> Xiaoyao Li (1):
>    KVM: x86: Keep MSR_IA32_XSS unchanged for INIT
> 
>   arch/x86/kvm/x86.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> 
> base-commit: e2e83a73d7ce66f62c7830a85619542ef59c90e4

Queued, though I'll note that I kinda disagree with the stable@ marking 
of patch 1 (and therefore with the patch order) as it has no effect in 
practice.

Paolo

