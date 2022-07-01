Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39565634B2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 15:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbiGANuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 09:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGANuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:50:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60E527CC2;
        Fri,  1 Jul 2022 06:50:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47798B8304A;
        Fri,  1 Jul 2022 13:50:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC38C3411E;
        Fri,  1 Jul 2022 13:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656683429;
        bh=7BqvMnV2CPFEbTLeWRyNM6r0PUUA2IvmiF020Jwgv7o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gDicXvWIJ9wpWGI3m+utmz6i+JHp/BxSwDwqbKoe+54EvIoLFyLcR8NXhSVrj0T0L
         hYnN7gYq84YFwsf6I3lsu/hKtWuD3Sr+kOFFQXpTIsL63meWYc4uzDRW1X1ZvRAv80
         dcKdW+H7LGhtE+4jn6VjxIy3raVKSBeBnoCRzsENWBHhLxNdxFIntI1LwXXFwlG/AZ
         INmqp4qwlhddrwHhNFMuNr/Sc9AAfVYkcmueQQovJkF9CgTgdhxKB1Rpj+ssv6e3y6
         6ot4dj/HgCsfrEb8qBNMbi1nRtgryFCmomzgMTR0Czg0K1/gKr0NNzJNk+KsGIJJdl
         /X3C3Qf5nPJkw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 89BA55C06A1; Fri,  1 Jul 2022 06:50:28 -0700 (PDT)
Date:   Fri, 1 Jul 2022 06:50:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Bill Wendling <morbo@google.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Ruud van der Pas <ruud.vanderpas@oracle.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Vladimir Mezentsev <vladimir.mezentsev@oracle.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>, Yonghong Song <yhs@fb.com>,
        Wenlei He <wenlei@fb.com>, Hongtao Yu <hoy@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>,
        elena.zannoni@oracle.com
Subject: Re: plumbers session on profiling?
Message-ID: <20220701135028.GN1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CAKwvOdkyY9rsH3eViMK-_4iz_W_usumz5nD+3AhbNCVQ3FRCjA@mail.gmail.com>
 <CAKwvOdnsZekEM77axBf67MDqQVP0n6PTKH=njSyPSWTNiWAOiA@mail.gmail.com>
 <87mtf7z0rt.fsf@gnu.org>
 <6F9E9D93-3913-4022-9384-D809C8EF7715@oracle.com>
 <CAKwvOdm=_YqBpuBzouqoWHYNe6MMUE10vqF0PUkU=hcOj+UqrQ@mail.gmail.com>
 <B0A01DE7-1B50-479A-92DF-DAFAB3F06E0F@oracle.com>
 <878rpgpvfj.fsf@gnu.org>
 <Yr638aOIaaEBPICy@worktop.programming.kicks-ass.net>
 <CAGG=3QWbW-Dang49Jx3fyNExWtL8syuMkMJmcPHA7J25cHQ0zw@mail.gmail.com>
 <Yr7fMre18pUMz9rA@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr7fMre18pUMz9rA@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 01:49:06PM +0200, Peter Zijlstra wrote:
> On Fri, Jul 01, 2022 at 03:17:54AM -0700, Bill Wendling wrote:
> > On Fri, Jul 1, 2022 at 2:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Tue, Jun 28, 2022 at 07:08:48PM +0200, Jose E. Marchesi wrote:
> > > >
> > > > [Added linux-toolchains@vger in CC]
> > > >
> > > > It would be interesting to have some discussion in the Toolchains track
> > > > on building the kernel with PGO/FDO.  I have seen a raise on interest on
> > > > the topic in several companies, but it would make very little sense if
> > > > no kernel hacker is interested in participating... anybody?
> > >
> > > I know there's been a lot of work in this area, but none of it seems to
> > > have trickled down to be easy enough for me to use it.
> > 
> > We use an instrumented kernel to collect the data we need. It gives us
> > the best payoff, because the profiling data is more fine-grained and
> > accurate. (PGO does much more than make inlining decisions.)
> > 
> > If I recall correctly, you previously suggested using sampling data.
> > (Correct?) Is there a document or article that outlines that process?
> 
> IIRC Google has LBR sample driven PGO somewhere as well. ISTR that being
> the whole motivation for that gruesome Zen3 BRS hack.
> 
> Google got me this: https://research.google.com/pubs/archive/45290.pdf

Whatever else, please refrain from using PGO and friends to drive
data-value speculation!

							Thanx, Paul
