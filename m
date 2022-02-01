Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716F04A64E7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 20:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240686AbiBATWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 14:22:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50859 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231995AbiBATWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:22:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643743327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KNLZeMJ1hLmOR320BSUE5LLY5y8wE3ZrAi1Mv89JbUQ=;
        b=NvgvnSwUmE6cYMmGtc/7CUanv8tY63TCctez4FZmPoO3GhMs/eu85E3s31AgYxkcsJBhSg
        Gm9T2FxOoQEDd6TGOSVMXLJcXBNi1PkNjBs+B7F4SP9FbJncN11OGjavw8N003c7NgjTKp
        IVJ/0mDIrePDCLE3DkDtEGsxy0gY3S8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-9yfm2ecbPT--accX3VS-UQ-1; Tue, 01 Feb 2022 14:22:06 -0500
X-MC-Unique: 9yfm2ecbPT--accX3VS-UQ-1
Received: by mail-ej1-f70.google.com with SMTP id gb4-20020a170907960400b0069d1ebc4538so7009216ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 11:22:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KNLZeMJ1hLmOR320BSUE5LLY5y8wE3ZrAi1Mv89JbUQ=;
        b=RUzai8esN2h/qIRcSg270XxPp7bqjlyvbxcElKkzD4rzbEwecxQcufI/9BVkGsSoR3
         z0H2xAgT2xPIIdYevgqAYUmoEcf3QcRNOHsNkCdvMRiP4uCLT+2uWVducUtLpdakFsyQ
         hjISNksorXkn0NG7P1IYLskRFs7bzYJVxyoig38xjxnMvNRgnPYVvVsmhdRpnj+WKuTU
         efKAx2CV0bomLRCJwWajVz92/brhYu+52dkB0Y0HgJ6vYtdFRJjlftw3rOmH9VrehzkB
         IwBY7q7pjP3/cfolG1c5sV5CXyeq2ehRKqfD62xZ5oNMWjGQNeD1wmUAF7VmB3x0z0dO
         qz/A==
X-Gm-Message-State: AOAM530+ApSOCUWygIMBjGDfx+UtpIErXgzBvqfjSoF1HBjLvKwi24Tn
        Pt/Yl2n9vxpWO/Vjx5kW5amj9xU2CTNquTVXoWcIqtjffyOKGfo4ZMcSrR7cypquj7E/7jrKhfq
        r2DnkPVNshh68L9QmLBssXllz
X-Received: by 2002:aa7:c0d4:: with SMTP id j20mr26748230edp.319.1643743325129;
        Tue, 01 Feb 2022 11:22:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxB0QkeShLAjTU/5/HP9pcNPzROHxknHP3s2Qa0pyu4FMnViL6Fm6YTtV2jmrf6VcpsVq4mqA==
X-Received: by 2002:aa7:c0d4:: with SMTP id j20mr26748210edp.319.1643743324942;
        Tue, 01 Feb 2022 11:22:04 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id i6sm15057876eja.132.2022.02.01.11.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 11:22:04 -0800 (PST)
Message-ID: <ebd368c8-5c2a-dc5b-203f-f058f68b7825@redhat.com>
Date:   Tue, 1 Feb 2022 20:22:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/5] KVM: SVM: nSVM: Implement Enlightened MSR-Bitmap for
 Hyper-V-on-KVM and fix it for KVM-on-Hyper-V
Content-Language: en-US
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        linux-kernel@vger.kernel.org
References: <20211220152139.418372-1-vkuznets@redhat.com>
 <35f06589-d300-c356-dc17-2c021ac97281@redhat.com> <87sft2bqup.fsf@redhat.com>
 <66bcd1bf-0df4-8f02-9c0d-f71cecef71f4@redhat.com> <87o83qbehk.fsf@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <87o83qbehk.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/22 19:58, Vitaly Kuznetsov wrote:
>> Hmm, it fails to compile with CONFIG_HYPERV disabled, and a trivial
>> #if also fails due to an unused goto label.  Does this look good to you?
>>
> Hm, it does but honestly I did not anticipate this dependency --
> CONFIG_HYPERV is needed for KVM-on-Hyper-V but this feature is for
> Hyper-V-on-KVM. Let me take a look tomorrow.
> 

It's because, without it, the relevant structs are not defined by 
svm_onhyperv.h.  Go ahead and send a new version if you prefer, I can 
unqueue it (really, just not push to kvm/queue).

Paolo

