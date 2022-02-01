Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37A64A5BF0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 13:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237838AbiBAML6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 07:11:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28739 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236377AbiBAML5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 07:11:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643717516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lsdysZ548rZ3tzqzcEGKcgNZBJ//Jtgmjh673Jd5TCs=;
        b=UHqRFchFXpZL5Ha+0FtJZwS5zpaBTQNJpVxCYcLsKC5xzfFZMiN8b/dW5iIfk84v0PGnWN
        23Jkfqp7EHF5XuDp9vMaTYkLz/852TZZvqT+cZ4q/CafVPoUFVAx7tA6cJlLWRzni7qtnm
        Y+hNuspwr23LRQrLv6svSVZNWN0VfKI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-Puev7iVCMjSskDn4aFSNPg-1; Tue, 01 Feb 2022 07:11:53 -0500
X-MC-Unique: Puev7iVCMjSskDn4aFSNPg-1
Received: by mail-ej1-f72.google.com with SMTP id i21-20020a1709063c5500b006b4c7308c19so6439603ejg.14
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 04:11:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lsdysZ548rZ3tzqzcEGKcgNZBJ//Jtgmjh673Jd5TCs=;
        b=H+MpgEd722ItNHJAc5VoZit6cpT1+bIMFb8UrPxvwbIPOl8EseMREDU1Pow8XPeJHL
         fdJEuliwTBPeUMSKn9IsUd0hfXWhXxkwUXv01rUR/pvSBvYT7JfcnTSyTUsWSUg4clvv
         bEOtwO8ePTtv/3yY7u1ygdr/00V/KYXVk3vZ6bXyMXz4Dzwz9mYA8by1djWSQr+dfVrC
         urwc6BeTLsam962Ml8IQ5Bj6LwAs9XXHhKjq8eP7hJRyUYZ2Tb5V68qp8NQsqT4K2G+t
         cNaRnqqJA6gV4nicYeoULGRXJ+L9pXjeynrN0YshZszEJ/mn9UcuB9Dm6ozhZx9OPvYv
         U08g==
X-Gm-Message-State: AOAM530DmCH+tXRRGMt1EIFKC1blkas7rNM+8sJ9q+X7WyMxdOuj5CGL
        4HQS0N6SllSX6y7PPS3fX2BI7A+cgVXaFWNQUmmk+u5DdI/YPHUc0NlROJgTKp5zcXXDsdQwI0H
        S6sxJCJd+Wa9BTlHp71jcX5n0
X-Received: by 2002:a05:6402:344d:: with SMTP id l13mr3567080edc.448.1643717512402;
        Tue, 01 Feb 2022 04:11:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz0KghrMv3/uj5R2TJQ7Eav9ORWV+tDOc9zzVirCQrQPDIm1zadhl+F3wCRz4HFr1kek9V8fA==
X-Received: by 2002:a05:6402:344d:: with SMTP id l13mr3567059edc.448.1643717512215;
        Tue, 01 Feb 2022 04:11:52 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id q12sm1188934edv.99.2022.02.01.04.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 04:11:51 -0800 (PST)
Message-ID: <ae828eca-40bd-60f3-263f-5b3de637a9aa@redhat.com>
Date:   Tue, 1 Feb 2022 13:11:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH RESEND v2] KVM: LAPIC: Enable timer posted-interrupt when
 mwait/hlt is advertised
Content-Language: en-US
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Aili Yao <yaoaili@kingsoft.com>
References: <1643112538-36743-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <1643112538-36743-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/22 13:08, Wanpeng Li wrote:
> As commit 0c5f81dad46 (KVM: LAPIC: Inject timer interrupt via posted interrupt)
> mentioned that the host admin should well tune the guest setup, so that vCPUs
> are placed on isolated pCPUs, and with several pCPUs surplus for*busy*  housekeeping.
> It is better to disable mwait/hlt/pause vmexits to keep the vCPUs in non-root
> mode. However, we may isolate pCPUs for other purpose like DPDK or we can make
> some guests isolated and others not, we may lose vmx preemption timer/timer fastpath
> due to not well tuned setup, and the checking in kvm_can_post_timer_interrupt()
> is not enough. Let's guarantee mwait/hlt is advertised before enabling posted-interrupt
> interrupt. vmx preemption timer/timer fastpath can continue to work if both of them
> are not advertised.

Is this the same thing that you meant?

--------
As commit 0c5f81dad46 ("KVM: LAPIC: Inject timer interrupt via posted interrupt")
mentioned that the host admin should well tune the guest setup, so that vCPUs
are placed on isolated pCPUs, and with several pCPUs surplus for *busy* housekeeping.
In this setup, it is preferrable to disable mwait/hlt/pause vmexits to
keep the vCPUs in non-root mode.

However, if only some guests isolated and others not, they would not have
any benefit from posted timer interrupts, and at the same time lose
VMX preemption timer fast paths because kvm_can_post_timer_interrupt()
returns true and therefore forces kvm_can_use_hv_timer() to false.

By guaranteeing that posted-interrupt timer is only used if MWAIT or HLT
are done without vmexit, KVM can make a better choice and use the
VMX preemption timer and the corresponding fast paths.
--------

Thanks,

Paolo

