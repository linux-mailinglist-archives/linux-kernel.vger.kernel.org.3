Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267E848497E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 21:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbiADUxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 15:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbiADUxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 15:53:37 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59737C061784
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 12:53:37 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id v13so33256295pfi.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 12:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YHbuMKpK/7yPcV7exxvo6MxPbekko6GR3b4aLBbszFQ=;
        b=ViA3u8JQef0w1/0BCfc6SjrLcqMpleOGdKch0TTffdI0aNusaCvBMHUJFcePY/KeUd
         TTGum/FovBeHiZFz4e1VJQlFzxJ3WBjset4LmZx26cFmWxIIrsEWBXARiPwV2TqQcOm6
         IwMXaQ7wpiizjfjlxJUQ+wwqJ5wVbthbr/HJ3FbBR7nD1k3eHX3AjXtrlk5ofkEuUzgo
         VLKpFqciNuIx2cJNACeEeCmBPCcjzcMc7wvUmRheS26WTW7CI8pT78iJ9UxulVN/fuMJ
         /cKIs0J5UeYqz2YctauwcgixE5X+qv/HLMp53tWA/x6H04ac8kdGI2q5SGPAZdqnw7gP
         itrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YHbuMKpK/7yPcV7exxvo6MxPbekko6GR3b4aLBbszFQ=;
        b=iWS77XoqNtr8JSxrAkMHrMsVLvTZpztDJo+PZgdCLMQAV1XAthwylcVqdizFhbVlRS
         2OAF/2bxJUCu6oMaq+Gt2Rn6jFIFn2sfvWo85mDN1h6AUJUI/62wMbgZEshJNOQHu1S7
         XmrN/KXrdxSUL3lDK4f72E3CYdMD8TmkEzB1uoqcU9p42+KBNXkGQ32PYlVHrjEzFt2n
         qn/C8W5VD0Db6aXVhMGIXEJLO0t2h5drNq9kWVNtg6NFMfkKfC/SU9cbiYfRfZzDBqxa
         HNZkce8jkizabAgzZhblDqZhvJFb9MJU8X667KUPAV1lOTkh4KY4Tt52/EOIS5/IF2pZ
         kChQ==
X-Gm-Message-State: AOAM533sFaiSUtvDU3XcsNVJjSoEoIj4yk9pVfa8B2Xupe5W7ircdFsZ
        VhMwzfN5SiUm5UZPEKSIWLQolQ==
X-Google-Smtp-Source: ABdhPJyXcI8OPBdUKG++5YBxn87AZNmAE4r6ciasH2PSZKtJ13K2LuaFIC0WtqM85jCU91ILd6QuRA==
X-Received: by 2002:aa7:9e9e:0:b0:4bb:39a:b85c with SMTP id p30-20020aa79e9e000000b004bb039ab85cmr52359568pfq.68.1641329616714;
        Tue, 04 Jan 2022 12:53:36 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id p10sm42252980pfw.69.2022.01.04.12.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 12:53:36 -0800 (PST)
Date:   Tue, 4 Jan 2022 20:53:32 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH 3/6] KVM: X86: Add arguement gfn and role to
 kvm_mmu_alloc_page()
Message-ID: <YdSzzOLTIOhFz7ys@google.com>
References: <20211210092508.7185-1-jiangshanlai@gmail.com>
 <20211210092508.7185-4-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210092508.7185-4-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> kvm_mmu_alloc_page() will access to more bits of the role.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 846a2e426e0b..54e7cbc15380 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -1734,13 +1734,13 @@ static void drop_parent_pte(struct kvm_mmu_page *sp,
>  	mmu_spte_clear_no_track(parent_pte);
>  }
>  
> -static struct kvm_mmu_page *kvm_mmu_alloc_page(struct kvm_vcpu *vcpu, int direct)
> +static struct kvm_mmu_page *kvm_mmu_alloc_page(struct kvm_vcpu *vcpu, gfn_t gfn, union kvm_mmu_page_role role)

Please wrap the union param to a new line.  Checkpatch now warns at 100 chars, but
80 is still the guideline (checkpatch was tweaked so that people would stop adding
really awkward newlines just to honor the 80 char limit).
