Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191C44A60DF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 16:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240751AbiBAP7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 10:59:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49994 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237158AbiBAP7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 10:59:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643731192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D20gs22S9rabd0+fMNoXvcTEn8NgDJog1qZfUCh12Vc=;
        b=JtoAawRgH0x+5DTpiYqSzAcblOE1YgK1uFlEtWaaCIZGyl1rToxFEKtt6wCPuE7Sd4j7g4
        hQne1BSDTZeDKCMJbFtCZEHm22oOVJjjsqxcRIi8NfY8IVEwyWsy+BkZheyjkXO8k0/onq
        l5PB/+tqmTPjgk1aO7S19duUt5OAXng=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-hbFAVL4_OL2yB2EBNeqU_Q-1; Tue, 01 Feb 2022 10:59:51 -0500
X-MC-Unique: hbFAVL4_OL2yB2EBNeqU_Q-1
Received: by mail-ed1-f72.google.com with SMTP id w15-20020a056402268f00b00408234dc1dfso8907948edd.16
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 07:59:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=D20gs22S9rabd0+fMNoXvcTEn8NgDJog1qZfUCh12Vc=;
        b=7CY8wo7D70dliY7sApKhvKR4YbJ9plHw1/xc1l/NL2E1OIUDYV1XWuobiohWNYdYza
         uMN1gPmqEY9xSVISNUE6RLtTLjJFMANTwOTEkjHqqXWFExAo+ODzcmH8mmrdsWoePiRD
         if6G9FbaWQBFWxv3NhZroFw8H8YAS5+2kpMT3+0As23xb9AvELEoyTC2238gVoWcUvLC
         FnMsfo226kfUOx64+vsyTRtP1XdY6nO2IBjZHrE04kXXnp0Pr/vhC5i0bQepzS/PGe6s
         XjGEaYO/zKzXtptPF+UG3j8DP83xRLW8MVxveW/f+X4c2I7UPqCs/lA0mDWN+6v4NaSC
         4vAA==
X-Gm-Message-State: AOAM531gIdqwznegWOXChk0Mabmy2XuzxWD4B0a3VY84R7c25xx5zx47
        Y9D9SIOYfBLgrrYW+NFW+j/yv/KFSVyla7CeZpsGSvfDeBPGgRz+95t91SOeyLHS3iGkvwxyNhx
        LLwta3lVHCnWeOKiuwerJuJLg
X-Received: by 2002:a05:6402:2688:: with SMTP id w8mr25585350edd.393.1643731190151;
        Tue, 01 Feb 2022 07:59:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvqhrX+wYMro3W0vh+iiLLi2W1gZHf+O52TX6b2unIGiAUG6Gz6xXfZZLNlv+/XNj7r7o9JQ==
X-Received: by 2002:a05:6402:2688:: with SMTP id w8mr25585309edd.393.1643731189875;
        Tue, 01 Feb 2022 07:59:49 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id c25sm19764227edt.0.2022.02.01.07.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 07:59:49 -0800 (PST)
Message-ID: <87aa8af0-c262-ad04-58f8-da6c7882e23c@redhat.com>
Date:   Tue, 1 Feb 2022 16:59:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 0/5] kvm: fix latent guest entry/exit bugs
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Cc:     aleksandar.qemu.devel@gmail.com, alexandru.elisei@arm.com,
        anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org,
        benh@kernel.crashing.org, borntraeger@linux.ibm.com, bp@alien8.de,
        catalin.marinas@arm.com, chenhuacai@kernel.org,
        dave.hansen@linux.intel.com, frederic@kernel.org,
        hca@linux.ibm.com, james.morse@arm.com, jmattson@google.com,
        joro@8bytes.org, maz@kernel.org, mingo@redhat.com,
        mpe@ellerman.id.au, nsaenzju@redhat.com, palmer@dabbelt.com,
        paulmck@kernel.org, paulus@samba.org, paul.walmsley@sifive.com,
        seanjc@google.com, suzuki.poulose@arm.com, svens@linux.ibm.com,
        tglx@linutronix.de, tsbogend@alpha.franken.de, vkuznets@redhat.com,
        wanpengli@tencent.com, will@kernel.org
References: <20220201132926.3301912-1-mark.rutland@arm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220201132926.3301912-1-mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/22 14:29, Mark Rutland wrote:
> I've pushed the series (based on v5.17-rc2) to my kvm/entry-rework branch:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=kvm/entry-rework
>    git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git kvm/entry-rework

Thanks!  I cherry-picked the basic, x86 and mips patches to kvm.git's 
master branch (I did not use your branch in order to leave arm64 and 
riscv to the respective maintainers).

Paolo

> This version of the series is tagged as kvm-entry-rework-20220201.
> 
> [1] https://lore.kernel.org/r/20220111153539.2532246-1-mark.rutland@arm.com/
> [2] https://lore.kernel.org/r/20220119105854.3160683-1-mark.rutland@arm.com/
> 
> Thanks,
> 
> 
> Mark Rutland (5):
>    kvm: add guest_state_{enter,exit}_irqoff()
>    kvm/arm64: rework guest entry logic
>    kvm/x86: rework guest entry logic
>    kvm/riscv: rework guest entry logic
>    kvm/mips: rework guest entry logic
> 
>   arch/arm64/kvm/arm.c     |  51 +++++++++++-------
>   arch/mips/kvm/mips.c     |  50 +++++++++++++++--
>   arch/riscv/kvm/vcpu.c    |  44 +++++++++------
>   arch/x86/kvm/svm/svm.c   |   4 +-
>   arch/x86/kvm/vmx/vmx.c   |   4 +-
>   arch/x86/kvm/x86.c       |   4 +-
>   arch/x86/kvm/x86.h       |  45 ----------------
>   include/linux/kvm_host.h | 112 +++++++++++++++++++++++++++++++++++++--
>   8 files changed, 222 insertions(+), 92 deletions(-)
> 

