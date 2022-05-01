Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C96516256
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 09:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242661AbiEAG6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 02:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236606AbiEAG6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 02:58:38 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABD23B9
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 23:55:10 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id s14so149829ild.6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 23:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=66d7SyRrONsXl8W4lFBX0N0VrTFcPFH9NXUMscq4ECs=;
        b=gpPu6skWQ2IhiBwq3C3Wc2ylJ363rdzpeVUcCH8kt9q7dHvFWOJnbcsgRbrOQFYKcv
         xrJApxsgnQjhM+ch1GfLHZVpgsTsxgUrisEHTgxjKRMkpBQquVQ+/xBVCpfdJ93hA3K/
         SgsLTwxHUi4HHmRW9L/hPBCR2UvYVZowMynW9UKHqqyPyLrpYzubdqiO/QUGqdSViE7m
         z6tL918AfC6MwJ+iX0V19yA3+jIRdVzwhXFkj/UtPLcXe23XsUGoFMHkcSQTHPTEDl1q
         qTv/u+du++0uQwQVqkWvjlmDbakho2tAf7ecAylV/KuDI4v+JsMZK13/y6YihPVVZ5z+
         tgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=66d7SyRrONsXl8W4lFBX0N0VrTFcPFH9NXUMscq4ECs=;
        b=gKv2Nwp8/jAKSJ7mbotZiuZpB9C39TKmYggIkRuq4hnaAdVZgwnZDu7yKm4udMUXcT
         RduyRAYY49CXzKJR0+prDBMG2P8zvoB9OS8HYg8rUoe9OzgT3FTiybcrW8LvGHRJCwkr
         Y0kbZu/UWuYW8DqFMEGUQtevrp5quLdFZDp0cv91z7KCQElK/ut6Z7h44kOVPYzXsPFU
         g1SoDLz97/agNVHDFr12YLAW6Pam09gIjrzsMRmeViRQ5s6JXKC3Xx4kLDgEO5Oc33FE
         1D7Nv7WIfisvcowMzmHQIong4fNB2Uhmr13ovIYtlDGO1XlC0fWKdZ1r+83qAmvi6LyR
         WiXA==
X-Gm-Message-State: AOAM533hBhctLRR6+QUyrsA/c3m6IK79CZLBihPVWnvCY3A1H6bmcbCJ
        G8ifPBWYhNiYRd8pp5e+o8tw3Q==
X-Google-Smtp-Source: ABdhPJxyPVbw+8ZIaPFEomRXrig6kQMnEuxlIz0lgU1En0dO9EeQyCH8axYSrs0P1kc0Cz80nR0P1w==
X-Received: by 2002:a05:6e02:160f:b0:2cd:5c76:817e with SMTP id t15-20020a056e02160f00b002cd5c76817emr2859671ilu.133.1651388109758;
        Sat, 30 Apr 2022 23:55:09 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id t17-20020a6bdb11000000b0065a47e16f4csm1152530ioc.30.2022.04.30.23.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 23:55:08 -0700 (PDT)
Date:   Sun, 1 May 2022 06:55:05 +0000
From:   Oliver Upton <oupton@google.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        eauger@redhat.com, Jonathan.Cameron@huawei.com,
        vkuznets@redhat.com, will@kernel.org, shannon.zhaosl@gmail.com,
        james.morse@arm.com, mark.rutland@arm.com, maz@kernel.org,
        pbonzini@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v6 15/18] KVM: arm64: Support SDEI_FEATURES hypercall
Message-ID: <Ym4uyaGGhPXlnkHQ@google.com>
References: <20220403153911.12332-1-gshan@redhat.com>
 <20220403153911.12332-16-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403153911.12332-16-gshan@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2022 at 11:39:08PM +0800, Gavin Shan wrote:
> This supports SDEI_FEATURES hypercall. It's used by guest to
> retrieve the supported features, which are number of slots for
> the interrupt binding events and relative mode for the event
> handler. Currently, none of them is supported.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/kvm/sdei.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
> index e1f6ab9800ee..ab0b7b5e3191 100644
> --- a/arch/arm64/kvm/sdei.c
> +++ b/arch/arm64/kvm/sdei.c
> @@ -527,6 +527,23 @@ static unsigned long hypercall_reset(struct kvm_vcpu *vcpu, bool private)
>  	return ret;
>  }
>  
> +static unsigned long hypercall_features(struct kvm_vcpu *vcpu)
> +{
> +	unsigned long feature = smccc_get_arg(vcpu, 1);
> +	unsigned long ret;
> +
> +	switch (feature) {
> +	case 0: /* BIND_SLOTS */
> +	case 1: /* RELATIVE_MODE */

Can you create macros for these?

--
Thanks,
Oliver
