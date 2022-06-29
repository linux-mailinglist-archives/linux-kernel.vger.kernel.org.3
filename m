Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BF85605EC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiF2QeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiF2QeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:34:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CD52126B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:34:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B35B61CD7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 16:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9F8C34114;
        Wed, 29 Jun 2022 16:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656520442;
        bh=edcI2vq8ccjkKH8WWYEdsMPx4T6G7LxZy5g/HfP1Iug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cp7/KFmRiQN89tgZlzc+ug9JGoAqdjDruVFxhte62BzFWPhVd9Cep0TItji/M9MMa
         XLLQrscLpqm4i4TgKvmVvY+w/I0TnFP4OXUOcAvqAd/5Px9BnN/2WQsrETKesidyYh
         S8iYV7xoKLAajUm4Y/9wImlSeZZkrf9+5UyvH7eDN8rCmZf+Hd0Eq5EquL6LDQbS3p
         eZuq8TAN50HHn9MsBvqPsdcfdWyTxM/HADGHLLN60yUj1xU81EwPfLAo0y7cwmUqFP
         2F7Tj5DAJMQ97U58LjQmiHn+crjviQezUdSGQNYs3QnnPAmKw+pV8Sf/IFDe10GgNk
         w1IkYi02syKSQ==
Date:   Wed, 29 Jun 2022 09:34:00 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: mainline build failure due to 281d0c962752 ("fortify: Add Clang
 support")
Message-ID: <20220629163400.cgeqmuu45zsyxtwq@treble>
References: <YrLtpixBqWDmZT/V@debian>
 <CAHk-=wiN1ujyVTgyt1GuZiyWAPfpLwwg-FY1V-J56saMyiA1Lg@mail.gmail.com>
 <YrMu5bdhkPzkxv/X@dev-arch.thelio-3990X>
 <CAHk-=wjTS9OJzggD8=tqtj0DoRCKhjjhpYWoB=bPQAv3QMa+eA@mail.gmail.com>
 <YrNQrPNF/XfriP99@debian>
 <CAHk-=wjje8UdsQ_mjGVF4Bc_TcjAWRgOps7E_Cytg4xTbXfyig@mail.gmail.com>
 <CAKwvOdmQKo4tZRLWxK2tTvd+OEtUmKJM7XiijLAF8JWMeUzFMA@mail.gmail.com>
 <CAKwvOdnfRnqBF8exO-Y1ooX=67TrO_8fSzgZwvUtidN_P31hzw@mail.gmail.com>
 <20220628224255.w4lmzalkx3qejuyg@treble>
 <CAHk-=wivq+i2-xp3WagixzQMBXaD4etMDmiTp5f-mgsfwOjxtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wivq+i2-xp3WagixzQMBXaD4etMDmiTp5f-mgsfwOjxtA@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 09:08:20AM -0700, Linus Torvalds wrote:
> On Tue, Jun 28, 2022 at 3:43 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > So, something like this:
> 
> No, clang should just be fixed.
> 
> These UBSAN reports should usually be WARN_ON_ONCE.
> 
> It's all the same issues we've had before: causing a panic will just
> kill the machine, and gets us fewer reports.
> 
> Now, UBSAN is something that presumably normal people don't actually
> run on real hardware, so it's probably less of a deal than some. But
> hey, maybe somebody wants to actually run an UBSAN kernel on a real
> load with a full accelerated graphical UI and real drivers: a panic
> may end up killing the kernel, and there you sit, with a dead machine
> and no idea what went wrong.
> 
> So the whole "panic if UBSAN reports something" is COMPLETE GARBAGE.
> It actually makes the whole point of running UBSAN go away. You *lose*
> coverage.
> 
> So please don't make the kernel worse because clang got something like
> this wrong.
> 
> Just fix clang.
> 
> And fix your mindset.

Yeah, good point.  All the other UBSAN handlers (other than builtin
unreachable) try to recover.  There's nothing special about divrem
overflow which requires it to be fatal.

So clang needs to stop assuming the divrem overflow handler is noreturn.

-- 
Josh
