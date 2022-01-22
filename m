Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C726496AEF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 09:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiAVIRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 03:17:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27167 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229488AbiAVIRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 03:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642839469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TG6QEhuY9ZIy4SOy4T7GfVmZPT2ViIWcL0SkcfVaGHU=;
        b=h1yMqd7YeeWfnYMXQ14qXVI3bWByLPl24NssaJy6h4G2amSNpoeJ4Nixt+y0Xkku8qrmiW
        6HoqavPQKZ5BAr4d0dDxFoZc+9MJoezgkfpP9anvIjCDVHw7lUdP71jk8hiG26bLa6pdBn
        e3JCX4A8uZx/zjdWes6cgaqXQSF/4Aw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-218-ZYOYpD1NPH6X8I7CFdyeUA-1; Sat, 22 Jan 2022 03:17:46 -0500
X-MC-Unique: ZYOYpD1NPH6X8I7CFdyeUA-1
Received: by mail-wr1-f71.google.com with SMTP id c10-20020adfa30a000000b001d79c73b64bso820645wrb.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 00:17:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=TG6QEhuY9ZIy4SOy4T7GfVmZPT2ViIWcL0SkcfVaGHU=;
        b=KI/8r8JfCeZ+MNrshhlG9m1K4LdHcxGIInRyljzwzVWqKm0F/q6SILnyfm49si7yoe
         x+gxzL1awZ6naYyRqECsdD6LYlo5/6q7U/bgQprK+YGuFONscghXVAnRPoYat6m8ITYC
         oftRmJudKg3Q+Jev+lsPAJsMXKGpkYKF1Ylzu4+1rHUabl0yIE/IAU/rhwn8FHTH7mzE
         Mk02SjYp7G7nwpI0wdJ3SDOpQqvGyNJmWD+HCWuwi0YNSzHsX7KC9G79DPVwfgEehVA8
         rRbKOb+IN0B95lIsfdp3JDo61b/uB9IG/FhJcXdSj9z8ZBFPR6xP9wzpnGhWhgQnCbpd
         yvjw==
X-Gm-Message-State: AOAM530FUdlE0bvevmL+eo6lpqwdA7th/D6FPJIASyALtAiOX6BK9I0X
        UOKU5pn4Ye22/a8cbqAH4VOnZWKeicJ6OcDqIqNLVLAYqxHWYDzQQGGIKF4uReGLnmJUU7Rb/ot
        7O1fElUDCEFtQgR7Ibk0dogRnlAY9nTnXh3DcuyGxREwijqCjP8tPPrsyx20HODFDbsbIrwP/ey
        zX
X-Received: by 2002:a1c:f303:: with SMTP id q3mr3664002wmq.63.1642839465140;
        Sat, 22 Jan 2022 00:17:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwZ30FILZYqtip38gkOzWjiKW119eyvaVofLJH217trFBRst6CBNJFQefEUV3LkVzG++CZv7Q==
X-Received: by 2002:a1c:f303:: with SMTP id q3mr3663986wmq.63.1642839464882;
        Sat, 22 Jan 2022 00:17:44 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id o2sm8263931wms.9.2022.01.22.00.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 00:17:44 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] KVM: x86: Move CPUID.(EAX=0x12,ECX=1) mangling
 to __kvm_update_cpuid_runtime()
In-Reply-To: <2ba86d3f-5ab2-af2f-1f7d-ba2d6b7e78d2@redhat.com>
References: <20220121132852.2482355-1-vkuznets@redhat.com>
 <20220121132852.2482355-3-vkuznets@redhat.com>
 <2ba86d3f-5ab2-af2f-1f7d-ba2d6b7e78d2@redhat.com>
Date:   Sat, 22 Jan 2022 09:17:43 +0100
Message-ID: <878rv8jiag.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 1/21/22 14:28, Vitaly Kuznetsov wrote:
>> To support comparing CPUID data update with what's already set for a vCPU
>> all mangling needs to happen in __kvm_update_cpuid_runtime(), before
>> 'vcpu->arch.cpuid_entries' is updated. CPUID.(EAX=0x12,ECX=1) is currently
>> being mangled in kvm_vcpu_after_set_cpuid(), move it to
>> __kvm_update_cpuid_runtime(). Split off cpuid_get_supported_xcr0() helper
>> as 'vcpu->arch.guest_supported_xcr0' update needs (logically) to stay in
>> kvm_vcpu_after_set_cpuid().
>> 
>> No functional change intended.
>
> Since v3 is already on its way to Linus, I'll merge this patch next week.
>

Thanks,

there is also a change in "[PATCH v4 3/5] KVM: x86: Partially allow
KVM_SET_CPUID{,2} after KVM_RUN" where I switch to memcmp (as suggested
by Sean). I can send an incremental patch if needed.

-- 
Vitaly

