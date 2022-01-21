Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977A849640F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241924AbiAURka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:40:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35218 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235773AbiAURk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:40:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642786826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WTtwQay8miS6u7qa97/OYe9kVctRWoIWbnoO4Ke45Hg=;
        b=CEbRg95qk1aqFIl7d0esOrVqKl6/WKZPCnr/NlJhcQnwaqhNqcTcHOFJrCXjOyCFu8CVKT
        DYR4Y1F8I/edQVjcBjonZkMYyOv+hPDiBDC29DO53fICaJT6NV6TCBwEbe4jx4YZWsmlUu
        ddSfn1NzsXr6EyOercEEmhbvSsAck9A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-pldxnBvQMQO2tdevAWCpMA-1; Fri, 21 Jan 2022 12:40:24 -0500
X-MC-Unique: pldxnBvQMQO2tdevAWCpMA-1
Received: by mail-wm1-f69.google.com with SMTP id a189-20020a1c98c6000000b0034e32e18a21so3651746wme.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 09:40:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=WTtwQay8miS6u7qa97/OYe9kVctRWoIWbnoO4Ke45Hg=;
        b=HCL0iYGF/MLRAVbESp4tLxFz5AH98pe9M//tCQ4yqxXoQLrjUpZ81bDyamEB5eMx/I
         Now/NRFRYF0+84XNWZfb7+2upVHuVtU1PTU9Kyfr0/ZZtJoeamNqMxzJ2AEQeiE9YfA4
         UOEFXcBZ2/eFj4HhmjtnvYOcB7drKgWBuEXuKK2QWARfSwv6bwR7Zp2I8CIQbCQGK5Os
         dnm7jcLexIh4xKsQknVYOyniOMJu5mL4K+sCyz1F1K6bhRLI4rJmNSfI8nek0+YbDmvV
         cdMip1TiDjQSOBwI7rhy/W6k7+2zL8tF/e94Q2aU5xzfLOded93cEMjrMw7W1LJky3Sw
         zo6Q==
X-Gm-Message-State: AOAM530PtA3zNUOYazTUh2qHebQNgYxMC8PQ8VH+ZSqND8einBuQnPeC
        /kDhGOMdqiIwsxOxuHv27S6XUoaaKf9wt6Z2LhkF49TUCO12os3yGw4LxWQFhFmjhgvZT+zVl+g
        U4UvuSaFMQL+uZGCuoh2pq+tF
X-Received: by 2002:a05:6000:38a:: with SMTP id u10mr4718397wrf.0.1642786822890;
        Fri, 21 Jan 2022 09:40:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/U7XRGC7xT66p5zdwvCJnX0GHvveyRPJi3mnkgzyC3XRh3p6GV5nKjlyJ+mgXw2pDlGFadA==
X-Received: by 2002:a05:6000:38a:: with SMTP id u10mr4718387wrf.0.1642786822687;
        Fri, 21 Jan 2022 09:40:22 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:1e09:d600:637e:7f1b:a4a0:fc92? ([2a0c:5a80:1e09:d600:637e:7f1b:a4a0:fc92])
        by smtp.gmail.com with ESMTPSA id d6sm6178108wrs.85.2022.01.21.09.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 09:40:22 -0800 (PST)
Message-ID: <3d76e432d17f5d579a866191a4a33be189781b60.camel@redhat.com>
Subject: Re: [PATCH v2 7/7] kvm/x86: rework guest entry logic
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
Date:   Fri, 21 Jan 2022 18:40:20 +0100
In-Reply-To: <20220119105854.3160683-8-mark.rutland@arm.com>
References: <20220119105854.3160683-1-mark.rutland@arm.com>
         <20220119105854.3160683-8-mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-01-19 at 10:58 +0000, Mark Rutland wrote:
> For consistency and clarity, migrate x86 over to the generic helpers for
> guest timing and lockdep/RCU/tracing management, and remove the
> x86-specific helpers.
> 
> Prior to this patch, the guest timing was entered in
> kvm_guest_enter_irqoff() (called by svm_vcpu_enter_exit() and
> svm_vcpu_enter_exit()), and was exited by the call to
> vtime_account_guest_exit() within vcpu_enter_guest().
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
>   ae95f566b3d22ade ("KVM: X86: TSCDEADLINE MSR emulation fastpath")
>   26efe2fd92e50822 ("KVM: VMX: Handle preemption timer fastpath")
> 
> Where KVM can enter a guest multiple times, calling vtime_guest_enter()
> without a corresponding call to vtime_account_guest_exit(), and with
> vtime_account_system() called when vtime_account_guest() should be used.
> As account_system_time() checks PF_VCPU and calls account_guest_time(),
> this doesn't result in any functional problem, but is unnecessarily
> confusing.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Wanpeng Li <wanpengli@tencent.com>
> ---

Reviewed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

Thanks,

-- 
Nicolás Sáenz

