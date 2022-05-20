Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D5652F434
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 22:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353400AbiETUGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 16:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353397AbiETUGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 16:06:16 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A69186FC
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 13:06:14 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d22so8205176plr.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 13:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oxi/xz+TkSciTWltjC+rtPwMZ91WNdjZnku8HYu4+Do=;
        b=YLeZA/Kh3pdiyKkWKKN8fsqVCpHcK0kf8mkJoiOqg1Jo1ti+YqjrFSeBaCwmg8jaRG
         rHFTxR2ltkA2sJ0JQ+0plz29WFRu3tI8SAk6hO7A3UE70QuOEuOLy35bHN0zuhqHfwpP
         x1QpI3WbaCBFV0ddp254gRd0Fj47AN5AVwIyuxuSB/ZWFJ2KTDKahAQ2tjH1WZyVv2Ir
         VU0eXJgp4bQfGuqAb3ZeLpZg6kCJ/F4Iso+4kTolcMYknPHyxEJrm6QrU/mpVcoxMqwR
         OeF18Usf87IA5s3EP0cyxw5oi76OBRTCQ/YaN0tRelrW3M8egRPqD9Xxr/cg2impTibm
         v37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oxi/xz+TkSciTWltjC+rtPwMZ91WNdjZnku8HYu4+Do=;
        b=3B7SEtwPn3KoXxjpRmpfihknNjo3RKrViDec/YdJsJUnYYDEl5yJyDKH4K6HSFgZVb
         Bnh3sYmmqHNRUdQtmeP8Bh9mBwx0SXBj8T6k1jTMFc+Muq8nnqBJ445jgjUnMf3pLmtQ
         enS5O5TihsfUZwSD1qQO/vUUinLUJFan4JB6s59YG7SuJmCJFB9qTL9jHaH65hujE1y9
         zBnGRxUa6lza/hKo9qY/wF29FxHSl39pr7rnkf75lHA1ACcGc5TZtkw5QItJvEaspuw8
         gSSrOwZmkyZOv+RmlxGD69TyTsQU2PB6D3BucPGbVbXUMkwge1WmB9ogKfM2ENIsOsjB
         MrlA==
X-Gm-Message-State: AOAM532+i5Qdc2HXTPKogKDggsFXHg/BFpZgE6L75EyZhSMyMasrasYU
        tXbSwhzByXSIF2oy/MQKZvmKLg==
X-Google-Smtp-Source: ABdhPJwCAh2L7xVmugWXxwOMvGlfvdKsTSxrUSMsWmDJKPsXKxG8pNYNQZ0N5fdRgJfnez3HVXcYmA==
X-Received: by 2002:a17:90b:250c:b0:1df:453f:561a with SMTP id ns12-20020a17090b250c00b001df453f561amr12763432pjb.35.1653077174024;
        Fri, 20 May 2022 13:06:14 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id z1-20020a17090ab10100b001df93c8e737sm2244751pjq.39.2022.05.20.13.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 13:06:13 -0700 (PDT)
Date:   Fri, 20 May 2022 20:06:09 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Jon Kohler <jon@nutanix.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Waiman Long <longman@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: VMX: do not disable interception for
 MSR_IA32_SPEC_CTRL on eIBRS
Message-ID: <Yof0sSy/xKrCY5ke@google.com>
References: <20220512174427.3608-1-jon@nutanix.com>
 <YoRPDp/3jfDUE529@google.com>
 <29CDF294-5394-47C7-8B50-5F1FC101891C@nutanix.com>
 <732266F9-9904-434A-857F-847203901A0C@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <732266F9-9904-434A-857F-847203901A0C@nutanix.com>
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

On Fri, May 20, 2022, Jon Kohler wrote:
> 
> > On May 18, 2022, at 10:23 AM, Jon Kohler <jon@nutanix.com> wrote:
> > 
> >> On May 17, 2022, at 9:42 PM, Sean Christopherson <seanjc@google.com> wrote:
> >>> +		if (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED) && data == BIT(0)) {
> >> 
> >> Use SPEC_CTRL_IBRS instead of open coding "BIT(0)", then a chunk of the comment
> >> goes away.
> >> 
> >>> +			vmx->spec_ctrl = data;
> >>> +			break;
> >>> +		}
> >> 
> >> There's no need for a separate if statement.  And the boot_cpu_has() check can
> >> be dropped, kvm_spec_ctrl_test_value() has already verified the bit is writable
> >> (unless you're worried about bit 0 being used for something else?)
> 
> I was (and am) worried about misbehaving guests on pre-eIBRS systems spamming IBRS
> MSR, which we wouldn’t be able to see today. Intel’s guidance for eIBRS has long been
> set it once and be done with it, so any eIBRS aware guest should behave nicely with that.
> That limits the blast radius a bit here.

Then check the guest capabilities, not the host flag.

	if (data == SPEC_CTRL_IBRS &&
	    (vcpu->arch.arch_capabilities & ARCH_CAP_IBRS_ALL))

> Sent out the v2 just now with a few minor tweaks, only notable one was keeping
> the boot cpu check and small tweaks to comments here and there to suit.

In the future, give reviewers a bit of time to respond to a contented point before
sending out the next revision, e.g. you could have avoided v3 :-)
