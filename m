Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145EC57BEE0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiGTTuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiGTTt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:49:58 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAE17393F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:49:54 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id o18so17333762pgu.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b+DylbHD8S48D4o1wD2FJSsTVK7ZV2ZeetMTzG1hbok=;
        b=Nf5eLtTSoGK+n/pFVXlIO9WwAt8+Liv5cKuLa8biUx3uV/GIqrb7OVTxI+ZytaVGWP
         9AWOkeHd5/GrDATS4TVzbvWvHcHXHoNZYD54XGOFqBZfnLSejsZsDsHEsccqs4uGSsb8
         JOeASjNTybNPMSAIppp8bk9u59XgERYOsniH+EG8oMOUxtCrzzm5+jSG8GOh5CM+CH0h
         7/sTUYzJ8aUanaQL9Ta7jAGEuD/d9KhGPlPnaKOmzfKXGzlw6sNw7Sef8dyt7Tup0dtq
         4cxX2+fvOxfhhxcG6fUtvx3Vks0LN3iTc/+/YW09paq/2XN9unbA3be7xuKy9jpzpgwc
         APiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b+DylbHD8S48D4o1wD2FJSsTVK7ZV2ZeetMTzG1hbok=;
        b=ki4NW7LMxveSZz2OmLXfBx70zxtuYZvEtzBA2rzyYw9FFUHQGxz/S29+Vs7xcV173v
         tq2WRXbsMxU/osOM5bn5f+shIvclWC/cjKKGGWQZC6Nf5UOT0kPDeSYtmiGXGdo4QusM
         jg6GL6PHwxsOkPR7m4+NK0DILUc8ZGBR3GCxpMh7hlmvij4gD94ph4AD9P61QsusSJL4
         +Z+B7R7WQd/HNVt1K6gF5b3XdlRIN2BCSlkZvrxV1nCBh0fT/Tw278ACTCvmKIHFRMB3
         KFEY1MXKjUL6spsHsvMRHiV1E9g+Ucn9Iv7RRPewg/L/05dPsddE+edyHYk/8Z928sVu
         kvLQ==
X-Gm-Message-State: AJIora+nH/7TsNdGnstakuOKthqnLpuD+A4+Fsyg/jX0gmMBhgNAXOsZ
        58cKChD6UPi+bUutDVdYZT2RtA==
X-Google-Smtp-Source: AGRyM1s74rEuPyhQq/4UZfKv6wWG2cJVZzIqK9DOXYh7Od54wqhHDZrQXo2riZ5uTGUUDlSDPyTo6A==
X-Received: by 2002:a05:6a00:27a6:b0:52a:e089:e777 with SMTP id bd38-20020a056a0027a600b0052ae089e777mr41652939pfb.53.1658346594084;
        Wed, 20 Jul 2022 12:49:54 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id v12-20020aa799cc000000b00528c149fe97sm19892pfi.89.2022.07.20.12.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 12:49:53 -0700 (PDT)
Date:   Wed, 20 Jul 2022 19:49:49 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     dave@sr71.net, Jarkko Sakkinen <jarkko@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Kai Huang <kai.huang@intel.com>,
        Haitao Huang <haitao.huang@linux.intel.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] x86/sgx: Allow enclaves to use Asynchrounous Exit
 Notification
Message-ID: <YthcXSTfjoM+jjvN@google.com>
References: <20220720191347.1343986-1-dave.hansen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720191347.1343986-1-dave.hansen@linux.intel.com>
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

On Wed, Jul 20, 2022, Dave Hansen wrote:
> Changes from v1:
>  * Make sure SGX_ATTR_ASYNC_EXIT_NOTIFY is in the masks that are
>    used at bare-metal enclave initialization and that enumerates
>    available attributes to KVM guests.

Heh, I was wondering if KVM needed to be updated.

> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 0c1ba6aa0765..96a73b5b4369 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1022,9 +1022,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  		 * userspace.  ATTRIBUTES.XFRM is not adjusted as userspace is
>  		 * expected to derive it from supported XCR0.
>  		 */
> -		entry->eax &= SGX_ATTR_DEBUG | SGX_ATTR_MODE64BIT |
> -			      SGX_ATTR_PROVISIONKEY | SGX_ATTR_EINITTOKENKEY |
> -			      SGX_ATTR_KSS;
> +		entry->eax &= SGX_ATTR_PRIV_MASK | SGX_ATTR_UNPRIV_MASK;

It may seem like a maintenance burdern, and it is to some extent, but I think it's
better for KVM to have to explicitly "enable" each flag.  There is no guarantee
that a new feature will not require additional KVM enabling, i.e. we want the pain
of having to manually update KVM so that we get "feature X isn't virtualized"
complaints and not "I upgraded my kernel and my enclaves broke" bug reports.

I don't think it's likely that attribute-based features will require additional
enabling since there aren't any virtualization controls for the ENCLU side of
things (ENCLU is effectively disabled by blocking ENCLS[ECREATE]), but updating
KVM isn't particularly difficult so I'd rather be paranoid.
