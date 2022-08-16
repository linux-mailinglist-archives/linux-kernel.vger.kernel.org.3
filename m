Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9757D596372
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 22:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237330AbiHPUBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 16:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbiHPUBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 16:01:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085C87E83A;
        Tue, 16 Aug 2022 13:01:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5EFAB816A4;
        Tue, 16 Aug 2022 20:01:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629AEC433D6;
        Tue, 16 Aug 2022 20:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660680084;
        bh=exaNKYkS3RGsXGptBvcU0ygllszaHLvdDMEuOEXqDh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ye5uz8wJF+KkzYAi6mwLSo+EQndL4RfeowxCt0/ubtbmZtHSqy0+5RZyHt3p+4buT
         jcykLx6DVR4FUv7XfLSLkrCMKE54KrYwsxUvUngW5gwsfAKc/MfM2Vh82sl7kHsqXI
         fz+BI+aw8VIy19PQQ8WleqiU+dqVkFCARE3LGairCU7+mU8pPjZC/0WmBwpKHJqtvo
         T7wJSN9/d4tWsy3BvA21DrpuBQkF7SYTH6Q1cYW2cp/8x5FYVq0b/kA2nuRlR9jSf2
         BJ1NUzWtTQ0KHf6zHeJh7VNetJH/DEEZ1H+JEsAmnBSTXQAJ9mG2k3AmFVyj27usaI
         mP9jAOoaiZUTw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C88944035A; Tue, 16 Aug 2022 17:01:21 -0300 (-03)
Date:   Tue, 16 Aug 2022 17:01:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/4] perf tools: Support reading PERF_FORMAT_LOST
Message-ID: <Yvv3kS9YqHMFSXDV@kernel.org>
References: <20220815190106.1293082-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815190106.1293082-1-namhyung@kernel.org>
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

Em Mon, Aug 15, 2022 at 12:01:02PM -0700, Namhyung Kim escreveu:
> Hello,
> 
> The kernel v6.0 added PERF_FORMAT_LOST which can read a number of lost

I've tentantively added this to perf/urgent, as this matches a feature
introduced in this merge window, we'll see how it goes, hopefully Linus
accepts this at this point.

- Arnaldo

> samples for the given event.  As it can change the output format of
> read(2) and perf sample data, it needs to access them carefully.
> 
> You can get the code from 'perf/read-lost-v1' brach on
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
>  tools/lib/perf/evsel.c                        |  72 ++++++++
>  tools/lib/perf/include/perf/event.h           |   3 +-
>  tools/lib/perf/include/perf/evsel.h           |   4 +-
>  tools/lib/perf/tests/test-evsel.c             | 161 ++++++++++++++++++
>  tools/perf/tests/sample-parsing.c             |  14 +-
>  tools/perf/util/event.h                       |  18 +-
>  tools/perf/util/evsel.c                       |  33 +++-
>  .../scripting-engines/trace-event-python.c    |  16 +-
>  tools/perf/util/session.c                     |  32 ++--
>  tools/perf/util/synthetic-events.c            |  34 +++-
>  11 files changed, 354 insertions(+), 38 deletions(-)
> 
> 
> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> -- 
> 2.37.1.595.g718a3a8f04-goog

-- 

- Arnaldo
