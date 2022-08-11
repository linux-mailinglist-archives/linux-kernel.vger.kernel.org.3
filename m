Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F83158FC68
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbiHKMf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbiHKMfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:35:38 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8659D12D06
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 05:35:19 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id a8so17540658pjg.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 05:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5w/KsvKeDQNB0nymQYwJO1nJhxYwskiJAdbQrcwrrws=;
        b=Ql5TzwacX39R2Jd3F8nwCUw2umD0dCX30wm+NAMytxnOiFhjI29r2fh4KHIe8FbJA5
         sYz4E0PDwIJi2YWeIZGBi2iV+Kzj0DYdKG+N+MawTLJhdefhUsUcV0ClrlBQcf1+CfbC
         BhOcyvxJBYHt9jAR2olKMbE/rOdvH8kuymWFoAFCIdQ3O3rDei5TMFoybUL9zX6OoiC6
         zSf7+O9WlFtOrgZpMoO4efq2+dLIYo4s6604mDZQ2A9zMsGb4t2OqoPcdUh7yyzAL4B5
         4m2ConxAm3a5QZ2B5OUxbrnEPhFZedReRM5K3lF3hX3flUt9J1LLpTzaRYKOp4znfWwG
         qROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5w/KsvKeDQNB0nymQYwJO1nJhxYwskiJAdbQrcwrrws=;
        b=pqEU1eCNdr14/Z0MKBS+KHS/0CmbxOr34xx1IkmduLlGtV89RN1sV6dBfFNQs+/qGY
         +2gHo+3vQc33pd45gSh5UBPVOU0Gi7X3XOxePIWI6bXoV1uXAxTJ7sW3sfYCzPFqhWIe
         yIVZCYVbPKyajeq4NYtfFd/+p3xmJmbUtrq/FxgZv9TKs4O9JPXWVaYLTtV5Z+abpibP
         /DnmI5Nt7+4LEUEqgWPds4YvQg3OAsrVYhpDAhNz4ciGnQsLdDIRYqLNbycraWk+CjEm
         4NbY0YwR3N+s0PkNdICg7v685FlE6yopCDPcYvvNhQhEUNGwa05CPLlVtCpC2AM0PJ+A
         h2SQ==
X-Gm-Message-State: ACgBeo16az8CqfpOOFMoQ7DPuSzTiqO3KJKTyg+keqj4xgpUlch3CLt1
        fdIIfpKXTjFw0U1H7nyzvRsBZA1SjOfVWNxvJIVOeNb8bO1UaA==
X-Google-Smtp-Source: AA6agR7mxh4xlrHaACk8ACRbYeCnushTJX/xovc1OX340+zRR7qqgn2gIIKem8n7+e/FLEibg6QqXPbdXVxgjeL2ts4=
X-Received: by 2002:a17:90b:3805:b0:1f4:ebfe:558b with SMTP id
 mq5-20020a17090b380500b001f4ebfe558bmr8709936pjb.48.1660221318988; Thu, 11
 Aug 2022 05:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220810114318.3220630-1-anders.roxell@linaro.org> <87fsi3ce28.fsf@mpe.ellerman.id.au>
In-Reply-To: <87fsi3ce28.fsf@mpe.ellerman.id.au>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 11 Aug 2022 14:35:08 +0200
Message-ID: <CADYN=9L_Sgd8HTkhtM5t0eoN7ict8zX6fRCJsVvYcgp9H_QsSg@mail.gmail.com>
Subject: Re: [PATCHv3, resend] powerpc: mm: radix_tlb: rearrange the if-else block
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     nathan@kernel.org, ndesaulniers@google.com, llvm@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Aug 2022 at 11:41, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Anders Roxell <anders.roxell@linaro.org> writes:
> > Clang warns:
> >
> > arch/powerpc/mm/book3s64/radix_tlb.c:1191:23: error: variable 'hstart' is uninitialized when used here [-Werror,-Wuninitialized]
> >                                 __tlbiel_va_range(hstart, hend, pid,
> >                                                   ^~~~~~
> > arch/powerpc/mm/book3s64/radix_tlb.c:1175:23: note: initialize the variable 'hstart' to silence this warning
> >                 unsigned long hstart, hend;
> >                                     ^
> >                                      = 0
> > arch/powerpc/mm/book3s64/radix_tlb.c:1191:31: error: variable 'hend' is uninitialized when used here [-Werror,-Wuninitialized]
> >                                 __tlbiel_va_range(hstart, hend, pid,
> >                                                           ^~~~
> > arch/powerpc/mm/book3s64/radix_tlb.c:1175:29: note: initialize the variable 'hend' to silence this warning
> >                 unsigned long hstart, hend;
> >                                           ^
> >                                            = 0
> > 2 errors generated.
>
> Which version & config are you building?

clang-13, clang-14 and clang-nightly, configs are cell_defconfig and
maple_defconfig

I'm building with tuxmake [1] like this:
$ tuxmake --runtime podman --target-arch powerpc --toolchain clang-14
--kconfig cell_defconfig

Cheers,
Anders
[1] https://tuxmake.org/
