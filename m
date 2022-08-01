Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A905B586FF0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbiHAR6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbiHAR5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:57:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55738B1DC;
        Mon,  1 Aug 2022 10:56:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFF1561160;
        Mon,  1 Aug 2022 17:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A0BC433C1;
        Mon,  1 Aug 2022 17:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659376583;
        bh=sgF7Ila5Go50G/Z0YwLeetdlAZaIQSPpQ4eGRIrjUfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eQTYpYq2X9p4/bUFs31elGwHf3bxE9a0XO/ulP0WVFoHMvP3pBDsTMQejLTPyc2N3
         U0fHcZyyUzs/hhoGl63QeTyCgHAAWQZe5PVcW3pUX6PHoCVWvrN7qmCR175zqC2h5i
         6yEdsEwEqFKRGuM4hKs3bzMgYHLh3cS7AmlMpItHucbTG+v8TztGV6kKSsW1wrdAoz
         jDJBZwDTV9oi3kQt+hKPYgo9brBELv4brGpE+pT9HyEmJI2p/7/4DShfeKyk/IagAY
         VirBQTb9SHpfzfBi8+biYsCRl6uS+abxZJMAkSqhtHs9YjBiHqk5FiyIi0wd7aKtOp
         VqQoQ40Kai+IA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5DE0940736; Mon,  1 Aug 2022 14:56:20 -0300 (-03)
Date:   Mon, 1 Aug 2022 14:56:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf symbol: Fail to read phdr workaround
Message-ID: <YugTxE/O0SmTb9FI@kernel.org>
References: <20220731164923.691193-1-irogers@google.com>
 <20220801015259.GA101027@leoy-ThinkPad-X240s>
 <CAP-5=fVSjCQ4jeAeyP5THnQVyXDpKd6Ob33C7PDwFB_6+YSXuw@mail.gmail.com>
 <YufJP5YqeEBM51HL@kernel.org>
 <20220801132511.GC73228@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801132511.GC73228@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 01, 2022 at 09:25:11PM +0800, Leo Yan escreveu:
> On Mon, Aug 01, 2022 at 09:38:23AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Sun, Jul 31, 2022 at 11:19:15PM -0700, Ian Rogers escreveu:
> > > On Sun, Jul 31, 2022, 6:53 PM Leo Yan <leo.yan@linaro.org> wrote:
> > > 
> > > > On Sun, Jul 31, 2022 at 09:49:23AM -0700, Ian Rogers wrote:
> > > > > The perf jvmti agent doesn't create program headers, in this case
> > > > > fallback on section headers as happened previously.
> > > > >
> > > > > Fixes: 882528d2e776 ("perf symbol: Skip symbols if SHF_ALLOC flag is not
> > > > set")
> > > >
> > > > It's good to change fix tag as:
> > > > Fixes: 2d86612aacb7 ("perf symbol: Correct address for bss symbols")
> > > >
> > > 
> > > Doh! I was rushing this morning. Thanks for catching and reviewing!
> > 
> > I made the adjustments and added a note with the repro, to help in the
> > future when trying to test this area.
> 
> Thanks, Arnaldo.
> 
> > I also think we could have something like a 'perf test' mode where, when
> > asked to, it would enable tests that involve downloading such files to
> > perform tests, such as this dacapo benchmark, and then would test if the
> > output matches expectations.
> 
> I will add a testing based on the steps, alongside with the discussed
> testing for data symbols.  Will share out after get ready.

Great! Thanks in advance,

- Arnaldo
