Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B4E533B99
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 13:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237291AbiEYLSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 07:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbiEYLSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 07:18:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ABF8D68D;
        Wed, 25 May 2022 04:18:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA20AB81D1A;
        Wed, 25 May 2022 11:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E68DC385B8;
        Wed, 25 May 2022 11:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653477510;
        bh=E5w2vhKQSCx5ztZzyuTMrII+sygSNLQwZIazhSkRbhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ITQjqkOi0ZCA9cAIL7viyzr+t29FWxtxihwVpsiFbgcuqnOLBxXkgRssP/csbER0u
         LEEWmRUTMg8ki5Q8iCIBM3d7Efmn5jTHlroYbOrmie1TiTmvJgpHPEWql3Ky51f1nd
         dhFlMqnZ677vW4Ikr37huJU9I9gLnWijafbVqxD4L7jyTQh7iBigpmTK9TBfuCag8p
         t0BtB/q2WEa+LD5qB2xJuKUPM+NMljSN0TfLp0pyVJOu/OFSpc0ksyHvLxVmDJK20F
         PsbskY1d3VQENcB3UT/uxiO/EhuTi1X3CTUmP8w89Dme3tNGE8Qg1TR9BIdYys386l
         mP8HcoO4p+NyA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5CF544007E; Wed, 25 May 2022 08:18:27 -0300 (-03)
Date:   Wed, 25 May 2022 08:18:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Claire Jensen <cjense@google.com>, Alyssa Ross <hi@alyssa.is>,
        Like Xu <likexu@tencent.com>,
        James Clark <james.clark@arm.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Claire Jensen <clairej735@gmail.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v4 0/3] JSON output for perf stat
Message-ID: <Yo4QgwigIfBX4jlJ@kernel.org>
References: <20220525053814.3265216-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220525053814.3265216-1-irogers@google.com>
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

Em Tue, May 24, 2022 at 10:38:11PM -0700, Ian Rogers escreveu:
> Parsing the CSV or text output of perf stat can be problematic when
> new output is added (columns in CSV format). JSON names values and
> simplifies the job of parsing. Add a JSON output option to perf-stat
> then add unit test that parses and validates the output.
> 
> This is a resend of two v2 patches:
> https://lore.kernel.org/lkml/20210813220754.2104922-1-cjense@google.com/
> https://lore.kernel.org/lkml/20210813220936.2105426-1-cjense@google.com/
> with a few formatting changes and improvements to the linter.
> 
> The CSV test/linter is also added to ensure that CSV output doesn't regress:
> https://lore.kernel.org/lkml/20210813192108.2087512-1-cjense@google.com/

So, the JSON test is failing:

⬢[acme@toolbox perf]$ perf test -v JSON
Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
 90: perf stat JSON output linter                                    :
--- start ---
test child forked, pid 2626229
Checking json output: no args [Success]
Checking json output: system wide [Skip] parnoia and not root
Checking json output: system wide [Skip] parnoia and not root
Checking json output: interval Test failed for input:
{"interval" : 0.000506453, "counter-value" : "0.212360", "unit" : "msec", "event" : "task-clock:u", "event-runtime" : 212360, "pcnt-running" : 100.00, "metric-value" : 0.000212, "metric-unit" : "CPUs utilized"}

{"interval" : 0.000506453, "counter-value" : "0.000000", "unit" : "", "event" : "context-switches:u", "event-runtime" : 212360, "pcnt-running" : 100.00, "metric-value" : 0.000000, "metric-unit" : "/sec"}

{"interval" : 0.000506453, "counter-value" : "0.000000", "unit" : "", "event" : "cpu-migrations:u", "event-runtime" : 212360, "pcnt-running" : 100.00, "metric-value" : 0.000000, "metric-unit" : "/sec"}

{"interval" : 0.000506453, "counter-value" : "45.000000", "unit" : "", "event" : "page-faults:u", "event-runtime" : 212360, "pcnt-running" : 100.00, "metric-value" : 211.904313, "metric-unit" : "K/sec"}

{"interval" : 0.000506453, "counter-value" : "143761.000000", "unit" : "", "event" : "cycles:u", "event-runtime" : 217290, "pcnt-running" : 100.00, "metric-value" : 0.676968, "metric-unit" : "GHz"}

{"interval" : 0.000506453, "counter-value" : "456.000000", "unit" : "", "event" : "stalled-cycles-frontend:u", "event-runtime" : 217290, "pcnt-running" : 100.00, "metric-value" : 0.317193, "metric-unit" : "frontend cycles idle"}

{"interval" : 0.000506453, "counter-value" : "11639.000000", "unit" : "", "event" : "stalled-cycles-backend:u", "event-runtime" : 217290, "pcnt-running" : 100.00, "metric-value" : 8.096076, "metric-unit" : "backend cycles idle"}

{"interval" : 0.000506453, "counter-value" : "150684.000000", "unit" : "", "event" : "instructions:u", "event-runtime" : 217290, "pcnt-running" : 100.00, "metric-value" : 1.048156, "metric-unit" : "insn per cycle"}

{"interval" : 0.000506453, "metric-value" : 0.077241, "metric-unit" : "stalled cycles per insn"}

{"interval" : 0.000506453, "counter-value" : "29735.000000", "unit" : "", "event" : "branches:u", "event-runtime" : 217290, "pcnt-running" : 100.00, "metric-value" : 140.021661, "metric-unit" : "M/sec"}

{"interval" : 0.000506453, "counter-value" : "<not counted>", "unit" : "", "event" : "branch-misses:u", "event-runtime" : 0, "pcnt-running" : 0.00, "metric-value" : 0.000000, "metric-unit" : ""}

Traceback (most recent call last):
  File "/var/home/acme/git/perf/./tools/perf/tests/shell/lib/perf_json_output_lint.py", line 91, in <module>
    check_json_output(expected_items)
  File "/var/home/acme/git/perf/./tools/perf/tests/shell/lib/perf_json_output_lint.py", line 52, in check_json_output
    raise RuntimeError(f'wrong number of fields. counted {count} expected {expected_items}'
RuntimeError: wrong number of fields. counted 2 expected 7 in '{"interval" : 0.000506453, "metric-value" : 0.077241, "metric-unit" : "stalled cycles per insn"}
'
test child finished with -1
---- end ----
perf stat JSON output linter: FAILED!
⬢[acme@toolbox perf]$

So please check this and resubmit.

My system is a fedora 35 silverblue toolbox.

⬢[acme@toolbox perf]$ rpm -q python3
python3-3.10.4-1.fc35.x86_64

- Arnaldo
