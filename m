Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5535637EA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 18:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbiGAQ2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 12:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbiGAQ2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:28:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5D73205B;
        Fri,  1 Jul 2022 09:28:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C599162573;
        Fri,  1 Jul 2022 16:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21922C341C7;
        Fri,  1 Jul 2022 16:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656692928;
        bh=8EPMGYldgRgjjDYLaj6mvfXTi2oreQHR+PEXE+t1tns=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JtZzSsYzmJedsJFw0B8d8L5oCI5pxc5AqSscDz7QxpPeNFe2cUASx8JDfrtygZyN6
         T8kKljVBPkWvHF8M+CVm+bJFVraXDZr8unrSKQE6Oh81HHTqPe1dwkH8tjP1DzXBjg
         Cox6C9EqtYq+xIjcVMJbpEOruvHJdecNf5AMkVjgDWA9EcZgAV92CBrsqg3ZtRoYFW
         cFAG71C5CuzCMSno1cq+Oof9SACkiYHCAF68T7ZQoWvIcRnLsG28/hvsRa+4FvxFeX
         JT50MfQzCZllUm7mjgR5S0EuHAcaZJvAImaAz+ocDBBr8/SbanF1m8LRCAkwcXImE+
         jmoV4OZLZbjtg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C22315C06A1; Fri,  1 Jul 2022 09:28:47 -0700 (PDT)
Date:   Fri, 1 Jul 2022 09:28:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Hongtao Yu <hoy@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Bill Wendling <morbo@google.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Ruud van der Pas <ruud.vanderpas@oracle.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Vladimir Mezentsev <vladimir.mezentsev@oracle.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>, Yonghong Song <yhs@fb.com>,
        Wenlei He <wenlei@fb.com>, Ingo Molnar <mingo@kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>,
        "elena.zannoni@oracle.com" <elena.zannoni@oracle.com>
Subject: Re: plumbers session on profiling?
Message-ID: <20220701162847.GS1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <87mtf7z0rt.fsf@gnu.org>
 <6F9E9D93-3913-4022-9384-D809C8EF7715@oracle.com>
 <CAKwvOdm=_YqBpuBzouqoWHYNe6MMUE10vqF0PUkU=hcOj+UqrQ@mail.gmail.com>
 <B0A01DE7-1B50-479A-92DF-DAFAB3F06E0F@oracle.com>
 <878rpgpvfj.fsf@gnu.org>
 <Yr638aOIaaEBPICy@worktop.programming.kicks-ass.net>
 <CAGG=3QWbW-Dang49Jx3fyNExWtL8syuMkMJmcPHA7J25cHQ0zw@mail.gmail.com>
 <Yr7fMre18pUMz9rA@worktop.programming.kicks-ass.net>
 <20220701135028.GN1790663@paulmck-ThinkPad-P17-Gen-1>
 <MW3PR15MB3868B1DC443B538A2A27F1D3CFBD9@MW3PR15MB3868.namprd15.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR15MB3868B1DC443B538A2A27F1D3CFBD9@MW3PR15MB3868.namprd15.prod.outlook.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 03:32:12PM +0000, Hongtao Yu wrote:
> 
> 
> ________________________________
> From: Paul E. McKenney <paulmck@kernel.org>
> Sent: Friday, July 1, 2022 6:50 AM
> To: Peter Zijlstra <peterz@infradead.org>
> Cc: Bill Wendling <morbo@google.com>; Jose E. Marchesi <jemarch@gnu.org>; Ruud van der Pas <ruud.vanderpas@oracle.com>; Nick Desaulniers <ndesaulniers@google.com>; Sami Tolvanen <samitolvanen@google.com>; Vladimir Mezentsev <vladimir.mezentsev@oracle.com>; clang-built-linux <llvm@lists.linux.dev>; LKML <linux-kernel@vger.kernel.org>; Yonghong Song <yhs@fb.com>; Wenlei He <wenlei@fb.com>; Hongtao Yu <hoy@fb.com>; Ingo Molnar <mingo@kernel.org>; linux-toolchains <linux-toolchains@vger.kernel.org>; elena.zannoni@oracle.com <elena.zannoni@oracle.com>
> Subject: Re: plumbers session on profiling?
> 
> On Fri, Jul 01, 2022 at 01:49:06PM +0200, Peter Zijlstra wrote:
> > On Fri, Jul 01, 2022 at 03:17:54AM -0700, Bill Wendling wrote:
> > > On Fri, Jul 1, 2022 at 2:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Tue, Jun 28, 2022 at 07:08:48PM +0200, Jose E. Marchesi wrote:
> > > > >
> > > > > [Added linux-toolchains@vger in CC]
> > > > >
> > > > > It would be interesting to have some discussion in the Toolchains track
> > > > > on building the kernel with PGO/FDO.  I have seen a raise on interest on
> > > > > the topic in several companies, but it would make very little sense if
> > > > > no kernel hacker is interested in participating... anybody?
> > > >
> > > > I know there's been a lot of work in this area, but none of it seems to
> > > > have trickled down to be easy enough for me to use it.
> > >
> > > We use an instrumented kernel to collect the data we need. It gives us
> > > the best payoff, because the profiling data is more fine-grained and
> > > accurate. (PGO does much more than make inlining decisions.)
> > >
> > > If I recall correctly, you previously suggested using sampling data.
> > > (Correct?) Is there a document or article that outlines that process?
> >
> > IIRC Google has LBR sample driven PGO somewhere as well. ISTR that being
> > the whole motivation for that gruesome Zen3 BRS hack.
> >
> > Google got me this: https://research.google.com/pubs/archive/45290.pdf
> 
> > Whatever else, please refrain from using PGO and friends to drive
> data-value speculation!
> 
>  Is there a particular reason for this?

Yes, there is.

Doing so breaks many concurrent algorithms.

Sure, the hardware can get away with this sort of thing.  But that is
only because it has access to cache and store-buffer state that allows it
to roll back and replay when needed.  The compiler does not have access
to this state [1], so it needs to avoid playing this game.

							Thanx, Paul
