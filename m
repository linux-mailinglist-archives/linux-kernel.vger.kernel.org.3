Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8758452A3DA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348084AbiEQNvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347768AbiEQNva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:51:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACCD426108
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652795487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DI+2TLyotaAB4m8Wk/Jy92LMvHUEqA+a9jwjfCWo8vE=;
        b=FmCca7dxnqMzFSaVZKJAvLEfynx6KuMhmfIPEBsM7X2lqFY4TD7Ux/TbWoeGqwlDl41nti
        E+IoR0cNIqOAoGXWTMJ58jZPjGKxzM+/HpUsgywdNFn9aqSOQgiAB/dFDt6tSbsN1y+2CS
        N0uzaeyQZObM0DpMQ4jeS0OhjfwlHcY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-4hwiblWhONy1fs9Q56W_ig-1; Tue, 17 May 2022 09:51:18 -0400
X-MC-Unique: 4hwiblWhONy1fs9Q56W_ig-1
Received: by mail-wm1-f70.google.com with SMTP id n26-20020a1c721a000000b003941ea1ced7so975984wmc.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=DI+2TLyotaAB4m8Wk/Jy92LMvHUEqA+a9jwjfCWo8vE=;
        b=5FDz4NFRrVAsBOJP7A1OAEMLY9islgU3KkbK41gX4KvIkQ0CGujmu6rccqObbsYvDN
         TTGhYv/PC75lpAbgTOI306TI20A2e0jZ6VUbSFp7GAXM6W2xncYb1Jq+eWpucv2kRmwF
         Dd079HkrGDQwJQknpLrnTER5aUJ9hjV838eF1nqwqhZc9Ue2l9EhIajqjdrwDz6DUMok
         fgcBmE1xAnCkzNb4xodIZwazLDUt0VP1bqQc2JeYqFdVa4bmBE7+o8MmIvkFwtbU+zT+
         4JR87YsSL5EPWU67C5aF57rzPr5pb7Rs10rM0b6wH3WI2lpl0y5ZNm+atwDkouaT33eM
         YWVQ==
X-Gm-Message-State: AOAM53328wJhcx74lBT7pG7Q5SmysovivsNP1vPNKvE8+FU+LDKoqUYQ
        XU0EdOCBfZSzvEs9QVU51uur4Tka6unemTpLxNd8GgkNEpIY8KxHVZkTiBxLqDUBZISzIB1CFkJ
        q5ftiXnTvJ6WObNN547xk0Q75yYbzhgPNolj7hYB5RD37AdjIrzQ0XHLehQmN9MclGbv4BpBkqR
        fm
X-Received: by 2002:a5d:595f:0:b0:20d:97d:4d14 with SMTP id e31-20020a5d595f000000b0020d097d4d14mr8262074wri.549.1652795477361;
        Tue, 17 May 2022 06:51:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGzb/41GwD8L8W8DX4aDq6yMVVszSErv2Y5yTV9eLtgY7MvadoakIwpfSvObshosUucUtTEA==
X-Received: by 2002:a5d:595f:0:b0:20d:97d:4d14 with SMTP id e31-20020a5d595f000000b0020d097d4d14mr8262048wri.549.1652795477119;
        Tue, 17 May 2022 06:51:17 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id o16-20020adf8b90000000b0020c5253d8e0sm12819325wra.44.2022.05.17.06.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 06:51:16 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/34] KVM: x86: hyper-v: Use preallocated buffer in
 'struct kvm_vcpu_hv' instead of on-stack 'sparse_banks'
In-Reply-To: <YoKunaNKDjYx7C21@google.com>
References: <20220414132013.1588929-1-vkuznets@redhat.com>
 <20220414132013.1588929-12-vkuznets@redhat.com>
 <YoKunaNKDjYx7C21@google.com>
Date:   Tue, 17 May 2022 15:51:15 +0200
Message-ID: <87k0akuv1o.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Apr 14, 2022, Vitaly Kuznetsov wrote:
>> To make kvm_hv_flush_tlb() ready to handle L2 TLB flush requests, KVM needs
>> to allow for all 64 sparse vCPU banks regardless of KVM_MAX_VCPUs as L1
>> may use vCPU overcommit for L2. To avoid growing on-stack allocation, make
>> 'sparse_banks' part of per-vCPU 'struct kvm_vcpu_hv' which is allocated
>> dynamically.
>> 
>> Note: sparse_set_to_vcpu_mask() keeps using on-stack allocation as it
>> won't be used to handle L2 TLB flush requests.
>
> I think it's worth using stronger language; handling TLB flushes for L2 _can't_
> use sparse_set_to_vcpu_mask() because KVM has no idea how to translate an L2
> vCPU index to an L1 vCPU.  I found the above mildly confusing because it didn't
> call out "vp_bitmap" and so I assumed the note referred to yet another sparse_banks
> "allocation".  And while vp_bitmap is related to sparse_banks, it tracks something
> entirely different.
>
> Something like?
>
> Note: sparse_set_to_vcpu_mask() can never be used to handle L2 requests as
> KVM can't translate L2 vCPU indices to L1 vCPUs, i.e. its vp_bitmap array
> is still bounded by the number of L1 vCPUs and so can remain an on-stack
> allocation.

My brain is probably tainted by looking at all this for some time so I
really appreciate such improvements, thanks :)

I wouldn't, however, say "never" ('never say never' :-)): KVM could've
kept 2-level reverse mapping up-to-date:

KVM -> L2 VM list -> L2 vCPU ids -> L1 vCPUs which run them

making it possible for KVM to quickly translate between L2 VP IDs and L1
vCPUs. I don't do this in the series and just record L2 VM_ID/VP_ID for
each L1 vCPU so I have to go over them all for each request. The
optimization is, however, possible and we may get to it if really big
Windows VMs become a reality.

>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/include/asm/kvm_host.h | 3 +++
>>  arch/x86/kvm/hyperv.c           | 6 ++++--
>>  2 files changed, 7 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index 058061621872..837c07e213de 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -619,6 +619,9 @@ struct kvm_vcpu_hv {
>>  	} cpuid_cache;
>>  
>>  	struct kvm_vcpu_hv_tlb_flush_ring tlb_flush_ring[HV_NR_TLB_FLUSH_RINGS];
>> +
>> +	/* Preallocated buffer for handling hypercalls passing sparse vCPU set */
>> +	u64 sparse_banks[64];
>
> Shouldn't this be HV_MAX_SPARSE_VCPU_BANKS?
>

It certainly should, thanks!

-- 
Vitaly

