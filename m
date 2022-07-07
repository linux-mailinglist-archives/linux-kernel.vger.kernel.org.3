Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636B256AEDC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 01:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbiGGXK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 19:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236420AbiGGXK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 19:10:56 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952286050F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 16:10:55 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id x18-20020a17090a8a9200b001ef83b332f5so242193pjn.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 16:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TqoITV2pKW32A4dt41SN4K/+XbRSwwvZNic7w5oXhBA=;
        b=aYs3bZQ1BCJjjPgBnSRGEbYaFkv+Iv8EEgeOrHKNmoqqEiSsZ0LdFntkloSGbcUeUU
         fiJGTQ28PCl7Xn2j8DwMdxNYmLnKoroRrcA27UO9bNBKSStsrGG1cKHfJBBHW3jm1xyx
         URvyw5cWZ+5kBh1emLqGyhQXGVptCWZhAQrt2DFw8ufP1eA598eMG4zaF6Qo2IXjV+ze
         Kz11jUYpa5gt+XubsghdEqVLuTNSF16rESYQO6Hd+b3KwkcwlEZ3UCmSEls3dxXmWOLv
         sDrLZudS/HntODg5hMKDeCp9zlcxNcvN01iz1xzuXct6/WYslFmfOaJUmR7j5Q3R4NO7
         h7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TqoITV2pKW32A4dt41SN4K/+XbRSwwvZNic7w5oXhBA=;
        b=SAL/l1JDZt2ANWjkgdxoddccIRm9HL8aSfrCfn5WUjYqGguHCzr89JeRRkk/2/7B9h
         +/kqBYBVzvXHkdbL87FJiGrRDgltCFLvQ+ASPzBHiTI2sgVRj5vZuRsr41aIgBisK7/p
         ssMj0ilgX2X5ZbfNmder02O3jqqA5geLJSiwQ2CrQTEwQ3NgzCXwEdJOpsa0WOXmMSFI
         7HjG4bcvu/98/1AQShsv7YqLh7JqMdgdSEoQ8H7rwLr4kIA4amwLDUn/XwdaSNao1Joy
         2HGzy/6nmG8TEiGZhoLufSFyvgGHl9F0BHnPlljZo9Vwz2OsEPKkhw1Dm83+Odj1gy6w
         mUUA==
X-Gm-Message-State: AJIora8kznsgzuewgVHuYK0n/zxuEVOco3fqOmMGQenacwaii6QXku26
        G8fcuHrnJXcdK5BLJBX5ryGBjQ==
X-Google-Smtp-Source: AGRyM1uZIJNZXUsYe+zR0XtBe4h3Xn2PoOIdAia3O5yVwvGe6Wp2msoXjkxftcPAEWGr9UWTwdot4Q==
X-Received: by 2002:a17:90b:1c02:b0:1ed:4bfb:7772 with SMTP id oc2-20020a17090b1c0200b001ed4bfb7772mr8300513pjb.139.1657235455012;
        Thu, 07 Jul 2022 16:10:55 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id l189-20020a6225c6000000b005255263a864sm27556291pfl.169.2022.07.07.16.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 16:10:54 -0700 (PDT)
Date:   Thu, 7 Jul 2022 23:10:50 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Gautam Menghani <gautammenghani201@gmail.com>
Cc:     pbonzini@redhat.com, shuah@kernel.org, yang.zhong@intel.com,
        jmattson@google.com, peterx@redhat.com, guang.zeng@intel.com,
        wei.w.wang@intel.com, dmatlack@google.com, vkuznets@redhat.com,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/kvm: Add error messages before skipping tests
 in vm_xsave_req_perm()
Message-ID: <Ysdn+ia40BSKnXU+@google.com>
References: <20220704163538.31165-1-gautammenghani201@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704163538.31165-1-gautammenghani201@gmail.com>
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

On Mon, Jul 04, 2022, Gautam Menghani wrote:
> Add messages in the checks that are performed before making a request
> with ARCH_REQ_XCOMP_GUEST_PERM.
> 
> Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
> ---
>  tools/testing/selftests/kvm/lib/x86_64/processor.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index ead7011ee8f6..c74e846661b7 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -643,11 +643,15 @@ void vm_xsave_req_perm(int bit)
>  	if (rc == -1 && (errno == ENXIO || errno == EINVAL))
>  		exit(KSFT_SKIP);
>  	TEST_ASSERT(rc == 0, "KVM_GET_DEVICE_ATTR(0, KVM_X86_XCOMP_GUEST_SUPP) error: %ld", rc);
> -	if (!(bitmask & (1ULL << bit)))
> +	if (!(bitmask & (1ULL << bit))) {
> +		print_skip("Userspace address of attr data is blank");
>  		exit(KSFT_SKIP);
> +	}
>  
> -	if (!is_xfd_supported())
> +	if (!is_xfd_supported()) {
> +		print_skip("XFD is not supported");
>  		exit(KSFT_SKIP);
> +	}

This is no longer necessary as of commit 7ed397d107d4 ("KVM: selftests: Add
TEST_REQUIRE macros to reduce skipping copy+paste"), which will automagically
print the missing requirement before calling exit().

Thanks much for the patch though!
