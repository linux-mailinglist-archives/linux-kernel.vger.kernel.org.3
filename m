Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79D54D1F4A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344117AbiCHRnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345430AbiCHRns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:43:48 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FC326123
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:42:50 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id cx5so13262pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 09:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2/CUf3S7kuNwgRHVA9U0egmiRYmyyn2A3M8F66MteHw=;
        b=K6FQwXnav0r9/lQf2ZQs22EVzoP1w5XD19pDUbI83X+HfULbDRCKJAPunBeCLcTsPH
         If/hus9nU1HPo1YjkX6zx9sUYzNsvr2GKjmHWGTSsbRIFAIHbGSRkz/ANrxZvbV/0dV8
         jyt80tQbwE38PPxRGyvYasp+OBLWrWVYx6aH/rMsJXfuU/WXdM0XqsbAAawF/enLi2pq
         sKEzpYwMFg8hGBYXBYqnWCLFf1Q0f0LoksTocbpTjOaG6Z8/Cwdgbasj5mqiO9YzQbwk
         eSbcCh5fkdzOXX+R5kOxkobsQngGmKp9k70iFy3r722GtG9FvEUjaamDZ/+bQRyL70c1
         wHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2/CUf3S7kuNwgRHVA9U0egmiRYmyyn2A3M8F66MteHw=;
        b=P69JFMqJZDOywVc7168JqCCc3DsqN5bt+UPQiNIWt/E+qGFeT7WJFmEYZuwqhvR7xq
         CXk8WDNLT/bmPS4isVjjYM5A0c5IVzx14jp6yjEnkFESMIz/+RUaubxrbFm3ghvQdArG
         LawR7RWEnl/YnHvMrNHulV2n/jso1EIMJqalHVhvxj4v5V7q2Fp8OcWqzsiTdsjPr67u
         RMi2YkhGerJR8yphCmocxOFirFUcowgI1cT9i53rl+NymQrp/VFaWhcWuglq2IMew+m6
         k84UanHpCpLfVepbCbe1b9ANODCdtXaFlTjRO7icmSHoVGGEHu9SdTSuXRKMWQNlGF3l
         D4dw==
X-Gm-Message-State: AOAM532laDBJqvtB027rK1Qgg2GpmmyqIR22t+KySuK36a3xznQ8r2jx
        /CMrMSv/Umf4xjwexKeEH6isRE1LyZXR4g==
X-Google-Smtp-Source: ABdhPJyZXljDBZAJbuO2P4mPRFNpMLLi23fbEFM9XepENcXZ/0h/oGhg2YrqN/imy2ysUkOrc4KNkQ==
X-Received: by 2002:a17:90a:8591:b0:1b9:da10:2127 with SMTP id m17-20020a17090a859100b001b9da102127mr5967730pjn.13.1646761369548;
        Tue, 08 Mar 2022 09:42:49 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id u8-20020a056a00098800b004f702473553sm8925797pfg.6.2022.03.08.09.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:42:49 -0800 (PST)
Date:   Tue, 8 Mar 2022 17:42:45 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        dmatlack@google.com
Subject: Re: [PATCH v2 10/25] KVM: x86/mmu: remove ept_ad field
Message-ID: <YieVlbIwYIIbEmd7@google.com>
References: <20220221162243.683208-1-pbonzini@redhat.com>
 <20220221162243.683208-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221162243.683208-11-pbonzini@redhat.com>
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

On Mon, Feb 21, 2022, Paolo Bonzini wrote:
> The ept_ad field is used during page walk to determine if the guest PTEs
> have accessed and dirty bits.  In the MMU role, the ad_disabled
> bit represents whether the *shadow* PTEs have the bits, so it
> would be incorrect to replace PT_HAVE_ACCESSED_DIRTY with just
> !mmu->mmu_role.base.ad_disabled.
> 
> However, the similar field in the CPU mode, ad_disabled, is initialized
> correctly: to the opposite value of ept_ad for shadow EPT, and zero
> for non-EPT guest paging modes (which always have A/D bits).  It is
> therefore possible to compute PT_HAVE_ACCESSED_DIRTY from the CPU mode,
> like other page-format fields; it just has to be inverted to account
> for the different polarity.
> 
> Having a CPU mode that is distinct from the MMU roles in fact would even
> allow to remove PT_HAVE_ACCESSED_DIRTY macro altogether, and always use
> !mmu->cpu_mode.base.ad_disabled.  I am not doing this because the macro
> has a small effect in terms of dead code elimination:
> 
>    text	   data	    bss	    dec	    hex
>  103544	  16665	    112	 120321	  1d601    # as of this patch
>  103746	  16665	    112	 120523	  1d6cb    # without PT_HAVE_ACCESSED_DIRTY
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
