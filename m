Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2DB57CEA1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiGUPKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiGUPKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:10:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D2027CF9;
        Thu, 21 Jul 2022 08:10:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76BD061213;
        Thu, 21 Jul 2022 15:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F63EC341C6;
        Thu, 21 Jul 2022 15:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658416229;
        bh=npRLRf/sAWAclkJPA3+ZSmi54RNpxH5tLibZRtjDSNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rere9p3lBvtpZ9MeZTafEhmVfofSA3t2r8VgSgJEjOhdUrv1ijFE31fCt4OYKWPgA
         b8NFzdM2pVEWVPCgaIQY1oNAcTXmd4LkollZj1bkNlKmvAOsXFrqMnT3G5/D+e6CfF
         LZVnNzMUOEZbFRLFnN9N/xN3RaaKZ3EcIAUMXjlHnBb6p2JJjD6kRzi3/DaiDL9SwP
         caJcjxLJMIFzwFu6ELaumXHc+dh/u2cACYc2OzMCJQOJMVXIuI0D0YL5K7+ntUQ2WK
         XEWk5QF1Edn9DxdibrCNjD+50/U6ZXzDJKDExFlC7PEyNkMrdnofXJDy2HjE7sSdw+
         pNLqBGXbjSWlw==
Date:   Thu, 21 Jul 2022 08:10:27 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>, Tom Rix <trix@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH] Makefile.extrawarn: re-enable -Wformat for clang
Message-ID: <YtlsY2A2ZWK97Y8O@dev-arch.thelio-3990X>
References: <20220720232332.2720091-1-justinstitt@google.com>
 <CAKwvOdnSjyOdCZZ9AegCyfns3bvH3fbtbVgdThO2+rJAE=1bag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnSjyOdCZZ9AegCyfns3bvH3fbtbVgdThO2+rJAE=1bag@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 07:27:34AM -0700, Nick Desaulniers wrote:
> On Wed, Jul 20, 2022 at 4:23 PM Justin Stitt <justinstitt@google.com> wrote:
> >
> > There's been an ongoing mission to re-enable the -Wformat warning for
> > Clang. A previous attempt at enabling the warning showed that there were
> > many instances of this warning throughout the codebase. The sheer amount
> > of these warnings really polluted builds and thus -Wno-format was added
> > to _temporarily_ toggle them off.
> >
> > After many patches the warning has largely been eradicated for x86,
> > x86_64, arm, and arm64 on a variety of configs. The time to enable the
> > warning has never been better as it seems for the first time we are
> > ahead of them and can now solve them as they appear rather than tackling
> > from a backlog.
> >
> > As to the root cause of this large backlog of warnings, Clang seems to
> > pickup on some more nuanced cases of format warnings caused by implicit
> > integer conversion as well as default argument promotions from
> > printf-like functions.
> >
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/378
> > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Previous attempt: (https://patchwork.kernel.org/project/linux-kbuild/patch/20190201210853.244043-1-jflat@chromium.org/)
> >
> > Note:
> > For this patch to land on its feet, the plethora of supporting patches that
> > fixed various -Wformat warnings need to be picked up. Thanfully, a lot
> > of them have!
> >
> > Here are the patches still waiting to be picked up:
> > * https://lore.kernel.org/all/20220718230626.1029318-1-justinstitt@google.com/
> > * https://lore.kernel.org/all/20220711222919.2043613-1-justinstitt@google.com/
> 
> Hi Masahiro, Nathan, and Tom,
> What are your thoughts for _when_ in the release cycle this should be
> picked up?  I worry that if we don't remove this soon, we will
> backslide, and more -Wformat issues will crop up making removing this
> in the future like digging in sand.  Justin has chased down many
> instances of this warning, and I'm happy to help clean up fallout from
> landing this.

Let me do a series of builds with the two patches above against
next-20220721 to see if there are any instances of this warning across
the less frequently tested architectures then I will review/ack this.

I don't think we need to worry much about backslide, as -Wformat is
enabled with W=1, which the 0day folks already test with, so new
instances of this warning should get reported to the authors when they
are introduced so they can be fixed immediately. However, I would still
like to see this applied sooner rather than later, although I would also
like us to be completely warning clean before doing so, especially with
-Werror now being selected with all{mod,yes}config. -rc8 is this Sunday
and final should be July 31st so I think this could be applied at some
point between those two dates then maybe sent to Linus for a late pull
request once all other trees have been merged but that is ultimately up
to Masahiro.

Cheers,
Nathan

> >
> >  scripts/Makefile.extrawarn | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> > index f5f0d6f09053..9bbaf7112a9b 100644
> > --- a/scripts/Makefile.extrawarn
> > +++ b/scripts/Makefile.extrawarn
> > @@ -47,7 +47,6 @@ else
> >
> >  ifdef CONFIG_CC_IS_CLANG
> >  KBUILD_CFLAGS += -Wno-initializer-overrides
> > -KBUILD_CFLAGS += -Wno-format
> >  KBUILD_CFLAGS += -Wno-sign-compare
> >  KBUILD_CFLAGS += -Wno-format-zero-length
> >  KBUILD_CFLAGS += $(call cc-disable-warning, pointer-to-enum-cast)
> > --
> > 2.37.0.170.g444d1eabd0-goog
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
