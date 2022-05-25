Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B395344A1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 22:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241729AbiEYUCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 16:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbiEYUCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 16:02:32 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2297368319
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 13:02:32 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ge11so879415pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 13:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AWaeHfIqso2uarSrq2voc6y6tcqWng3SnNIxku0tA0k=;
        b=ezecxoS1sA3vkGGfwUxIzhGQpcMdwdQ/B9z2SvvAPRmDulRg7UxU9szNANvQ24Y57r
         ivBiwI1khWN3D600by1SoMY+gQ2uvqvLzdj6JqyC3GStB1oKR0vo010PlPD/Ov4uDDMX
         PcNzCUpi4CzTj7LRLePIkozu7t9ZfSWN2y7Ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AWaeHfIqso2uarSrq2voc6y6tcqWng3SnNIxku0tA0k=;
        b=rCWyDbMY5o8yddO79/2tQHhthud9SmMQGaOEiODJIY4ltU6z5wkFV9PLoGAwSyFSpz
         dui2KammNApDUNzi3pwA0rYhztU3ajccD2PWaZ4gSus/rg4HMQZ08A877ihJ/Eu3WOPg
         VaP/fJ6VW0BqSWgHJ18SQn9sUFd2PnHMp1DjPHCpfsRj9delKZ5d68B37aj4V1/fhSJF
         SeG9GXMO2R3RCoZEi3eWwejRZIGyD1qM+DzYXCFZluOcUmhPLmf1GTMPtN3Q4SfX2qv8
         SVACINfCsXr9JVHzs81duU6aDG1iq5Km7N6NIPf19lp3zm8ilvsg6oN1MY6X26T0j3zx
         290Q==
X-Gm-Message-State: AOAM533H5JmCgQ0qfFaHd3uMmdIj8GQa7VciehC9tIEtLURwCjZ1Pxhh
        1+6OexP/6bdFUqwjZ8heGhO/Nw==
X-Google-Smtp-Source: ABdhPJyhTlIBPpX3HR10hM9NOmXQk/4SBxH2F1TSa7CgOZddaoOpxfLS37lZuJOm1uIRUa88qkEuyw==
X-Received: by 2002:a17:90b:4b82:b0:1e0:c609:69d7 with SMTP id lr2-20020a17090b4b8200b001e0c60969d7mr2258619pjb.119.1653508951535;
        Wed, 25 May 2022 13:02:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f13-20020a056a00228d00b0050dc762819esm11876635pfe.120.2022.05.25.13.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 13:02:29 -0700 (PDT)
Date:   Wed, 25 May 2022 13:02:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH v2 20/21] x86: Add support for CONFIG_CFI_CLANG
Message-ID: <202205251241.FDC27BC9@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-21-samitolvanen@google.com>
 <YoIfWENLV1AR2ijj@hirez.programming.kicks-ass.net>
 <CABCJKucXA2jbTc9TF1mLUsEDKu52t71tzxpnsGOXY3_ks+W4Bg@mail.gmail.com>
 <20220516183047.GM76023@worktop.programming.kicks-ass.net>
 <CABCJKudmrBOkoDvDPOA-aEyrs9evHPWpzMpDZ10n8vXDBRdCxQ@mail.gmail.com>
 <20220516203723.GN76023@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516203723.GN76023@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 10:37:23PM +0200, Peter Zijlstra wrote:
> On Mon, May 16, 2022 at 12:39:19PM -0700, Sami Tolvanen wrote:
> 
> > > > With the current compiler patch, LLVM sets up function arguments after
> > > > the CFI check. if it's a problem, we can look into changing that.
> > >
> > > Yes, please fix that. Again see that same patch for why this is a
> > > problem. Objtool can trivially find retpoline calls, but finding this
> > > kCFI gadget is going to be hard work. If you ensure they're
> > > unconditionally stuck together, then the problem goes away find one,
> > > finds the other.
> > 
> > You can use .kcfi_traps to locate the check right now, but I agree,
> > it's not quite ideal.
> 
> Oohh, indeed.
> [...]

Hi Peter,

Sami investigated moving the CFI check after arg setup, and found that
to do it means making LLVM's CFI logic no longer both architecture
and call-type agnostic. The CFI logic needs put at a lower level,
requiring it be done in per-architecture code, and then additionally
per-call-type. (And by per-call-type, AIUI, this means various types of
indirect calls: standard, tail-call, etc.) Sami has it all working for
x86, but I'm concerned about the risk/benefit in doing it this way. I
only see down-sides:

- Linux cannot enable CFI for a new architecture without also
  implementing it within LLVM first.

- LLVM CFI code becomes more complex, making it harder to
  maintain/bug-fix/etc.

I actually see the first issue as the larger problem: I want to make it
easy for the kernel to use CFI, rather than harder. :P The first user
of CFI already cleared the way for other architectures by adjusting the
bulk of core kernel code, etc, so adding another architecture should be
as trivial as possible, and not require yet newer releases of LLVM, etc,
etc.

So, since using .kcfi_traps already solves the issue for finding the
checks, can we not require moving the CFI check? I think it would be a
mistake to have to do that.

-Kees

-- 
Kees Cook
