Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18974F8696
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346614AbiDGRuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346587AbiDGRuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:50:54 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3D622EB21
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:48:54 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y10so6111286pfa.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 10:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FQPnRvfQpxKy8a4hkHWSvx2boAG1Tq4/Z1flY88bDVQ=;
        b=Kx0G6+6KmESb5d/rIYTwll+83oYkLSmNmW51wZe5STLuffxhnOIXcFU4pk+WtNTRcO
         2xQKnfmPrOG/s6hAQ+9tiYBxJoHJWarYBQ0E4j2MoXZ/pkafM2Ljdo76T8mKILbFO7LV
         f5dJFxdlFc2ih9kmoFe2Ua46MsDNeDIGRdXwq7qMC+UyC9BGzLU/wrLzYAVxOGDCKc2c
         qJBWwcqSVxwSkq9D6qb4GzAIsTxv9crYN/0AAlgik3QvvhyVhcmAagyUgF9XMtTNnd8a
         +G4pMjVXpq1BiELKMgLZIq2ZxzZiR9uTjWEylui8vWDisFWjIEPzzLu2EsROGcNknRyh
         febg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FQPnRvfQpxKy8a4hkHWSvx2boAG1Tq4/Z1flY88bDVQ=;
        b=GJWzLFheMBklYsAFNB3+h2k1SujJszTCjmIAy2jp18V5LatC9nau7S8lXRIDMJoh4e
         hiEXB54OlTZxP208RsV2D8eLM8lWWXw/K+aFamFN2f0PXsd/iBeGwdFRomK3vCoAi1Sv
         pLkYqa3sAVQtUsLi+FAziiH/eW44mlgGCyiBkKYsxxnst/UoW6hz7MK7hi1f8+0J3TSC
         YBJPqjioXGJCphnsFecJf1emiGy5ADkT9ZW+0xCn6dF4g/vnOQCdX8gXBLJPH/3wyJcg
         zBNfeNvmrA7wCRplnzPZsEz4yU0qEspH8fu14jRKY3Ugg1hzo5C5OK5qM8LtB+004uao
         ig4Q==
X-Gm-Message-State: AOAM532gvJnOolWhiBz8X6EKEi2Rc9N8iLMLqCqIeFjkBKsUs1dzUoCX
        +GxgIIGWQpf4ut2urehiSJBbng==
X-Google-Smtp-Source: ABdhPJw8WinGRgHOM5heftTI2tbEASHa4CAYJ0Gd8CceJAeot8qIksnXkcmRxTFrGkBmgym3TNR0Hw==
X-Received: by 2002:a63:3fc4:0:b0:380:c8be:38d9 with SMTP id m187-20020a633fc4000000b00380c8be38d9mr12209654pga.566.1649353718335;
        Thu, 07 Apr 2022 10:48:38 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id i7-20020a628707000000b004fa6eb33b02sm22951425pfe.49.2022.04.07.10.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 10:48:37 -0700 (PDT)
Date:   Thu, 7 Apr 2022 17:48:34 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/31] KVM: x86: hyper-v: Don't use
 sparse_set_to_vcpu_mask() in kvm_hv_send_ipi()
Message-ID: <Yk8j8pTnnFMymyds@google.com>
References: <20220407155645.940890-1-vkuznets@redhat.com>
 <20220407155645.940890-7-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407155645.940890-7-vkuznets@redhat.com>
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

On Thu, Apr 07, 2022, Vitaly Kuznetsov wrote:
> Get rid of on-stack allocation of vcpu_mask and optimize kvm_hv_send_ipi()
> for a smaller number of vCPUs in the request. When Hyper-V TLB flush
> is in  use, HvSendSyntheticClusterIpi{,Ex} calls are not commonly used to
> send IPIs to a large number of vCPUs (and are rarely used in general).
> 
> Introduce hv_is_vp_in_sparse_set() to directly check if the specified
> VP_ID is present in sparse vCPU set.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/hyperv.c | 35 ++++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index d7bcdf87b90c..918642bcdbd0 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -1746,6 +1746,23 @@ static void sparse_set_to_vcpu_mask(struct kvm *kvm, u64 *sparse_banks,
>  	}
>  }
>  
> +static bool hv_is_vp_in_sparse_set(u32 vp_id, u64 valid_bank_mask, u64 sparse_banks[])
> +{
> +	int bank, sbank = 0;
> +
> +	if (!test_bit(vp_id / 64, (unsigned long *)&valid_bank_mask))

'64' really, really, really needs a #define.  I assume this is the same '64' that's
used to check the var_cnt when getting the sparse_banks.

> +		return false;
> +
> +	for_each_set_bit(bank, (unsigned long *)&valid_bank_mask,
> +			 KVM_HV_MAX_SPARSE_VCPU_SET_BITS) {
> +		if (bank == vp_id / 64)
> +			break;
> +		sbank++;
> +	}
> +
> +	return test_bit(vp_id % 64, (unsigned long *)&sparse_banks[sbank]);
> +}
