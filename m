Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2F75AB8B8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 21:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiIBTJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 15:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiIBTJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 15:09:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF6413E88;
        Fri,  2 Sep 2022 12:09:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDE67B82D6B;
        Fri,  2 Sep 2022 19:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568BEC433D7;
        Fri,  2 Sep 2022 19:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662145770;
        bh=JgbTsvyX+Nxm+CbzSBYRYr/ejplaYINRqEHHMS7q/2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KaN+qsET2GDv9Q4Ifk4pA/Achrq/6l7EPYiXmu9TapL9PQZBIHpYXI77hHl8ylS+m
         7QMFwk9J15Gn7I8ZdeQg6r9H9sGHWgd+XSPh8bQ9jodrVfA+NDS6hnvgH1rTRh65QL
         nm7Qn6mnG7g/Erd1SpibM+fPvHWvxBXZiTAPV5CYPMpQTnS4gH7J22kPeyf5ywi8dz
         JuB3MnhOPGOsox2Ys1eYi4CtBb7pGJUbD4xNTDgrN7IuQMkSsUpBLxW84VO21OZzCg
         03EG5F/gaEmksp+ywA0yOrHlqIDaNOu2VxLnQZ1ipfOHvG4iuHRd64R7S9Aq+B2Xk1
         ElPe/jalzUmbg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 96389404A1; Fri,  2 Sep 2022 16:09:27 -0300 (-03)
Date:   Fri, 2 Sep 2022 16:09:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCHSET 0/5] perf tools: Show per-event lost sample count (v2)
Message-ID: <YxJU5yfFC0bI545e@kernel.org>
References: <20220901195739.668604-1-namhyung@kernel.org>
 <5466ec6a-e964-ea8a-d253-f7d3d4af4ea1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5466ec6a-e964-ea8a-d253-f7d3d4af4ea1@intel.com>
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

Em Fri, Sep 02, 2022 at 08:44:25PM +0300, Adrian Hunter escreveu:
> On 1/09/22 22:57, Namhyung Kim wrote:
> > Hello,
> > 
> > Now we have PERF_FORMAT_LOST support, add it to perf record and report so that
> > it can show number of lost samples per event.  This can be useful if you want
> > to reconstruct number of events from the samples like when using -c option.
> > 
> > Changes in v2)
> >  * fix id_hdr_size calculation  (Adrian)
> >  * fix a memory leak
> >  * display lost samples even if no samples
> >  
> >  
> > Currently it adds PERF_RECORD_LOST_SAMPLES at the end of perf data after reading
> > event values by read(2).  The perf record unconditionally sets the lost bit if
> > the kernel supports it.  Users can see the number with `perf report --stat`.
> > 
> > You can get the code from 'perf/report-lost-v2' brach on
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> > 
> > Thanks,
> > Namhyung
> > 
> > Namhyung Kim (5):
> >   perf tools: Print LOST read format in the verbose mode
> >   perf record: Set PERF_FORMAT_LOST by default
> >   perf record: Read and inject LOST_SAMPLES events
> >   perf hist: Add nr_lost_samples to hist_stats
> >   perf report: Show per-event LOST SAMPLES stat
> 
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied.

- Arnaldo
