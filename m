Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A6E57E6ED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 21:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbiGVTAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 15:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiGVTAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 15:00:25 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EAF1570C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 12:00:23 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id ku18so5131054pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 12:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h0ufdNeiYqfMuypR3ZZlDpDYrErqoCi+vB/gT2XuF2g=;
        b=WnhIOXR9V9QRJyMMWlFX0qVsle5XohtimvQASOwwvOHtCPjE0klYnneZAG7OyDWs1q
         pvMY+63UlQDtJqO7je9qVQylPytUIIsI8yNEkGiRMFoQctbHdFYBF1KUTd2lhARS34wo
         98/3c5h1UeO8dF0ojkGrxc2YsaqrPSkJlauMoLbeYXwlRTMeOzvotF0lD2VjDCAw1amk
         eQDGcizrPVOuaiRUtV2U33TZquYXrsg1q3G1UmVMB5nEK8amp38kGYgEvCuMVmO94seW
         yeymKgQqlN2G9aX/fwqKUTkGn5/Yzpp3F9ndibMUanqgJdhXEPVP+NAlkN/Kj8k1gMxh
         2uwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h0ufdNeiYqfMuypR3ZZlDpDYrErqoCi+vB/gT2XuF2g=;
        b=jP3++y6OSh/HK3fFuEyvyJZlz6p8D8//v+GnYsEBFNtZCCdAsbGhfGRFlssdPYTjG8
         0Gh3C6GbiLoIAxETWnr4TyOPVyJMT7N0nXlq9maIOCblgwDwt8Kd2I5pzy+gqHNzH+8G
         F6xEkGG1Dp8Pe4jY6Q3a/t5eC+MOMKQa721bI2NicNfDR76AjkaffxWHGo8gU7w4AUkx
         Nc6yF+9db1xkzTnnj1EYC7P+saEXkrHKXf1UewE22mb0CPOjbO5ltfQQbmkIKojpaKLr
         tFJUgPpREafQ2bOvemUWiFUG2qQUl/k4BWi6RZBvNOl8vIV7gWvTf+Ie6L6Dn+wuaSkv
         ErFA==
X-Gm-Message-State: AJIora/01G9jInVDYkCsD/oljUSADHkLS4Jn0onA/FjYHTKLyzoWbucD
        tw8jWfesQ1C6LRPHFfkcS+Ynmg==
X-Google-Smtp-Source: AGRyM1sjc41xLj6BjTeZif1moV0XCEceVJ7SCEifMIlzHmkviIGQxhRG9dW3PcyYftax1ifHKT+vIw==
X-Received: by 2002:a17:902:ea07:b0:16c:1efb:916e with SMTP id s7-20020a170902ea0700b0016c1efb916emr914512plg.25.1658516422655;
        Fri, 22 Jul 2022 12:00:22 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id e16-20020a63db10000000b0041981461f5dsm3714332pgg.90.2022.07.22.12.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 12:00:21 -0700 (PDT)
Date:   Fri, 22 Jul 2022 19:00:17 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, dave@sr71.net,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Kai Huang <kai.huang@intel.com>,
        Haitao Huang <haitao.huang@linux.intel.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] x86/sgx: Allow enclaves to use Asynchrounous Exit
 Notification
