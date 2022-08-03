Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F137588F25
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 17:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237848AbiHCPMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 11:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbiHCPMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 11:12:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD1B2AC64;
        Wed,  3 Aug 2022 08:12:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D5D5616DA;
        Wed,  3 Aug 2022 15:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CA9C433D6;
        Wed,  3 Aug 2022 15:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659539552;
        bh=p8QyDDDw5i78K85n6ri69fueQGZCAVLQxha9fjbynak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vEIYcNU92D1Fx6/jc/qFgiTqebXCPFev99O6evkXGK75fW2wj75NOjv4ZqGNmifGP
         HyF0Ppg0U9ufEryHgO70XWGnocyjjkUNh0Awa/LaGMl6LwA3bTwVZSh6Ax3HZ4Mi7k
         Xm3PPJT+3vAqH99ZBAGu4yKGiJLZexOe3raWclBxEOr1ZEPfoVhPoVEGE6f8b9qJam
         D1VP8o3rh051irPkOqC7e8J4A5B2HlExNCE67zGTvAVjyH/7vVh4NU2aOIALLItbgt
         Saj7tF8HtlcBJbH9IGB1GutE0FtV7yoJAw/ol2E/MPn23Dfsq8oZX6Fujuj3ycez/C
         IaRHNHjE1qZYw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7341840736; Wed,  3 Aug 2022 12:12:29 -0300 (-03)
Date:   Wed, 3 Aug 2022 12:12:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Song Liu <songliubraving@fb.com>,
        Blake Jones <blakejones@google.com>
Subject: Re: [PATCH v2 1/3] perf lock: Introduce struct lock_contention
Message-ID: <YuqQXbCTCLPjTnH6@kernel.org>
References: <20220802191004.347740-1-namhyung@kernel.org>
 <YumRXcxc5XIUwlBO@kernel.org>
 <CAM9d7choD8v8Bxu3w4V1Q3M1i7SwP2W+pY5ZWLqUqr89O2PLOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7choD8v8Bxu3w4V1Q3M1i7SwP2W+pY5ZWLqUqr89O2PLOQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 02, 2022 at 04:47:02PM -0700, Namhyung Kim escreveu:
> On Tue, Aug 2, 2022 at 2:04 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > Em Tue, Aug 02, 2022 at 12:10:02PM -0700, Namhyung Kim escreveu:
> > > The lock_contention struct is to carry related fields together and to
> > > minimize the change when we add new config options.
> >
> >
> > Thanks, applied. Forgot the cover letter? :-)
> 
> Thank you!
> 
> I thought it's a small change that doesn't require a cover letter.
> But if you prefer seeing it for small changes too, I'd write a
> short letter next time.

Yeah, just felt unusual, but then, b4 with any of the message-ids works
just fine, so up to you, I'm adjusting.

- Arnaldo
