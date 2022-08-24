Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9C05A043A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 00:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiHXWmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 18:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiHXWmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 18:42:44 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D2F7FF9E
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 15:42:44 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 67so9705568pfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 15:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=qUzHVbVr2MZ+fXii+ezCtPP4i7g/WAnNmigYKg+BHJU=;
        b=rBtBR6Nk9gwa4/Is7ZiDycoR7zbtgYjUx7LvKf4LEY/bFyg+MsMaBTmK/BRM6CH89d
         VLTmhGScLHw+GkTV/kW5rrMdk19ejQuosW6urBu3zM7AAj7Q4+qzKKPaWBvPfVYt8uId
         LfVvz5nL/DqmBvCF1bH5uKrj1d6Xe4AkbF/j4IXYTFxGOoGTsibFEuCei/XgbiP5ggo6
         VlrdIQowTN6XRUd9ItIq7WGxW/5So/vMsGquE6LjNnMFLNLkjIBO9iwGCKjyTIjcUXmL
         G1/6Q/j+Ac7HE8Zzeg2oASg3MeF2+CtgcFLiR2oGqnIcJIL6L+luZTJX6X1iAmf4A83G
         qP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=qUzHVbVr2MZ+fXii+ezCtPP4i7g/WAnNmigYKg+BHJU=;
        b=2zyMNGA73Xm0IP9ttOW/pXQ4u5nxJRTjRPOsVRSvXGrbwIKN87jjf9Pbc3538E+xc0
         FyTlKxFxFQ5SMExmUS1S0bsNyuBTKEdEu0vH9RzIO8s2eRf/ZJ4BgTFDFab5H7pfTs5i
         9K9iWM8VUVTX1veOcdto5Eq5n7jk+Qh+zMLy+5dtwUJt76InQ0jYQ6Oot7hdxA27caHi
         bRJKNiwAAP7wQoXnJzHkUWZm+A2QisZS283+b6NPsoM+zmkKwvWhPlicBlocFev5U3LV
         l3TF9EsbNEhhkf7DE+YoRoJ59q7IEhEgq6xVMBCS/gOplRKwvj6woIR6VyiWZt0ijhwS
         yCbg==
X-Gm-Message-State: ACgBeo17mqmMzXunRxzrr/Ks+1oBn3tDRo3Tv9a+P9kKKuUTZ1ztGaA2
        VRJUaKHDa7RvKTRiBbSQ+uV0nQ==
X-Google-Smtp-Source: AA6agR4qlDyk9utv1/W1ih12a2ghsZID1CeoBMUWOHrW8N/mljBy83ej70E+DAfNxHbP4Whglk5KHw==
X-Received: by 2002:a63:2a02:0:b0:42b:3b16:5759 with SMTP id q2-20020a632a02000000b0042b3b165759mr829605pgq.564.1661380963491;
        Wed, 24 Aug 2022 15:42:43 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id i17-20020a17090332d100b00172ff99d0afsm4459981plr.140.2022.08.24.15.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 15:42:42 -0700 (PDT)
Date:   Wed, 24 Aug 2022 22:42:39 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Jim Mattson <jmattson@google.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 11/13] KVM: x86: SVM: use smram structs
Message-ID: <YwapX2HFpUGbxBZJ@google.com>
References: <20220803155011.43721-1-mlevitsk@redhat.com>
 <20220803155011.43721-12-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803155011.43721-12-mlevitsk@redhat.com>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022, Maxim Levitsky wrote:
> @@ -4486,28 +4482,23 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
>  {
>  	struct vcpu_svm *svm = to_svm(vcpu);
>  	struct kvm_host_map map, map_save;
> -	u64 saved_efer, vmcb12_gpa;
>  	struct vmcb *vmcb12;
>  	int ret;
>  
> -	const char *smstate = (const char *)smram;

To shorten line lengths, what about grabbing smram64 here?

	const kvm_smram_state_64 *smram64 = &smram->smram64;

IMO, makes things a little easier to read too.

> -
>  	if (!guest_cpuid_has(vcpu, X86_FEATURE_LM))
>  		return 0;
>  
>  	/* Non-zero if SMI arrived while vCPU was in guest mode. */
> -	if (!GET_SMSTATE(u64, smstate, 0x7ed8))
> +	if (!smram->smram64.svm_guest_flag)
>  		return 0;
>  
>  	if (!guest_cpuid_has(vcpu, X86_FEATURE_SVM))
>  		return 1;
>  
> -	saved_efer = GET_SMSTATE(u64, smstate, 0x7ed0);
> -	if (!(saved_efer & EFER_SVME))
> +	if (!(smram->smram64.efer & EFER_SVME))
>  		return 1;
>  
> -	vmcb12_gpa = GET_SMSTATE(u64, smstate, 0x7ee0);
> -	if (kvm_vcpu_map(vcpu, gpa_to_gfn(vmcb12_gpa), &map) == -EINVAL)
> +	if (kvm_vcpu_map(vcpu, gpa_to_gfn(smram->smram64.svm_guest_vmcb_gpa), &map) == -EINVAL)

Eww, this is horrifically wrong.  KVM will explode if kvm_vcpu_map() returns
-EFAULT, e.g. if guest memory is not backed by struct page and memremap() fails.
Not to mention that it's comically fragile too.

Can you add a patch to this series to drop the "== -EINVAL"?

And there's another one lurking just out of sight in this diff.

>  		return 1;
>  
>  	ret = 1;
> @@ -4533,7 +4524,7 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
>  	vmcb12 = map.hva;
>  	nested_copy_vmcb_control_to_cache(svm, &vmcb12->control);
>  	nested_copy_vmcb_save_to_cache(svm, &vmcb12->save);
> -	ret = enter_svm_guest_mode(vcpu, vmcb12_gpa, vmcb12, false);
> +	ret = enter_svm_guest_mode(vcpu, smram->smram64.svm_guest_vmcb_gpa, vmcb12, false);
>  
>  	if (ret)
>  		goto unmap_save;
> -- 
> 2.26.3
> 
