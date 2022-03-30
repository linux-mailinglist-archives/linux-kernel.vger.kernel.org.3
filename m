Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3054C4EB758
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 02:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241408AbiC3AIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 20:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241383AbiC3AIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 20:08:50 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F75643496
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 17:07:06 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id t2so17301980pfj.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 17:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y2rRhw4flc97ksCHOd8D6zj8TKfoieAVBtd70rXcpQs=;
        b=o9HHTHEYnmATJjpdZ+6at7qnwRTprPUxz44HrTkQVZVnCOrEgYVmZWSnp4gUPhisJv
         Rmiu/9OTD/qceAnczy4elXmZYfqCtOJj96eJQMuVW9Lc1lYOGiX8XPbzl8WSTIsAt0FI
         9afhf33i8d59GFe3+3rYaQygWjErHAhbVZIako5ZoRr5T0a8YW9Q16JqV/pxo4oBHHo/
         UEXCoV5RfVH/960ntKzVVEko47A4lLAAUFSwvWxPfrN0Y8SkBw/e1ZrQUnG2NqnubIrO
         RzIPQAd1lEWZL6FPCSVd745Vy6Zx7A2+ckbidrCyQzYqyMtumppulGgHbvCydajf90TS
         nKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y2rRhw4flc97ksCHOd8D6zj8TKfoieAVBtd70rXcpQs=;
        b=MWrUjrnnUjMrDrtYUamRRCWW6eQy58tmqJSe76dZlyNiTafZdhBqX1tEm///pGvuv8
         d05ByFflYEMgn7GH8kVuWzY8bjkIPLqjk50e8O74Q0kOc5K/bJzNMsnqbd/vPYLM+vaL
         6twn/HrgnllvyRLVBzY7zdy6ejmsOQC5Nq0M3DFeTQx+E7rSLKN9JZSeYgu91CV+rWnQ
         LPGbSwn1Ycn5IJo8LkI9aeTC+vM0+MrEnl86ccsjQpnIDfL0KrsmLcP+q/Cq6dU0n9Xv
         z/hx2cGZhg43buQ+HPNnoIID/8p0LA+0cfDoUasJHsGcONkgzxWrsDawy7M3FqbDX9By
         gz9g==
X-Gm-Message-State: AOAM530WVYhgO40UrJ4rzVCZyZ+23F2evvH6q95oPAMSxUIE6pOSe79r
        EamguYSBoFLJL6RMWzcr22e5irUEbiGuEQ==
X-Google-Smtp-Source: ABdhPJxUppfMa3o7A5xAfew/ErKXOffjoVHzpxNp8qP8IaCknbYo1DmmtfVP+XIrltUTJl/gsv4W0g==
X-Received: by 2002:a63:dd47:0:b0:381:2bb3:86ba with SMTP id g7-20020a63dd47000000b003812bb386bamr3899371pgj.381.1648598825402;
        Tue, 29 Mar 2022 17:07:05 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id f20-20020a056a00229400b004fb16860af6sm17208497pfe.195.2022.03.29.17.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 17:07:04 -0700 (PDT)
Date:   Wed, 30 Mar 2022 00:07:01 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH RESEND 3/5] KVM: X86: Boost vCPU which is in critical
 section
Message-ID: <YkOfJeXm8MiMOEyh@google.com>
References: <1648216709-44755-1-git-send-email-wanpengli@tencent.com>
 <1648216709-44755-4-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648216709-44755-4-git-send-email-wanpengli@tencent.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022, Wanpeng Li wrote:
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 425fd7f38fa9..6b300496bbd0 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10375,6 +10375,28 @@ static int vcpu_run(struct kvm_vcpu *vcpu)
>  	return r;
>  }
>  
> +static int kvm_vcpu_non_preemptable(struct kvm_vcpu *vcpu)

s/preemtable/preemptible

And I'd recommend inverting the return, and also return a bool, i.e.

static bool kvm_vcpu_is_preemptible(struct kvm_vcpu *vcpu)

> +{
> +	int count;
> +
> +	if (!vcpu->arch.pv_pc.preempt_count_enabled)
> +		return 0;
> +
> +	if (!kvm_read_guest_cached(vcpu->kvm, &vcpu->arch.pv_pc.preempt_count_cache,
> +	    &count, sizeof(int)))
> +		return (count & ~PREEMPT_NEED_RESCHED);

This cements PREEMPT_NEED_RESCHED into KVM's guest/host ABI.  I doubt the sched
folks will be happy with that.

> +
> +	return 0;
> +}
> +
