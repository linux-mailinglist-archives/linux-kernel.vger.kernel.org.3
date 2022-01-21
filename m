Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C116F496402
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380645AbiAURfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:35:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45148 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351773AbiAURfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:35:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642786542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/FItQTdTTxZ8OmEXVkTibfMTfUXZva/DU+2WFxzkIGs=;
        b=a+f4AvV40pilJWd855/1sQimXMLIxCCIHW2RO9eHFRx4GzQ4tBIAfoW7KU2GsrilRcBpG2
        0Vn6poNBsC51UalJDMEXN3Il6Zg7bDYPL6lF4CfWUiziaShuR8FFi3lqREfSsaKS5BBqzk
        IxHGspw43lXibRsADvPwh/w4wvcSJCM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-467-k7TDtO4oMpy22IlyUKMJkQ-1; Fri, 21 Jan 2022 12:35:41 -0500
X-MC-Unique: k7TDtO4oMpy22IlyUKMJkQ-1
Received: by mail-wr1-f72.google.com with SMTP id b17-20020adfee91000000b001d70ba23156so157307wro.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 09:35:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=/FItQTdTTxZ8OmEXVkTibfMTfUXZva/DU+2WFxzkIGs=;
        b=wVY2mRZ+EbE6N+m18ZTGsnpO8v9Ezx+OAZfyRuyz3rwe6XSCEk6n88UFucKcfbkd66
         /sTCrSEa1iLhNFrvPNezqGO2Ir/M6y0RGdhoChXpR8wXeVWyQf+WDRh49deTcq9NZq58
         cTjnFsEdMIOTmeowaqNInls/cpngCt05pLxmNa8uMxi8z0H/9BqWMzdCZdVmM+GWuBKG
         7QuEwH8vJnbExb3hKQsXwWtKcouxV4gnhItoHdcacUOQw1RBIdoWTQVL0rb0s5N8vuIR
         hK37TDTtgw63B2PZp18nG345d/GP3ydDjvO6rxj0PJdbkPdVrTfl9T5JRi7zdhpYWjC9
         MmTw==
X-Gm-Message-State: AOAM531lOpFeRR5um0XVArU+vStW489klQeaaNB+7f1m3vd1cEUOGA0y
        Sq5ovW7cUxgARbfCX2zbKeD7ss0sEYZz+6iXAokUDMjzjhU3CAIBy5R8Z4fnvGFXG10THpD7rdJ
        YiWayMjMVDj7/TlQzEnMoJ91z
X-Received: by 2002:a1c:f413:: with SMTP id z19mr1647585wma.111.1642786539714;
        Fri, 21 Jan 2022 09:35:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJymbL97ctopOilZLXpC6oR3cDi8qm8Ch35A6I5quhV01MX26uTYSrPElASRfa3xyZc/yPScgg==
X-Received: by 2002:a1c:f413:: with SMTP id z19mr1647561wma.111.1642786539482;
        Fri, 21 Jan 2022 09:35:39 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:1e09:d600:637e:7f1b:a4a0:fc92? ([2a0c:5a80:1e09:d600:637e:7f1b:a4a0:fc92])
        by smtp.gmail.com with ESMTPSA id bg26sm11091182wmb.48.2022.01.21.09.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 09:35:38 -0800 (PST)
Message-ID: <7d0208e94300cec295b3d3f9545e4d0257436c61.camel@redhat.com>
Subject: Re: [PATCH v2 2/7] kvm: add guest_state_{enter,exit}_irqoff()
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Cc:     aleksandar.qemu.devel@gmail.com, alexandru.elisei@arm.com,
        anup.patel@wdc.com, aou@eecs.berkeley.edu, atish.patra@wdc.com,
        borntraeger@linux.ibm.com, bp@alien8.de, catalin.marinas@arm.com,
        chenhuacai@kernel.org, dave.hansen@linux.intel.com,
        frankja@linux.ibm.com, frederic@kernel.org, gor@linux.ibm.com,
        hca@linux.ibm.com, james.morse@arm.com, jmattson@google.com,
        joro@8bytes.org, luto@kernel.org, maz@kernel.org, mingo@redhat.com,
        mpe@ellerman.id.au, palmer@dabbelt.com, paulmck@kernel.org,
        paul.walmsley@sifive.com, pbonzini@redhat.com,
        peterz@infradead.org, seanjc@google.com, suzuki.poulose@arm.com,
        svens@linux.ibm.com, tglx@linutronix.de, tsbogend@alpha.franken.de,
        vkuznets@redhat.com, wanpengli@tencent.com, will@kernel.org
Date:   Fri, 21 Jan 2022 18:35:37 +0100
In-Reply-To: <20220119105854.3160683-3-mark.rutland@arm.com>
References: <20220119105854.3160683-1-mark.rutland@arm.com>
         <20220119105854.3160683-3-mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-01-19 at 10:58 +0000, Mark Rutland wrote:
> When transitioning to/from guest mode, it is necessary to inform
> lockdep, tracing, and RCU in a specific order, similar to the
> requirements for transitions to/from user mode. Additionally, it is
> necessary to perform vtime accounting for a window around running the
> guest, with RCU enabled, such that timer interrupts taken from the guest
> can be accounted as guest time.
> 
> Most architectures don't handle all the necessary pieces, and a have a
> number of common bugs, including unsafe usage of RCU during the window
> between guest_enter() and guest_exit().
> 
> On x86, this was dealt with across commits:
> 
>   87fa7f3e98a1310e ("x86/kvm: Move context tracking where it belongs")
>   0642391e2139a2c1 ("x86/kvm/vmx: Add hardirq tracing to guest enter/exit")
>   9fc975e9efd03e57 ("x86/kvm/svm: Add hardirq tracing on guest enter/exit")
>   3ebccdf373c21d86 ("x86/kvm/vmx: Move guest enter/exit into .noinstr.text")
>   135961e0a7d555fc ("x86/kvm/svm: Move guest enter/exit into .noinstr.text")
>   160457140187c5fb ("KVM: x86: Defer vtime accounting 'til after IRQ handling")
>   bc908e091b326467 ("KVM: x86: Consolidate guest enter/exit logic to common helpers")
> 
> ... but those fixes are specific to x86, and as the resulting logic
> (while correct) is split across generic helper functions and
> x86-specific helper functions, it is difficult to see that the
> entry/exit accounting is balanced.
> 
> This patch adds generic helpers which architectures can use to handle
> guest entry/exit consistently and correctly. The guest_{enter,exit}()
> helpers are split into guest_timing_{enter,exit}() to perform vtime
> accounting, and guest_context_{enter,exit}() to perform the necessary
> context tracking and RCU management. The existing guest_{enter,exit}()
> heleprs are left as wrappers of these.
> 
> Atop this, new guest_state_enter_irqoff() and guest_state_exit_irqoff()
> helpers are added to handle the ordering of lockdep, tracing, and RCU
> manageent. These are inteneded to mirror exit_to_user_mode() and
> enter_from_user_mode().
> 
> Subsequent patches will migrate architectures over to the new helpers,
> following a sequence:
> 
> 	guest_timing_enter_irqoff();
> 
> 	guest_state_enter_irqoff();
> 	< run the vcpu >
> 	guest_state_exit_irqoff();
> 
> 	< take any pending IRQs >
> 
> 	guest_timing_exit_irqoff();
> 
> This sequences handles all of the above correctly, and more clearly
> balances the entry and exit portions, making it easier to understand.
> 
> The existing helpers are marked as deprecated, and will be removed once
> all architectures have been converted.
> 
> There should be no functional change as a result of this patch.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

Thanks,

-- 
Nicolás Sáenz

