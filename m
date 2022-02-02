Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F5B4A769C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346173AbiBBROw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:14:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44541 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229751AbiBBROv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:14:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643822090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z5luWBqzyOZ8TMy1EXyCPtbt4++Mrcm5+Fa6Hswl/gc=;
        b=B1IiOX9K4KkwAW28sJHHit19HN1g/oDEPCOUAdOIWe2RcBB1JrQfCLwv1zcFj0zPHALsa6
        lEFXJRTUTlqhpD09aAzDkDERIto/dundPVShEwvVwhkPYjSZ1N2DS0/iJf1gB5Drg3+IZ3
        /Ky8N+woa/2KNR90iijOw76yLVSM4e8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154-lVqn4mfUM2GICW8sPjmHFw-1; Wed, 02 Feb 2022 12:14:49 -0500
X-MC-Unique: lVqn4mfUM2GICW8sPjmHFw-1
Received: by mail-wm1-f70.google.com with SMTP id q127-20020a1ca785000000b00352a4860babso52432wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 09:14:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=z5luWBqzyOZ8TMy1EXyCPtbt4++Mrcm5+Fa6Hswl/gc=;
        b=oH7mXxizc9fZMGYhhwKjfmsKM2oemskN6it4HlYvUd5oBaIZAA2nypu2RI/ePnpvDp
         qGHN0kE80Zc4MLjA+wGCVleiCl8kI7nR3psxFR6sDhN4e0pITgxnDINqA0uLMvxtc+a/
         IMQgeP5nNGDJVZCnjWxY1ehENtPVneLBMLFThbGrYIROMbvPYZN6MyZW7mRGQJ78ZYyq
         H0y2oAXHFBd14psbn075ywnqoMF+29B6kvoVvJKZ1D1ssNega0PK+flYevnO/YRrZWUL
         Pn4ZyeDchp/Ii4mlPYN7ryPflaMyNP/f+98MSAsmrFx0E0m1/yQiJsM1VIA4g3MtJx+h
         9OvQ==
X-Gm-Message-State: AOAM532nx3kbCtvRb2j3kalVGbx7IXeN0TiU9enoJp0PF8REJcyLj8Rw
        AY1f7LjHMsAvoZm19CnfFlImMthHhhZSGZhIXWqF/XDDPuG4SWNW8CECbKqWPP6kxg67h4VmEGv
        yVXlHztAeCuW1EUlHcTZfAQ8o
X-Received: by 2002:a5d:6349:: with SMTP id b9mr25789769wrw.178.1643822088720;
        Wed, 02 Feb 2022 09:14:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzxYywfTMgP3DeL9IBxHNRCeFE+uDAERjb3gBE+FqbAoFTNlYgMaIPAmOzHLnuT5Tho6NVoeg==
X-Received: by 2002:a5d:6349:: with SMTP id b9mr25789754wrw.178.1643822088491;
        Wed, 02 Feb 2022 09:14:48 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id n15sm21791299wrf.37.2022.02.02.09.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 09:14:47 -0800 (PST)
Message-ID: <429afd81-7bef-8ead-6ca4-12671378d581@redhat.com>
Date:   Wed, 2 Feb 2022 18:14:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/4] KVM: SVM: nSVM: Implement Enlightened MSR-Bitmap
 for Hyper-V-on-KVM
Content-Language: en-US
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        linux-kernel@vger.kernel.org
References: <20220202095100.129834-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220202095100.129834-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/22 10:50, Vitaly Kuznetsov wrote:
> Changes since v1:
> - Patches 1/2 from "[PATCH 0/5] KVM: SVM: nSVM: Implement Enlightened
>    MSR-Bitmap for Hyper-V-on-KVM and fix it for KVM-on-Hyper-V" are already
>    merged, dropped.
> - Fix build when !CONFIG_HYPERV (PATCH3 "KVM: nSVM: Split off common
>    definitions for Hyper-V on KVM and KVM on Hyper-V" added).
> 
> Description:
> 
> Enlightened MSR-Bitmap feature implements a PV protocol for L0 and L1
> hypervisors to collaborate and skip unneeded updates to MSR-Bitmap.
> KVM already implements the feature for KVM-on-Hyper-V.
> 
> Vitaly Kuznetsov (4):
>    KVM: nSVM: Track whether changes in L0 require MSR bitmap for L2 to be
>      rebuilt
>    KVM: x86: Make kvm_hv_hypercall_enabled() static inline
>    KVM: nSVM: Split off common definitions for Hyper-V on KVM and KVM on
>      Hyper-V
>    KVM: nSVM: Implement Enlightened MSR-Bitmap feature
> 
>   arch/x86/kvm/hyperv.c           | 12 +--------
>   arch/x86/kvm/hyperv.h           |  6 ++++-
>   arch/x86/kvm/svm/hyperv.h       | 35 ++++++++++++++++++++++++
>   arch/x86/kvm/svm/nested.c       | 47 ++++++++++++++++++++++++++++-----
>   arch/x86/kvm/svm/svm.c          |  3 ++-
>   arch/x86/kvm/svm/svm.h          | 11 ++++++++
>   arch/x86/kvm/svm/svm_onhyperv.h | 25 +-----------------
>   7 files changed, 95 insertions(+), 44 deletions(-)
>   create mode 100644 arch/x86/kvm/svm/hyperv.h
> 

Queued, thanks.

Paolo

