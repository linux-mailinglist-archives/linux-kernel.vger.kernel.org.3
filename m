Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F164A6237
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241259AbiBARTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:19:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24458 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240683AbiBARTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:19:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643735974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KcsFPU0hUyaRVw35zLc4ecfKycgP6KY1g6YUHK3IxEI=;
        b=N3J7I6MrHsb1Ab8AUbJctQGXB8gxqEcdWByx4D9RvqGsoJadMvxEZXhpRjz5EpIeBARfsH
        Nplg4Sk8xVoaWPsCEXhUQB3+ZqTs5UN2utfd6NDkW/OJx6s5bdzJeFxKumKeIQ4EuV4ZFA
        VKr3whfpxpx/thWQ65nHwfGydtI6EVk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-h4UnsUoLPhqF5SIPwRiOwQ-1; Tue, 01 Feb 2022 12:19:32 -0500
X-MC-Unique: h4UnsUoLPhqF5SIPwRiOwQ-1
Received: by mail-ed1-f70.google.com with SMTP id w23-20020a50d797000000b00406d33c039dso9028036edi.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 09:19:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KcsFPU0hUyaRVw35zLc4ecfKycgP6KY1g6YUHK3IxEI=;
        b=lz5nLDVFPt+rCFTDDIxpn0Vg7ClY3qLGZ3xEIDE5O8P7X4zxU+1bELe2RAim1k8wR+
         y9JZGgZlnJ0EM9VIWfX950P0qPgdovafp82AB18fnY4kX6eK2vuzri+xySSl2EGxsxDA
         HWLMq0YKoitnmLAqmL5OS28YuOozM3izLwLeGibK0setd4L1dXCPjiFMB6VajXd18NKy
         Jwh2ZuK4TMpuRZ9ZiiuMYRGu6PQJ+L5qI7hweqlBW0MAwu56cR8tTfzw/kf1rdibOiY4
         MRiGtWJEbjpG/uX9eVesrrO8lfONGdZUnjQFqJth1Mo1l7SoQ5mSU0g1IlWXuNEd2bht
         S5pw==
X-Gm-Message-State: AOAM533EmkucUJRsnyz4spDME23Kh4vZTFCUZvFnJjUQW2x7YbNLanj0
        X2Y2bxl7LyhZMzBmg9whmjpN1WVNe9K6M7H4jbcLJN3a8Bll7UxfnKVxikoBoaUpTg07Q6tVyMb
        tgwrqX/gRByrMveXQKlPtg3Vc
X-Received: by 2002:a05:6402:1705:: with SMTP id y5mr26171129edu.200.1643735971718;
        Tue, 01 Feb 2022 09:19:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJziuvxK+tKS0kkMRWjqDG2bHnRyq174U3nOlorRasUEDjgAg9WJPr5K9WPoGdm3MeRzYXOF6g==
X-Received: by 2002:a05:6402:1705:: with SMTP id y5mr26171112edu.200.1643735971491;
        Tue, 01 Feb 2022 09:19:31 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id i6sm14964394eja.132.2022.02.01.09.19.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 09:19:30 -0800 (PST)
Message-ID: <75b07c8e-b951-fdde-5429-27c9ef198dcc@redhat.com>
Date:   Tue, 1 Feb 2022 18:19:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH RESEND v2] KVM: LAPIC: Enable timer posted-interrupt when
 mwait/hlt is advertised
Content-Language: en-US
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Aili Yao <yaoaili@kingsoft.com>
References: <1643112538-36743-1-git-send-email-wanpengli@tencent.com>
 <ae828eca-40bd-60f3-263f-5b3de637a9aa@redhat.com>
 <CANRm+CwkYJAsv=VngY6m1uQtCLa+WqOJwSJzx95dO7LRAkbsbg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CANRm+CwkYJAsv=VngY6m1uQtCLa+WqOJwSJzx95dO7LRAkbsbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/22 14:57, Wanpeng Li wrote:
> On Tue, 1 Feb 2022 at 20:11, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 1/25/22 13:08, Wanpeng Li wrote:
>>> As commit 0c5f81dad46 (KVM: LAPIC: Inject timer interrupt via posted interrupt)
>>> mentioned that the host admin should well tune the guest setup, so that vCPUs
>>> are placed on isolated pCPUs, and with several pCPUs surplus for*busy*  housekeeping.
>>> It is better to disable mwait/hlt/pause vmexits to keep the vCPUs in non-root
>>> mode. However, we may isolate pCPUs for other purpose like DPDK or we can make
>>> some guests isolated and others not, we may lose vmx preemption timer/timer fastpath
>>> due to not well tuned setup, and the checking in kvm_can_post_timer_interrupt()
>>> is not enough. Let's guarantee mwait/hlt is advertised before enabling posted-interrupt
>>> interrupt. vmx preemption timer/timer fastpath can continue to work if both of them
>>> are not advertised.
>>
>> Is this the same thing that you meant?
>>
>> --------
>> As commit 0c5f81dad46 ("KVM: LAPIC: Inject timer interrupt via posted interrupt")
>> mentioned that the host admin should well tune the guest setup, so that vCPUs
>> are placed on isolated pCPUs, and with several pCPUs surplus for *busy* housekeeping.
>> In this setup, it is preferrable to disable mwait/hlt/pause vmexits to
>> keep the vCPUs in non-root mode.
>>
>> However, if only some guests isolated and others not, they would not have
>> any benefit from posted timer interrupts, and at the same time lose
>> VMX preemption timer fast paths because kvm_can_post_timer_interrupt()
>> returns true and therefore forces kvm_can_use_hv_timer() to false.
>>
>> By guaranteeing that posted-interrupt timer is only used if MWAIT or HLT
>> are done without vmexit, KVM can make a better choice and use the
>> VMX preemption timer and the corresponding fast paths.
>> --------
> 
> Looks better, thanks Paolo! :)

Queued then, thanks!

Paolo

