Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D35562F38
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiGAI4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236411AbiGAIzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:55:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E61D7359B;
        Fri,  1 Jul 2022 01:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ab5snWWj0dJHDeLigcKWOMjLLiIqRzk2rWZJIW0Pk6I=; b=UZBPeXYs5Kx58t6JlZ5UP1dxRe
        y0aPXvgzdAE3mycmypUhx2TlP7k6ymTu0cWphSuZzxH4iDr6DV36tqdCV0kRnqFV6Z20BIcR4ObOX
        uEo5UsvKFk5oQodpCvsO8wsbqYg2VcXpYAscoQmDG3lTSVhWpodyx+xcI7Sxdfi4PnHyMSueEMUFa
        vQ8y2My3J+xjSggpB/HmPA6Uk4nUGHsjO4MOgUmHu0ikl2oXUm230dkt5t2bomk8gTLiXu8jpapmP
        2FPXTz09ZXqPQc6lLvKW4i4V85+kQi5O3pChqmkHrEUWj0/ykDR6P0TQm6/gQlWokgPpB0e0Ksx7b
        QBkjBtxw==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o7CR1-00EqlV-PY; Fri, 01 Jul 2022 08:55:31 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0BB6B980017; Fri,  1 Jul 2022 10:55:31 +0200 (CEST)
Date:   Fri, 1 Jul 2022 10:55:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Claire Jensen <cjense@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>, ben@decadent.org.uk
Subject: Re: [PATCH] perf test: Skip for paranoid 3
Message-ID: <Yr62go3Zx1ydlxpg@worktop.programming.kicks-ass.net>
References: <20220629034007.332804-1-irogers@google.com>
 <Yr1ozmP2E8Fer11e@worktop.programming.kicks-ass.net>
 <CAP-5=fXRxvSB9WrcTEM+2rnALuzPBdPz=v+WGhvN_SS2Ba2MTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXRxvSB9WrcTEM+2rnALuzPBdPz=v+WGhvN_SS2Ba2MTw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 01:59:54PM -0700, Ian Rogers wrote:
> On Thu, Jun 30, 2022 at 2:11 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Jun 28, 2022 at 08:40:07PM -0700, Ian Rogers wrote:
> > > Add skip tests for paranoid level being 3.
> > > Rather than skipping lines starting "Failed", skip lines containing
> > > "failed" - making the behavior consistent with the previous python
> > > version.
> >
> > paranoid 3 is an out of tree patch.
> 
> Thanks, what is the right way to resolve this? My desktop appears to
> be carrying the patch and I'd like the tests to be as green as
> possible.

Then you desktop is probably running a Debian or derivative distro
kernel. You can run your own kernel, or ask the Debian team to ditch
their hack and use the LSM hooks to further limit perf usage if they
feel this is required.

The big advantage of the LSM hooks is that they can explicitly
white-list the perf binary while dis-allowing random users access to the
syscall. That way perf will still work but the possible exploit
potential is much reduced.
