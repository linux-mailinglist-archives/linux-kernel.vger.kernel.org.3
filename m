Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBA64CB3A9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 01:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiCCAJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 19:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiCCAJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:09:03 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B4D33E33
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 16:08:18 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id b5so84953ilj.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 16:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jiVdJeDoLwQpICgbJfPUxKiHkSDi4LNXBrJ/L+vsKOw=;
        b=SSZjuQHCwyqlk9e6Fm/9hketAWCO5Am0rg1ge/DMoNXYSFjsC2IJ5GWXs8qQyjpN+R
         ndZ+np9KbbpyYhUvKTeqHahIUuF30OUpsqa2LNF/+NTgaillMi+7v/rjr0oviRv0q3Br
         uIXjMWADlr6xgzsKI7sBYja1dFSuzfCel0dEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jiVdJeDoLwQpICgbJfPUxKiHkSDi4LNXBrJ/L+vsKOw=;
        b=Gh5zdDPIzdbKzcsoCA0sYbv6iwPNilxy89097Y+lIIPs1I5fAY4bUtE6im69bGBSX5
         hLskqqDyeJFgHnPeTwOqvElkxGk9fFfcLMia3ZYMh9w5zJ1PExeWDQpsiL5ffZqGt4W0
         05tRFTnr6oDl8Azi3FeFo5QD/myw4yfCmVa+xaO9dGZSv0QZLsXRY/b2GFzo+iLy7xjy
         lAZk6zbQZoHYzNMzV+Eb44Q+lUhTLVx/hDjywGS9oFsA9cx9U585wiSA9CCxWrfubptt
         r0llcdWD7u/EYsqETZfgWc1jU3FIzXgZ9NaXBASc0HwU4FQKnAth3XVY2sLaFe2jpn8T
         1HlQ==
X-Gm-Message-State: AOAM533M4LAZL6gfoHDJSmwWOo8GEEPQhpSeZL1CZv9zvJ0BXW5x1DSJ
        oiSpDwq/lnwW3Y9QFPipdvfIidMcmQQtyQ==
X-Google-Smtp-Source: ABdhPJxBjvI3yZjCw8B7OkUPODokVsRZvTy4HsVuuQWiFbeQFf4ytA91cVs/RVuc/nlND4+pBJM+EQ==
X-Received: by 2002:a65:41c3:0:b0:363:5711:e234 with SMTP id b3-20020a6541c3000000b003635711e234mr27821213pgq.386.1646262046040;
        Wed, 02 Mar 2022 15:00:46 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id lk9-20020a17090b33c900b001bc7c2dfcdbsm112754pjb.37.2022.03.02.15.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 15:00:45 -0800 (PST)
Date:   Wed, 2 Mar 2022 15:00:44 -0800
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
Message-ID: <202203021459.55F4992@keescook>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.072632223@infradead.org>
 <CAKwvOdkD2WY=hEHy8_0zs70AGx6LRQwxL5mEZyB30uqpruYJyA@mail.gmail.com>
 <Yh+dMJsH+ZMPfqwD@thelio-3990X>
 <CAKwvOdmouBTe5pH3JoP6EEfwNT5=6WvX3oCEZRxO0Dkf38S14w@mail.gmail.com>
 <Yh/egU1LZudfrgVy@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh/egU1LZudfrgVy@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 02:15:45PM -0700, Nathan Chancellor wrote:
> Sounds good, tentative patch attached, it passes all of my testing.
> There is an instance of $(LLVM) in tools/testing/selftests/lib.mk that I
> did not touch, as that will presumably have to go through the selftests
> tree. I can send a separate patch for that later.

I think it's fine to include that here, just to keep the logic together.

> Peter, is this approach okay with you? If so, would you like to be
> co-author or should I use a suggested-by tag?
> 
> Cheers,
> Nathan

> From 83219caafbb7dbc2e41e3888ba5079d342aff633 Mon Sep 17 00:00:00 2001
> From: Nathan Chancellor <nathan@kernel.org>
> Date: Wed, 2 Mar 2022 13:28:14 -0700
> Subject: [PATCH] kbuild: Allow a suffix with $(LLVM)
> 
> The LLVM variable allows a developer to quickly switch between the GNU
> and LLVM tools. However, it does not handle versioned binaries, such as
> the ones shipped by Debian, as LLVM=1 just defines the build variables
> with the unversioned binaries.
> 
> There was some discussion during the review of the patch that introduces
> LLVM=1 around this, ultimately coming to the conclusion that developers
> can just add the folder that contains the unversioned binaries to their
> PATH, as Debian's versioned suffixed binaries are really just symlinks
> to the unversioned binaries in /usr/lib/llvm-#/bin:
> 
> $ realpath /usr/bin/clang-14
> /usr/lib/llvm-14/bin/clang
> 
> $ PATH=/usr/lib/llvm-14/bin:$PATH make ... LLVM=1
> 
> However, it is simple enough to support this scheme directly in the
> Kbuild system by allowing the developer to specify the version suffix
> with LLVM=, which is shorter than the above suggestion:
> 
> $ make ... LLVM=-14
> 
> It does not change the meaning of LLVM=1 (which will continue to use
> unversioned binaries) and it does not add too much additional complexity
> to the existing $(LLVM) code, while allowing developers to quickly test
> their series with different versions of the whole LLVM suite of tools.
> 
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

I like it!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
