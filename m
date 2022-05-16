Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D645290BA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 22:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349974AbiEPUjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 16:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347227AbiEPUMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 16:12:40 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAAE1180A
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 13:05:56 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n18so15490933plg.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 13:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V0FTGzMJBgyREqhxX8R65mAMakAJSuzxyomCAV6mgLc=;
        b=SSzpkrzoHGzfaphBfgfEmNpvaSX+MugKbN6DbDP1EsOcaJ8wLG8aqjVoWEQHgIlmh/
         NdFXDVSyhLg6TlGxSTu9LxYWpmPUPhNSrUgt7DZdL19+bfoaX1zmMDlt4UuHwK+JF4kC
         iIeTYHtCHYH3+KL/KOn343UgU1cBy/wr21vLoJ2T+eEfbc9Dwc1jYgQ0O/O/rlIiUNFJ
         UGcmJE2vl46RnTeV4GzEMW7TfhL23dctpd15mQMJdkHJ80Fv7sRNFw5SolNIRTjPVhle
         exq7xjRyljp820JflaXAvMp96Vj+IILsbFSS6xSOHK1BW5W3NihRdkvIYBUT6ZOej/J3
         Amvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V0FTGzMJBgyREqhxX8R65mAMakAJSuzxyomCAV6mgLc=;
        b=Po7BhCMntuYZwz7NBN0EMFcVxfBqiK0Qru3PUSTxjVczrvp9wyoGw8bnkxBH34Rj5F
         ci4JygKnw3esqwLDc+bF2TZM4rCnuxKd/UzNHYGTC1sLctKQQ4JxxXUBwHuDFUqFKzi6
         RX4e8xz63RtqsXaS6y5XUmuWJlEN26uuHsuM9ShsP4WsS1ooCrQtbpjoG6/xYOGYhIqf
         6/XpCiVKHp1tFGfYyWaVTH+qNTzzTkY02oCpU1AhiV9wlTW+I7hQEqWw7pWs8aVgPtxx
         j/aAAzOXSE2lKs0IQPwRRz535WxjUSGx2WmQGM/nk8H1e8+oTDrWVZ2iLk+rSrIN9QJD
         FR2w==
X-Gm-Message-State: AOAM5329jJzyvrdZBu5Rs1lmtpfiBlRANvQH6q6yrkTdgGpvHHeKjDm7
        RIPQjfXVBpDkc8U5Ta2UKQHFuA==
X-Google-Smtp-Source: ABdhPJwX1CuKym2vhkwKheHNZIwLKfvS20yrckaBa15rLs63cRodMdN8IvrD+yQdEkpAS2o2yBLveQ==
X-Received: by 2002:a17:902:ba8c:b0:161:5ad4:1800 with SMTP id k12-20020a170902ba8c00b001615ad41800mr11177867pls.9.1652731553787;
        Mon, 16 May 2022 13:05:53 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id b12-20020a170902650c00b0015e8d4eb268sm7406140plk.178.2022.05.16.13.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 13:05:53 -0700 (PDT)
Date:   Mon, 16 May 2022 20:05:49 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/34] KVM: x86: hyper-v: Use preallocated buffer in
 'struct kvm_vcpu_hv' instead of on-stack 'sparse_banks'
Message-ID: <YoKunaNKDjYx7C21@google.com>
References: <20220414132013.1588929-1-vkuznets@redhat.com>
 <20220414132013.1588929-12-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414132013.1588929-12-vkuznets@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022, Vitaly Kuznetsov wrote:
> To make kvm_hv_flush_tlb() ready to handle L2 TLB flush requests, KVM needs
> to allow for all 64 sparse vCPU banks regardless of KVM_MAX_VCPUs as L1
> may use vCPU overcommit for L2. To avoid growing on-stack allocation, make
> 'sparse_banks' part of per-vCPU 'struct kvm_vcpu_hv' which is allocated
> dynamically.
> 
> Note: sparse_set_to_vcpu_mask() keeps using on-stack allocation as it
> won't be used to handle L2 TLB flush requests.

I think it's worth using stronger language; handling TLB flushes for L2 _can't_
use sparse_set_to_vcpu_mask() because KVM has no idea how to translate an L2
vCPU index to an L1 vCPU.  I found the above mildly confusing because it didn't
call out "vp_bitmap" and so I assumed the note referred to yet another sparse_banks
"allocation".  And while vp_bitmap is related to sparse_banks, it tracks something
entirely different.

Something like?

Note: sparse_set_to_vcpu_mask() can never be used to handle L2 requests as
KVM can't translate L2 vCPU indices to L1 vCPUs, i.e. its vp_bitmap array
is still bounded by the number of L1 vCPUs and so can remain an on-stack
allocation.

> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 3 +++
>  arch/x86/kvm/hyperv.c           | 6 ++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 058061621872..837c07e213de 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -619,6 +619,9 @@ struct kvm_vcpu_hv {
>  	} cpuid_cache;
>  
>  	struct kvm_vcpu_hv_tlb_flush_ring tlb_flush_ring[HV_NR_TLB_FLUSH_RINGS];
> +
> +	/* Preallocated buffer for handling hypercalls passing sparse vCPU set */
> +	u64 sparse_banks[64];

Shouldn't this be HV_MAX_SPARSE_VCPU_BANKS?
