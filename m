Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CA0498156
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 14:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbiAXNqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 08:46:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:49058 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232769AbiAXNqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 08:46:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643031993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VMWjUFPNROSNZ1gB7bIAJHjMk/KVdbCxC1i1CaU9o8k=;
        b=dLaq+IBnNeXqPubyheXgyWNkID+xMyS8+JlPZKTFbclUe2gHPL7G0/GxOfs5yBNV6AK3BZ
        vzBU70fEpeQR88+AaddKhapHfh5n1sqZFNb35lqpuJFLuNh+CIDhCNzXoBgUtdxK08DVcF
        IFHGeb529SqUGYtE6FMivvH+FSUv7ls=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323--LN8TaWMM6-n68guag0gWQ-1; Mon, 24 Jan 2022 08:46:32 -0500
X-MC-Unique: -LN8TaWMM6-n68guag0gWQ-1
Received: by mail-ej1-f71.google.com with SMTP id d18-20020a1709063ed200b006a5eeb2ee4dso2073625ejj.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 05:46:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VMWjUFPNROSNZ1gB7bIAJHjMk/KVdbCxC1i1CaU9o8k=;
        b=NNxC7xZNwc8FkwgQQBV3t4mu8yoF447PG4cSKKwye7KF6+Hf3IHG15ExvaeaS659nH
         7p3GnE2EK7buy31r/XAhnQFH6kaye50UY6SSnAjWUB4nhsGKpx7m28uZE+MvXTQfIsUd
         9tMn9orwEzOWq6NYBSUK8JgehFhO3GntOkjx8u2hCZ5wVVV3CMH0YSPYFyYmMzd2WSg+
         pxh7FOk+kzbo7Itqe/i8LHP083iNOXymOb6ezxA6gf3GEQdG7ErRZNUhW9ZUzbU8GjOq
         x9+5ZIQhsoILRyXC5FmtgqEL1SI1lJH61no2BC5P8oq94+S1/iVJjgxii+4tCQczmFKZ
         yncA==
X-Gm-Message-State: AOAM533QENHZx+Xq8qaux+3JjjKyW7eJN5DZnBnhqd+4wujeASUas7YB
        CwjdYIGfcks48kU3MxqH1FLHdYOC3eneb1SDRBTN5kiaY3iz17DJuorwlEzYTv8aMp2hlkK3JcD
        3M1F8KxcjSmdKdgMJUVFF1uE6
X-Received: by 2002:a05:6402:650:: with SMTP id u16mr16286102edx.163.1643031990561;
        Mon, 24 Jan 2022 05:46:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyPPS6Cfx4PZykBtvSaLRQRaAbKk4CngKeatZ4sjeSvxKkSns8X1naDMiTsILFxx8eTjvA0Ag==
X-Received: by 2002:a05:6402:650:: with SMTP id u16mr16286089edx.163.1643031990351;
        Mon, 24 Jan 2022 05:46:30 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id gh14sm4886125ejb.38.2022.01.24.05.46.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 05:46:29 -0800 (PST)
Message-ID: <93cd45a7-700b-2437-d56b-3597bdadb657@redhat.com>
Date:   Mon, 24 Jan 2022 14:46:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] KVM: VMX: Zero host's SYSENTER_ESP iff SYSENTER is NOT
 used
Content-Language: en-US
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>
References: <20220122015211.1468758-1-seanjc@google.com>
 <8735lgjgwl.fsf@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <8735lgjgwl.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/22 09:47, Vitaly Kuznetsov wrote:
>>   	 */
>> -	vmcs_writel(HOST_IA32_SYSENTER_ESP, 0);
>> +	if (!IS_ENABLED(CONFIG_IA32_EMULATION) && !IS_ENABLED(CONFIG_X86_32))
> Isn't it the same as "!IS_ENABLED(CONFIG_COMPAT_32)"? (same goes to the
> check in vmx_vcpu_load_vmcs())
> 

It is, but I think it's clearer to write it as it's already done in 
arch/x86/kvm/vmx/vmx.c, or possibly

if (IS_ENABLED(CONFIG_X86_64) && !IS_ENABLED(CONFIG_IA32_EMULATION))

CONFIG_COMPAT_32 doesn't say as clearly whether it's enabled for 32-bit 
systems or not.

Paolo

