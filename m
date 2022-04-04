Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77AF4F2000
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 01:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242308AbiDDXNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 19:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345218AbiDDXMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 19:12:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9CA393C7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 15:52:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF2C7B81A62
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 22:52:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCC6C2BBE4;
        Mon,  4 Apr 2022 22:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649112733;
        bh=54rQNEoc5ehhks896JDl4yq3WCx9/eYdhiBhR9iefCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bF3QJRnbcjc8y6fPNoXkVkRgf5gEx3NVFnuts+9skTbjtP9eot8cnBXlFI8pw4fuE
         GDxPaF9NNC+WKlfDsnXfLMOEPfRc4SbvvzHprSmilCsuJiNcMP9TXgJX0wirB2EJU0
         1jt2jv3o/4kcckKRO0ZLqHFrWfTjDbf8Uy9BGbXRYBZHFHKIj0GPlWBKZvOJgZqbm9
         5c2ejL+9CkNE5w62Iy313yMgPWNfOLxHEqB+RZKw2gQBiiajiu/lpyCo/x+BlNMkoK
         HVm2lhF8OwyNiL9R63NGAXx12znc6NTHCGZABalsH/d85DkPbOIyGTj3JVExakaPjy
         Smyk9vwpAPC8Q==
Date:   Mon, 4 Apr 2022 15:52:11 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH 1/3] kbuild: Change CFI_CLANG to depend on
 __builtin_function_start
Message-ID: <Ykt2mz3gBTAyu9pL@dev-arch.thelio-3990X>
References: <20220401201916.1487500-1-samitolvanen@google.com>
 <20220401201916.1487500-2-samitolvanen@google.com>
 <CAK7LNAQoJWUscyxXVnOQ9924MYZwaZGgfBYSzmjJxKH_UC0Pkw@mail.gmail.com>
 <CABCJKudaQJ0_e290gD+rG8SwEembd33ua1MG-w2OKRq3es8Kjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKudaQJ0_e290gD+rG8SwEembd33ua1MG-w2OKRq3es8Kjw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 12:40:46PM -0700, Sami Tolvanen wrote:
> On Sat, Apr 2, 2022 at 6:32 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > On Sat, Apr 2, 2022 at 5:19 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> > >
> > > Clang 14 added support for the __builtin_function_start()
> > > built-in function, which allows us to implement function_nocfi()
> > > without architecture-specific inline assembly. This patch changes
> > > CONFIG_CFI_CLANG to depend on the built-in and effectively upgrades
> > > the minimum supported compiler version for CFI to Clang 14.
> >
> > From this description, I think the straight-forward change would be:
> >
> >     depends on CLANG_VERSION >= 120000
> > -->
> >     depends on CLANG_VERSION >= 140000
> >
> > Any reason to avoid this?
> 
> I thought testing for the compiler feature was preferred, but I can
> certainly just increase the minimum version number here too.

I think we have been somewhat inconsistent with feature versus version
checking. It might be nice to hash out when a feature check should be
done instead of a version one.

Generally, I think we tend to prefer version checks, as they are
"cheaper" since we do not have to call the compiler again because we
already cached the version code. When adding version checks, our policy
has always been use the upstream version of LLVM that the feature in
question shipped in, even if it is a top of tree version, as people who
are using prereleased versions of LLVM should be frequently updating
them.

Unfortunately, that does not always match reality. For example,
Android's LLVM tracks the main branch but they are almost always behind
by a few months. For example, the latest release is 14.0.4, based on a
version of LLVM from January 28th:

https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+/ab73cd180863dbd17fdb8f20e39b33ab38030cf9/clang-r450784b/clang_source_info.md
https://github.com/llvm/llvm-project/commits/282c83c32384cb2f37030c28650fef4150a8b67c

Normally, I would say "who cares?" but Android's LLVM is used by the
Android kernel team both downstream and upstream, so I would argue it is
important to take that into account when deciding to do a feature check
versus a version check. In other words, by moving to a version check,
will we knowingly break a version of clang that is relatively widely
used?

In this case, 14.0.4 has __builtin_function_start(), so I think it is
okay to use a version check instead of a feature one.

There are times where feature or problem checking is not always
possible:

https://lore.kernel.org/r/20220318230747.3900772-1-nathan@kernel.org/

In cases like these, we can work to upgrade the compiler before changing
the feature check ot a version one, which helps minimize the window for
breakage.

Another aspect of feature versus version checks is that it is easier to
clean up stale versions checks when we bump the minimum supported
version of the compiler (as we can just look for "CLANG_VERSION" across
the tree) compared to stale feature checks. We could fix this by adding
some sort of common keyword, like

Compiler check: <compiler> <comparison> <version>

like

Compiler check: clang <= 14.0.0

Cheers,
Nathan
