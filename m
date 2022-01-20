Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C40B494CBB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiATLUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:20:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26428 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229779AbiATLU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642677628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oxb420uCG8aBuWa1aCClpOccejYPa+jGmi+S8D+HWIA=;
        b=dqZ2bOH7D8vjoQ7O8sfP2d3GQIfozdQ/nufUUfANVRlQO3OgjoLUIVWuPF6O3YwXS5W/pT
        EsJCBJGjQDGudQrVJPiR7utmCXfSDPJTDeAr7gySpH8E8S1+AY7KpyEDCtQdWUTaSGeGT/
        rZBiTVldn10ZKj1mdQraGcn99skROcs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-Ob-x14i1MFOoWEmJULK6Xg-1; Thu, 20 Jan 2022 06:20:26 -0500
X-MC-Unique: Ob-x14i1MFOoWEmJULK6Xg-1
Received: by mail-wm1-f71.google.com with SMTP id f188-20020a1c1fc5000000b0034d79edde84so2628819wmf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 03:20:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oxb420uCG8aBuWa1aCClpOccejYPa+jGmi+S8D+HWIA=;
        b=Yq+lz9Nytanp5UhRNzZ9wCV5Pkmno5XaSPn0wXNE8g5Xf3Ly0YIRHyMOzmZYnY7Xac
         jEvpdcfmwi+vy3g11TWMpinDaXbGsNCob6IblVo26KZ5ySAyXPCOVKEimLNGlPLtunYj
         EZpW1Awspwys+OJ8hc2hqWMBY6vZFPqA9ziccMvgmgyaf87VskI6n81OH3LfHrQ1IAfi
         6z6wBDzn1zsPEQHQrcfCMJ9tyNj/83vhsrDfwzS7BJ4en75Vq3jTt1Gei6Nc5Jxni+bp
         6DkoTeqbRgzADP/H1fBI3DkJ4vjDBKjE5UDooye4LGZD4ZG3hYj7P6rMBJBypLNzmvCb
         6kHQ==
X-Gm-Message-State: AOAM531sK6x35fhvHmkJpoDvUuNKthEazB8lQ/BHh9MDGq9xEWPoXgFj
        UTrsWsnh2AtK+K9akTNa3POYdJvOHRjPHC58yKpP/7mSVNuJrqYWA03EbfIn65iUNgQuBHgw4AE
        0nur5EWtyB4wzwbW9KovS0dDw
X-Received: by 2002:a05:600c:3b9e:: with SMTP id n30mr8578825wms.180.1642677625121;
        Thu, 20 Jan 2022 03:20:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx7Cz1Uxk2SJP0IdOYpHjH87YRl1ckQst1vd6li4i603rWoRBIOUpateX35UnGplxJW3hlwRQ==
X-Received: by 2002:a05:600c:3b9e:: with SMTP id n30mr8578776wms.180.1642677624854;
        Thu, 20 Jan 2022 03:20:24 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id l9sm2098284wrs.43.2022.01.20.03.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 03:20:24 -0800 (PST)
Message-ID: <ae988971-4184-36f4-98e8-32936dd7ea85@redhat.com>
Date:   Thu, 20 Jan 2022 12:20:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 7/7] kvm/x86: rework guest entry logic
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Cc:     aleksandar.qemu.devel@gmail.com, alexandru.elisei@arm.com,
        anup.patel@wdc.com, aou@eecs.berkeley.edu, atish.patra@wdc.com,
        borntraeger@linux.ibm.com, bp@alien8.de, catalin.marinas@arm.com,
        chenhuacai@kernel.org, dave.hansen@linux.intel.com,
        frankja@linux.ibm.com, frederic@kernel.org, gor@linux.ibm.com,
        hca@linux.ibm.com, james.morse@arm.com, jmattson@google.com,
        joro@8bytes.org, luto@kernel.org, maz@kernel.org, mingo@redhat.com,
        mpe@ellerman.id.au, nsaenzju@redhat.com, palmer@dabbelt.com,
        paulmck@kernel.org, paul.walmsley@sifive.com, peterz@infradead.org,
        seanjc@google.com, suzuki.poulose@arm.com, svens@linux.ibm.com,
        tglx@linutronix.de, tsbogend@alpha.franken.de, vkuznets@redhat.com,
        wanpengli@tencent.com, will@kernel.org
References: <20220119105854.3160683-1-mark.rutland@arm.com>
 <20220119105854.3160683-8-mark.rutland@arm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220119105854.3160683-8-mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/22 11:58, Mark Rutland wrote:
> 
> To minimize duplication and to more clearly balance entry and exit, both
> entry and exit of guest timing are placed in vcpu_enter_guest(), using
> the new guest_timing_{enter,exit}_irqoff() helpers. When context
> tracking is used a small amount of additional time will be accounted
> towards guests; tick-based accounting is unnaffected as IRQs are
> disabled at this point and not enabled until after the return from the
> guest.
> 
> This also corrects (benign) mis-balanced context tracking accounting
> introduced in commits:
> 
>    ae95f566b3d22ade ("KVM: X86: TSCDEADLINE MSR emulation fastpath")
>    26efe2fd92e50822 ("KVM: VMX: Handle preemption timer fastpath")
> 
> Where KVM can enter a guest multiple times, calling vtime_guest_enter()
> without a corresponding call to vtime_account_guest_exit(), and with
> vtime_account_system() called when vtime_account_guest() should be used.
> As account_system_time() checks PF_VCPU and calls account_guest_time(),
> this doesn't result in any functional problem, but is unnecessarily
> confusing.

Yes, I agree.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

