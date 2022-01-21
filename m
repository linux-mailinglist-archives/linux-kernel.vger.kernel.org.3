Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CF34963FE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380670AbiAURfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:35:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43584 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351773AbiAURfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:35:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642786500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gunQ+pu0TYYeQjUyB19mOPc2RAg9P4dQy6dZCRj1KCA=;
        b=Rb0c5/sFmDYY7LYW4tCeikfTYr29C/hwYyNDzdR3NK5KW02yVv9EYQ27dcoByoxIv2qk0t
        w/GVR4VK7nfemlo+ZXvXRZqwGydhnCpcvtmK3Dh/xwfnXd0gFWCNLFR1wN4HW6XgN1rdzR
        yCoCYb0LxnTWoQUj86ePJx+z9rv2zFo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-nVS5empnMvimEd7TWczqoA-1; Fri, 21 Jan 2022 12:34:59 -0500
X-MC-Unique: nVS5empnMvimEd7TWczqoA-1
Received: by mail-wm1-f72.google.com with SMTP id 7-20020a1c1907000000b003471d9bbe8dso4850378wmz.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 09:34:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gunQ+pu0TYYeQjUyB19mOPc2RAg9P4dQy6dZCRj1KCA=;
        b=4o42uHzouRWnCEBspNca0RQJorY56d/mbA1MzyxEVFDbBGtBD1i6KocF9hGxFh+q0S
         1Ut3ehehOpDtBRlYg2KFEP6bZwJlALr3Vdu20m/RiH0bCm38pPc9QjoMjdryRVzWhPHj
         n14gXqmt4HO2JvArXvMB/xdgfwtRoIkhATt9EFHC1Rz5e46D5qaJzbrNP/0PG4FU/3w6
         y+4ZFG4x9/6bcbw3o6Zoxn2rIPymh0k5wljaDdf9Pq5dDG9AEWUodRSUcAKl0Y3X1Fb0
         XXDQexs4ff6UcgHRNHSMqVeyIEi0zYPcaxN3Yumv/4YcHrMxgwPk1vZ2P80j9Iz6UlnS
         UzVg==
X-Gm-Message-State: AOAM5331l2K4FYuodOLFL9vgu+dfWXqmZLbJy8gqLHEZFUKmFX2vyvbK
        7yvJOn3GkAhC40Vmu89rNI2+/2CPD40MG61wQAEqUt2cT76lONKjL7Kni//w3eoaqiOWT4S5Yq6
        Yo/newXQaJyE+p5NYYjshjh1a
X-Received: by 2002:adf:eb41:: with SMTP id u1mr4729981wrn.201.1642786498038;
        Fri, 21 Jan 2022 09:34:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxWuEcdGKgqLH08Fqd+urasZV1sWOKR6nvZXijDAgjEN0K4PYlpkZCLOzvXc9Xxiv2TfPR3PQ==
X-Received: by 2002:adf:eb41:: with SMTP id u1mr4729949wrn.201.1642786497739;
        Fri, 21 Jan 2022 09:34:57 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:1e09:d600:637e:7f1b:a4a0:fc92? ([2a0c:5a80:1e09:d600:637e:7f1b:a4a0:fc92])
        by smtp.gmail.com with ESMTPSA id r2sm10054817wrz.99.2022.01.21.09.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 09:34:57 -0800 (PST)
Message-ID: <cedc658bf82146e21aac1959e5bd1b534c0b063e.camel@redhat.com>
Subject: Re: [PATCH v2 1/7] entry: add arch_in_rcu_eqs()
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     aleksandar.qemu.devel@gmail.com, alexandru.elisei@arm.com,
        anup.patel@wdc.com, aou@eecs.berkeley.edu, atish.patra@wdc.com,
        borntraeger@linux.ibm.com, bp@alien8.de, catalin.marinas@arm.com,
        chenhuacai@kernel.org, dave.hansen@linux.intel.com,
        frankja@linux.ibm.com, frederic@kernel.org, gor@linux.ibm.com,
        hca@linux.ibm.com, james.morse@arm.com, jmattson@google.com,
        joro@8bytes.org, maz@kernel.org, mingo@redhat.com,
        mpe@ellerman.id.au, palmer@dabbelt.com, paulmck@kernel.org,
        paul.walmsley@sifive.com, pbonzini@redhat.com, seanjc@google.com,
        suzuki.poulose@arm.com, svens@linux.ibm.com,
        tsbogend@alpha.franken.de, vkuznets@redhat.com,
        wanpengli@tencent.com, will@kernel.org
Date:   Fri, 21 Jan 2022 18:34:55 +0100
In-Reply-To: <20220119105854.3160683-2-mark.rutland@arm.com>
References: <20220119105854.3160683-1-mark.rutland@arm.com>
         <20220119105854.3160683-2-mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-01-19 at 10:58 +0000, Mark Rutland wrote:
> All architectures have an interruptible RCU extended quiescent state
> (EQS) as part of their idle sequences, where interrupts can occur
> without RCU watching. Entry code must account for this and wake RCU as
> necessary; the common entry code deals with this in irqentry_enter() by
> treating any interrupt from an idle thread as potentially having
> occurred with an EQS and waking RCU for the duration of the interrupt
> via rcu_irq_enter() .. rcu_irq_exit().
> 
> Some architectures may have other interruptible EQSs which require
> similar treatment. For example, on s390 is it necessary to enable
> interrupts around guest entry in the middle of a period where core KVM
> code has entered an EQS.
> 
> So that architectueres can wake RCU in these cases, this patch adds a
> new arch_in_rcu_eqs() hook to the common entry code which is checked in
> addition to the existing is_idle_thread() check, with RCU woken if
> either returns true. A default implementation is provided which always
> returns false, which suffices for most architectures.
> 
> As no architectures currently implement arch_in_rcu_eqs(), there should
> be no functional change as a result of this patch alone. A subsequent
> patch will add an s390 implementation to fix a latent bug with missing
> RCU wakeups.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---

Reviewed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

Thanks,

-- 
Nicolás Sáenz

