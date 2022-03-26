Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A098E4E83FC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 21:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbiCZUB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 16:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbiCZUBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 16:01:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BE8554BC
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 13:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EEC21B80B4F
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 20:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3F8C2BBE4;
        Sat, 26 Mar 2022 20:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648324815;
        bh=w1S2sozUrJXSdf8UVBNRrFIn4nOpImB/x51FVZxOxzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=khWXOIAgFnEB4hWvMbR1ordDbuC7r1wB9fi+Yb7p/HOvA3ApShogONQYrhpON8kng
         HJgtBPJkIM//jNRkuRyxU38L9sEhwxDuU0wRpQeyZAc0ZqCCqCOGDwQMfXsEmYo8L4
         FiofT8SsV6bitKCeOLGL3boVSpyq2HLTAPwwFhfn43/AHUqDcMB9T9culXIvuuJ7oY
         7lxqaFspjBROwgbTXTK/LHbNwHN9G2Ci8qWYkGsdwQzMzQVkJURVUZhCTlrf4YAHql
         LGO/DfGeD/CpJqIG9AKZOVxyaezzJwJIDBNDRdGzbAEW18EAb1Fg7/1lto41kf3Od8
         wdhdtPDJa85cw==
Date:   Sat, 26 Mar 2022 13:00:08 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Gow <davidgow@google.com>, linux-um@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH] um: Fix filtering '-mno-global-merge'
Message-ID: <Yj9wyNwZWkilNbJM@dev-arch.thelio-3990X>
References: <20220322173547.677760-1-nathan@kernel.org>
 <CAK7LNAT8TcDy=iKaWZ7_+MbT84vOVEBzHxJY8Bx54Ju5fur8-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAT8TcDy=iKaWZ7_+MbT84vOVEBzHxJY8Bx54Ju5fur8-w@mail.gmail.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2022 at 12:29:55PM +0900, Masahiro Yamada wrote:
> On Wed, Mar 23, 2022 at 2:39 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > When booting a clang compiled UML kernel, the kernel panics when trying
> > to run init:
> >
> >   wait_stub_done : failed to wait for SIGTRAP, pid = 651294, n = 651294, errno = 0, status = 0xb7f
> >   Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> >
> > After the commit in Fixes, many flags from KBUILD_CFLAGS do not appear
> > in USER_CFLAGS, likely due to USER_CFLAGS initially being a recursive
> > variable ("VAR =") then being switched to a simple ("VAR :=") variable.
> > For example, diffing arch/x86/um/.ptrace_user.o.cmd shows flags such as
> > '-Os' and '-fno-delete-null-pointer-checks' getting dropped, which both
> > impact code generation.
> >
> > Rework the filtering to use filter-out instead of patsubst, which allows
> > all the patterns that USER_CFLAGS cares about to be excluded in one
> > command and ensures all flags from KBUILD_CFLAGS are transferred over to
> > USER_CFLAGS properly, which resolves the boot issue noted above.
> >
> > Fixes: 6580c5c18fb3 ("um: clang: Strip out -mno-global-merge from USER_CFLAGS")
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> 
> 
> 
> Can we remove -mno-global-merge entirely?
> 
> 
> 61163efae02040f66a95 was a very old commit,
> without enough explanation.
> 
> Shall we remove  -mno-global-merge, and do compile-tests.
> If we are hit by problems for arm/arm64, we can re-add it.

Yes, I think that was the conversation that we had on the commit that
this fixes:

https://lore.kernel.org/r/YiD7R2wRxoWxtVq7@dev-arch.thelio-3990X/

I can test that on my Raspberry Pi 3 and 4 on Monday, although I would
like for this patch to be picked up in the meantime so that it is
possible to test UML on -next with clang. We can remove
-mno-global-merge in a follow up change, if you do not have any
objections?

Cheers,
Nathano
