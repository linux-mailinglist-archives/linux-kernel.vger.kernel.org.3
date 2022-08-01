Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26560586FFD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbiHAR71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbiHAR7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:59:10 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B6BDFC2
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 10:59:00 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id w15so18469644lft.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 10:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7yJue3wpE46mqMp6WfUlVgKTJyxRggT/HsVWQliUjAA=;
        b=baZtFM+E8jy0urk7ZQ/53EmacTrKbsBnvC4gnQsFSE4Xor6gw+u3FxpwZ3oOBhnwpW
         rLj/pVIQZC4/vYyFqDZQCnOTkDIUNeHUIinm/xvmU1t+cJbC6QjCDmIgcBM9yuAehGeR
         z3jZkpzc/sjT3iR4N5Kw9qPzwsgeSvm3VXBF5sj6kzz7wWaj1kT4oH42lixMmwWy3cEp
         0hwtc+ML4IqNE5y8J0JxkRWe++b8jbXAvp50q/q4jQmV0JNcSUNY9oI19wEMddsPC7u1
         aseeDg5zh5jGKprMt726AzYUEB3oc+hRmMHVQwelMzX/IItZKahz9+UTzSCXghGppvNL
         4FGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7yJue3wpE46mqMp6WfUlVgKTJyxRggT/HsVWQliUjAA=;
        b=b3CFhcwyH7pkkgnwzSaUsaDySz8KE319yuAKfVj0DPMzLiXJySYhWves/xftBiXf6Y
         Fc20smHpkq0eerC7ChRNETQDevhbWhOFpyMiSxAHuDszbGpDXJrR7YKTyGKSnIxiSmWS
         faY6H733X+/1xXyQi8fENGRmRfND/yCRyWVIaF7tEWa+ESddBcWkaRmdDE1lmTxow2GO
         iud4N45oYOByQu5sHJDvoq0JykkxDrDNN1va/lvGmdXp+mCf9+HsLpG5zLp6zIOwtWWC
         dljSVn5GPkmqO+8O0dYwmlJxfyaOSN7EWqRPlrYYValKXndSxX512a/rzLoIA6rBZBxX
         NP1w==
X-Gm-Message-State: AJIora8lVitumUIK/TdGJplEKfJ6nF99mAdmPN8mxIEdOmO0YQvYVjeB
        CaPS0KA2JQD5zz3jJE2SeXXJ0qqdPL1hyB5++dcc+w==
X-Google-Smtp-Source: AGRyM1tGJjG6mSt41oFvvwn+SA1Zafr1raTgRq9oDWlEyv2VYmo1Yqq8O7EFhbioIhMWJ4CIBLfi7iGbUSCW3bHKpwY=
X-Received: by 2002:a19:7902:0:b0:48a:6872:68ab with SMTP id
 u2-20020a197902000000b0048a687268abmr5702496lfc.626.1659376738622; Mon, 01
 Aug 2022 10:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220728161208.865420-1-yury.norov@gmail.com> <CAHk-=wiFJboHXZEXtMhDcHbEYXujTiDxkGbpONC=DJA7dJG6nw@mail.gmail.com>
 <CAHk-=wgga5hrg5qgm4UwuOCjgBrobhZcdKTr1AFU7WSWgVKKZQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgga5hrg5qgm4UwuOCjgBrobhZcdKTr1AFU7WSWgVKKZQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 1 Aug 2022 10:58:46 -0700
Message-ID: <CAKwvOdkigxQUF399-WoWwsg-W2dbMj-mx4sOx91hb9RDodqHmw@mail.gmail.com>
Subject: Re: [PATCH 0/5] lib/find: optimize find_bit() functions
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 2:49 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Jul 28, 2022 at 11:49 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > It builds for me and seems to generate reasonable code, although I
> > notice that clang messes up the "__ffs()" inline asm and forces the
> > source into memory.
>
> I have created a llvm issue for this at
>
>         https://github.com/llvm/llvm-project/issues/56789

Thanks for the report.  I left a response there (in case you have
notification emails from github filtered; following up here).
https://github.com/llvm/llvm-project/issues/56789#issuecomment-1201525395

So it looks like at least 3 things we can clean up:
1. https://github.com/llvm/llvm-project/issues/20571
2. https://github.com/llvm/llvm-project/issues/34191
3. https://github.com/llvm/llvm-project/issues/33216

>
> and while I noticed this while looking at the rather odd code
> generation for the bit finding functions, it seems to be a general
> issue with clang inline asm.
>
> It looks like any instruction that takes a mod/rm input (so a register
> or memory) will always force the thing to be in memory. Which is very
> pointless in itself, but it actually causes some functions to have a
> stack frame that they wouldn't otherwise need or want. So it actually
> has secondary downsides too.
>
> And yes, that particular case could be solved with __builtin_ctzl(),
> which seems to DTRT. But that uses plain bsf, and we seem to really
> want tzcnt ("rep bsf") here, although I didn't check why (the comment
> explicitly says "Undefined if no bit exists", which is the main
> difference between bsf and tzcnt).
>
> I _think_ it's because tzcnt is faster when it exists exactly because
> it always writes the destination, so 'bsf' is actually the inferior
> op, and clang shouldn't generate it.
>
> But the "rm" thing exists elsewhere too, and I just checked - this
> same issue seems to happen with "g" too (ie "any general integer
> input").
>
>                       Linus



-- 
Thanks,
~Nick Desaulniers
