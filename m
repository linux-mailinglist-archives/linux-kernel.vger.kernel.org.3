Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E6552661F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382046AbiEMP3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382012AbiEMP3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:29:13 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03C76A009;
        Fri, 13 May 2022 08:29:10 -0700 (PDT)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L0C9V3WMHz6H6vZ;
        Fri, 13 May 2022 23:24:14 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 17:29:07 +0200
Received: from [10.47.25.226] (10.47.25.226) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 13 May
 2022 16:29:06 +0100
Message-ID: <6341384c-b3e6-fbe5-f29f-e0db114bd439@huawei.com>
Date:   Fri, 13 May 2022 16:29:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/7] perf test: Skip reason for suites with 1 test
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        "Sohaib Mohamed" <sohaib.amhmd@gmail.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Marco Elver <elver@google.com>,
        Michael Petlan <mpetlan@redhat.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Stephane Eranian <eranian@google.com>
References: <20220513040519.1499333-1-irogers@google.com>
 <20220513040519.1499333-2-irogers@google.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220513040519.1499333-2-irogers@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.25.226]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2022 05:05, Ian Rogers wrote:
> When a suite has just 1 subtest, the subtest number is given as -1 to
> avoid indented printing. When this subtest number is seen for the skip
> reason, use the reason of the first test.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/tests/builtin-test.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index fac3717d9ba1..33fcafa0fa79 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -137,10 +137,10 @@ static bool has_subtests(const struct test_suite *t)
>   
>   static const char *skip_reason(const struct test_suite *t, int subtest)
>   {
> -	if (t->test_cases && subtest >= 0)
> -		return t->test_cases[subtest].skip_reason;
> +	if (!t->test_cases)
> +		return NULL;
>   
> -	return NULL;
> +	return t->test_cases[subtest >= 0 ? subtest : 0].skip_reason;
>   }

I was not sure which suite has a single tastcase, so I experimented for 
libpfm4 by deleting a testcase so it has only 1x remaining, I get:

before your change:
john@localhost:~/acme/tools/perf> sudo ./perf test 63
63: Test libpfm4 support : Skip

after:

john@localhost:~/acme/tools/perf> sudo ./perf test 63
63: Test libpfm4 support : Skip (not compiled in)

Although it is odd to have a single sub-test, is there a reason for 
which we don't print its name? We print the name when there are multiple 
sub-tests.

Thanks,
John
