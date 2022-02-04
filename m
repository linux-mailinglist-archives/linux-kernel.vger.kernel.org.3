Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9692C4A9EC7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 19:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377452AbiBDSQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 13:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377428AbiBDSQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 13:16:09 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AD2C06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 10:16:09 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id e16so5686564pgn.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 10:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=24fUn3xmnEilqT1jq/nGliNWONEiQK4TZRbt9tZDMlQ=;
        b=bGgtFbWe3ziMU0nKrhS3SJwIpKKPRE8sx03vQd/usftYdU53QwE7kMYgCkrBVpQaSn
         cc1kH0+GOpcJ650zI1Kr/MBrRacaXb6IElkbAWy5x8hkqSLu/7E04dD4xHSnLaZy4dxW
         PoB13Rhw7kSMDr3FKu1O8hpjFJesFeojGVjO46zIWgVOA1eId0PKoL7w4c53KxbZthCT
         obZ3UVM2jCOdkrFxW8so90shvxDNCOET3+CFkDUVbarIVIxluK9gcKub20E+BFcK5XnF
         uEJL2th7Uz//pVIwMjQCWoCh5plx4zJUKyYgBCtbpI9X7BhJVsy2g8TW765JbfdO6ww/
         mJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=24fUn3xmnEilqT1jq/nGliNWONEiQK4TZRbt9tZDMlQ=;
        b=wXVYeIXM6IuLUbUfDn2xqEo4L3R1h5sOXMUiEzP9ThjdceAm5Q6XXfYu6niEKI3Ew2
         5IN06MrtYdVxhifQOAXr2O3OP0lmwmDvs13u/oJou+KPcrbAkknVTVPgw8beYZR1F/BA
         GW1luMafaFnPbPIWTCv0jpkPRXXxNI6mVnWEyCaFqWIec8/Ix0YV9EeQJMkeyTIFzOPu
         Tk54BmYMkaTT0j4l3gaZqTuD6l4APvDRUAHbiH8xE4LamOrYTPMFzo3U6WHOV4pBw5cR
         3386tD4aOVuqP1Jt76WoEFO63Mvc5Cvo+iaue2sEreb+zXQXYPC6ofdcxv6P5k0ynPF9
         cNaA==
X-Gm-Message-State: AOAM532rPnuStjd8UFa0XPGoL9jjuYFt20OHCqsvZFij3B8tit5TorMn
        10DZk9LYRDTBPXYkTdhAQ6NXsA==
X-Google-Smtp-Source: ABdhPJxxWQEZCDuVfUv+aKvwFvMItCjJT1miQIwGcWQ9nWKCfty6DDdqYR/qZh3k6YM47t8qXBtiYA==
X-Received: by 2002:a05:6a00:23d3:: with SMTP id g19mr4231238pfc.27.1643998568449;
        Fri, 04 Feb 2022 10:16:08 -0800 (PST)
Received: from google.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id b2sm2160893pgg.59.2022.02.04.10.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 10:16:07 -0800 (PST)
Date:   Fri, 4 Feb 2022 18:16:03 +0000
From:   David Matlack <dmatlack@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        seanjc@google.com, vkuznets@redhat.com
Subject: Re: [PATCH 02/23] KVM: MMU: nested EPT cannot be used in SMM
Message-ID: <Yf1tY8kNzZDRtH3e@google.com>
References: <20220204115718.14934-1-pbonzini@redhat.com>
 <20220204115718.14934-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204115718.14934-3-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 06:56:57AM -0500, Paolo Bonzini wrote:
> The role.base.smm flag is always zero, do not bother copying it over
> from vcpu->arch.root_mmu.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: David Matlack <dmatlack@google.com>

> ---
>  arch/x86/kvm/mmu/mmu.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 9424ae90f1ef..b0065ae3cea8 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4881,9 +4881,6 @@ kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty,
>  {
>  	union kvm_mmu_role role = {0};
>  
> -	/* SMM flag is inherited from root_mmu */
> -	role.base.smm = vcpu->arch.root_mmu.mmu_role.base.smm;

nit: Retaining a comment here and/or warning here would be useful.

	/* EPT is not allowed in SMM */
	WARN_ONCE_ONCE(vcpu->arch.root_mmu.mmu_role.base.smm);

(Although I imagine it would just get removed later in the series.)

> -
>  	role.base.level = level;
>  	role.base.has_4_byte_gpte = false;
>  	role.base.direct = false;
> -- 
> 2.31.1
> 
> 
