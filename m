Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAD654E5E7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377619AbiFPPVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiFPPVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:21:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64276377D6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655392899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=06juFOw2FxSYc+BHU/Wl3gl3OUWvf0N50iDPfaEDM38=;
        b=i/VAlUYd5GcuXFyinoEdkIyJVwus8/u9a3loVg9IxZzPv/bRefuiBBL4MhVdLrvA15oCK3
        3kckEYl5KoKukDVtE1VnQgUNxp90sNaD02s0/k09aubXLTSirhX21QIXpXKIbLOfOyRbhD
        U9Wx8hYv90ngbnqwYYUS0snZ/yKij2w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-vIoQMoJIM9av38uCzEDoFg-1; Thu, 16 Jun 2022 11:21:30 -0400
X-MC-Unique: vIoQMoJIM9av38uCzEDoFg-1
Received: by mail-ed1-f72.google.com with SMTP id m5-20020a056402430500b004319d8ba8afso1501293edc.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=06juFOw2FxSYc+BHU/Wl3gl3OUWvf0N50iDPfaEDM38=;
        b=Iklit5UQxTTnlLNF/qsEuntPTzPgnbO/70a8ckvjIiD1CapWxSd/ftEOoxwTtN7Phv
         Jl3IwHJ0zibTOhxygvLMKdZMUh53OIqJw11LwNOaYeVDy5LI9MtFrATH6tPgfPSLVC6U
         wziMm31UwGtwCsEWPTvLGskqyLTuQ8ki2/POHpq30+Cy/6Wm6g31eWm0F66LCQwBsptY
         W4UookfwNC5353aTVWzlkj2dSlfy39h913KQVgSdpwEQN9ZkPStoOhlVdrJvTErUUUJu
         kLzX/hvVJvUstkC6SuYcICY/rw+lSXC/1aWzhPyXeENQeFU2+IR+IIxsLfmIvwPEh80s
         QzKw==
X-Gm-Message-State: AJIora+zuiXvaufcZg5cA6n8StL3sk1M3/bXYQFrc4y+LWhA8sBP2S0I
        /JBmNLspNhVzRVVekH4geZF1xb5Nnuw5xj9Z/xEa710PvXU0SVx6cxILTBuQAqPRFEbSh2WA6CC
        uKc4gXUwd6fR4WInNFoxaCfCJ
X-Received: by 2002:a17:906:7053:b0:711:b90e:47b7 with SMTP id r19-20020a170906705300b00711b90e47b7mr4876476ejj.652.1655392889371;
        Thu, 16 Jun 2022 08:21:29 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1scUxIqI2Go1RYSFcOPPILRtIJCYm33+w4HHAK64jTkfDW6I9MnDnvZVmp1Mh1gVt+nVMKYPA==
X-Received: by 2002:a17:906:7053:b0:711:b90e:47b7 with SMTP id r19-20020a170906705300b00711b90e47b7mr4876460ejj.652.1655392889166;
        Thu, 16 Jun 2022 08:21:29 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id kz24-20020a17090777d800b00715a02874acsm911612ejc.35.2022.06.16.08.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 08:21:28 -0700 (PDT)
Message-ID: <99e7513a-af90-46ef-fb65-a9ffd0f925f9@redhat.com>
Date:   Thu, 16 Jun 2022 17:21:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 00/10] KVM: Clean up 'struct page' / pfn helpers
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220429010416.2788472-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220429010416.2788472-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/22 03:04, Sean Christopherson wrote:
> Clean up KVM's struct page / pfn helpers to reduce the number of
> pfn_to_page() and page_to_pfn() conversions.  E.g. kvm_release_pfn_dirty()
> makes 6 (if I counted right) calls to pfn_to_page() when releasing a dirty
> pfn that backed by a vanilla struct page.  That is easily trimmed down to
> a single call.
> 
> And perhaps more importantly, rename and refactor kvm_is_reserved_pfn() to
> try and better reflect what it actually queries, which at this point is
> effectively whether or not the pfn is backed by a refcounted page.
> 
> Sean Christopherson (10):
>    KVM: Do not zero initialize 'pfn' in hva_to_pfn()
>    KVM: Drop bogus "pfn != 0" guard from kvm_release_pfn()
>    KVM: Don't set Accessed/Dirty bits for ZERO_PAGE
>    KVM: Avoid pfn_to_page() and vice versa when releasing pages
>    KVM: nVMX: Use kvm_vcpu_map() to get/pin vmcs12's APIC-access page
>    KVM: Don't WARN if kvm_pfn_to_page() encounters a "reserved" pfn
>    KVM: Remove kvm_vcpu_gfn_to_page() and kvm_vcpu_gpa_to_page()
>    KVM: Take a 'struct page', not a pfn in kvm_is_zone_device_page()
>    KVM: Rename/refactor kvm_is_reserved_pfn() to
>      kvm_pfn_to_refcounted_page()
>    KVM: x86/mmu: Shove refcounted page dependency into
>      host_pfn_mapping_level()
> 
>   arch/x86/kvm/mmu/mmu.c     |  26 +++++--
>   arch/x86/kvm/mmu/tdp_mmu.c |   3 +-
>   arch/x86/kvm/vmx/nested.c  |  39 ++++-------
>   arch/x86/kvm/vmx/vmx.h     |   2 +-
>   include/linux/kvm_host.h   |  12 +---
>   virt/kvm/kvm_main.c        | 140 +++++++++++++++++++++++++------------
>   6 files changed, 131 insertions(+), 91 deletions(-)
> 
> 
> base-commit: 2a39d8b39bffdaf1a4223d0d22f07baee154c8f3

Queued, thanks.

Paolo

