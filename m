Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF45494C89
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiATLKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:10:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45929 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230124AbiATLKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:10:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642677037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eZiFnHtXoPm2mpu78nKh9PJits8vQO5Q+C8iCYjoyCw=;
        b=A6G8LCB2YvRg8Rxu8ABZDNQIgTqcTKBZIQGwUKRDUgJB5CQuPHdLPgh2NgIg9mdnddztTW
        Ijkh9iVwPRHIsm/y7i9qZZZGNHb381hlhlLKLMho+bnvc01l8h5jgBryn6pdwToBjcBk/m
        L4PKC4yIHFLyzhmWRLO4yYtfE8iqPx8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-6s_QNcbUPS6QNbN3NyzYfw-1; Thu, 20 Jan 2022 06:10:36 -0500
X-MC-Unique: 6s_QNcbUPS6QNbN3NyzYfw-1
Received: by mail-wm1-f72.google.com with SMTP id a189-20020a1c98c6000000b0034e32e18a21so271919wme.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 03:10:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eZiFnHtXoPm2mpu78nKh9PJits8vQO5Q+C8iCYjoyCw=;
        b=Ohk/bK5rvaJQZtffnso4TWtxPhnhPWYeS6jcNYMc4TBPCfXvxJ2Qx0H2b0cxYKKqci
         6zL3AMM5+NS4UNj53NVf3ZHFtQDHCobnAP8kn1Gf664GgxCbp9dpKlSedpGlIquLt0m9
         tjngd/BCRywrhTs320XzrWw+sSj1vkczXwWOBV9F2Y6RQzhZAPOKP/q8vvZrnZhng/+O
         SaVHX7Eik2A6keZ6EcbPZjUiWtUrgIpfAEyedMcwebicjDZkCVWNll3O3g7ko5OlmHYk
         Jza0OLHjjt+NZa0Z6wO1yITjuFngI98YgxZh4Ox/MZ6M8/wgIuJiwVAa8xi0eD5YEwhy
         dmVw==
X-Gm-Message-State: AOAM530gHLqOtX4UA6g+yYS3yZOBpFjU0r298QASbsWY85LP+fno8d2B
        qm+CaovhQx6ytG9EpeIKa70CYqpMQRQG/4kErWD6eX6neFCLwbavl7wksflkenmbuPc0DLLtEsz
        TomhdDu42OQiqU/ThPmruy8m8
X-Received: by 2002:a05:600c:35d0:: with SMTP id r16mr8311643wmq.195.1642677031886;
        Thu, 20 Jan 2022 03:10:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyD6f+RP/yAkHQ+ZHaTHkrSJaHFaCVgb8l6O5w//R8/nT6YwFDvFD96p40aKXcLXTVRdG5nHg==
X-Received: by 2002:a05:600c:35d0:: with SMTP id r16mr8311305wmq.195.1642677027579;
        Thu, 20 Jan 2022 03:10:27 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id m187sm1993003wme.25.2022.01.20.03.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 03:10:26 -0800 (PST)
Message-ID: <cbb6a332-f230-ff5e-ce64-5dbbd6df02b5@redhat.com>
Date:   Thu, 20 Jan 2022 12:10:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 4/7] kvm/mips: rework guest entry logic
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
 <20220119105854.3160683-5-mark.rutland@arm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220119105854.3160683-5-mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/22 11:58, Mark Rutland wrote:
> +	 * TODO: is there a barrier which ensures that pending interrupts are
> +	 * recognised? Currently this just hopes that the CPU takes any pending
> +	 * interrupts between the enable and disable.
> +	 */
> +	local_irq_enable();
> +	local_irq_disable();
>   

It's okay, there is irq_enable_hazard() but it's automatically included 
in arch_local_irq_enable().

Paolo

