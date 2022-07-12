Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9575728DD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 23:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiGLV4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 17:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiGLV4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 17:56:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8705A49B57
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657662991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s/3T4vxNFVONPISbNOnbcOQJiMW1pUHoPXX64SqOHNQ=;
        b=YJyEoWoUEyPhKwnS91fBy/Aeiaxn95j1fQeV3i0F6vTCaaNNcBbLBm3jlgVQ/lx0mN9Qr3
        MNYHOc3K0fF8OW7ORqiETaDe8JkhYOwa9Q9tw3x8yAL15/o7Lg807x34tqX+x8S7UCDs64
        muVyBDD1RCT9vvmL4uCt2GoOV4ktBqA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-YhmgqhUjMbC1THjfYwF2bQ-1; Tue, 12 Jul 2022 17:56:30 -0400
X-MC-Unique: YhmgqhUjMbC1THjfYwF2bQ-1
Received: by mail-qk1-f199.google.com with SMTP id br43-20020a05620a462b00b006b5833f8132so6348221qkb.22
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s/3T4vxNFVONPISbNOnbcOQJiMW1pUHoPXX64SqOHNQ=;
        b=PkugZqieU04CqX13VJUxA7h6TjGFZQFMMguQDFEHhOhtFIff5wFfUWk9geY9rDxTT3
         Hhj8fcRPH8LBErGX5DN/Ic3O2FJZZG1FC4xcVsreuS/QsgWND3u9ziINrf9j6SFsG8kC
         0MeA90un6bUw9Mv2wCe6PDE3Wm1yMDP4qsY+SBp6FIVAXq7EWxj0udreCTjYHM5aVQNv
         LH+elKUGY+hPMNvipfBJuE/omfiDrt9G0EEIs6FfkiWuXHvDImXJnDfU8ngLTi2lvc5w
         jWDB262npKY2AWpFwBJw4IcLsM4Tvc/UwwIN4ar6VLQrApZiI1e7q1HBSsqD3Y49Lo5+
         GxKQ==
X-Gm-Message-State: AJIora86ggo08N82dtupgpTyY3WscDBemXx+KOWYk2q+RfDIKDVJ4dir
        yqt/qhU/LBfpl7szgUb0pAXhylsFCEdg9oUntcv8DDIriMOQ4ai4v7FwAnQT2jFG9vEp6OO1uXO
        faKO+QH8w53oDjkKBilbvY7Rf
X-Received: by 2002:ac8:4e94:0:b0:31b:f600:b59f with SMTP id 20-20020ac84e94000000b0031bf600b59fmr79258qtp.527.1657662990012;
        Tue, 12 Jul 2022 14:56:30 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vLwHaf4xn2tp3fYNXeTJIBe+MYbyQyS/7FEmpJ8XMqS+OfIe5Kxxt5cbR0Cnx3qgruuFWobw==
X-Received: by 2002:ac8:4e94:0:b0:31b:f600:b59f with SMTP id 20-20020ac84e94000000b0031bf600b59fmr79250qtp.527.1657662989829;
        Tue, 12 Jul 2022 14:56:29 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-37-74-12-30-48.dsl.bell.ca. [74.12.30.48])
        by smtp.gmail.com with ESMTPSA id cm23-20020a05622a251700b0031bed25394csm8390535qtb.3.2022.07.12.14.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 14:56:29 -0700 (PDT)
Date:   Tue, 12 Jul 2022 17:56:28 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] KVM: x86/mmu: Defer "full" MMU setup until after
 vendor hardware_setup()
Message-ID: <Ys3uDJ90dBeFFbka@xz-m1.local>
References: <20220624232735.3090056-1-seanjc@google.com>
 <20220624232735.3090056-3-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220624232735.3090056-3-seanjc@google.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 11:27:33PM +0000, Sean Christopherson wrote:
> @@ -11937,6 +11932,10 @@ int kvm_arch_hardware_setup(void *opaque)
>  
>  	kvm_ops_update(ops);
>  
> +	r = kvm_mmu_hardware_setup();
> +	if (r)
> +		goto out_unsetup;
> +
>  	kvm_register_perf_callbacks(ops->handle_intel_pt_intr);
>  
>  	if (!kvm_cpu_cap_has(X86_FEATURE_XSAVES))
> @@ -11960,12 +11959,18 @@ int kvm_arch_hardware_setup(void *opaque)
>  	kvm_caps.default_tsc_scaling_ratio = 1ULL << kvm_caps.tsc_scaling_ratio_frac_bits;
>  	kvm_init_msr_list();
>  	return 0;
> +
> +out_unsetup:
> +	static_call(kvm_x86_hardware_unsetup)();

Should this be kvm_mmu_hardware_unsetup()?  Or did I miss something?..

-- 
Peter Xu

