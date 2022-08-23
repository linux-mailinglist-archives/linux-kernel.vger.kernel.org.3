Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6A659EC99
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbiHWTmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbiHWTmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:42:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44503C8CB;
        Tue, 23 Aug 2022 11:42:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 410C66170B;
        Tue, 23 Aug 2022 18:42:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA2FC433C1;
        Tue, 23 Aug 2022 18:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661280137;
        bh=Mi4OM1rqCjF6cIOjGdzw7szRnUp7ZnNMmJ8zusLZ5NM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=acBfzBQtU6hGV3Bl3i6RibFmWvDsiqPk1i8pr5LTrQABjTxxf2oSZ7nrSFyB1d1II
         5A5eBQc2kLpj0FglnREN6rGcwI2uWPAW6MfaplIyebEa35FloYbf6DRrAPo1KJ3ZHn
         RU1879AD1VlmmD4nE59+xaUn6BKqRISKEzT44tg5hbqm77PmVb6oyAJs0Nan52ds65
         CnFfYXJYpLYMfj1UaK7Sp3NG/Ot2SQCTaKigdkQpLJ7OfNdIiLEMtKvpjTwZ92wRmJ
         /e9N8MX/45Zqx2kgpdgKSHvPpdy+RFQ8DDo5cBwHUkPju2QFz0qW1AeVOOXwreqR4+
         QwDr+xN9sWAUg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5814B404A1; Tue, 23 Aug 2022 15:42:14 -0300 (-03)
Date:   Tue, 23 Aug 2022 15:42:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 1/2] perf stat: Clear reset_group for each stat run
Message-ID: <YwUfhvMUsE3FwZQ4@kernel.org>
References: <20220822213352.75721-1-irogers@google.com>
 <dc07fcb8-9a7c-7f74-375f-99ce192c4f39@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc07fcb8-9a7c-7f74-375f-99ce192c4f39@linux.intel.com>
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

Em Tue, Aug 23, 2022 at 05:10:55PM +0200, Andi Kleen escreveu:
> 
> On 8/22/2022 11:33 PM, Ian Rogers wrote:
> > If a weak group is broken then the reset_group flag remains set for
> > the next run. Having reset_group set means the counter isn't created
> > and ultimately a segfault.
> > 
> > A simple reproduction of this is:
> > perf stat -r2 -e '{cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles}:W
> > which will be added as a test in the next patch.
> > 
> > Fixes: 4804e0111662 ("perf stat: Use affinity for opening events")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> 
> Makes sense
> 
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

Ok, applied.

- Arnaldo
