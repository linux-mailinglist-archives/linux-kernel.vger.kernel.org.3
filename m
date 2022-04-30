Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170E15160A4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 23:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245418AbiD3Vfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 17:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbiD3Vfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 17:35:37 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAB22315F
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 14:32:14 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id z18so12610438iob.5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 14:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6Dc326+1xtPNu80ribLvmOWmJsI+u5HwW/pN6DNiLdg=;
        b=BMDhYIWfw3HduEt7j5KU1o8O/B+WmLWME9DRVXpw+9VJzVQia/f2kl0Qz4UzNcEVh8
         fCk7Y7oogFoG8YokWaFmI30bM8f788SXMTbJu+jL/Lu1bajJ4ygKxPXpxS3INhE8lpI9
         qECtrk/Po6tesEuXtchgDVws9WJcG6sMwt1nyG2plOWi3DoKY7wBQoWzls/tTYeOTMaH
         7hHtRfjB7KGv1yxFV9PwCMxjC0abCIfYKUj2LmVtSHvyqx9q58dBUGxOiJ2LQQxSzIdF
         X/inLnmn2Havn1WIC0xlWVAJ7Z6P51rB+mDImAxVn9i8TX1lCgKqTcpa/YGMe1flxR6A
         9org==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Dc326+1xtPNu80ribLvmOWmJsI+u5HwW/pN6DNiLdg=;
        b=SderH9kEya9wvnIfbOBJNvYOYa8u0FyxQ9Bm14Gowf5g8a82mOpxeBay4Fhuj1bq2G
         3L/JH6gmRwSBokQhnDBFc0L6RoJxOGjl3GuCTaOwYB12PA4AQ2BwNOj5UDn7S/BqHpRW
         9CEmVMOJiVXkC7e0mPSfvj0ZNjwUCF2QB033DsmLE3VhetLxDiF63PbdHLJ5UGTQUWDc
         wrSa5j19o1APFaXheTTDMAc2BZHAZNnTSnm+DBpgwsqiHrw6K/2fwOsWi1m2Rsbj11Tg
         s81MrR5staSvH8VFnNazYLII+n0JEvvM0opAti/2NmQywmJ9FWl3k+uU+N7Xw0sF8L3g
         rD3g==
X-Gm-Message-State: AOAM5333z1bk+dRI3WJya/opm7kwWyvRaayD8+VA+4wjUYVOXodTU93X
        k1ygBW1/EQV7qFGergZaKDR8IA==
X-Google-Smtp-Source: ABdhPJwBjP+hA4Oy4Q6UzY3bpDakQPq3HCE59R2PRNvu86H6zjx4Y1dXSMTznllxBSVIarfUAr9JCQ==
X-Received: by 2002:a5d:9249:0:b0:64c:8a57:b7ec with SMTP id e9-20020a5d9249000000b0064c8a57b7ecmr2038499iol.65.1651354333946;
        Sat, 30 Apr 2022 14:32:13 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id 188-20020a021dc5000000b0032b52f27d73sm883572jaj.57.2022.04.30.14.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 14:32:12 -0700 (PDT)
Date:   Sat, 30 Apr 2022 21:32:09 +0000
From:   Oliver Upton <oupton@google.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        eauger@redhat.com, Jonathan.Cameron@huawei.com,
        vkuznets@redhat.com, will@kernel.org, shannon.zhaosl@gmail.com,
        james.morse@arm.com, mark.rutland@arm.com, maz@kernel.org,
        pbonzini@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v6 14/18] KVM: arm64: Support SDEI_EVENT_SIGNAL hypercall
Message-ID: <Ym2q2fUwPXNDcMjQ@google.com>
References: <20220403153911.12332-1-gshan@redhat.com>
 <20220403153911.12332-15-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403153911.12332-15-gshan@redhat.com>
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

Hi Gavin,

On Sun, Apr 03, 2022 at 11:39:07PM +0800, Gavin Shan wrote:
> This supports SDEI_EVENT_SIGNAL hypercall. It's used by guest
> to inject event, whose number must be zero to the specified
> vCPU. As the shared event isn't supported, calling vCPU is
> assumed to be the target.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/kvm/sdei.c | 45 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
> index ebdbe7810cf0..e1f6ab9800ee 100644
> --- a/arch/arm64/kvm/sdei.c
> +++ b/arch/arm64/kvm/sdei.c
> @@ -455,6 +455,48 @@ static unsigned long hypercall_mask(struct kvm_vcpu *vcpu, bool mask)
>  	return ret;
>  }
>  
> +static unsigned long hypercall_signal(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
> +	struct kvm_sdei_event *event;
> +	unsigned int num = smccc_get_arg(vcpu, 1);
> +	unsigned long ret = SDEI_SUCCESS;
> +
> +	/*
> +	 * The event must be the software signaled one, whose number
> +	 * is zero.
> +	 */
> +	if (!kvm_sdei_is_sw_signaled(num)) {
> +		ret = SDEI_INVALID_PARAMETERS;
> +		goto out;
> +	}
> +
> +	spin_lock(&vsdei->lock);
> +
> +	/* Check if the vcpu has been masked */
> +	if (vsdei->masked) {
> +		ret = SDEI_INVALID_PARAMETERS;
> +		goto unlock;
> +	}

You should still be able to signal an event if the vCPU is masked. Just
means the bit will rot in the pending bitmap until the vCPU is unmasked.

--
Thanks,
Oliver
