Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DC3502CA3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350019AbiDOP2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355097AbiDOP1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:27:39 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB19D3AF4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:25:11 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id q3so7368484plg.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HSNkFlfPfBDbcR8sD587o294JAzA+6MXjR3ij3H7xVU=;
        b=Ry3JfCDJcrSM+jiPFBNRWrNAoC/cjyXh1Yqz5Z1K5L6ZkkYDRcx0LJ4KVVgIBE0iNZ
         ncgEWa2XwNWZ3CWaKNBCTUnMRgK5g+AqfUf1EzvNGv1vL5nEMNQM4++DUo+czOOR9J4o
         6+loWIeyvgXTsQ4JVOzYJhmSZ6HVaRienxIbHfox8CCF78Lz7xCOLER+z4fmOwRu5l0o
         kK67Kc6jdWgn4JvI2Xa6pJkzcaUi0FH0/xaamaGOzC8DR8uIWtV1DJEeU64dgoSZVQt8
         ELdSRtQSi0xInDZ4f8PJDbKirMh+ejV8pqvoybPenbauFmvBn6P2G7xKjIQEzO4z77/v
         mAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HSNkFlfPfBDbcR8sD587o294JAzA+6MXjR3ij3H7xVU=;
        b=0f1Pg6f53Y8kDxUfDZpzU6BRd+g4iD4ahMVkzGrDIEsDdhommqhH9oWIgoJQLsxOEx
         KqslcLj3gEHub4f0d0vaCPKPxHLIXWh88Q8i6zF+53eHKag9iZ8so8Vo9pHr5kbfQgiS
         WruN6CTJMUGkGdPvTg5BRcVZffN2DCQHBvwDWl/muBjQ6HG25LsSIK6B88cBIglzTyQu
         i9WCM82hW/6EqGJhHb7vagiIADO9/i2cI3zojdJtpbO4McUXuxEZm8TMsiai0ByeJnHm
         ow1cI0jD757YUVFJTbCegPEGYby5rwAfuRPL4g/6dh8fkGd6+lrKXLj4EIe5wFKZBm/0
         QmVg==
X-Gm-Message-State: AOAM530YwMcRluZN6Z9Ez+ZBSBvt6PUat9Ky81jWX5p7KLztU8j5aBbj
        bU9BKYEF9t9LZQDkqAUftXs6vw==
X-Google-Smtp-Source: ABdhPJz33fR5itpB4TPFwy+WoFynrhFeWTR3Dac78AQFV5lbMLll+04N7HwgsISvDxYo7EFKwpvr8Q==
X-Received: by 2002:a17:902:c412:b0:158:642f:bb13 with SMTP id k18-20020a170902c41200b00158642fbb13mr24819504plk.18.1650036310361;
        Fri, 15 Apr 2022 08:25:10 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id oj16-20020a17090b4d9000b001c709bca712sm9346846pjb.29.2022.04.15.08.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 08:25:09 -0700 (PDT)
Date:   Fri, 15 Apr 2022 15:25:06 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Zeng Guang <guang.zeng@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Kai Huang <kai.huang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Robert Hu <robert.hu@intel.com>,
        Gao Chao <chao.gao@intel.com>
Subject: Re: [PATCH v8 9/9] KVM: VMX: enable IPI virtualization
Message-ID: <YlmOUtXgIdQcUTO1@google.com>
References: <20220411090447.5928-1-guang.zeng@intel.com>
 <20220411090447.5928-10-guang.zeng@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411090447.5928-10-guang.zeng@intel.com>
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

On Mon, Apr 11, 2022, Zeng Guang wrote:
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d1a39285deab..23fbf52f7bea 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -11180,11 +11180,15 @@ static int sync_regs(struct kvm_vcpu *vcpu)
>  
>  int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
>  {
> +	int ret = 0;
> +
>  	if (kvm_check_tsc_unstable() && atomic_read(&kvm->online_vcpus) != 0)
>  		pr_warn_once("kvm: SMP vm created on host with unstable TSC; "
>  			     "guest TSC will not be reliable\n");
>  
> -	return 0;
> +	if (kvm_x86_ops.alloc_ipiv_pid_table)
> +		ret = static_call(kvm_x86_alloc_ipiv_pid_table)(kvm);

Add a generic kvm_x86_ops.vcpu_precreate, no reason to make this so specific.
And use KVM_X86_OP_RET0 instead of KVM_X86_OP_OPTIONAL, then this can simply be

	return static_call(kvm_x86_vcpu_precreate);

That said, there's a flaw in my genius plan.

  1. KVM_CREATE_VM
  2. KVM_CAP_MAX_VCPU_ID, set max_vcpu_ids=1
  3. KVM_CREATE_VCPU, create IPIv table but ultimately fails
  4. KVM decrements created_vcpus back to '0'
  5. KVM_CAP_MAX_VCPU_ID, set max_vcpu_ids=4096
  6. KVM_CREATE_VCPU w/ ID out of range

In other words, malicious userspace could trigger buffer overflow.

That could be solved by adding an arch hook to undo precreate, but that's gross
and a good indication that we're trying to solve this the wrong way.

I think it's high time we add KVM_FINALIZE_VM, though that's probably a bad name
since e.g. TDX wants to use that name for VM really, really, being finalized[*],
i.e. after all vCPUs have been created.

KVM_POST_CREATE_VM?  That's not very good either.

Paolo or anyone else, thoughts?

[*] https://lore.kernel.org/all/83768bf0f786d24f49d9b698a45ba65441ef5ef0.1646422845.git.isaku.yamahata@intel.com
