Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97644484FD4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238784AbiAEJMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:12:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:39510 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233564AbiAEJMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:12:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641373934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YuZR8Blv4ggkVN5CJn82939kNMxQ+jdkHDrF0kcyzK8=;
        b=VPPbm6tbIuX5x6Y+2oCPGeZnvNdwYsb+FLB/3Q1ijhzVMsYKQTBIrbvvk2/W7MslY8f8Mh
        nqshgcVX4vc6vOb5qcKFLJunJnNZvN7k1BVVR5arfuhTgbW3+Rnv+Z9cs+LLdDmY+FG1RO
        Q19wLW2pKd+oquzihFY1S4hiPfsEnvA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-xW3sjxlYPcC9hMvVD8XPsQ-1; Wed, 05 Jan 2022 04:12:13 -0500
X-MC-Unique: xW3sjxlYPcC9hMvVD8XPsQ-1
Received: by mail-wr1-f72.google.com with SMTP id d6-20020adfa346000000b001a262748c6fso12284385wrb.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 01:12:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=YuZR8Blv4ggkVN5CJn82939kNMxQ+jdkHDrF0kcyzK8=;
        b=a+p5PSlQzwijWMze3L+hkAU7zcLySdzAFstfPJArRkenqdQaLKtEJ74z7808mLjo5L
         0eq13yxGhwDiJfhMjMlWgbL9aiMh0IahRRc1Mj3eYwD0vi7YMBDVaq/9QUmjmM5er3/4
         hNMQEqmhBKxseUByWL6wF8GVhsNxO/jVstJ6uy7+pmwvnDlFpDs7tIsI807eV1RYv8De
         TOFgOf/8epiLKS5syewjvFIBKR2NHmxcD4wYwwD74VSX4VqQj9FyF54bR6nDke7nCnoT
         ceRzKkVQyKU2EvlsRGbhaZTxnqugRp2elK5apMTfpJ2r0gby+qaRQvabDXA+nBMpyA4S
         Oe5w==
X-Gm-Message-State: AOAM530oIHCiv0A+pmmeETJ7MlvBcl4A9g8YnrA/EvKp9YWtM83Cr2pX
        ZEwRFxBxFXvq6ueyrO06IaI+jkZi/c5s9inySIIiE3YSz+L8Nd0Hk3jVQpMJ0aW1/DkAA07OS5a
        920wFUfOEzaTzVGMj9BcrqMTwIpUJmng534AMJNtKp2RTNTvhfK8LFSI66oN/E3hpCHun8YN4/0
        HZ
X-Received: by 2002:a05:600c:4f83:: with SMTP id n3mr1931435wmq.129.1641373931739;
        Wed, 05 Jan 2022 01:12:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxJGEufGnlcPzjgNtiUf6Lw4kxejjQ0hkoClytwxQe81eCYbmD1eSwlLenyXSK3BfXqRxswbg==
X-Received: by 2002:a05:600c:4f83:: with SMTP id n3mr1931404wmq.129.1641373931446;
        Wed, 05 Jan 2022 01:12:11 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id e13sm1933746wmq.10.2022.01.05.01.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 01:12:10 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Igor Mammedov <imammedo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: x86: Forbid KVM_SET_CPUID{,2} after KVM_RUN
In-Reply-To: <20220105091724.1a667275@redhat.com>
References: <20211122175818.608220-1-vkuznets@redhat.com>
 <20211122175818.608220-3-vkuznets@redhat.com>
 <16368a89-99ea-e52c-47b6-bd006933ec1f@redhat.com>
 <20211227183253.45a03ca2@redhat.com>
 <61325b2b-dc93-5db2-2d0a-dd0900d947f2@redhat.com>
 <87mtkdqm7m.fsf@redhat.com> <20220103104057.4dcf7948@redhat.com>
 <875yr1q8oa.fsf@redhat.com> <20220105091724.1a667275@redhat.com>
Date:   Wed, 05 Jan 2022 10:12:08 +0100
Message-ID: <87tueipmvr.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Igor Mammedov <imammedo@redhat.com> writes:

> On Mon, 03 Jan 2022 13:56:53 +0100
> Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
>> Igor Mammedov <imammedo@redhat.com> writes:
>> 
>> > On Mon, 03 Jan 2022 09:04:29 +0100
>> > Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>> >  
>> >> Paolo Bonzini <pbonzini@redhat.com> writes:
>> >>   
>> >> > On 12/27/21 18:32, Igor Mammedov wrote:    
>> >> >>> Tweaked and queued nevertheless, thanks.    
>> >> >> it seems this patch breaks VCPU hotplug, in scenario:
>> >> >> 
>> >> >>    1. hotunplug existing VCPU (QEMU stores VCPU file descriptor in parked cpus list)
>> >> >>    2. hotplug it again (unsuspecting QEMU reuses stored file descriptor when recreating VCPU)
>> >> >> 
>> >> >> RHBZ:https://bugzilla.redhat.com/show_bug.cgi?id=2028337#c11
>> >> >>     
>> >> >
>> >> > The fix here would be (in QEMU) to not call KVM_SET_CPUID2 again. 
>> >> > However, we need to work around it in KVM, and allow KVM_SET_CPUID2 if 
>> >> > the data passed to the ioctl is the same that was set before.    
>> >> 
>> >> Are we sure the data is going to be *exactly* the same? In particular,
>> >> when using vCPU fds from the parked list, do we keep the same
>> >> APIC/x2APIC id when hotplugging? Or can we actually hotplug with a
>> >> different id?  
>> >
>> > If I recall it right, it can be a different ID easily.
>> >  
>> 
>> It's broken then. I'd suggest we revert the patch from KVM and think
>> about the strategy how to proceed.
>
> Can you post a patch, then?
>

Paolo,

would you like to send a last minute revert to Linus to save 5.16 ...

>> Going forward, we really want to ban
>> KVM_SET_CPUID{,2} after KVM_RUN (see the comment which my patch moves).
>> E.g. we can have an 'allowlist' of things which can change (and put
>> *APICids there) and only fail KVM_SET_CPUID{,2} when we see something
>> else changing.
>
> It might work, at least on QEMU side we do not allow mixing up CPU models
> within VM instance (so far). So aside of APICid (and related leafs
> (extended APIC ID/possibly other topo related stuff)) nothing else should
> change ever when a new vCPU is hotplugged.

or should we just focus on this (or similar) solution (for 5.17 and
stable@5.16)?

>
>> In QEMU, we can search the parked CPUs list for an entry
>> with the right *APICid and reuse it only if we manage to find one.
> In QEMU, 'parked cpus' fd list is a generic code shared by all supported
> archs. And I'm reluctant to push something x86 specific there (it's not
> impossible, but it's a crutch to workaround forbidden KVM_SET_CPUID{,2}).
>

You can see it this was: vCPU fd corresponds to the particular CPU being
hot plugged/unplugged, not to any CPU in the guest system. The change
may be generic enough then (but it's not going to save existing QEMUs of
course).

-- 
Vitaly

