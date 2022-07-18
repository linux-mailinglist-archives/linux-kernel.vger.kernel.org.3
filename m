Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC095789C6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 20:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbiGRSr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 14:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiGRSr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 14:47:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E84C2E9C9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:47:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C30D6B8124B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 18:47:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0274C341C0;
        Mon, 18 Jul 2022 18:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658170072;
        bh=EdLuhAp6mm2b6DjZkJnJlmLd0M16AJJo5FVvP9To6dI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hpF0O/+UqR0HG/IvaIaLYXcP6MFpyUwZvEGD3vIc0iq5QDAlaS/jPgvKWyr8/wd5e
         JaUPpHNqOrsnONc6lg3DkWJDWIJFfXkotxFHJQXFDwsupCzdkGEziFv118vM+/4NcC
         tjoPhvbbsF9t6KBKmjVTO7vwTKhdtc7bkB6bsnWPKr5194JWBWpxrf3DIuPiT9Yh76
         /rcK7nKJry6L4EtwHJwJhIgm2THTAIuiaoVyJAZ0YKCvGuHArj4w8qyG4QhH+X+B6k
         yuZovkcJBqesnp9pKy6j6IToSg1+7wGDMO4cR+ag3gB6WygQaYtN857PtTwA1sWcD2
         1UIha5yzp6Sug==
Date:   Mon, 18 Jul 2022 11:47:50 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Justin Stitt <jstitt007@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3] include/uapi/linux/swab.h: move explicit cast outside
 ternary
Message-ID: <YtWq1vX+8VylSa4G@dev-arch.thelio-3990X>
References: <20220608223539.470472-1-justinstitt@google.com>
 <YqJYrImC3Bk40H1H@dev-arch.thelio-3990X>
 <CAFhGd8qTc-=Fjw2LZW4HYJtVyizkLhYRyv-TYLd1ji-9oR9EdA@mail.gmail.com>
 <YtWk1abYruK6DIoL@dev-arch.thelio-3990X>
 <CAFhGd8oTs1gM8C8zZvcZw0pxzRJc1ogvp3jg6TSGPVegsXCNsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFhGd8oTs1gM8C8zZvcZw0pxzRJc1ogvp3jg6TSGPVegsXCNsg@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 11:25:27AM -0700, Justin Stitt wrote:
> On Mon, Jul 18, 2022 at 11:22 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Mon, Jul 18, 2022 at 11:12:25AM -0700, Justin Stitt wrote:
> > > Any chance a maintainer could take a look at this patch? I am trying
> > > to get it through this cycle and we are so close to enabling the
> > > -Wformat option for Clang. This patch fixes over 50 warnings and
> > > there's only a handful of patches remaining until we can enable
> > > -Wformat.
> >
> > I think this change is already picked up? It's in -next.
> 
> Oh, awesome!
> 
> > https://git.kernel.org/akpm/mm/c/d30dfd490f7dc4cb6a7c11a647bd1ff7a22139e7
> > https://git.kernel.org/next/linux-next/c/d30dfd490f7dc4cb6a7c11a647bd1ff7a22139e7
> 
> How did you track this down? I wasn't able to find any references to
> my patch in -next through kernel.org.

If you have a copy of the linux-next repo, you can just run:

  $ git log --author "Justin Stitt" --oneline

after updating it (or 'git log <file>', whichever works) to quickly
survey.

Through the cgit web interface on kernel.org, the easiest way would be
searching your name in the upper right search bar with the "Author"
option. Otherwise, I typically look through the git log of a particular
file by appending "log/" + the full path of the file to the repository
URL like so:

  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/include/uapi/linux/swab.h

Sometimes maintainer trees might not funnel into -next (they should be)
but your patch might still be picked up. You can pass the '--scm'
argument to get_maintainer.pl to see if the MAINTAINERS file has a git
tree associated with it and do the same thing as above to see if the
patch has been accepted (you might need to analyze the different
branches).

Cheers,
Nathan
