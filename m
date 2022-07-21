Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D96357C1B9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 02:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiGUApt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 20:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiGUAps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 20:45:48 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D89B86F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 17:45:47 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id h132so177489pgc.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 17:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DzgINBTk+IPGI+PfhGtwC4cWcROmUsPhDG+JRiaEHx0=;
        b=E8CnPUqb0Muy+A6k7dU+TQ6JCyAjkKaRor/iMc3FeGIZqFQOC8Tf4JkYur3iUSv/AO
         IJjRNo59J1ldqRvBn1gA2bSKRprs1AkmTqEWpMOoOWpdkEeqo1Hv3Y7ZB5t+L4DhDcQg
         g8NA/CyjdlhqvmWpt/RT+8phWpFsagm6RN7YR4EG5GosMmglLERlfUAKqPui78QTOG7Q
         YJsg4EzkOBIpEcUZvoVHkwYIWWV8kd8xSHjDWyQlnO1pKgqCEMlEw3urrS/O8j1thrjc
         uz1o9MwdAw9BL1yGjDMFD2sofetxJdHQwFsFcAuM73O9s42Y+xkzOqYj+eJvCVOdSt/C
         N7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DzgINBTk+IPGI+PfhGtwC4cWcROmUsPhDG+JRiaEHx0=;
        b=0UsKDbLoPcqcs6WledOUC6NCr3fukkps1Vc1lhXohptNr5Eysc9tY3IgZ0ku5scnIC
         5t4FNS2kQd9/cSMcw1YV4HnCsr+WaNAAr1q6p1mddRLuS0pQYUiDbfWogydgY/CrGQcu
         WrLqnigf7Uxj9+onft6rnMryPkKGsuIALw1n0VSGurN3wyS7KokmcdFQ9xWUt+sFN8fT
         Wqxs90au6rM5Pm6zq3KVUiLcP9X5d1WTu2vaSmbH2Xh6ZsDn+JH/UWZUrtD1xQJOJnFB
         xwAFI4fj21aADqo8lzDEMxzWf8zxyi2exFFwrKI18/fOxImtNNhS/RL7cvfze+T6kYSB
         D5Qw==
X-Gm-Message-State: AJIora/1lJEwDpJncGfaRL/2GYrs4jSx92U0bGJmIfDXCXFmEEsRiTc/
        0DeRfOcyjLmgN8DmA+wwxPqzXw==
X-Google-Smtp-Source: AGRyM1t95yJjIPVkVFatyXpqXfbdvoqlgTK2evvm5rjbSx3FZWCSRNJX7Mk8kkbMnCWe60yPKln02Q==
X-Received: by 2002:a05:6a00:1d18:b0:52a:c350:6538 with SMTP id a24-20020a056a001d1800b0052ac3506538mr42498478pfx.7.1658364346891;
        Wed, 20 Jul 2022 17:45:46 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id i11-20020a63e44b000000b00401a9bc0f33sm93762pgk.85.2022.07.20.17.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 17:45:46 -0700 (PDT)
Date:   Thu, 21 Jul 2022 00:45:42 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Like Xu <likexu@tencent.com>
Subject: Re: [PATCH 3/7] KVM: x86/pmu: Avoid setting BIT_ULL(-1) to
 pmu->host_cross_mapped_mask
Message-ID: <YtihtuxO/uefpAqJ@google.com>
References: <20220713122507.29236-1-likexu@tencent.com>
 <20220713122507.29236-4-likexu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713122507.29236-4-likexu@tencent.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> In the extreme case of host counters multiplexing and contention, the
> perf_event requested by the guest's pebs counter is not allocated to any
> actual physical counter, in which case hw.idx is bookkept as -1,
> resulting in an out-of-bounds access to host_cross_mapped_mask.
> 
> Fixes: 854250329c02 ("KVM: x86/pmu: Disable guest PEBS temporarily in two rare situations")
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
>  arch/x86/kvm/vmx/pmu_intel.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 53ccba896e77..1588627974fa 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -783,20 +783,19 @@ static void intel_pmu_cleanup(struct kvm_vcpu *vcpu)
>  void intel_pmu_cross_mapped_check(struct kvm_pmu *pmu)
>  {
>  	struct kvm_pmc *pmc = NULL;
> -	int bit;
> +	int bit, hw_idx;
>  
>  	for_each_set_bit(bit, (unsigned long *)&pmu->global_ctrl,
>  			 X86_PMC_IDX_MAX) {
>  		pmc = intel_pmc_idx_to_pmc(pmu, bit);
>  
>  		if (!pmc || !pmc_speculative_in_use(pmc) ||
> -		    !intel_pmc_is_enabled(pmc))
> +		    !intel_pmc_is_enabled(pmc) || !pmc->perf_event)
>  			continue;
>  
> -		if (pmc->perf_event && pmc->idx != pmc->perf_event->hw.idx) {
> -			pmu->host_cross_mapped_mask |=
> -				BIT_ULL(pmc->perf_event->hw.idx);
> -		}
> +		hw_idx = pmc->perf_event->hw.idx;
> +		if (hw_idx != pmc->idx && hw_idx != -1)

How about "hw_idx > 0" so that KVM is a little less dependent on perf's exact
behavior?  A comment here would be nice too.

> +			pmu->host_cross_mapped_mask |= BIT_ULL(hw_idx);
>  	}
>  }
>  
> -- 
> 2.37.0
> 
