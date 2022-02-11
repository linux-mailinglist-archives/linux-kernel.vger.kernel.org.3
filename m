Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5BE4B2BB6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352086AbiBKR0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:26:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbiBKR0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:26:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727E2EB;
        Fri, 11 Feb 2022 09:26:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D1C16171C;
        Fri, 11 Feb 2022 17:26:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABB9C340E9;
        Fri, 11 Feb 2022 17:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644600365;
        bh=HoH0qp+HzKRae3uS5NJBL+V6WCPABOJ4JbObL/7vHJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nYvTi+kXbR/YZxs8kOggDfamE1zH8O58i8fEm2gvqPR08CnFUJjGCOGnOs3HgrzQz
         N5+ZQm97iEYbcThS8bX32ea8nEB2Xb0AekyZNBLztoZmGy+w+ilwhPkcFD2Nq66+GC
         5KeYRMLIRaf7mhpXwUFachLR5nYFbeFLyIQY4tgiozdDJObg43p3kuuLWFPSBLGT18
         0doim1HbgQNIoyO/BndYhKCLDFJZe+zM4cLF5/jQIUIjT8TiSqtraRD4jVbR6WnQun
         7KMnYYRfBGwTjKMpD2P6oKxQ4+JOgLdAFQNquQZ5KeibU/HL5HAn27SN9vcUCFlT3f
         1S3KXozMG/ABQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4E7B8400FE; Fri, 11 Feb 2022 14:26:03 -0300 (-03)
Date:   Fri, 11 Feb 2022 14:26:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hao Luo <haoluo@google.com>, eranian@google.com
Subject: Re: [PATCH v3 07/22] perf maps: Reduce scope of init and exit
Message-ID: <YgacKyExIYBG8awX@kernel.org>
References: <20220211103415.2737789-1-irogers@google.com>
 <20220211103415.2737789-8-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211103415.2737789-8-irogers@google.com>
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

Em Fri, Feb 11, 2022 at 02:34:00AM -0800, Ian Rogers escreveu:
> Now purely accessed through new and delete, so reduce to file scope.

Seems to depend on previously dropped patch proposals.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/map.c  | 4 ++--
>  tools/perf/util/maps.h | 2 --
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index ae99b52502d5..4d1de363c19a 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -527,7 +527,7 @@ u64 map__objdump_2mem(struct map *map, u64 ip)
>  	return ip + map->reloc;
>  }
>  
> -void maps__init(struct maps *maps, struct machine *machine)
> +static void maps__init(struct maps *maps, struct machine *machine)
>  {
>  	maps->entries = RB_ROOT;
>  	init_rwsem(&maps->lock);
> @@ -616,7 +616,7 @@ static void __maps__purge(struct maps *maps)
>  	}
>  }
>  
> -void maps__exit(struct maps *maps)
> +static void maps__exit(struct maps *maps)
>  {
>  	down_write(&maps->lock);
>  	__maps__purge(maps);
> diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
> index 3dd000ddf925..7e729ff42749 100644
> --- a/tools/perf/util/maps.h
> +++ b/tools/perf/util/maps.h
> @@ -60,8 +60,6 @@ static inline struct maps *maps__get(struct maps *maps)
>  }
>  
>  void maps__put(struct maps *maps);
> -void maps__init(struct maps *maps, struct machine *machine);
> -void maps__exit(struct maps *maps);
>  int maps__clone(struct thread *thread, struct maps *parent);
>  size_t maps__fprintf(struct maps *maps, FILE *fp);
>  
> -- 
> 2.35.1.265.g69c8d7142f-goog

-- 

- Arnaldo
