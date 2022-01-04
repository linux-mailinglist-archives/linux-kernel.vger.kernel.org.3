Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16224484AF4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 23:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbiADW5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 17:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbiADW5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 17:57:38 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A35C061784
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 14:57:38 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id t32so2346269pgm.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 14:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ijixhb9TZXSDPw+PDbrz8astljejWZJIUbahpVCNB8U=;
        b=HNokIIvqO2DyolcBwq9qPxnH6YVha3Vcl+EQx8KJA+R1xqvqoD6j5ge1hubshRl34C
         qmtjLHkIc3pyNes1CKP0mEzwCJ5Zbkrzn3gwDlKMePsM7qY2Elw922WUsnJINMSrtmxl
         aKFIh8VMcTuVYziv/vG5ZkA7A0VNLoXC/rlZu3rpaJKkSOBPnrRpsXjbrPbw2iwA0NT/
         aU+lJdEaqsZO3py8XIgfhD1/GPCjSyEUBXY11Yz+2elyp5Z6W4cRaDwS7WR3WvUQurew
         rX2PS5549pliKItnY1yzx/k2dVPufvX1AvuoHDgGpUcM+SLAMuLdNbub4YvkSzWL6KdU
         8uMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ijixhb9TZXSDPw+PDbrz8astljejWZJIUbahpVCNB8U=;
        b=K1DD53HsoqvSCSGiAv+iyNrREDji4u1T9xiCF5E//8BbYuECi3bppLR6MDBD5P6t6f
         oqOWNilfjqxn1uSBsPdsa2ii41RLV21hHe4bRahd+ewk369AxMQO1h0G2qNl8nWgDuz5
         cRGtg7088C/tdbKBWiGvpLu+1ht6z6VPCKY+y2pfJR1YL0SdQVYmqjEgzl/nY91qp6XN
         aXZeLhhv3tY+kD566bBGM1RSp1qZ+db015vRTVhDvtvvHSeOCR2DG1smK4Krw0eVBxo/
         TlJD/uZXTp2dDFAK6b1MXp4l7zdaWZSpyYlapTyxLCF6HPpRoyWDsPzHs0wBYNJxTvGz
         Ef2A==
X-Gm-Message-State: AOAM530iRe4URZl1OGH5bB3d/37eTc5/IwOQKitphQTAM83O5smholBm
        yLM1EvmX+agUUGveTqd5m24QWA==
X-Google-Smtp-Source: ABdhPJxKLJWv3sEIBZVdjOFc4tC9d8PqmlrAEb3b5QSax+WzXUVLr+CsAlL1IagnfobcWM1u/ZDD0g==
X-Received: by 2002:aa7:8541:0:b0:4bb:b0f2:6134 with SMTP id y1-20020aa78541000000b004bbb0f26134mr47124189pfn.37.1641337057347;
        Tue, 04 Jan 2022 14:57:37 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id s14sm159268pjq.4.2022.01.04.14.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 14:57:36 -0800 (PST)
Date:   Tue, 4 Jan 2022 22:57:33 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2 4/5] KVM: x86: don't touch irr_pending in
 kvm_apic_update_apicv when inhibiting it
Message-ID: <YdTQ3ewNzNOKoXCN@google.com>
References: <20211213104634.199141-1-mlevitsk@redhat.com>
 <20211213104634.199141-5-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213104634.199141-5-mlevitsk@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021, Maxim Levitsky wrote:
> kvm_apic_update_apicv is called when AVIC is still active, thus IRR bits
> can be set by the CPU after it was called, and won't cause the irr_pending
> to be set to true.
> 
> Also the logic in avic_kick_target_vcpu doesn't expect a race with this
> function.
> 
> To make it simple, just keep irr_pending set to true and
> let the next interrupt injection to the guest clear it.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/kvm/lapic.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index baca9fa37a91c..6e1fbbf4c508b 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2312,7 +2312,10 @@ void kvm_apic_update_apicv(struct kvm_vcpu *vcpu)
>  		apic->irr_pending = true;
>  		apic->isr_count = 1;
>  	} else {
> -		apic->irr_pending = (apic_search_irr(apic) != -1);
> +		/*
> +		 * Don't touch irr_pending, let it be cleared when
> +		 * we process the interrupt

Please don't use pronouns in comments, e.g. who is "we" in this context?  Please
also say _why_.  IIUC, this could more precisely be:

		/*
		 * Don't clear irr_pending, searching the IRR can race with
		 * updates from the CPU as APICv is still active from hardware's
		 * perspective.  The flag will be cleared as appropriate when
		 * KVM injects the interrupt.
		 */

> +		 */
>  		apic->isr_count = count_vectors(apic->regs + APIC_ISR);
>  	}
>  }
> -- 
> 2.26.3
> 
