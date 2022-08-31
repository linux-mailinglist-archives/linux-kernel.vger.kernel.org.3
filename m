Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26C55A7D4D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiHaMaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiHaMaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:30:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BABB1E3;
        Wed, 31 Aug 2022 05:30:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63B3C61999;
        Wed, 31 Aug 2022 12:30:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D51DC433C1;
        Wed, 31 Aug 2022 12:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661949005;
        bh=xUAe/8husFmwnBA0zfVEAqWyrCl83ZcMIyiwRkNQ/A0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tq+5F6knMwcUy7jvIG0XcNJ+kcjbinj3aLlcszl+ZsZjV7F6Q6DUccGBrae5H1VJp
         MP9eanqJzI0BF5vq1V+Cy3z/NfbuCMTG5mzKrQyU9W46S/+vynmLiO5qi6JeTn9w1R
         aLRS+eCJKey1uCkpwoi+7sCeV9TsyvoGyWHFVF/NrFBcuVj/LwSJES2Mlh3v6duLzN
         AH7VIXkUuyOF6yMankiGQ2HAb3G+higOdsRRJIYVt9VRwfLnzyKK13mbpeZKqTI2Hs
         Zg6SkcFPcxGg20jHsiUmHPhnX2lz3oeR5G/01wi3BkDsxBjZF9MOavScLUoNXjLQJV
         iOkMaD/gWLyrQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4F3DA404A1; Wed, 31 Aug 2022 09:30:03 -0300 (-03)
Date:   Wed, 31 Aug 2022 09:30:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 2/8] perf metric: Return early if no CPU PMU table
 exists
Message-ID: <Yw9US7HG0hDsc+FA@kernel.org>
References: <20220830164846.401143-1-irogers@google.com>
 <20220830164846.401143-3-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830164846.401143-3-irogers@google.com>
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

Em Tue, Aug 30, 2022 at 09:48:40AM -0700, Ian Rogers escreveu:
> Previous behavior is to segfault if there is no CPU PMU table and a
> metric is sought. To reproduce compile with NO_JEVENTS=1 then request
> a metric, for example, "perf stat -M IPC true".
> 
> Fixes: 00facc760903 ("perf jevents: Switch build to use jevents.py")
> Signed-off-by: Ian Rogers <irogers@google.com>

Before:

  $ make -k NO_JEVENTS=1 BUILD_BPF_SKEL=1 O=/tmp/build/perf-urgent -C tools/perf install-bin
  $ perf stat -M IPC true
  Segmentation fault (core dumped)
  $

After:

  $ perf stat -M IPC true

   Usage: perf stat [<options>] [<command>]

      -M, --metrics <metric/metric group list>
                            monitor specified metrics or metric groups (separated by ,)
  $

Better, but perhaps we could provide some better message as to why the
metric provided isn't acceptable?

Anyway, applied to perf/urgent.

Thanks,

- Arnaldo

> ---
>  tools/perf/util/metricgroup.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index ad5cacdecd81..18aae040d61d 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1655,6 +1655,9 @@ int metricgroup__parse_groups(const struct option *opt,
>  	struct evlist *perf_evlist = *(struct evlist **)opt->value;
>  	const struct pmu_events_table *table = pmu_events_table__find();
>  
> +	if (!table)
> +		return -EINVAL;
> +
>  	return parse_groups(perf_evlist, str, metric_no_group,
>  			    metric_no_merge, NULL, metric_events, table);
>  }
> -- 
> 2.37.2.672.g94769d06f0-goog

-- 

- Arnaldo
