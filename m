Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAF0517264
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385748AbiEBPYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385801AbiEBPYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:24:08 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6CA1208C
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 08:20:39 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id w17so26569119ybh.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 08:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VG2N1KHd1YR2ZF1sjkCgsuS94s3wv0dEZ2AS2biKRuc=;
        b=nCCr/m44vAOB3fWxcTwSvULnXuiNVu4xAEa/q8PX0e8wp//HRJ3pAwZlfI8oXQakqb
         PBNA5VrluDTvJXwHjjEqKVrz+t1ZAhOuAy0UZ/lpPuIF5TfAQhvGp0eP9kDlGthADP7B
         jQS2jgmlIf2O2YIMWFKayiS6OkGnXXTuI6mSozGLIgWSqWTudoL0mragtOrIMycv0iNu
         cZvbiKKjzeuQMjCAHgd1ar9MSdep3a1AilDwleb2gMChOjj8zJLFVuMg4VeHUCWQC8gh
         4i9wU09zBuZyOBMRAX6+2An3+4aqYMkmsLVezmWAt06zT2xLERXvPiNYHUXkJ6I1taeF
         kDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VG2N1KHd1YR2ZF1sjkCgsuS94s3wv0dEZ2AS2biKRuc=;
        b=pTgVLKq+5v25Kx5ccd+cc76bchfLuDSY4K3qiF9QghW7NOedV2bQenajdgVvo/hKys
         +ERqoP4BP9Lz+/CRtsd7KdCJMPPlwiCBWS6An4+S2uH1QgtJyvcm6M4sv5qT2DIdG7Td
         jUX8mSVrgEUvKnM1sjufzLfC7D6jfNDpjvr877owz+ZCY12ib9gLREq7h55Csfa38+Je
         BsGL6Ej5Tn3+vsq/XsLcYoPDZTwDkRUuFuyjn6Nfm39rcACtZ36CDpWp9bkzROd3rNrz
         xzAnk4azs8lfvd0GS81paLjq37IQy8qZDXez0GKOX1V/38qluOiQU5e9AMU10zONQ7UJ
         yFNQ==
X-Gm-Message-State: AOAM531SD+k7D+tttN3CpzJ+dxV81QwqJcXO60noE5IN//t3uu8/CdDm
        tUGDDgKWMi5UmCcY1ynNmnkdLNI5Z5Bc4DweRjzknA==
X-Google-Smtp-Source: ABdhPJzqk8+IJH8fkyTp0bTuIuMWgJsHqUrnpAZSbYcMmkZ/+21K1dsNoH6iUg94I0Y7z6gpiKYrRf3BnqDN09p5vbs=
X-Received: by 2002:a25:3455:0:b0:648:44db:51e0 with SMTP id
 b82-20020a253455000000b0064844db51e0mr10124096yba.314.1651504838091; Mon, 02
 May 2022 08:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com>
 <20220429203644.2868448-22-samitolvanen@google.com> <Ym0ASy87mE3r3EVE@hirez.programming.kicks-ass.net>
In-Reply-To: <Ym0ASy87mE3r3EVE@hirez.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 2 May 2022 08:20:05 -0700
Message-ID: <CABCJKucK39XnVPA=EhLSJ+vcgVLCSgnGzLrRy9tZSM2jzZtUBg@mail.gmail.com>
Subject: Re: [RFC PATCH 21/21] x86: Add support for CONFIG_CFI_CLANG
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 2:24 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Apr 29, 2022 at 01:36:44PM -0700, Sami Tolvanen wrote:
> > -     if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN) {
> > +     if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
> > +         report_cfi(regs->ip, regs) == BUG_TRAP_TYPE_WARN) {
>
> This way you'll first get a BUG splat and then tack on the CFI thing.

The CFI ud2 isn't in the bug table, which means find_bug returns
BUG_TRAP_TYPE_NONE and report_bug bails out before printing out
anything.

Sami
