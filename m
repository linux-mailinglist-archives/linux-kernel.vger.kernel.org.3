Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF7F46DAB9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238610AbhLHSOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbhLHSOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:14:02 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5B7C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 10:10:30 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p18so2030461plf.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 10:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FQ7PKcUEO3UP2W+Pf4InayHPMU1S6OuS0wUdoJJOcGg=;
        b=Mmp9jWEBM3adijP1etV2lJRZPGMlsXLzITNuyVxk7elsI0tiJa2tLg4dZOBzea9FNA
         K4olauer8Fvz+m7ZI8PDYZ6qXONmUiYf6OUMQGVDn9W5ArDCG/1EHvTVntqz5cKWLI89
         UyWp1m0n4g6QorZ8NNILJdANgqUhEFMSVmzKgocUH5KojUHBOmJXQwqCQfeoJCtRCbMJ
         hhzsblyugW0f4XnFFmfvnuctG8vm7ywI12gkDi7tIvoXHDQtFVKXd088nVf+GCRDEeWH
         z4gIT0YFgiDmjW5bM3ga6hRRDdeocaaLm0y93J0EwTWnfVuG2jNyaAJih+KDLEbIh/hP
         8hLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FQ7PKcUEO3UP2W+Pf4InayHPMU1S6OuS0wUdoJJOcGg=;
        b=btycNTvw4CU47pAB1LiutFF8xlpaJoSgefi411AT4zugjGMSx1rsRl/GMDVM5uhK5k
         eYdfsJdy3Yjwl0GW+NvfmL585YBnkxMe1kjXjF6MMnx8MRuSinnYEQZWXm2x5c0TdfWR
         Z4g3GQonrCJsonLWLoI89kZLSPpxcUi0lJdtV5+XVV8/72KT2CUolbE95qwqtkDJ7hHS
         bMyu3a1rxeaKSkGMRvQryIQZ1HP77nGP4HL1+0uIbvklcy1Kl+jkLeZ3H94wzlnQYImx
         xtQbK4Q2PC8dLjEWwvphQl7nUD6TMMNncca4pLctZABrkXC8hns4HH8jyCitiem459bZ
         0YCg==
X-Gm-Message-State: AOAM531VXnwkuJhfttYkCh7KXzAcLvVqVZH6e/HT/KWF2KD1a0WQ+CYl
        C3gFen5Bf/nS7y8vCAelwISK/A==
X-Google-Smtp-Source: ABdhPJz2NsSGxze+K4VZkPy8GXFY8LJ85R0vjcOSriovznbTMzQzJhkLXER2qloaEyFfN2DcSpCJKg==
X-Received: by 2002:a17:90a:49c2:: with SMTP id l2mr9239325pjm.23.1638987029398;
        Wed, 08 Dec 2021 10:10:29 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id j1sm4461778pfu.47.2021.12.08.10.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 10:10:28 -0800 (PST)
Date:   Wed, 8 Dec 2021 18:10:25 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] KVM: x86: Copy kvm_pmu_ops by value to eliminate
 layer of indirection
Message-ID: <YbD1ETLLpf4uKPWY@google.com>
References: <20211108111032.24457-1-likexu@tencent.com>
 <20211108111032.24457-5-likexu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108111032.24457-5-likexu@tencent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> Replace the kvm_pmu_ops pointer in common x86 with an instance of the
> struct to save one pointer dereference when invoking functions. Copy the
> struct by value to set the ops during kvm_init().
> 
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
>  arch/x86/kvm/pmu.c | 41 ++++++++++++++++++++++-------------------
>  arch/x86/kvm/pmu.h |  4 +++-
>  arch/x86/kvm/x86.c |  1 +
>  3 files changed, 26 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index aa6ac9c7aff2..353989bf0102 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -47,6 +47,9 @@
>   *        * AMD:   [0 .. AMD64_NUM_COUNTERS-1] <=> gp counters
>   */
>  
> +struct kvm_pmu_ops kvm_pmu_ops __read_mostly;
> +EXPORT_SYMBOL_GPL(kvm_pmu_ops);

This export isn't necessary.
