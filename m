Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374694CADBE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 19:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243207AbiCBSl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 13:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbiCBSl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:41:28 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EE7D207B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 10:40:45 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id mr24-20020a17090b239800b001bf0a375440so205253pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 10:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sFxoRgrz8KohI1fJKR74aYbi9fTI6OzJ5gZS0IdaClo=;
        b=FqtKhM2WF7Jc6NpSCyY6TObLSgAalvebQmDZ7Cmnj3Q6/HPOsS2yrpPnaqq4PCyRlc
         rPuOQ3zSY6orsEbVMmCw8vqQmgu17OkywHjW/ut7YGDpCj2Z3eRmyVvHObByzeUYI1BI
         f9ykpZhAyXvTC2hGuLC7ICDLhWy3TMlg65fHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sFxoRgrz8KohI1fJKR74aYbi9fTI6OzJ5gZS0IdaClo=;
        b=SQugRM6i9Lex3OqnSqANR05/eJfUA44Ua3IhLPUtfSFpZ/xnfk3dvOTlGFNhabdYHL
         pr/DGCG88IkUs2PDPiDxfPDI+e21vrkQ8Z1PpF52dVwY/T0fY0HrVQmoso9aGxjkySpj
         FeA4s2EIPZYsGELw7GHz8cMXKEglwlvj0t6m19S8JSKWnB577GbEod7XVY4g1yNyThWa
         Uq6/Z5Wd8vEcgXgO+yIBUZwqRgwiDj8Ij2r/ng+vOgD0avSEBSvB4eB8zNkq9Io0xko5
         8IkPJ4kZDP2VxqXNriOzvVokcWjAznnLVWV8fnricViw4E1yDJ87Ze2YWdrNkK91CYFY
         ZpvQ==
X-Gm-Message-State: AOAM530OOsvCYIlpLnQfyT6/Ki3kzwAScsud1FgnlkvAKplfDVcTX5C1
        0mZ9HhrNaLER0BrJZkqDouAR8Q==
X-Google-Smtp-Source: ABdhPJyklsyONHI38lOVI0R5wsUnGsW6kq05jCjs2DiOqIxIjANGoPXFxwEDemY6YKQCv1gPZ1G1Qg==
X-Received: by 2002:a17:90b:1645:b0:1bf:11:66ae with SMTP id il5-20020a17090b164500b001bf001166aemr1164990pjb.198.1646246444742;
        Wed, 02 Mar 2022 10:40:44 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b3-20020a056a00114300b004cc39630bfcsm21702579pfm.207.2022.03.02.10.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 10:40:44 -0800 (PST)
Date:   Wed, 2 Mar 2022 10:40:43 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        joao@overdrivepizza.com, hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH v2 01/39] kbuild: Fix clang build
Message-ID: <202203021039.0DF89D3F2C@keescook>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.072632223@infradead.org>
 <CAKwvOdkD2WY=hEHy8_0zs70AGx6LRQwxL5mEZyB30uqpruYJyA@mail.gmail.com>
 <Yh+dMJsH+ZMPfqwD@thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh+dMJsH+ZMPfqwD@thelio-3990X>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 09:37:04AM -0700, Nathan Chancellor wrote:
> However, I think we could still address Peter's complaint of "there
> should be an easier way for me to use the tools that are already in my
> PATH" with his first iteration of this patch [1], which I feel is
> totally reasonable:
> 
> $ make LLVM=-14
> 
> It is still easy to use (in fact, it is shorter than 'CC=clang-14') and
> it does not change anything else about how we build with LLVM. We would
> just have to add something along the lines of
> 
> "If your LLVM tools have a suffix like Debian's (clang-14, ld.lld-14,
> etc.), use LLVM=<suffix>.
> 
> $ make LLVM=-14"
> 
> to Documentation/kbuild/llvm.rst.
> 
> I might change the patch not to be so clever though:
> 
> ifneq ($(LLVM),)
> ifneq ($(LLVM),1)
> LLVM_SFX := $(LLVM)
> endif
> endif

I like this idea! I think it's much easier to control than PATH (though
I see the rationale there too).

-- 
Kees Cook
