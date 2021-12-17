Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A2A47909B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbhLQPy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbhLQPy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:54:26 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B26C061574;
        Fri, 17 Dec 2021 07:54:25 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id o13so4847134wrs.12;
        Fri, 17 Dec 2021 07:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AHfUikZmyD4dINCWakIQJtobxvYGz5CvtkfmXC/JM0U=;
        b=kkoc4FHM+YuQr9vZVtoceLdb6WDPQLhgj4yrAneG0S9X+rspnO/cHTjzzLHoFMucxW
         f/hpbjjYx/5FXX57Y9KVVq6kXDhnnu1UaInliIeJ1fVNCwxAG7x1ch6jrIUGx3e4q4vb
         i4ozNkufUfpUMXtDhBwJxFdBi5dYXn3N6+rAKS49Kca2spsxiL1X5jXW5OxxQExxyPB5
         mtn8C7cwExGjebtfAkAs6vAWhPNDr6SD3aHoHqaB73+jKuH7VQjS2Rp4CFL3Cqyr7pTJ
         p8dmjR4mYm6fdo4+GoSjpl6nYl4XwkcOKU0xajZXIL2YxeDPiL3khk6uQ3bl7z+Kg35W
         HKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AHfUikZmyD4dINCWakIQJtobxvYGz5CvtkfmXC/JM0U=;
        b=ULL3w/O3QGgSQ0xr5HBhJYm4PjfFL60bxQoxavULTaTn3XRp5cQTTQdhQ3/gGIHK2p
         iD3mJA2vnsZrNfMdt3BEq4h/w99kW8JNbhn3hajYwEChtv96vl79Y6fsVPKfAmVomYvN
         0arzn/td1zk0PFoCVvb/x+XdLqsAlxdJGCl/bi3j5vNY4CicFgTdDs5u5Zq9MTnR8hN3
         9vGLaRHbRDMTXGGaVqTmI/Ht7g4Ws4a4keZcFIMCz5fIADb1Jmj2ZGcSE1usokZNtoLP
         Ux2cl33cpQR8cj1ycCsq5uRegqJEpPSa96Nl036yVVqzpi8pzB/9SxUnUVyhpnu28cq3
         DLag==
X-Gm-Message-State: AOAM530HSxGI4ESVpZwC3rSk23zit9McxI4wZwBobCplU5PGYqQXVPwm
        XIgX6OtgUnpuLCmr5WCLxGY=
X-Google-Smtp-Source: ABdhPJyGxYhZSxDUxszzp9INdkaMS8zLvwT/pmwuIPWM1rk+PG085n9I8oYQLKBFYA2zw6Fgd+MA6A==
X-Received: by 2002:a5d:6d8b:: with SMTP id l11mr3077055wrs.25.1639756464297;
        Fri, 17 Dec 2021 07:54:24 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:48f9:bea:a04c:3dfe? ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
        by smtp.googlemail.com with ESMTPSA id k13sm7619520wri.6.2021.12.17.07.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 07:54:23 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <9ab8107f-ff41-6a9e-57e1-a261bea93aca@redhat.com>
Date:   Fri, 17 Dec 2021 16:54:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: Possible nohz-full/RCU issue in arm64 KVM
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     paulmck <paulmck@kernel.org>, maz <maz@kernel.org>,
        frederic <frederic@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rcu <rcu@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <d80e440375896f75d45e227d40af60ca7ba24ceb.camel@redhat.com>
 <YbyO40zDW/kvUHEE@FVFF77S0Q05N>
 <70f112072d9496d21901946ea82832d3ed3a8cb2.camel@redhat.com>
 <Ybyg1r/Q6EfeuXGV@FVFF77S0Q05N>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Ybyg1r/Q6EfeuXGV@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/21 15:38, Mark Rutland wrote:
> For example kvm_guest_enter_irqoff() calls guest_enter_irq_off() which calls
> vtime_account_guest_enter(), but kvm_guest_exit_irqoff() doesn't call
> guest_exit_irq_off() and the call to vtime_account_guest_exit() is open-coded
> elsewhere. Also, guest_enter_irq_off() conditionally calls
> rcu_virt_note_context_switch(), but I can't immediately spot anything on the
> exit side that corresponded with that, which looks suspicious.

rcu_note_context_switch() is a point-in-time notification; it's not 
strictly necessary, but it may improve performance a bit by avoiding 
unnecessary IPIs from the RCU subsystem.

There's no benefit from doing it when you're back from the guest, 
because at that point the CPU is just running normal kernel code.

Paolo
