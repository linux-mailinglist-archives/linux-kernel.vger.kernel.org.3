Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC35527443
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 23:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbiENVtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 17:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiENVti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 17:49:38 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D8A12D1B
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:49:38 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id v11so10735785pff.6
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s6gyFIzNx3uPs0E9QTdHeabUUHOLCiS5BRmtEkTrJ0M=;
        b=c7bt5Yyim6jXKVU+nad9I6JP2/SU4szhm6beG8K9aijDODZgSy0Agoa/TRIPhM8F1M
         rmYwZd8/LYOr0N85MfiL1hP82YXqGevzNXXADwKiS+C2Z1EidmmFYt0rEWxDNpDTeDfz
         isXaa8uHnFoI1HAe6xmc8AxSjWofOHnUnKFTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s6gyFIzNx3uPs0E9QTdHeabUUHOLCiS5BRmtEkTrJ0M=;
        b=LsmCzvYThvEXslbayW0Pj9+FVMg2uHs05k6WeKDdL92rm5CmyZpv1YjvJ6f1OJeaka
         tqFuY2mgSIIlw/zKASxkhXn+5D/Pb6wljVDDYM61TI0debmLjZ2XrD99fvcLja+wCogm
         Uu21g/qvzGHnEDH4cAECSNfS+kPbUoTsQfHXJXIQIx3tUQSIatdyvZnYZhDhzuyoKFQ8
         gzV7NL5yZ7j4mdVFicuaWhSJnkkLXgnsMec5VW4jqRNgX7iliMCg797xsgdZPjh2Rv0T
         YPA8RndDLMY6yhfy5YHTjSY25/5EIBBkayq4ZKiYmaRnPg5UV5orL83B+yWV9QBYr12X
         p5MA==
X-Gm-Message-State: AOAM532OeVB/eH/gdBFak222bpIKFdxA2pCaucqY7nWeZGVkHVQol/82
        i28It/TIIp+63TPX9nOd07T3NA==
X-Google-Smtp-Source: ABdhPJwk8CcBX6QnXuAE6iXMXjeE8Vq7UImMhCQwh4Vg8IjNOXTMawTzaFXfXJRgS9HCVdGKlVDekA==
X-Received: by 2002:a65:4ccd:0:b0:3c2:428d:d13b with SMTP id n13-20020a654ccd000000b003c2428dd13bmr9330640pgt.425.1652564977729;
        Sat, 14 May 2022 14:49:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f1-20020a170902ff0100b0015e8d4eb26asm4114685plj.180.2022.05.14.14.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:49:37 -0700 (PDT)
Date:   Sat, 14 May 2022 14:49:36 -0700
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
Subject: Re: [RFC PATCH v2 07/21] cfi: Add type helper macros
Message-ID: <202205141447.E3B5A29@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-8-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-8-samitolvanen@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 01:21:45PM -0700, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, assembly functions called indirectly
> from C code must be annotated with type identifiers to pass CFI
> checking. The compiler emits a __kcfi_typeid_<function> symbol for
> each address-taken function declaration in C, which contains the
> expected type identifier. Add typed versions of SYM_FUNC_START and
> SYM_FUNC_START_ALIAS, which emit the type identifier before the
> function.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

And the reason to not make this change universally (i.e. directly in
SYM_FUNC_START) is to minimize how many of these symbol annotations get
emitted? (And to more directly indicate which asm is called indirectly?)

What happens if an asm function is called indirectly and it doesn't have
this annotation? (Is this case detectable at compile-time?)

Regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
