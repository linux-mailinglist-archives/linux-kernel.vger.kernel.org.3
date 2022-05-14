Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAD6527462
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 23:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbiENV4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 17:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236039AbiENV4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 17:56:34 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DC819286
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:56:03 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id b12so1730008pju.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FRz+GXXZaKOMrKydUY42JkbUz0KXbswZCunobIsh+ok=;
        b=EMGxS7CubkSoRXJvbmCOUMnABXzcITd5+nEUdRyvBWZr0Ejfu0faLMdmwYhOM8pXx4
         qOvD2ibBSHZJuEbw1khfAuvievTdhMLKWyGiMShRtK8Ll3XYbrif7r38L2UQePBNmqGc
         wDzdnSTxfK8uDgCLXMc/+iLNVxeUASGOOeNys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FRz+GXXZaKOMrKydUY42JkbUz0KXbswZCunobIsh+ok=;
        b=0RFMfDs1UISDQl2pARAeDwRxIg7StYqCeLaAvEOmPLKS2bxrDro+n2jMPu8liCmsCL
         pfjvBvfuqiLaqimb9SYSWHqCiU8LjCefU3OiE1uQqqsHquSyOL5ryoYiZqjpk31VwLtf
         QThxBf9+t2PLY24TByRW0oc18mx9rJi3IY0RyvbkNMclLVDC6+km6V4eszMMQS4+LpFc
         t64ZgGtW/SK1sOxKf+mmBZ7JRgG3Xd5iNeun+6xb9oUK44Y4sz/JWyQ6dLg5ZhJBu6FV
         A6EfN6DaaOpVESei2SZTsj3Wr5nyDnu2wG4og6H891SqIMuWpb0E0uPq6GFJOdU/JgaW
         S6CQ==
X-Gm-Message-State: AOAM530gtxcpceAlf9PPzkwz14YxRbqXo6+xWncK7duI19zcnOzMr0ch
        ++QgafKIqlpVqMGJw2wm0gSP4g==
X-Google-Smtp-Source: ABdhPJwN6qwi59HdCtNsN1hdnIt3qawy44T1UkLBIVUFePlqWn8+tMNJ68vLHuPdKrk2BA5cYKH36g==
X-Received: by 2002:a17:90b:3510:b0:1dc:88d2:6a1b with SMTP id ls16-20020a17090b351000b001dc88d26a1bmr23153588pjb.158.1652565363278;
        Sat, 14 May 2022 14:56:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v9-20020a170902b7c900b0016162e01553sm495864plz.168.2022.05.14.14.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:56:03 -0700 (PDT)
Date:   Sat, 14 May 2022 14:56:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH v2 14/21] treewide: Drop __cficanonical
Message-ID: <202205141455.0A6F409@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-15-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-15-samitolvanen@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 01:21:52PM -0700, Sami Tolvanen wrote:
> CONFIG_CFI_CLANG doesn't use a jump table anymore and therefore,
> won't change function references to point elsewhere. Remove the
> __cficanonical attribute and all uses of it.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  include/linux/compiler_types.h | 4 ----
>  include/linux/init.h           | 4 ++--
>  include/linux/pci.h            | 4 ++--
>  3 files changed, 4 insertions(+), 8 deletions(-)

I think this is missing removing it from include/linux/compiler-clang.h ?

With that done (or explained why not):

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
