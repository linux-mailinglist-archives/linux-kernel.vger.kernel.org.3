Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14EEA496406
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381031AbiAURhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:37:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50607 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380830AbiAURhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:37:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642786632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dFp3Rf1PJ0ZkpLEQlKgt/t4Cba/gZtQKSEU2axrr8yM=;
        b=iFxriE4m/1/fz+xRvtvcbeLyKTW6y65g4OMB0uGVfEn0DWeYjsGgNiId12yZdiZoJd0Fop
        RlmJsxCVNal94ZQvK+cKz3yQRSp0PvVIwg5xEcq1Ydw3YUXBAhRGdz5n+fSxDk8CBSI9FP
        6RpWW5RxMcpFtydswXVFrlFJIHNmtBw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616--4y0P0LJPc-D2cPRPCa_Jg-1; Fri, 21 Jan 2022 12:37:11 -0500
X-MC-Unique: -4y0P0LJPc-D2cPRPCa_Jg-1
Received: by mail-wm1-f70.google.com with SMTP id z2-20020a05600c220200b0034d2eb95f27so6665490wml.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 09:37:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=dFp3Rf1PJ0ZkpLEQlKgt/t4Cba/gZtQKSEU2axrr8yM=;
        b=M8SolNCj/ntZ/9fYFIEsZnQuMQoGPPq1CQqkDQmKyt09FVBYFKc8KV6N2XJAhhOazV
         onZte0v2lj78rweMTK8ZSu3SFRGxUK3nlN8N3m+G9EbU71k9sCDGnS2yqHYH8jDCvkMA
         g/I9IFOIUpX9/7lCdVp8/bUpSZa3gpvQ5zaqo543dWc2THo2hZay7HcGurqV96Lgch/Z
         PlqxUjtiQeczzTCi4Bd1tY6VJ9CWhJGI9YavGGJ5L3hVEj7PcuVpZI++AUV0JEC0Alz8
         HNiw3ljoH5B51W19o4mG/Sn7AAkhGxHExJhYGBwOYOGAF9Nzm7vTdET0kPDRWjPqW/CC
         IPAg==
X-Gm-Message-State: AOAM530qA1Lxei0flZ38NnR9/9gAvYlqLjCO6bW6Vh/lalPb9C9g/PPg
        Lr5kmiuOsado9R17+lZZgZsj4ciNOFiS7mQdIBESRUgLM5mS1l2KxbdK4XmIIR/miFM11TIHGh4
        CqI34zYZEzKwIsbikm1xaMX6s
X-Received: by 2002:a5d:64a9:: with SMTP id m9mr4435753wrp.712.1642786629871;
        Fri, 21 Jan 2022 09:37:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzOGg1qMV5wiGFDObK1LBkr1x1Fb44Q/G2oonjM7S43J7xSEmQFRlJBuBjnbHrTKDenlTvy/g==
X-Received: by 2002:a5d:64a9:: with SMTP id m9mr4435710wrp.712.1642786629671;
        Fri, 21 Jan 2022 09:37:09 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:1e09:d600:637e:7f1b:a4a0:fc92? ([2a0c:5a80:1e09:d600:637e:7f1b:a4a0:fc92])
        by smtp.gmail.com with ESMTPSA id e15sm7949634wrg.91.2022.01.21.09.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 09:37:09 -0800 (PST)
Message-ID: <7d13da7d25282de0668fa3df5ee92c61b4b41ce2.camel@redhat.com>
Subject: Re: [PATCH v2 3/7] kvm/arm64: rework guest entry logic
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
Date:   Fri, 21 Jan 2022 18:37:07 +0100
In-Reply-To: <20220119105854.3160683-4-mark.rutland@arm.com>
References: <20220119105854.3160683-1-mark.rutland@arm.com>
         <20220119105854.3160683-4-mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-01-19 at 10:58 +0000, Mark Rutland wrote:
> In kvm_arch_vcpu_ioctl_run() we enter an RCU extended quiescent state
> (EQS) by calling guest_enter_irqoff(), and unmasked IRQs prior to
> exiting the EQS by calling guest_exit(). As the IRQ entry code will not
> wake RCU in this case, we may run the core IRQ code and IRQ handler
> without RCU watching, leading to various potential problems.
> 
> Additionally, we do not inform lockdep or tracing that interrupts will
> be enabled during guest execution, which caan lead to misleading traces
> and warnings that interrupts have been enabled for overly-long periods.
> 
> This patch fixes these issues by using the new timing and context
> entry/exit helpers to ensure that interrupts are handled during guest
> vtime but with RCU watching, with a sequence:
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
> Since instrumentation may make use of RCU, we must also ensure that no
> instrumented code is run during the EQS. I've split out the critical
> section into a new kvm_arm_enter_exit_vcpu() helper which is marked
> noinstr.
> 
> Fixes: 1b3d546daf85ed2b ("arm/arm64: KVM: Properly account for guest CPU time")
> Reported-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> Cc: Alexandru Elisei <alexandru.elisei@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: James Morse <james.morse@arm.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Will Deacon <will@kernel.org>
> ---

Reviewed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

Thanks,

-- 
Nicolás Sáenz

