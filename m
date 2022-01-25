Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2886749B6FD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357135AbiAYOys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:54:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45077 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1580799AbiAYOwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:52:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643122351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=000N8i0ck0tOaQfaIosTwzm6+d1XOHKA+Or39H8w7yU=;
        b=U2g3dz1yPLwkFzEk0cboxsBoQzKHfH4LFvKe1vpLgOFDYEGX5C6w9c1CqgUd7c7fWUBjvd
        QnVeVP1RIu0XUnF04pw6gV0QMtVNxLGsOH2p6CPPEmRq7P1CjW4xx82TkchMG4g4pky8zK
        7Mc16yp+ouqPkXZyuORhh0Ki0c1Ichg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189-uMLFNgDPPuaAoTbFdeoK9w-1; Tue, 25 Jan 2022 09:52:29 -0500
X-MC-Unique: uMLFNgDPPuaAoTbFdeoK9w-1
Received: by mail-ed1-f70.google.com with SMTP id i22-20020a50fd16000000b00405039f2c59so11074543eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 06:52:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=000N8i0ck0tOaQfaIosTwzm6+d1XOHKA+Or39H8w7yU=;
        b=119TT9S9BuihVtkNPzopOQ7+JUQ5VVs794mRyDgtOkfyOKsbTEUTLvYjwSbqn7+H42
         awEuseaQ2Es6YWLGvgO4DLfJ/bcEIkyUEEaOXvhbmRihjLomwuUYWtvt8NYTeON3BPnF
         JpaFZpQ++m2pmXcozcJ9G/mfvJUCB5wJQYWO8FiyIVQMFbXYfCokahg8VK7MmxKe3DvU
         Ek9N16Ve4oDWcVrhak5KTs6Y01BQpTuLVxk66xFrxBhm/AIcW+vktJd4qYlB+8wT+7kl
         12rqIKOWBzdD4/C1MTWTGg7HwrPEA5iFQb9qo2onPawdt8XiuXZ+hV0KodmnEITI+3/W
         hLrg==
X-Gm-Message-State: AOAM531Xr7cfTUYvnp+GFBm+Gja4j+u8CjLJGYZynZYwqASa1OvTj8Ww
        RLQZDNfHG9zAS97Zvqj93eWvvMQaCb9kOSI0bqiCPpuzI0OVQwsigjHvgvomhwJcN4X2oscU06d
        Eg/EYoDoMlvwe0vUCdt83IagX
X-Received: by 2002:a17:906:5d0f:: with SMTP id g15mr16299069ejt.670.1643122348431;
        Tue, 25 Jan 2022 06:52:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwuLAUZcxf2zf3QzTwsEbiyKjOaNCI+O1Cluqag6g3b96dEm1xslHqRRBbInR4PoPT/UamFPA==
X-Received: by 2002:a17:906:5d0f:: with SMTP id g15mr16299058ejt.670.1643122348252;
        Tue, 25 Jan 2022 06:52:28 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id t6sm6172259ejd.85.2022.01.25.06.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 06:52:27 -0800 (PST)
Message-ID: <d0a79b9a-6ead-2fd3-00fe-7d96d4f7f428@redhat.com>
Date:   Tue, 25 Jan 2022 15:52:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 0/9] KVM: SVM: Fix and clean up "can emulate" mess
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Liam Merwick <liam.merwick@oracle.com>
References: <20220120010719.711476-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220120010719.711476-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/22 02:07, Sean Christopherson wrote:
> Revert an amusing/embarassing goof reported by Liam Merwick, where KVM
> attempts to determine if RIP is backed by a valid memslot without first
> translating RIP to its associated GPA/GFN.  Fix the underlying bug that
> was "fixed" by the misguided memslots check by (a) never rejecting
> emulation for !SEV guests and (b) using the #NPF error code to determine
> if the fault happened on the code fetch or on guest page tables, which is
> effectively what the memslots check attempted to do.
> 
> Further clean up, harden, and document SVM's "can emulate" helper, and
> fix a #GP interception SEV bug found in the process of doing so.
> 
> Sean Christopherson (9):
>    KVM: SVM: Never reject emulation due to SMAP errata for !SEV guests
>    Revert "KVM: SVM: avoid infinite loop on NPF from bad address"
>    KVM: SVM: Don't intercept #GP for SEV guests
>    KVM: SVM: Explicitly require DECODEASSISTS to enable SEV support
>    KVM: x86: Pass emulation type to can_emulate_instruction()
>    KVM: SVM: WARN if KVM attempts emulation on #UD or #GP for SEV guests
>    KVM: SVM: Inject #UD on attempted emulation for SEV guest w/o insn
>      buffer
>    KVM: SVM: Don't apply SEV+SMAP workaround on code fetch or PT access
>    KVM: SVM: Don't kill SEV guest if SMAP erratum triggers in usermode
> 
>   arch/x86/include/asm/kvm_host.h |   3 +-
>   arch/x86/kvm/svm/sev.c          |   9 +-
>   arch/x86/kvm/svm/svm.c          | 162 ++++++++++++++++++++++----------
>   arch/x86/kvm/vmx/vmx.c          |   7 +-
>   arch/x86/kvm/x86.c              |  11 ++-
>   virt/kvm/kvm_main.c             |   1 -
>   6 files changed, 135 insertions(+), 58 deletions(-)
> 
> 
> base-commit: edb9e50dbe18394d0fc9d0494f5b6046fc912d33

Queued, thanks.

Paolo

