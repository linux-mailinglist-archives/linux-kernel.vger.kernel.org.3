Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB6A58E048
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbiHITh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239078AbiHIThl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:37:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4836B248DB;
        Tue,  9 Aug 2022 12:37:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3F83B8188F;
        Tue,  9 Aug 2022 19:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522BEC433D6;
        Tue,  9 Aug 2022 19:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660073857;
        bh=UlHNdfjvJwrgfY/HF8VYrLwVoLslBIlbGovh3PnUzec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h0+qf+RTT6pmAEGKM22b+Fks0g0MY8EV/fSn50yGF0OyK62g3ei+l3jbllzOs0Mu3
         Y6aVcr+BRAtlMIs9RUKzTnyBm8xLpM3juhFBTnm33njvegcbRi88yhybioKd8FIy7W
         imPceEfIwkbuM+67e8ajwUZ2ZnTqwgKhIf+cApjIgiyLwmGMQHxX4JZgtsMQ4Kxmbm
         Y37wLm75aDeO9blRj9ZlOW/21ICqY0tbkO65Q/7tuIyo3ude4fobGUMF9uHbbWEgRV
         1c/vh9sa3Xji+XDF9ioOJIvS5a1RxJAQ2aJYIOgeb0kXqyB2MhcxDdZB5MhOACnqKa
         rk6g+0scHVL5w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C6BC94035A; Tue,  9 Aug 2022 16:37:34 -0300 (-03)
Date:   Tue, 9 Aug 2022 16:37:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v4 02/17] perf jevents: Simplify generation of C-string
Message-ID: <YvK3fjexLddUJeYR@kernel.org>
References: <20220804221816.1802790-1-irogers@google.com>
 <20220804221816.1802790-3-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804221816.1802790-3-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 04, 2022 at 03:18:01PM -0700, Ian Rogers escreveu:
> Previous implementation wanted variable order and '(null)' string output
> to match the C implementation. The '(null)' string output was a
> quirk/bug and so there is no need to carry it forward.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/jevents.py | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index 5b72048d50da..cdfa4e0e7557 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -203,7 +203,7 @@ class JsonEvent:
>      """Representation of the event as a C struct initializer."""
>  
>      def attr_string(attr: str, value: str) -> str:
> -      return '\t.%s = \"%s\",\n' % (attr, value)
> +      return f'\t.{attr} = \"{value}\",\n'
>  
>      def str_if_present(self, attr: str) -> str:
>        if not getattr(self, attr):
> @@ -211,17 +211,11 @@ class JsonEvent:
>        return attr_string(attr, getattr(self, attr))
>  
>      s = '{\n'
> -    for attr in ['name', 'event']:
> -      s += str_if_present(self, attr)
> -    if self.desc is not None:
> -      s += attr_string('desc', self.desc)
> -    else:
> -      s += attr_string('desc', '(null)')
> -    s += str_if_present(self, 'compat')
>      s += f'\t.topic = "{topic_local}",\n'
>      for attr in [
> -        'long_desc', 'pmu', 'unit', 'perpkg', 'aggr_mode', 'metric_expr',
> -        'metric_name', 'metric_group', 'deprecated', 'metric_constraint'
> +        'aggr_mode', 'compat', 'deprecated', 'desc', 'event', 'long_desc',
> +        'metric_constraint', 'metric_expr', 'metric_group', 'metric_name',
> +        'name', 'perpkg', 'pmu', 'unit'
>      ]:
>        s += str_if_present(self, attr)
>      s += '},\n'
> -- 
> 2.37.1.559.g78731f0fdb-goog

-- 

- Arnaldo
