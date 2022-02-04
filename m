Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E314A9575
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 09:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345043AbiBDItk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 03:49:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35161 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239817AbiBDIti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 03:49:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643964577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KmoD3b9T2QlVeR55XUKFS9sSRzif+Zqzh068n/5n3FA=;
        b=eKwyfvvC8PerbG6KZRGhvKB2+6SFwN3+1oZqnyJIujxh2oRnUth4s+bnpTYBUlP1AJWueP
        Du8Ze5xke4BBRSt0lIQO6nXbFoAM6zAgdoZgsBwsUV1B/FfjEMI0h3nAKqLcSbSVsYjtq2
        2Lp27nZg0zGnfNe1QRKVT96D/iZWYNg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-1DiY4RhjPyucIAC6KzuH0Q-1; Fri, 04 Feb 2022 03:49:34 -0500
X-MC-Unique: 1DiY4RhjPyucIAC6KzuH0Q-1
Received: by mail-ej1-f69.google.com with SMTP id la22-20020a170907781600b006a7884de505so2243654ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 00:49:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KmoD3b9T2QlVeR55XUKFS9sSRzif+Zqzh068n/5n3FA=;
        b=Cvsyxpx6hgMc56838ErC7uTk+45pVVC2vj2LAWx0zKfK2o/+mM+ujCzRVmbLI218nS
         +cp1xMO03NqSKo4fSzTkDajjWeT6NNce+MP4zUHXjVTUP/kPxWQM+W4X5F/YsAk1FlYt
         Mo3AuYkraK+PNGNyBHcdIsWzRV+agF24CpByMQucIcybrpdwzI1ooqzznT0P1QYy/+xC
         9szeeZbu90ukWH+eijlycwV4eFbo2rHkBht+qq06Qnx+aNpNjxfufZp8dl0gn5gfyDMR
         /n6PLOlB73Itof809g9nA3seJ6KD1LkQ8ui+BrBO9Sd4ZT5wNyuvNv+2e4YxrabtjsWq
         bokQ==
X-Gm-Message-State: AOAM532jghW1A5xpFQGx+RSRbxPI/+0XKAa0/52AL3wIL59y57hm+ovR
        BiR7GrQXQU2nnsS9hwQk487Uvx4S2Zk2aPnP3EaXNucAmEemNJeQVIm/WZwvcs5bZFh9BX+rKG2
        cm/wrGnR2UcZRSQqfDBtODG+W
X-Received: by 2002:a17:907:2d88:: with SMTP id gt8mr1604545ejc.618.1643964573347;
        Fri, 04 Feb 2022 00:49:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxvInqjlWbjztNR1P4DcWcUE2FAOcKPCXPBcb6/ec1lRJOz1W9DqXcHE6darCzcl4xe6tB2fg==
X-Received: by 2002:a17:907:2d88:: with SMTP id gt8mr1604530ejc.618.1643964573160;
        Fri, 04 Feb 2022 00:49:33 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id g9sm428003ejf.33.2022.02.04.00.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 00:49:32 -0800 (PST)
Message-ID: <53c1864c-f966-0412-deb5-10912e84555c@redhat.com>
Date:   Fri, 4 Feb 2022 09:49:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/6] KVM: selftests: Introduce selftests for enlightened
 MSR-Bitmap feature
Content-Language: en-US
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
References: <20220203104620.277031-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220203104620.277031-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/22 11:46, Vitaly Kuznetsov wrote:
> KVM gained support for enlightened MSR-Bitmap Hyper-V feature (Hyper-V
> on KVM) for both nVMX and nSVM, test it in selftests.
> 
> Vitaly Kuznetsov (6):
>    KVM: selftests: Adapt hyperv_cpuid test to the newly introduced
>      Enlightened MSR-Bitmap
>    KVM: selftests: nVMX: Properly deal with 'hv_clean_fields'
>    KVM: selftests: nVMX: Add enlightened MSR-Bitmap selftest
>    KVM: selftests: nSVM: Set up MSR-Bitmap for SVM guests
>    KVM: selftests: nSVM: Update 'struct vmcb_control_area' definition
>    KVM: selftests: nSVM: Add enlightened MSR-Bitmap selftest
> 
>   tools/testing/selftests/kvm/Makefile          |   1 +
>   .../selftests/kvm/include/x86_64/evmcs.h      | 150 ++++++++++++++-
>   .../selftests/kvm/include/x86_64/svm.h        |   9 +-
>   .../selftests/kvm/include/x86_64/svm_util.h   |   6 +
>   tools/testing/selftests/kvm/lib/x86_64/svm.c  |   6 +
>   .../testing/selftests/kvm/x86_64/evmcs_test.c |  64 ++++++-
>   .../selftests/kvm/x86_64/hyperv_cpuid.c       |  29 +--
>   .../selftests/kvm/x86_64/hyperv_svm_test.c    | 175 ++++++++++++++++++
>   8 files changed, 424 insertions(+), 16 deletions(-)
>   create mode 100644 tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
> 

Queued, thanks.

Paolo

