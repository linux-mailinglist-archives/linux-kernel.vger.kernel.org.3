Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCF7487F4C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 00:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiAGXSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 18:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiAGXSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 18:18:17 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6657C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 15:18:17 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id h1so6120144pls.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 15:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yaoLqv5jRYvwceeR5DSPvo5ncAgq+xEgxFxHcI2Knk8=;
        b=HWhgHw3ZS8xY+JgACdrlsFANWeCOv/rM1m6Nc5MLehoXVnpOlJlo2XtXyeMTcknEZG
         ZNPFe+O47dfU4oxk9JDQdJkIHRV/iCPfuvX6Abkqwof2T9DYCpUoxCk4gC6FlEWcpOA9
         MbXQ6ZurU18pgPUPKhHh6P1OczKpFUfvcQ3D3lVuF8EZ4i4Sv0twSgB6Kz5VBvIr9RNu
         /9uQS4EtXUPqSrsdCK4kmOi96ejUcyw60Zn8RzPq8b3S41r3Gbz98OfcRRJKnKKLU5RR
         YBwGhlcgWj2pOce8MUMs2jbhZM4frWKyNMVSCyvc/RtYZQHBcCGa7mylUhhqCDzpuqIq
         RU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yaoLqv5jRYvwceeR5DSPvo5ncAgq+xEgxFxHcI2Knk8=;
        b=bHRbNpc0JwZd2Fk8i6hSG7DeNxAGl9fjYEcef3Zfle1zuXy4+02KogHpv2wdHuej1G
         UD8yP1OV5AXPNTC6NDfMDyiKM0vN5oWu8Hsff9ywkCLD3AEVoev7+yDZhtr5v7rNS51o
         WcClLTu0HbE/fub7lw27jBlG4E6I6hsyuEgYSxdfEzNTYRtE0EJTHZ5ZHZOy3pfnAnVi
         Ajqk7/GzniZYKFjGFBNthY3/ExNsiaKAMYTiZD6ZB/VKqLYfmCU5sD8JTDuG1B62Zv/R
         IdQzF3BWX9+la6ESbLNytYfLbAAwqCX0pVgTTUvvUbyQqpI/D3N1bkevlcm0I7IFCqXS
         D/Tw==
X-Gm-Message-State: AOAM532u0pEq7SOsm3sVy8pvkcDqJcJ5+tubsSA09uavknFJ9c7DVoMd
        qBQrscxh9Zs5S7FBGOwshaPK1A==
X-Google-Smtp-Source: ABdhPJxWzsZpPEniI/bjv14ONAp64VKU7JxHfh//mJ9FcB6M6YOdo0bUa6suDqExYlgub8MsNm5IWg==
X-Received: by 2002:a17:902:bc88:b0:149:2032:6bcf with SMTP id bb8-20020a170902bc8800b0014920326bcfmr64767891plb.44.1641597497025;
        Fri, 07 Jan 2022 15:18:17 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g10sm3697pjs.1.2022.01.07.15.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 15:18:16 -0800 (PST)
Date:   Fri, 7 Jan 2022 23:18:13 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] KVM: nVMX: Allow VMREAD when Enlightened VMCS is
 in use
Message-ID: <YdjKNcTcd2rFaA27@google.com>
References: <20220107102859.1471362-1-vkuznets@redhat.com>
 <20220107102859.1471362-6-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107102859.1471362-6-vkuznets@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022, Vitaly Kuznetsov wrote:
> Hyper-V TLFS explicitly forbids VMREAD and VMWRITE instructions when
> Enlightened VMCS interface is in use:
> 
> "Any VMREAD or VMWRITE instructions while an enlightened VMCS is
> active is unsupported and can result in unexpected behavior.""
> 
> Windows 11 + WSL2 seems to ignore this, attempts to VMREAD VMCS field
> 0x4404 ("VM-exit interruption information") are observed. Failing
> these attempts with nested_vmx_failInvalid() makes such guests
> unbootable.
> 
> Microsoft confirms this is a Hyper-V bug and claims that it'll get fixed
> eventually but for the time being we need a workaround. (Temporary) allow
> VMREAD to get data from the currently loaded Enlightened VMCS.
> 
> Note: VMWRITE instructions remain forbidden, it is not clear how to
> handle them properly and hopefully won't ever be needed.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>

> +		/*
> +		 * Hyper-V TLFS (as of 6.0b) explicitly states, that while an
> +		 * enlightened VMCS is active VMREAD/VMWRITE instructions are
> +		 * unsupported. Unfortunately, certain versions of Windows 11
> +		 * don't comply with this requirement which is not enforced in
> +		 * genuine Hyper-V so KVM has implement a workaround allowing to

Nit, missing a "to".  But rather say what KVM "has" to do, maybe this?

		 * genuine Hyper-V.  Allow VMREAD from an enlightened VMCS as a
		 * workaround, as misbehaving guests will panic on VM-Fail.

> +		 * read from enlightened VMCS with VMREAD.
> +		 * Note, enlightened VMCS is incompatible with shadow VMCS so
> +		 * all VMREADs from L2 should go to L1.
> +		 */
> +		if (WARN_ON_ONCE(is_guest_mode(vcpu)))
> +			return nested_vmx_failInvalid(vcpu);
>  
> -	/* Read the field, zero-extended to a u64 value */
> -	value = vmcs12_read_any(vmcs12, field, offset);
> +		offset = evmcs_field_offset(field, NULL);
> +		if (offset < 0)
> +			return nested_vmx_fail(vcpu, VMXERR_UNSUPPORTED_VMCS_COMPONENT);
> +
> +		/* Read the field, zero-extended to a u64 value */
> +		value = evmcs_read_any(vmx->nested.hv_evmcs, field, offset);
> +	}
>  
>  	/*
>  	 * Now copy part of this value to register or memory, as requested.
> -- 
> 2.33.1
> 
