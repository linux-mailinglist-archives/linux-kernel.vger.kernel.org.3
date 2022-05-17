Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F64B52ACAC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 22:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243342AbiEQU0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 16:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiEQU0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:26:36 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DEB527EA
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 13:26:35 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2ec42eae76bso2945347b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 13:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wkLF6OT1t2YOSmlQuHNSc8YMQFZWsweJNSK3A1X9WFc=;
        b=lRLBJQQGJdCf/Vu5j6vHzWkLG9PUWk/gz7qLmFYdfdeMrVMiDYwEGSqEgimFBRs/WR
         O4fzMukpLDP635Z0lxkIi/bGO+6noGtP3ot9Q6tPrpn5Qgc8EBWqdICI1eFCMI80Ma8f
         3pmbS7srfTEV/kcWtkPkbs4OUB9yf9NtfT3b3XSlogZZaNp0x1O7QOpDXUpYtygcePvN
         r44Nl5IDZG3YlfUztaaVn5/rsfAb7pQG3FUP3uVcOUwlKpzvjWE1Js0p/1TuDq4NRwPT
         ySAm9/hX9TNiNyu3JgtBpjTrtlclAwH3eZZ8opRa481V27pvCsGDX/3oZhvbvnsW3dLn
         tX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wkLF6OT1t2YOSmlQuHNSc8YMQFZWsweJNSK3A1X9WFc=;
        b=eCyAzJrpB6RHW3C8l4SPYb8dOCnQqIrrIxKqJt5KrbihTJVwYoQBdxsMfart9a3nPu
         /etXC9SnSLros239cv4XJzdJ4FQ7KB0o01a79IfPh0xqNT0RY/PzKOgHULb84n5yMZ0L
         TDDLM34ny21/MwLu/ZM/1JG0u5+fu/z8CS0cIMxf9I56/n1RzUr74fsXqWoaK4+BXbqb
         BZ/UmVn2nP7FILMzp6ilmvEIiZjZbYMgm5SyQ9jCCM/HSwRf3l/QFBhMCCAEj2g9GU/z
         VkeITpa87T+ch1u9kft99urEwmRDs8lvyOZHOYz4TGioxgx8DniCUW0uJ/kUzX9M46G5
         gzWQ==
X-Gm-Message-State: AOAM532FTmdmDWmSC6Bb9T1+YsHF6f6+mPPOQl0YDnma9eTHk0Mw1uM6
        NsuSexMUXUnkVzjOc7jfBh6EOjgd8DqIxt4QsVYH5A==
X-Google-Smtp-Source: ABdhPJyUXGOqF8+tBvLpsGWh5ahMBfxg2ZLY5vD+1aR0edc0om38+5POyM0OXwEuZ9R6X5KTM2qgFqwhL5XOumOXyK0=
X-Received: by 2002:a81:2008:0:b0:2f8:3968:e70a with SMTP id
 g8-20020a812008000000b002f83968e70amr28536127ywg.321.1652819194477; Tue, 17
 May 2022 13:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com> <YoNjjjb3ygIKnwfj@hirez.programming.kicks-ass.net>
In-Reply-To: <YoNjjjb3ygIKnwfj@hirez.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 17 May 2022 13:25:58 -0700
Message-ID: <CABCJKufWy0QrZbpe7CyZOxse60rVHp8fF0iv3D7rS67gjy+E7g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/21] KCFI support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
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

On Tue, May 17, 2022 at 1:58 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, May 13, 2022 at 01:21:38PM -0700, Sami Tolvanen wrote:
> > KCFI is a proposed forward-edge control-flow integrity scheme for
> > Clang, which is more suitable for kernel use than the existing CFI
> > scheme used by CONFIG_CFI_CLANG. KCFI doesn't require LTO, doesn't
> > alter function references to point to a jump table, and won't break
> > function address equality. The latest LLVM patch is here:
> >
> >   https://reviews.llvm.org/D119296
> >
> > This RFC series replaces the current arm64 CFI implementation with
> > KCFI and adds support for x86_64.
>
> You have some weird behaviour vs weak functions (I so hate those)...
>
> 100: 0000000000000980     9 FUNC    LOCAL  DEFAULT    2 __cfi_free_initmem
> 233: 0000000000000989    35 FUNC    WEAK   DEFAULT    2 free_initmem
>
> With the result that on the final link:
>
>    179: 00000000000009b0     9 FUNC    LOCAL  DEFAULT    1 __cfi_free_initmem
>   8689: 00000000000007f0     9 FUNC    LOCAL  DEFAULT   65 __cfi_free_initmem
> 173283: 00000000000007f9   198 FUNC    GLOBAL DEFAULT   65 free_initmem
>
> This is getting me objtool issues (I'll fix them) but perhaps it's
> something you can do something about as well.

Good catch, I'll fix this.

Sami
