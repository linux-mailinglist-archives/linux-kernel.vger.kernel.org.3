Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4675333F1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 01:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242661AbiEXXec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 19:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbiEXXe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 19:34:29 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CFD53A68
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 16:34:27 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id a9so15500441pgv.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 16:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n7kAS8+SQg3tDfrlbZ5mmg1qDbfS/foHLDASc1bodBQ=;
        b=hsmkfm94yZzmyGgiMh7SVk0307c6XUeiNjpNHK6WgBdeEImYn9OYzmElvKdMQzl73I
         NxlfdLV3IJ4KvpwDhrw8gm7W0YtIBI9IGv9SHI9z2KGPajHD0H5ht9llBBW9pm97iRoH
         Iy35bJ3sKBVge5ryTwLDbzzQVJsp45iOqS1pDVaEyEmGohvlVNTdkl+TPQVLfbt1ULbw
         i/25kJpTgdo1npSKYpi3+oQeVgp6RMgOFfdMrDXs7islasSuTfEFIdIEZD+rChdi4XqC
         sOFFSiyU6zO5n30EWjuDq2+KRMnVYiA225CHXERr3SWyqq/41vC5YibErMBoXLYPkuNZ
         mVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n7kAS8+SQg3tDfrlbZ5mmg1qDbfS/foHLDASc1bodBQ=;
        b=7FI3Kwx7D1ojAdEXu22dLSZgC1kGVNsnWCxlVg0CsbBbAkiep2amPykaaVo10+vk52
         kfP3c2x6Sngqxx+vLEWIY2O1tW2lMlAimJu+pQa627SBgUc7272gBJ1zsN8o7OQYG6gY
         9snAhMCaERLyvuGmGBhHh6DSSq3xW/TxLIdCI+mUmr5Vzv+Vq3fcpVmQD0U6O8RxdIo6
         OGIbBTfG8UYYOMEJAqXupGiGeIvEET08l6OvZoS6hntmokcDSdYjNQPK2trrgBxzL9C8
         7v74LV4bqyjWMUbXXCry+/8QdBzhrQx91Z1M2NU3GDRcFy65dzKs4g6waL7MS/S/ypK5
         1agQ==
X-Gm-Message-State: AOAM530p5lEeww3Mlfp+SK30ik2rIFURtuwk3XXRaZ1gZ5LLglnw5LX5
        whOOnK7xM5xVLF241nGWYtgDrw==
X-Google-Smtp-Source: ABdhPJyDWPLMrtzkOnYZQxyyfR9Q/SCaxQt2DmghU0OjgDSGxQCpEOoC3wcosmhMJnat9Eg3o2vJKA==
X-Received: by 2002:a63:5522:0:b0:3c5:e4be:5a49 with SMTP id j34-20020a635522000000b003c5e4be5a49mr25717828pgb.26.1653435267062;
        Tue, 24 May 2022 16:34:27 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id a12-20020aa780cc000000b005184640c939sm399613pfn.207.2022.05.24.16.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 16:34:26 -0700 (PDT)
Date:   Tue, 24 May 2022 23:34:22 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Lei Wang <lei4.wang@intel.com>
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, chenyi.qiang@intel.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 7/8] KVM: VMX: Expose PKS to guest
Message-ID: <Yo1rfrnV5nObIHJK@google.com>
References: <20220424101557.134102-1-lei4.wang@intel.com>
 <20220424101557.134102-8-lei4.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424101557.134102-8-lei4.wang@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022, Lei Wang wrote:
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 9d0588e85410..cbcb0d7b47a4 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -3250,7 +3250,7 @@ void vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
>  		}
>  
>  		/*
> -		 * SMEP/SMAP/PKU is disabled if CPU is in non-paging mode in
> +		 * SMEP/SMAP/PKU/PKS is disabled if CPU is in non-paging mode in
>  		 * hardware.  To emulate this behavior, SMEP/SMAP/PKU needs

Heh, missed one ;-)  Let's reduce future pain and reword this whole comment:

		/*
		 * SMEP/SMAP/PKU/PKS are effectively disabled if the CPU is in
		 * non-paging mode in hardware.  To emulate this behavior,
		 * clear them in the hardware CR4 when the guest switches to
		 * non-paging mode and unrestricted guest is disabled, as KVM
		 * must run the guest with hardware CR0.PG=1.
		 */


>  		 * to be manually disabled when guest switches to non-paging
>  		 * mode.
