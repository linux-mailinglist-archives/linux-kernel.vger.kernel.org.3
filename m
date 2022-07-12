Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE3D572593
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 21:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbiGLTXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 15:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbiGLTXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 15:23:13 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213DDEBBFE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 12:00:28 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id r186so1187894pgr.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 12:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=24a4DPzJMkufkus91pFJUFud3yFqwwXytBA96SJJdD0=;
        b=Px/QN0h6joRjGgAJ040a+wPwOgRX0ajg8b5ub0VXfzDgNM+lkH1ZD1EozzKNh9HD/7
         kXjR99K/2HL6gbNlUSxGdWXdYf3DBo/Fuqhc/skA8I+0L6GHk/dwNY2JCctfy7LE6uvz
         g6wPKE8LZgVg7dTH+5u2dKEeHJh5xAFHbEPsHRfW445loekLLiNoWD399ZaZUt6RdpcA
         fPsmgCPj8mUs5h6XhIr7H5gNsF5A1qnKi8dr+MqL513b3CNeysBMK9SgIKlyeMgNdNgC
         zcY3GQM0oEREokqFjYs87E0Fffbwc0W+XS0qqRKZJhGJLF1dny8WbMz//keqq+YxoZ5Z
         tvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=24a4DPzJMkufkus91pFJUFud3yFqwwXytBA96SJJdD0=;
        b=rwTW+WFd8b1eo361Wm8Ovf9eWQ6Q04Kn+JIrOYcPet/pdB3QvqM1KSdOwCBG45D4VE
         kEHtrBp/2lE/EkZwRhznJncnhhAPziXqqr+8gNWhCXPLARyS/C3deg3Orw+q0RTzeaTu
         BmByQW5cvxItYFt1+bZpyekSuvPoBw2LBpvcsEQrSG8EKVjZyIjIBx6AAVkwE0X3/qnh
         1sOPCxKHHZGUHvFcER/vIVLlK3FDFEiu1kpAtTHshSnmxBRNy9uw56To1fCCkx+gxRhw
         ZT61pfuRSx3x2LE73ohtn0okCH33oI/PaVIGNfWu83Laaixp8veT3wXIuKrpE8Yn9rEB
         LeLA==
X-Gm-Message-State: AJIora8kiIhqDqUEZP91hihka6XAeYLmuR5NYbBXruETs5ACWb6oxVH+
        emUiJr/mjkDfPVuYLXjANTrp/w==
X-Google-Smtp-Source: AGRyM1uh9o5tjg4FqPlHU104ll/MUN6188FPj1U1eBmyjMFWPwuMjOfBt10ey9dNF8JHp9efnylMbQ==
X-Received: by 2002:a63:170d:0:b0:415:f76d:45e1 with SMTP id x13-20020a63170d000000b00415f76d45e1mr11592144pgl.171.1657652427244;
        Tue, 12 Jul 2022 12:00:27 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id d1-20020aa797a1000000b005259578e8fcsm7141163pfq.181.2022.07.12.12.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 12:00:26 -0700 (PDT)
Date:   Tue, 12 Jul 2022 19:00:23 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Zhang Jiaming <jiaming@nfschina.com>
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        renyu@nfschina.com
Subject: Re: [PATCH] KVM: LAPIC: Fix a spelling mistake in comments
Message-ID: <Ys3Ex9GaoWAbNqF0@google.com>
References: <20220701065558.9073-1-jiaming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701065558.9073-1-jiaming@nfschina.com>
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

On Fri, Jul 01, 2022, Zhang Jiaming wrote:
> There is a typo (writeable) in kvm_apic_match_physical_addr's comments.
> Fix it.
> 
> Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
> ---
>  arch/x86/kvm/lapic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 0e68b4c937fc..ace161bf3744 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -808,7 +808,7 @@ static bool kvm_apic_match_physical_addr(struct kvm_lapic *apic, u32 mda)
>  	 * Hotplug hack: Make LAPIC in xAPIC mode also accept interrupts as if
>  	 * it were in x2APIC mode.  Hotplugged VCPUs start in xAPIC mode and
>  	 * this allows unique addressing of VCPUs with APIC ID over 0xff.
> -	 * The 0xff condition is needed because writeable xAPIC ID.
> +	 * The 0xff condition is needed because writable xAPIC ID.


Oof, that comment isn't exactly overflowing with information about why writable
xAPIC IDs are problematic.

>  	 */
>  	if (kvm_x2apic_id(apic) > 0xff && mda == kvm_x2apic_id(apic))

IMO checking @mda for > 0xff is more intuitive and easier to document.  Checking
the x2APID ID is functionally equivalent when combined with the "== mda" check, but
in isolation depends on the x2APIC ID being read-only.

Aha!  And checking @mda would allow dropping "fallthrough" logic, as the xAPIC
_can't_ match if @mda > 0xff.  

So this?

---
From: Sean Christopherson <seanjc@google.com>
Date: Tue, 12 Jul 2022 11:46:53 -0700
Subject: [PATCH] KVM: x86: Check target, not vCPU's x2APIC ID, when applying
 hotplug hack

When applying the hotplug hack to match x2APIC IDs for vCPUs in xAPIC
mode, check the target APID ID for being unaddressable in xAPIC mode
instead of checking the vCPU's x2APIC ID.  Functionally, the two checks
yield identical behavior when combined with the "mda == x2apid_id" check.
But in isolation, checking the x2APIC ID takes an unnecessary dependency
on the x2APIC ID being read-only (which isn't strictly true on AMD CPUs,
and is difficult to document as well), and requires KVM to fallthrough
and check the xAPIC ID as well to deal with a writable xAPIC ID, whereas
the xAPIC ID _can't_ match a target ID greater than 0xff.

Opportunistically reword the comment to call out the various subtleties,
and to fix a typo reported by Zhang Jiaming.

No functional change intended.

Cc: Zhang Jiaming <jiaming@nfschina.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 48740a235dee..ef5417d3ce95 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -830,13 +830,16 @@ static bool kvm_apic_match_physical_addr(struct kvm_lapic *apic, u32 mda)
 		return mda == kvm_x2apic_id(apic);

 	/*
-	 * Hotplug hack: Make LAPIC in xAPIC mode also accept interrupts as if
-	 * it were in x2APIC mode.  Hotplugged VCPUs start in xAPIC mode and
-	 * this allows unique addressing of VCPUs with APIC ID over 0xff.
-	 * The 0xff condition is needed because writable xAPIC ID.
+	 * Hotplug hack: Accept interrupts for vCPUs in xAPIC mode as if they
+	 * were in x2APIC mode if the target APIC ID can't be encoded as an
+	 * xAPIC ID.  This allows unique addressing of hotplugged vCPUs (which
+	 * start in xAPIC mode) with an APIC ID that is unaddressable in xAPIC
+	 * mode.  Match the x2APIC ID if and only if the target APIC ID can't
+	 * be encoded in xAPIC to avoid spurious matches against a vCPU that
+	 * changed its (addressable) xAPIC ID (which is writable).
 	 */
-	if (kvm_x2apic_id(apic) > 0xff && mda == kvm_x2apic_id(apic))
-		return true;
+	if (mda > 0xff)
+		return mda == kvm_x2apic_id(apic);

 	return mda == kvm_xapic_id(apic);
 }

base-commit: ba0d159dd8844469d4e4defff4985a7b80f956e9
--

