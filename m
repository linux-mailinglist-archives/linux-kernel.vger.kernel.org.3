Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7D6486DD8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 00:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245621AbiAFXgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 18:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245546AbiAFXgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 18:36:47 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EAAC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 15:36:47 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id z3so3558910plg.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 15:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GRkLdkwcM4+2ERhMx/rFYN2pykmE1vvwdiXV7ezvwio=;
        b=FwtC/N7CT+G7r8qi6DcGnKMXMQLBE3YIdgElNSW8qYM+u3cMPEz3R9PvTZiJVPAhcK
         qK/Dq2upCHzbAgBHm5n+FJ6p8ae6uxbjn9efX2XZOQegEKn8ilbJHqe3Bz4wXd3zmnQN
         mnHPXKP7phnuBnQbmrVcYuDfJV1rA9XijGjSvunof3RyqHkVdHAty36o172GU1D6l5fV
         tblm9ee8jIw5p+G9nqOsp7jpd/aYAQvZJJwwLLcPzItwDaY+hnjrRquclDGnN6/wNRK6
         AAUgSySCDurgXiipz42CYiU/UXGDoH6zy/kgmPYvWKGhPDm5rE5ZdrT/+qD6R8NdS3td
         hRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GRkLdkwcM4+2ERhMx/rFYN2pykmE1vvwdiXV7ezvwio=;
        b=NnM0wJJLhYFbrme6v3A3rhMl5Ulacs9tvbkOYQMr3Ylqo5zosX/n9dZal8wESYTv5r
         mVP3wyhvWc8jq7aU+hy25O+DYBDkxK2cWnXPrfaNhUw6HEFKwxL+eLGrjj3GRTqfVveW
         /Hxpq6uP1vj47Qb3tfRz1K+QPwL1m2p/ONTnMS5L8v2MLtmFx6qCEAVKDXZzPhOkuWQM
         lYie1LV6v0YQx7g37SgzCiyT1OA1+GvIALMJ1XWjue4DVLwqjFxwOR0iSuKyEQ7Ysv6Z
         sVF5Pge0Muk+3EWe+yzjO3NCJNBiNq9DzH6U+6UtjSRpHVZqFdXJ1IZ+4OtxbUUZVujG
         4W/g==
X-Gm-Message-State: AOAM532jAzoXsr14q9zhWxF1IrHB2e8/fsiRGi4gjwLFtUWlwJ2IkA3o
        1B55zedKBOMAurzspJ9470J3IQ==
X-Google-Smtp-Source: ABdhPJzf9JzkPSYvIYftb/+peqoGxb+eTYS5JRT1dSULtbYzmoZUbOlVmP22lblhIryLl/eC2F8/FQ==
X-Received: by 2002:a17:902:f54e:b0:148:e76e:a5 with SMTP id h14-20020a170902f54e00b00148e76e00a5mr58921879plf.135.1641512206735;
        Thu, 06 Jan 2022 15:36:46 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id z4sm3483633pfh.215.2022.01.06.15.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 15:36:46 -0800 (PST)
Date:   Thu, 6 Jan 2022 23:36:43 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] KVM: nVMX: Rename vmcs_to_field_offset{,_table} to
 vmcs12_field_offset{,_table}
Message-ID: <Ydd9C7A56JtpSWnu@google.com>
References: <20211214143859.111602-1-vkuznets@redhat.com>
 <20211214143859.111602-4-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214143859.111602-4-vkuznets@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021, Vitaly Kuznetsov wrote:
> vmcs_to_field_offset{,_table} may sound misleading as VMCS is an opaque
> blob which is not supposed to be accessed directly. In fact,
> vmcs_to_field_offset{,_table} are related to KVM defined VMCS12 structure.
> 
> No functional change intended.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> diff --git a/arch/x86/kvm/vmx/vmcs12.h b/arch/x86/kvm/vmx/vmcs12.h
> index 2a45f026ee11..13e2bd017538 100644
> --- a/arch/x86/kvm/vmx/vmcs12.h
> +++ b/arch/x86/kvm/vmx/vmcs12.h
> @@ -361,10 +361,10 @@ static inline void vmx_check_vmcs12_offsets(void)
>  	CHECK_OFFSET(guest_pml_index, 996);
>  }
>  
> -extern const unsigned short vmcs_field_to_offset_table[];
> +extern const unsigned short vmcs12_field_offset_table[];

While we're tweaking names, what about dropping "table" and calling this
vmcs12_field_offsets?

>  extern const unsigned int nr_vmcs12_fields;
>  
> -static inline short vmcs_field_to_offset(unsigned long field)
> +static inline short vmcs12_field_offset(unsigned long field)

And get_vmcs12_field_offset() here to make it more obvious that it's translating
something to an offset, which is communicated by the "to" in the current name.

>  {
>  	unsigned short offset;
>  	unsigned int index;
> @@ -377,7 +377,7 @@ static inline short vmcs_field_to_offset(unsigned long field)
>  		return -ENOENT;
>  
>  	index = array_index_nospec(index, nr_vmcs12_fields);
> -	offset = vmcs_field_to_offset_table[index];
> +	offset = vmcs12_field_offset_table[index];
>  	if (offset == 0)
>  		return -ENOENT;
>  	return offset;
> -- 
> 2.33.1
> 
