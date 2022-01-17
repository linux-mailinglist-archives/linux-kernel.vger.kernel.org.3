Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77420490711
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 12:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbiAQLUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 06:20:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35480 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236242AbiAQLUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 06:20:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642418436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CSwkkcPBH4uW8wbUBd+sfq/hcSR5RMC3A5g8KIsw41c=;
        b=EpdiRhOhnxIuBPclMGvTrlYqI0bBMY24eHKJg4GLDFSIzCDTyNzTCfcV+UK+yYAdEtS8iM
        5S91OMh36ONtKEbi3t29c48ejEBfcyxA+vHdCnByLNvYMEw4B9Mx7mTb7TrNtTZfZKnh1C
        HHp/so0azF0FsNy7TEEGH+qTX9UNM44=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-pWjKIfePN1SrhIm2PZS7YQ-1; Mon, 17 Jan 2022 06:20:35 -0500
X-MC-Unique: pWjKIfePN1SrhIm2PZS7YQ-1
Received: by mail-wm1-f70.google.com with SMTP id k36-20020a05600c1ca400b0034aeea679a5so3962315wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 03:20:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CSwkkcPBH4uW8wbUBd+sfq/hcSR5RMC3A5g8KIsw41c=;
        b=zIE7ehBcd6ACbaA8CT3OuWwDnLqwSOZCxnIlgSP7i8rOLENKBn8so7ybWMzUWDDysL
         ELd4gBf3nyLIOa368E/B0xaJMZTecWZMNezxDF2Y+BM4C/OrripaE19lqPCCL2ITtzIG
         QuOFR+CWTIRf+vxuYhxIDUWTufAB4GkbijZAEAKb3Wxd1QaGZ0RtciWNlraKZEntCAaP
         BBYpE8bXv3Lmy4vu5GwJkjuKzNUUhWXzEQ6IWN1OoQ9X1xv5hkujJtRaN8CHjsjccOtX
         nkVlAaoRxnMRiUgpOh1x8CpDUX3E59IKOSM7WDFrRDvl/rY9FHNDQSICjTCv+JCwN0TB
         lDMQ==
X-Gm-Message-State: AOAM532u5qPg8BNRipHgYOVlfs+2MseFWjgqLPlJaqoaHcrKSMGJtMDH
        d9wsfj8z/B3Y6CUiScrdRcoF+2kdEdCYOWfP81Zewc5/uaMxOfgoCZKyMOrejO/RHQj5aPIED+B
        oL4Rc24ccBM4nwRNj6AcDX/yw
X-Received: by 2002:a7b:c40c:: with SMTP id k12mr20014553wmi.185.1642418434439;
        Mon, 17 Jan 2022 03:20:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwJBRfrzBWxBqWuCdx7trdwRGWYNdZTP5PcXzny7OgW1OgDE8/6v4EIiV29TTbWPniTmzekeg==
X-Received: by 2002:a7b:c40c:: with SMTP id k12mr20014529wmi.185.1642418434192;
        Mon, 17 Jan 2022 03:20:34 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id i10sm17358719wmq.45.2022.01.17.03.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 03:20:33 -0800 (PST)
Message-ID: <517e8b95-e336-8796-6657-c0f8d554143a@redhat.com>
Date:   Mon, 17 Jan 2022 12:20:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] KVM: x86: Forbid KVM_SET_CPUID{,2} after KVM_RUN
Content-Language: en-US
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Igor Mammedov <imammedo@redhat.com>, kvm@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
References: <16368a89-99ea-e52c-47b6-bd006933ec1f@redhat.com>
 <20211227183253.45a03ca2@redhat.com>
 <61325b2b-dc93-5db2-2d0a-dd0900d947f2@redhat.com> <87mtkdqm7m.fsf@redhat.com>
 <20220103104057.4dcf7948@redhat.com> <YeCowpPBEHC6GJ59@google.com>
 <20220114095535.0f498707@redhat.com> <87ilummznd.fsf@redhat.com>
 <20220114122237.54fa8c91@redhat.com> <87ee5amrmh.fsf@redhat.com>
 <YeGsKslt7hbhQZPk@google.com> <8735lmn0t1.fsf@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <8735lmn0t1.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/22 10:55, Vitaly Kuznetsov wrote:
> No, honestly I was thinking about something much simpler: instead of
> forbidding KVM_SET_CPUID{,2} after KVM_RUN completely (what we have now
> in 5.16), we only forbid to change certain data which we know breaks
> some assumptions in MMU, from the comment:
> "
>           * KVM does not correctly handle changing guest CPUID after KVM_RUN, as
>           * MAXPHYADDR, GBPAGES support, AMD reserved bit behavior, etc.. aren't
>           * tracked in kvm_mmu_page_role.  As a result, KVM may miss guest page
>           * faults due to reusing SPs/SPTEs.
> "
> It seems that CPU hotplug path doesn't need to change these so we don't
> need an opt-in/opt-out, we can just forbid changing certain things for
> the time being. Alternatively, we can silently ignore such changes but I
> don't quite like it because it would mask bugs in VMMs.

I think the version that only allows exactly the same CPUID is the best, 
as it leaves less room for future bugs.

Paolo

