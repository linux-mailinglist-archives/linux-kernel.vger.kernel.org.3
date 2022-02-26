Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF6E4C53C0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 05:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiBZE6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 23:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiBZE6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 23:58:38 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2247513CA3F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 20:58:05 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id gl14-20020a17090b120e00b001bc2182c3d5so8647331pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 20:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5WDq2AfJRdEk3uwNCX9CCL0Qxk/1zT3oEVQ37zTBxiQ=;
        b=c3aDV/sWGC8Aav0gTokKYXKTVE9bAzdOg/VodTQkI1ZuWDFLBaAapUK41ly/1s3IY/
         W+Z6/i2+AiHX1zTPTIWN0fxwS7weXUa9htEgesB3a3/aUvLro2QbUvmJvb7PuCo8MDxY
         cWLiWBjaqvM9w53HJp7E2yo9+WCoeGP3wPwnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5WDq2AfJRdEk3uwNCX9CCL0Qxk/1zT3oEVQ37zTBxiQ=;
        b=5C9DM4tnHmlEe9XJHgYltSIMH9CgtDGOBiFk3vTkF04I+jOA1oH23ZxxaKheqC9eh8
         Sx7MvMrZGg6fWHUhQLaUIbsHwgFgzcwKw6/akPqjejcEKxWVpEUWnOMxyOLOn2XE+TfJ
         SnuNxLnKKb38+B9qafKD6/9x070yb8EObb6mdxB4Xuw0XGWbc2cOV8DqRI9oxLWw+lmL
         qQ+uWWMkIisgeFyQuHzysWaFuBmojHfaq27Z8kjvOc8iU926o3y/Y9hgtOSycFq5mDJv
         IRjyVQW0V0niq1F6sAzkkZpDccZubdI+4R5TRLSc5FYgHc30DzB9YQEVW/ZKW0myGwUH
         WihQ==
X-Gm-Message-State: AOAM5319zAz+olXGFfZFQ6ivSQ6umE2CC4keEPNhq1BGmGKsNpQaVa0l
        x7DjDnbC0BVwLiM94WFT85diNg==
X-Google-Smtp-Source: ABdhPJw+Pq5ORed8exj9wiY5jEUAPWkvWhs95qMwc9/ZjM7l7Vq7hTKWaYi8/0ifVsSFdaFo8S2A8g==
X-Received: by 2002:a17:90a:6a45:b0:1bc:5899:c960 with SMTP id d5-20020a17090a6a4500b001bc5899c960mr6431453pjm.128.1645851484628;
        Fri, 25 Feb 2022 20:58:04 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v3-20020a17090a088300b001bc76ed4ad9sm11129598pjc.9.2022.02.25.20.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 20:58:04 -0800 (PST)
Date:   Fri, 25 Feb 2022 20:58:03 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Joao Moreira <joao@overdrivepizza.com>,
        Fangrui Song <maskray@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, mhiramat@kernel.org,
        alexei.starovoitov@gmail.com, llvm@lists.linux.dev
Subject: Re: [PATCH v2 05/39] x86: Base IBT bits
Message-ID: <202202252055.AB16A4B8@keescook>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.307406918@infradead.org>
 <202202241627.EEF3D5D2@keescook>
 <YhgnA8O4Bp19hfse@dev-arch.archlinux-ax161>
 <YhlTRhh7qj538ygM@dev-arch.archlinux-ax161>
 <605731324a76f36aafa87bd9390808c3@overdrivepizza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <605731324a76f36aafa87bd9390808c3@overdrivepizza.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 04:29:49PM -0800, Joao Moreira wrote:
> > https://github.com/ClangBuiltLinux/linux/issues/1606
> 
> Candidate fix: https://reviews.llvm.org/D120600

And landed! Thanks!

Since this is a pretty small change, do you think it could be backported
to the clang-14 branch?

-- 
Kees Cook
