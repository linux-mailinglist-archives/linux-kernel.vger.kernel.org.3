Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F18596DC2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 13:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238927AbiHQLko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 07:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239226AbiHQLke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 07:40:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722A482FAB;
        Wed, 17 Aug 2022 04:40:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE885614CD;
        Wed, 17 Aug 2022 11:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C83C433D6;
        Wed, 17 Aug 2022 11:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660736432;
        bh=ONtkeJPXeNURpLNKLHDePnWlDmpB+dnu6iDI/6X8T3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b3kl48/4jnJFhWCWnqyUt4SP1JZP8p0VWe3Uo6unxx7XUu9/e6DP5G9hiWh/9zKAy
         39Tpu7qkmWoK7wLKt5PdBhVo/nbtx1JYLRnHmr08U5QJ58W8awg42LXbdzcw4gtwaF
         h/M8lVG0DiXDfE0HdX66HMjLxWTYSHWpejtGGCesfBxCdWa4H7UJq9w7IKdiIJVz4z
         PuJQz86a5PoamQJ9068JnYdPI0C7Agr4rU3hnF1B6PSdEwZT6hmL6SOnETYaw37qJS
         yFEEtR8WRF7f4VkplZ8hWp7apNuKU7+/j2V6snGnQ8kI/LIObUdnBClZ0A08dsV5Um
         BYmZ366Qn1rTw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1CCEA4035A; Wed, 17 Aug 2022 08:40:29 -0300 (-03)
Date:   Wed, 17 Aug 2022 08:40:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/4] perf tools: Support reading PERF_FORMAT_LOST (v2)
Message-ID: <YvzTrSUF5XTsslH7@kernel.org>
References: <20220816221747.275828-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816221747.275828-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 16, 2022 at 03:17:43PM -0700, Namhyung Kim escreveu:
> Hello,
> 
> The kernel v6.0 added PERF_FORMAT_LOST which can read a number of lost
> samples for the given event.  As it can change the output format of
> read(2) and perf sample data, it needs to access them carefully.
> 
> Changes in v2)
>  * add a comment in perf_evsel__read_group()  (Jiri)
>  * simplify perf_evsel__adjust_values()  (Jiri)

Replaced v1 with this one in my local tree.

- Arnaldo
 
> 
> You can get the code from 'perf/read-lost-v2' brach on
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (4):
>   tools headers UAPI: Sync linux/perf_event.h with the kernel sources
>   tools lib perf: Handle read format in perf_evsel__read()
>   tools lib perf: Add a test case for read formats
>   perf tools: Support reading PERF_FORMAT_LOST
> 
>  tools/include/uapi/linux/perf_event.h         |   5 +-
>  tools/lib/perf/evsel.c                        |  79 ++++++++-
>  tools/lib/perf/include/perf/event.h           |   3 +-
>  tools/lib/perf/include/perf/evsel.h           |   4 +-
>  tools/lib/perf/tests/test-evsel.c             | 161 ++++++++++++++++++
>  tools/perf/tests/sample-parsing.c             |  14 +-
>  tools/perf/util/event.h                       |  18 +-
>  tools/perf/util/evsel.c                       |  33 +++-
>  .../scripting-engines/trace-event-python.c    |  16 +-
>  tools/perf/util/session.c                     |  32 ++--
>  tools/perf/util/synthetic-events.c            |  34 +++-
>  11 files changed, 360 insertions(+), 39 deletions(-)
> 
> 
> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> -- 
> 2.37.1.595.g718a3a8f04-goog

-- 

- Arnaldo
