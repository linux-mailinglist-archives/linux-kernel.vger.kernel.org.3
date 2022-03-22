Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FAB4E46DA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 20:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbiCVTod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 15:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiCVTob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 15:44:31 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D58D382
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 12:42:59 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id z7so21507574iom.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 12:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kQfCViyvUcBGR9en7E9fM3gdNj6iSkExb9yK7Ef7nEA=;
        b=ftdIEVwRJDcINszz+pr2yi6zQaeeWx0v8sERiwy/J65J8gwYYBKlP0vwlFd4V5ivIc
         F5jbq0UkSMW398aYNBgLFHwNilRbIz06KMjmGGEPppjE1liHeZ8YIz4abvK4/IDPqSqx
         TuO8izyi0Uhf17++AoAFq/Uh2DkSuANy5cwZKf8MpMa8fvBCheNivveIFMwg4uu4AhTh
         d/Pn3MIRX6V0KKejM0KnbPVp95/pKJj/XVE1gvqMp1/r9fbwit46uZDi+g0DPNxaKWW4
         1NK6nhBEuWFlyN3/xcp/BfInF/UvkyZNzsupHUuK0LjCRMdbPg0PdOa1rJdrgWeNRVpp
         NERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kQfCViyvUcBGR9en7E9fM3gdNj6iSkExb9yK7Ef7nEA=;
        b=SM2qyzxKMrrhgSIUbsEkX74QPvlBk++aT3hOnnkteRf07cPoHfcI6o8EjOfchmGLHn
         O6QLSZJFz4tPe9g8OrTlTP4uOMDys8FynaYzKDWTjxOkqd6/AjzO+xGsOk9unH7mFphn
         FScl5lGZIrMGzb3JLfdoiHzuio4qlC6BaFT1wS0E9J+uOTTjqmopkA0s0pbjYrGlqeP5
         EkGYBrlY+4awd98MjncyhnyCNxpyaGRW+vcOyha77L2oPCQ1FYvIf4fFYcIK/gY5ksCN
         mIDCXguPPFP2Rdnr+3FUdAGg2CwlKAwRNMy0FfPku0j2xws2QhqZA/w2SYMStWaNK8JH
         Cc7Q==
X-Gm-Message-State: AOAM533imFdv9A/xkA97xpTSe0cvAJG4Ewo5hgU524fDMuj63EkVbHUV
        prU4xO2fN8nUWz6KY3whAgkR2/KJ5pOEyQ==
X-Google-Smtp-Source: ABdhPJzbEmmA31pMa7o1H5I0WOaV1TzDfua9AcuuxEy8N/e12lQalCiP31/gC0kyxSNbn9HRDMpncQ==
X-Received: by 2002:a05:6638:1694:b0:31a:594:f4c7 with SMTP id f20-20020a056638169400b0031a0594f4c7mr13259160jat.139.1647978178814;
        Tue, 22 Mar 2022 12:42:58 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id i12-20020a926d0c000000b002c3fa6cf756sm11169508ilc.25.2022.03.22.12.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 12:42:58 -0700 (PDT)
Date:   Tue, 22 Mar 2022 19:42:54 +0000
From:   Oliver Upton <oupton@google.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, maz@kernel.org,
        linux-kernel@vger.kernel.org, eauger@redhat.com,
        shan.gavin@gmail.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org
Subject: Re: [PATCH v5 01/22] KVM: arm64: Introduce template for inline
 functions
Message-ID: <YjomvjFNjGADmu6l@google.com>
References: <20220322080710.51727-1-gshan@redhat.com>
 <20220322080710.51727-2-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322080710.51727-2-gshan@redhat.com>
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

Hi Gavin,

On Tue, Mar 22, 2022 at 04:06:49PM +0800, Gavin Shan wrote:
> The inline functions used to get the SMCCC parameters have same
> layout. It means these functions can be presented by an unified
> template, to make the code simplified. Besides, this adds more
> similar inline functions like smccc_get_arg{4,5,6,7,8}() to get
> more SMCCC arguments, which are needed by SDEI virtualization
> support.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  include/kvm/arm_hypercalls.h | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/include/kvm/arm_hypercalls.h b/include/kvm/arm_hypercalls.h
> index 0e2509d27910..d5144c852fe4 100644
> --- a/include/kvm/arm_hypercalls.h
> +++ b/include/kvm/arm_hypercalls.h
> @@ -13,20 +13,20 @@ static inline u32 smccc_get_function(struct kvm_vcpu *vcpu)
>  	return vcpu_get_reg(vcpu, 0);
>  }
>  
> -static inline unsigned long smccc_get_arg1(struct kvm_vcpu *vcpu)
> -{
> -	return vcpu_get_reg(vcpu, 1);
> -}
> -
> -static inline unsigned long smccc_get_arg2(struct kvm_vcpu *vcpu)
> -{
> -	return vcpu_get_reg(vcpu, 2);
> +#define SMCCC_DECLARE_GET_ARG(reg)					\
> +static inline unsigned long smccc_get_arg##reg(struct kvm_vcpu *vcpu)	\
> +{									\
> +	return vcpu_get_reg(vcpu, reg);					\
>  }
>  
> -static inline unsigned long smccc_get_arg3(struct kvm_vcpu *vcpu)
> -{
> -	return vcpu_get_reg(vcpu, 3);
> -}
> +SMCCC_DECLARE_GET_ARG(1)
> +SMCCC_DECLARE_GET_ARG(2)
> +SMCCC_DECLARE_GET_ARG(3)
> +SMCCC_DECLARE_GET_ARG(4)
> +SMCCC_DECLARE_GET_ARG(5)
> +SMCCC_DECLARE_GET_ARG(6)
> +SMCCC_DECLARE_GET_ARG(7)
> +SMCCC_DECLARE_GET_ARG(8)

Hmm. What if we specify a single inline function where the caller passes
the arg # as a parameter? We really just want to abstract away the
off-by-one difference between GP registers and SMCCC arguments.

Macros generally make me uneasy for template functions, but I may be in
the vocal minority on this topic :)

--
Thanks,
Oliver