Message-ID: <YtrzwbLZjc+jURDI@google.com>
References: <20220720191347.1343986-1-dave.hansen@linux.intel.com>
 <YthcXSTfjoM+jjvN@google.com>
 <00b07459-5512-b00b-636b-f35845ec369f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00b07459-5512-b00b-636b-f35845ec369f@intel.com>
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
> On 7/20/22 12:49, Sean Christopherson wrote:
> > On Wed, Jul 20, 2022, Dave Hansen wrote:
> >> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> >> index 0c1ba6aa0765..96a73b5b4369 100644
> >> --- a/arch/x86/kvm/cpuid.c
> >> +++ b/arch/x86/kvm/cpuid.c
> >> @@ -1022,9 +1022,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
> >>  		 * userspace.  ATTRIBUTES.XFRM is not adjusted as userspace is
> >>  		 * expected to derive it from supported XCR0.
> >>  		 */
> >> -		entry->eax &= SGX_ATTR_DEBUG | SGX_ATTR_MODE64BIT |
> >> -			      SGX_ATTR_PROVISIONKEY | SGX_ATTR_EINITTOKENKEY |
> >> -			      SGX_ATTR_KSS;
> >> +		entry->eax &= SGX_ATTR_PRIV_MASK | SGX_ATTR_UNPRIV_MASK;
> > 
> > It may seem like a maintenance burdern, and it is to some extent, but I think it's
> > better for KVM to have to explicitly "enable" each flag.  There is no guarantee
> > that a new feature will not require additional KVM enabling, i.e. we want the pain
> > of having to manually update KVM so that we get "feature X isn't virtualized"
> > complaints and not "I upgraded my kernel and my enclaves broke" bug reports.
> > 
> > I don't think it's likely that attribute-based features will require additional
> > enabling since there aren't any virtualization controls for the ENCLU side of
> > things (ENCLU is effectively disabled by blocking ENCLS[ECREATE]), but updating
> > KVM isn't particularly difficult so I'd rather be paranoid.
> 
> How about something where KVM gets to keep a discrete mask, but where
> it's at least defined next to the attributes, something like:
> 
> /*
>  * These attributes will be advertised to KVM guests as being
>  * available.  This includes privileged attributes.  Only add
>  * to this list when host-side KVM does not require additional
>  * enabling for the attribute.
>  */
> #define SGX_ATTR_KVM_MASK       (SGX_ATTR_DEBUG         | \
>                                  SGX_ATTR_MODE64BIT     | \
>                                  SGX_ATTR_PROVISIONKEY  | \
>                                  SGX_ATTR_EINITTOKENKEY | \
>                                  SGX_ATTR_KSS           | \
>                                  SGX_ATTR_ASYNC_EXIT_NOTIFY)
> 
> That at least has a *chance* of someone seeing it who goes to add a new
> attribute.

Hmm, what if we enforce it in code with a compile-time assert?  That will make it
even harder to screw things up, and it also avoids a scenario where someone
extends SGX_ATTR_KVM_MASK without getting approval from KVM folks.  And conversely,
KVM won't need to touch SGX files if there's ever a need to tweak KVM behavior.

		/*
		 * Index 1: SECS.ATTRIBUTES.  ATTRIBUTES are restricted a la
		 * feature flags.  Advertise all supported flags, including
		 * privileged attributes that require explicit opt-in from
		 * userspace.  ATTRIBUTES.XFRM is not adjusted as userspace is
		 * expected to derive it from supported XCR0.
		 */
#define KVM_SGX_ATTR_ALLOWED_MASK (SGX_ATTR_DEBUG |		\
				   SGX_ATTR_MODE64BIT |		\
				   SGX_ATTR_PROVISIONKEY |	\
				   SGX_ATTR_EINITTOKENKEY |	\
				   SGX_ATTR_KSS |		\
				   SGX_ATTR_ASYNC_EXIT_NOTIFY)

#define KVM_SGX_ATTR_DENIED_MASK (0)

		/*
		 * Assert that KVM explicitly allows or denies exposing all
		 * features, i.e. detect attempts to add kernel support without
		 * also updating KVM.
		 */
		BUILD_BUG_ON((KVM_SGX_ATTR_ALLOWED_MASK | KVM_SGX_ATTR_DENIED_MASK) !=
			     (SGX_ATTR_PRIV_MASK | SGX_ATTR_UNPRIV_MASK));

		entry->eax &= KVM_SGX_ATTR_ALLOWED_MASK;
		entry->ebx &= 0;
		break;
