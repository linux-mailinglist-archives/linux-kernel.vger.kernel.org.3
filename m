Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A933542F38
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 13:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238036AbiFHL36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 07:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238026AbiFHL3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 07:29:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46D7F19322F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 04:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654687790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sjjh9mjrrLd/KMp3FEsD5rNPrO+WiPNF11Vn/yRkM94=;
        b=g+wsw+51m5suBrhXUbE8Dk3O48xUtmh00OudEMVlmQNsYQK6syNs0FFpGiG6I3bnKcMz9J
        QCDrteqqR4qqpoGW9r5flQBbhanTBsVHKEIgDxhtWyz8T7w9D69CAgLoHt0X0CBpvjMuBb
        ENjv+M2rK4PNG6OMCozWyfRAItsfBuE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-292-MSti5YZ1OrqR__TuvyYIbA-1; Wed, 08 Jun 2022 07:29:45 -0400
X-MC-Unique: MSti5YZ1OrqR__TuvyYIbA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA447800124;
        Wed,  8 Jun 2022 11:29:44 +0000 (UTC)
Received: from starship (unknown [10.40.194.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D16D492C3B;
        Wed,  8 Jun 2022 11:29:40 +0000 (UTC)
Message-ID: <3943020ac3540af8055c487e4810c63a422d65e7.camel@redhat.com>
Subject: Re: [PATCH] crypto: x86/aes-ni: fix AVX detection
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Borislav Petkov <bp@alien8.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Date:   Wed, 08 Jun 2022 14:29:39 +0300
In-Reply-To: <622444d6-f98b-dae4-381e-192e5cb02621@intel.com>
References: <20211103124614.499580-1-mlevitsk@redhat.com>
         <622444d6-f98b-dae4-381e-192e5cb02621@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-11-03 at 07:43 -0700, Dave Hansen wrote:
> On 11/3/21 5:46 AM, Maxim Levitsky wrote:
> > Fix two semi-theoretical issues that are present.
> > 
> > 1. AVX is assumed to be present when AVX2 is present.
> >  That can be false in a VM.
> >  This can be considered a hypervisor bug,
> >  but the kernel should not crash in this case if this is possible.
> 
> The kernel shouldn't crash in this case.  We've got a software
> dependency which should disable AVX2 if AVX is off:
> 
> static const struct cpuid_dep cpuid_deps[] = {
> ...
>         { X86_FEATURE_AVX2,                     X86_FEATURE_AVX,      },



Looks like this table is only used when someone calls setup_clear_cpu_cap/clear_cpu_cap
which is used in all kind of places to disable CPU features that fails various conditions
(like VMX/SMX when MSR_IA32_FEAT_CTL suddently faults, or to disable RDRAND when
it fails built-in selfcheck and such, and it is used when user disables features on
kernel cmd line like the 'noxsave'

Also we do have the 'filter_cpuid_features' which disables some CPUID features,
which depend on whole CPUID leaves to be there.
This is the only precendent of the kernel coping with a bogus CPUID given by the
hypervisor, and it is even mentioned in a comment near this code.


filter_cpuid_features can be extended to filter known bogus CPUID depedencies,
like case when AVX2 supported and AVX not supported in CPUID.
If you agree, then it seems the best case to deal with this issue.

> 
> 
> > 2. YMM state can be soft disabled in XCR0.
> > 
> > Fix both issues by using 'cpu_has_xfeatures(XFEATURE_MASK_YMM')
> > to check for usable AVX support.
> 
> There's another table to ensure that this doesn't happen:
> 
> > static unsigned short xsave_cpuid_features[] __initdata = {
> >         [XFEATURE_FP]                           = X86_FEATURE_FPU,
> >         [XFEATURE_SSE]                          = X86_FEATURE_XMM,
> >         [XFEATURE_YMM]                          = X86_FEATURE_AVX,
> 
> So, if XFEATURE_YMM isn't supported, X86_FEATURE_AVX should be cleared.

I afraid that it is the other way around - this table makes sure that
we disable 'XFEATURE_YMM' in the xsave header when we (the kernel) uses
the xsave instruction, if the X86_FEATURE_AVX is not supported.

However, I haven't found a way to disable selected xfeatures, but only the
'noxsave/noxsaves/etc' which disable the whole feature in cpuid,
and that indeed does trigger the disablement via 'cpuid_deps' table.

> 
> But, that's all how it's _supposed_ to work.  It's quite possible we've
> got bugs somewhere, so if you're hitting an issue in practice please let
> us know.
> 
> If this did end up confusing you and Paulo, that's not great either.
> Any patches that make these dependency tables easier to find or grok
> would be appreciated too.
> 


Sorry for very late reply, I haven't gotten to work on this bug for a while,
Best regards,
	Maxim Levitsky

