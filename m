Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE3146C351
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 20:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240849AbhLGTJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 14:09:36 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46586 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240833AbhLGTJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 14:09:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50F2DB81E49;
        Tue,  7 Dec 2021 19:06:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367DCC341C1;
        Tue,  7 Dec 2021 19:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638903962;
        bh=oVDed5jqXZIErqKCATeNwJIZ2ezcymyVXAhxeiC8gvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B6PWEc8/0wqLtrVEyCGg5gxEF5BehZ3Ey5MJAXg2nMCM4r5pbnreIjUV3RXwcGJ4U
         qawGNBPR95iM4oZG9VVVgE6r6u6ZZx2zI9LC6SB9HRIXaAGzq0p/gZW8ZiuOgexjvX
         KQR7j9fJizJsWN9ZDd8f0rZI7i+6OherDTFuNLvfE5kHaUpaEd5x96PyWxAnVr3F31
         kXZVowPDxVDYGzAEQr4vne6/p1lZ5qhhK3a8rPSAeNOwu8wr3+0XBtAx9r0dURuBgW
         f4fmkR/e6Ey5DH0q55z9os6kIA71RcQDRve+Nnax5L1chhnqdFVb0ewFcRWmH08eCf
         lc+YiHKdWHStg==
Date:   Tue, 7 Dec 2021 12:05:57 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        =?iso-8859-1?Q?Ren=E9?= Moll <Rene.Moll@xsens.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] power: reset: ltc2952: fix float conversion error
Message-ID: <Ya+wlfX7ZPb95mZ4@archlinux-ax161>
References: <20211204220249.591482-1-arnd@kernel.org>
 <CAKwvOdnZSyfZaa1crQ15DGNNj8JBspnM0xxOF3D2mTt96Ftfgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnZSyfZaa1crQ15DGNNj8JBspnM0xxOF3D2mTt96Ftfgw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 10:41:24AM -0800, Nick Desaulniers wrote:
> On Sat, Dec 4, 2021 at 2:02 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > clang-14 does not like the way this driver converts a 'long double'
> > to an integer when the target architecture disables floating point
> > support:
> >
> > drivers/power/reset/ltc2952-poweroff.c:162:28: error: expression requires  'long double' type support, but target 'x86_64-unknown-linux' does not support it
> >         data->wde_interval = 300L * 1E6L;
> >                                   ^
> >
> > Turn this into pure integer math and make it more readable at the
> > same time using the NSEC_PER_MSEC macro instead.
> >
> > Fixes: 6647156c00cc ("power: reset: add LTC2952 poweroff driver")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Thanks for the patch! The change in clang-14 (ToT) that triggered this
> has had another patch on top reverting these diagnostics.
> https://reviews.llvm.org/D114162

I can still reproduce this failure on current ToT (33e3554ea33d) on
x86_64 allmodconfig; it seems like that patch only fixes it for 32-bit
x86.

> That said, this change is still worthwhile for the improved semantics, IMO.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1497
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

My patch appears to be accepted in Sebastian's branch already, it seems
like it just needs to be sent to Linus (it also looks like that branch
doesn't flow into -next, it probably should):

https://git.kernel.org/sre/linux-power-supply/c/644106cdb89844be2496b21175b7c0c2e0fab381

Cheers,
Nathan

> > ---
> >  drivers/power/reset/ltc2952-poweroff.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset/ltc2952-poweroff.c
> > index fbb344353fe4..9fc88a9f244c 100644
> > --- a/drivers/power/reset/ltc2952-poweroff.c
> > +++ b/drivers/power/reset/ltc2952-poweroff.c
> > @@ -159,8 +159,8 @@ static void ltc2952_poweroff_kill(void)
> >
> >  static void ltc2952_poweroff_default(struct ltc2952_poweroff *data)
> >  {
> > -       data->wde_interval = 300L * 1E6L;
> > -       data->trigger_delay = ktime_set(2, 500L*1E6L);
> > +       data->wde_interval = 300 * NSEC_PER_MSEC;
> > +       data->trigger_delay = ktime_set(2, 500 * NSEC_PER_MSEC);
> >
> >         hrtimer_init(&data->timer_trigger, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> >         data->timer_trigger.function = ltc2952_poweroff_timer_trigger;
> > --
> > 2.29.2
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
