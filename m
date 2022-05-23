Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFA5530FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235891AbiEWNFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235856AbiEWNFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:05:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135DF4992D;
        Mon, 23 May 2022 06:05:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A108361349;
        Mon, 23 May 2022 13:05:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB6DC385A9;
        Mon, 23 May 2022 13:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653311141;
        bh=bWrL+p+gwqZvG50H6tpkpi47lD1PdQOmcrKzmQSZeBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AWu9228BkTIzNTsWBSiHPPYtNXOhYhpo/D98nFYLThrLxBvWxCMfQwNpndNN3m7KR
         HA+q61wF+dJrYwr3/9eyH1ooD6+HEgfi7dtjS7BJPzcS2pJeZs8FyYkEazWmYcPgKh
         CCI00uz8N1c7dGCDuw9+vjkDByD1ybgzzhn89RgzZxksQzJ449Q2P95G8GK4vFGnmM
         wAj4h0xF7iQ/LHHAy/dcm6aJQgzXGdYOW24hwBTARFUeiE6uBI+sHf+B3qH48c1yK3
         WpzVvtTrnK9glwiFOHg1Tu8Pi/zLzsb9mWZAZAoEClOPENxV/6j4VKtjBx2VKSBY4H
         Ae3USidvIzS6g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E4DCC400B1; Mon, 23 May 2022 10:05:37 -0300 (-03)
Date:   Mon, 23 May 2022 10:05:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Marco Elver <elver@google.com>,
        John Garry <john.garry@huawei.com>,
        Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 0/8] Make more tests skip rather than fail
Message-ID: <YouGoc9elnPwV5IM@kernel.org>
References: <20220518042027.836799-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518042027.836799-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 17, 2022 at 09:20:19PM -0700, Ian Rogers escreveu:
> A long standing niggle has been that tests that cannot pass are marked
> as failing rather than skip.  John Garry mentioned a similar concern
> in [1]. These changes fix this behavior so that as root, or not, at
> least the first 10 tests are passing or skipping.
> 
> [1] https://lore.kernel.org/lkml/d32376b5-5538-ff00-6620-e74ad4b4abf2@huawei.com/
> 
> v2. Updates reviewed-by and acked-by. It addresses review comments
>     from Namhyung Kim <namhyung@kernel.org>. An extra fix is now
>     included for PERF_RECORD_* which can fail as a user because of
>     perf_event_paranoid.

Thanks, applied.

- Arnaldo

 
> Ian Rogers (8):
>   perf test: Skip reason for suites with 1 test
>   perf test: Use skip in vmlinux kallsyms
>   perf test: Use skip in openat syscall
>   perf test: Basic mmap use skip
>   perf test: Parse events tidy terms_test
>   perf test: Parse events tidy evlist_test
>   perf test: Parse events break apart tests
>   perf test: Use skip in PERF_RECORD_*
> 
>  tools/perf/tests/builtin-test.c            |   6 +-
>  tools/perf/tests/mmap-basic.c              |  18 +-
>  tools/perf/tests/openat-syscall-all-cpus.c |  23 +-
>  tools/perf/tests/openat-syscall.c          |  20 +-
>  tools/perf/tests/parse-events.c            | 492 +++++++++++----------
>  tools/perf/tests/perf-record.c             |  18 +-
>  tools/perf/tests/vmlinux-kallsyms.c        |  12 +-
>  7 files changed, 341 insertions(+), 248 deletions(-)
> 
> -- 
> 2.36.0.550.gb090851708-goog

-- 

- Arnaldo
