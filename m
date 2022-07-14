Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108155755DA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 21:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240534AbiGNTgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 15:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240519AbiGNTgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 15:36:41 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05CD5885D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 12:36:40 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id bf13so2467051pgb.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 12:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gsRk7t2Fg8fNdp4dpl5BvpQeyL4GIWzZfCIoGVEvJGs=;
        b=hh1/yTdZnCsVTYD0aANJOlF973VdVa5cXEwdjStzWlwFZx2sB6o/npf0HjLO96VXXX
         8/VfayIFFH+ueKb3Bd54td2xLD2QkQl4r58+4SiLqR8BhgUlYyNo0QBK2FXD/6Fk6Jg3
         N4xYe1IEHXBkHxp2nRqECxvEAOpO3Kp87CdcOeV20LnPIhuKL4f1Cl95eAjcd8vIZJSt
         jJGRGXb297hjV9l4jpCRETrsCNvDGhtlJOXaN+8w5Fqig1p0UEGXMoJSovJWFnHpjfQn
         /bQEFW1JtymD3IOPyOvtVuyKRmxPdvROYaTaNsHiOJl0GR+bs59ZbMejxOnDrCzbBQY3
         XRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gsRk7t2Fg8fNdp4dpl5BvpQeyL4GIWzZfCIoGVEvJGs=;
        b=b5aNGKceSYooNNZ8hQEkao0yTzPNqZeJ9VQVl/xlWM+7TvrEp6a92ZljM7AkPrNLj1
         uUHZ30gahuy2tJWGhnC0E5OfpQcy/GkvdD1rgGSoE2MqQG01kqvY3SmkdKzZQcDvLwnT
         IS2UzIFnxni3KPCmRH6UvAXPMUHoUTtSOxHPnY3SnPSKoZQuU5H15iBjv4LOHGDYJS2Y
         nvM6wuk8o8WjtVwq0Zh7tL+cvZ2c+OZ2V1WpkaEkFCVke24We//k8WGpUPcFbID4XPci
         UK7wdaCuQuhetgDp5qG8ljPKkV6BOhywQfTaBLTb4ykwtLoFUKAGdd75wgMvqtbc1YU0
         AWAQ==
X-Gm-Message-State: AJIora9xHP5GTxYqbwHrEt0+55SN4sODKQDCPmKGOe7r6XOiuhtw5xLg
        gFy426g2AZA1bi3bOBDWbxSJaQ==
X-Google-Smtp-Source: AGRyM1tT5lHblTli/9Mhvqlr+lDrujYvNGGf1erzZXg7w0/tgIkpMzNgEHD+oCWSoZfuw3mNNaZR1w==
X-Received: by 2002:a05:6a00:1704:b0:525:714b:5c77 with SMTP id h4-20020a056a00170400b00525714b5c77mr9910448pfc.29.1657827400359;
        Thu, 14 Jul 2022 12:36:40 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id b31-20020a631b1f000000b0041282c423e6sm1711103pgb.71.2022.07.14.12.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 12:36:39 -0700 (PDT)
Date:   Thu, 14 Jul 2022 19:36:36 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Yang, Weijiang" <weijiang.yang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rick.p.edgecombe@intel.com
Subject: Re: [PATCH 00/19] Refresh queued CET virtualization series
Message-ID: <YtBwRIiZi262hHiE@google.com>
References: <20220616084643.19564-1-weijiang.yang@intel.com>
 <YqsB9upUystxvl+d@hirez.programming.kicks-ass.net>
 <62d4f7f0-e7b2-83ad-a2c7-a90153129da2@redhat.com>
 <Yqs7qjjbqxpw62B/@hirez.programming.kicks-ass.net>
 <8a38488d-fb6e-72f9-3529-b098a97d8c97@redhat.com>
 <2855f8a9-1f77-0265-f02c-b7d584bd8990@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2855f8a9-1f77-0265-f02c-b7d584bd8990@intel.com>
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

On Sat, Jun 18, 2022, Yang, Weijiang wrote:
> 
> On 6/16/2022 11:28 PM, Paolo Bonzini wrote:
> > If you build with !X86_KERNEL_IBT, KVM can still rely on the FPU state
> > for U_CET state, and S_CET is saved/restored via the VMCS independent of
> > X86_KERNEL_IBT.
> 
> A fundamental question is, should KVM always honor host CET enablement
> before expose the feature to guest? i.e., check X86_KERNEL_IBT and
> X86_SHADOW_STACK.

If there is a legitimate use case to NOT require host enablement and it's 100%
safe to do so (within requiring hacks to the core kernel), then there's no hard
requirement that says KVM can't virtualize a feature that's not used by the host.

It's definitely uncommon; unless I'm forgetting features, LA57 is the only feature
that KVM fully virtualizes (as opposed to emulates in software) without requiring
host enablement.  Ah, and good ol' MPX, which is probably the best prior are since
it shares the same XSAVE+VMCS for user+supervisor state management.  So more than
one, but still not very many.

But, requiring host "support" is the de facto standard largely because features
tend to fall into one of three categories:

  1. The feature is always available, i.e. doesn't have a software enable/disable
     flag.

  2. The feature isn't explicitly disabled in cpufeatures / x86_capability even
     if it's not used by the host.  E.g. MONITOR/MWAIT comes to mind where the
     host can be configured to not use MWAIT for idle, but it's still reported
     as supported (and for that case, KVM does have to explicitly guard against
     X86_BUG_MONITOR).

  3. Require some amount of host support, e.g. exposing XSAVE without the kernel
     knowing how to save/restore all that state wouldn't end well.

In other words, virtualizing a feature if it's disabled in the host is allowed,
but it's rare because there just aren't many features where doing so is possible
_and_ necessary.
