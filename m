Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7A952BF5D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 18:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239779AbiERP4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 11:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239849AbiERP4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 11:56:12 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095003D1E8
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 08:56:11 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r71so2570126pgr.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 08:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qWXKTxpMjmn1u6F63OBGUz8tILVO6jaTHdWT2R8iYlg=;
        b=eBaghM2dqTUIVv/7a2pxqIjSQL1Ktx2k9P6YqlUuVPZm2g5J8JNomOwqnfQufns4XX
         EkbC6Ht6q3Fl76dyOSK61FlnvJDZJJyMXoICbSld7XnACBvxHAd3sZqXbyrOAUx8VxZV
         Wxp0k/pkWhPgpQTw3Nufa/nCelbz5bgxvtzTtcWYrNcyVbYiXUkjh++XNiw8AUHfJgqx
         uxRfBFqLeQoJxXExhfJpce/LhRiPIjwXFrlPOJlXMFRHFvXmwSoBfUWcNk0BQLh9litq
         S0uKGx7PYGr6wsD5SrY4WHHMRNu7wiTpqLvuKvgBGptl3Qve+CjsXQnx11zkp8MuBFMA
         NpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qWXKTxpMjmn1u6F63OBGUz8tILVO6jaTHdWT2R8iYlg=;
        b=RUJJquF7CG9lvI+WnejjJ95CvCUZH0c1ogRW3TmEe9jGN8r0lV1363YmlO1EzsQDFT
         4LiHSysVWXMFXHTOHwFs2MLqc5jsF0Mip6dAU16SbWrqZQaNHPEelHU6f9yfqGi0MeSZ
         bT48Kz4obrzjIJminGTMRVHji+HtNJfIolMBa2BBR936UpC3FvRnuCYhCxeOb6sGGkz5
         sl5XepILB6ord2HJWarTuQsZj4lZM3WhIG/k7UEFp6GTXFLpJTOb23vmGFfRebMwtbqq
         wFl9PkPYfgfpZwmTZIWZ+Wdlht7Z6wKi2sJY0hJpsyuoNDqpjvbmMPQZZTdKL9FmWp/b
         aBew==
X-Gm-Message-State: AOAM532nLBukyaR3YN/wfyv4isytAVy9yU0xF+NfBTT3miWbDWA131A6
        JtAQSHgW4iB+FnNVXzwfas1lpw==
X-Google-Smtp-Source: ABdhPJxSEJX/gDr7F2yeujTeOEbh2dCd+3p9S2SawsVfH6UMPR5YU1kkRbp4HL/UBle/+eRE4D2uKA==
X-Received: by 2002:a05:6a00:2444:b0:4fd:db81:cbdd with SMTP id d4-20020a056a00244400b004fddb81cbddmr381800pfj.32.1652889370308;
        Wed, 18 May 2022 08:56:10 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id h8-20020a654688000000b003f60df4a5d5sm1449792pgr.54.2022.05.18.08.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 08:56:09 -0700 (PDT)
Date:   Wed, 18 May 2022 15:56:06 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        intel-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH v3 01/19] KVM: x86: document AVIC/APICv inhibit
 reasons
Message-ID: <YoUXFmh9vef4CC+8@google.com>
References: <20220427200314.276673-1-mlevitsk@redhat.com>
 <20220427200314.276673-2-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427200314.276673-2-mlevitsk@redhat.com>
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

On Wed, Apr 27, 2022, Maxim Levitsky wrote:
> These days there are too many AVIC/APICv inhibit
> reasons, and it doesn't hurt to have some documentation
> for them.

Please wrap at ~75 chars.

> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index f164c6c1514a4..63eae00625bda 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1046,14 +1046,29 @@ struct kvm_x86_msr_filter {
>  };
>  
>  enum kvm_apicv_inhibit {
> +	/* APICv/AVIC is disabled by module param and/or not supported in hardware */

Rather than tag every one as APICv vs. AVIC, what about reorganizing the enums so
that the common vs. AVIC flags are bundled together?  And then the redundant info
in the comments about "XYZ is inhibited" can go away too, i.e. the individual
comments can focus on explaining what triggers the inhibit (and for some, why that
action is incompatible with APIC virtualization).

E.g.
	/***************************************************************/
	/* INHIBITs are relevant to both Intel's APICv and AMD's AVIC. */
	/***************************************************************/

	/* APIC/AVIC is unsupported and/or disabled via module param. */
	APICV_INHIBIT_REASON_DISABLE,

	/* The local APIC is not in-kernel.  See KVM_CREATE_IRQCHIP. */
	APICV_INHIBIT_REASON_ABSENT,

	/*
	 * At least one IRQ vector is configured for HyperV's AutoEOI, which
	 * requires manually injecting the IRQ to do EOI on behalf of the guest.
	 */
	APICV_INHIBIT_REASON_HYPERV,
	

	/**********************************************/
	/* INHIBITs relevant only to AMD's AVIC. */
	/**********************************************/

>  	APICV_INHIBIT_REASON_DISABLE,
> +	/* APICv/AVIC is inhibited because AutoEOI feature is being used by a HyperV guest*/
>  	APICV_INHIBIT_REASON_HYPERV,
> +	/* AVIC is inhibited on a CPU because it runs a nested guest */
>  	APICV_INHIBIT_REASON_NESTED,
> +	/* AVIC is inhibited due to wait for an irq window (AVIC doesn't support this) */
>  	APICV_INHIBIT_REASON_IRQWIN,
> +	/*
> +	 * AVIC is inhibited because i8254 're-inject' mode is used
> +	 * which needs EOI intercept which AVIC doesn't support
> +	 */
>  	APICV_INHIBIT_REASON_PIT_REINJ,
> +	/* AVIC is inhibited because the guest has x2apic in its CPUID*/
>  	APICV_INHIBIT_REASON_X2APIC,
> +	/* AVIC/APICv is inhibited because KVM_GUESTDBG_BLOCKIRQ was enabled */
>  	APICV_INHIBIT_REASON_BLOCKIRQ,
> +	/*
> +	 * AVIC/APICv is inhibited because the guest didn't yet

s/guest/userspace

> +	 * enable kernel/split irqchip
> +	 */
>  	APICV_INHIBIT_REASON_ABSENT,
> +	/* AVIC is disabled because SEV doesn't support it */
>  	APICV_INHIBIT_REASON_SEV,
>  };
>  
> -- 
> 2.26.3
> 
