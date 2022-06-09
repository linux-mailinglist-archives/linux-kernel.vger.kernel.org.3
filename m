Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AA0544341
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237689AbiFIFlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbiFIFl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:41:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C64122C4B4;
        Wed,  8 Jun 2022 22:41:26 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2594oaiK007264;
        Thu, 9 Jun 2022 05:41:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=3XyrJDIW7xwf9xYilnC3Tb9J1PzuaF7CkFAc0hilI9I=;
 b=bTp4wzZcY9R/RnVuOnwvujb6H3GpNS8FVn6sPluciYM7Zela1MwRUthoZNKLDIfgMiIS
 61VdKaLtECCoZoeH3oBzPCUIM+2ObiXgRNpnN4YXSVIJ6FTuFQoN+jXGNrLm0GYBmRFr
 LQhMA0kLqL21SPKyHzyoCWePAGAP/VpLD9CNBHd9ahvQLd6HTk1GdeT9ySNyIhkYwO8n
 9linVWLDG5cwZ4EeX3nB6XQDpj1Ax56PIQvZ+QL9kZtObduSHf7g4CGsmofC+H4LtaDM
 cAO4/1Y1tZ59v/GJU3GqyrpFLbDYcNTWjjRBu/bwgdVxoHPvGqiG/1tjrL1k/LBkczHU qA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gka6nrsj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jun 2022 05:41:10 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2595dU4p005982;
        Thu, 9 Jun 2022 05:41:10 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gka6nrsh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jun 2022 05:41:10 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2595LjuM004761;
        Thu, 9 Jun 2022 05:41:07 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 3gfy1952pj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jun 2022 05:41:07 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2595f5LJ13894116
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Jun 2022 05:41:05 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F765A404D;
        Thu,  9 Jun 2022 05:41:05 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E10B5A4040;
        Thu,  9 Jun 2022 05:40:58 +0000 (GMT)
Received: from [9.43.103.181] (unknown [9.43.103.181])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Jun 2022 05:40:57 +0000 (GMT)
Message-ID: <b0b27e2a-c335-f300-c56e-94e831d65973@linux.ibm.com>
Date:   Thu, 9 Jun 2022 11:10:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 4/4] perf test: Add user space counter reading tests
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Cc:     Stephane Eranian <eranian@google.com>
References: <20220609052355.1300162-1-irogers@google.com>
 <20220609052355.1300162-5-irogers@google.com>
From:   kajoljain <kjain@linux.ibm.com>
In-Reply-To: <20220609052355.1300162-5-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AsIRKX1tbVE8EcUUVp2tT2_5vBqOhZFb
X-Proofpoint-GUID: 06NK7WrnA36pEFQmc80CwWpBB8nDZPvh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-08_05,2022-06-07_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206090020
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch looks fine to me.

Reviewed-By: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain

On 6/9/22 10:53, Ian Rogers wrote:
> These tests are based on test_stat_user_read in
> tools/lib/perf/tests/test-evsel.c. The tests are modified to skip if
> perf_event_open fails or rdpmc isn't supported.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/mmap-basic.c | 127 +++++++++++++++++++++++++++++++++-
>  1 file changed, 126 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
> index 30bbe144648a..dfb6173b2a82 100644
> --- a/tools/perf/tests/mmap-basic.c
> +++ b/tools/perf/tests/mmap-basic.c
> @@ -170,14 +170,139 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
>  	return err;
>  }
>  
> +static int test_stat_user_read(int event)
> +{
> +	struct perf_counts_values counts = { .val = 0 };
> +	struct perf_thread_map *threads;
> +	struct perf_evsel *evsel;
> +	struct perf_event_mmap_page *pc;
> +	struct perf_event_attr attr = {
> +		.type	= PERF_TYPE_HARDWARE,
> +		.config	= event,
> +#ifdef __aarch64__
> +		.config1 = 0x2,		/* Request user access */
> +#endif
> +	};
> +	int err, i, ret = TEST_FAIL;
> +	bool opened = false, mapped = false;
> +
> +	threads = perf_thread_map__new_dummy();
> +	TEST_ASSERT_VAL("failed to create threads", threads);
> +
> +	perf_thread_map__set_pid(threads, 0, 0);
> +
> +	evsel = perf_evsel__new(&attr);
> +	TEST_ASSERT_VAL("failed to create evsel", evsel);
> +
> +	err = perf_evsel__open(evsel, NULL, threads);
> +	if (err) {
> +		pr_err("failed to open evsel: %s\n", strerror(-err));
> +		ret = TEST_SKIP;
> +		goto out;
> +	}
> +	opened = true;
> +
> +	err = perf_evsel__mmap(evsel, 0);
> +	if (err) {
> +		pr_err("failed to mmap evsel: %s\n", strerror(-err));
> +		goto out;
> +	}
> +	mapped = true;
> +
> +	pc = perf_evsel__mmap_base(evsel, 0, 0);
> +	if (!pc) {
> +		pr_err("failed to get mmapped address\n");
> +		goto out;
> +	}
> +
> +	if (!pc->cap_user_rdpmc || !pc->index) {
> +		pr_err("userspace counter access not %s\n",
> +			!pc->cap_user_rdpmc ? "supported" : "enabled");
> +		ret = TEST_SKIP;
> +		goto out;
> +	}
> +	if (pc->pmc_width < 32) {
> +		pr_err("userspace counter width not set (%d)\n", pc->pmc_width);
> +		goto out;
> +	}
> +
> +	perf_evsel__read(evsel, 0, 0, &counts);
> +	if (counts.val == 0) {
> +		pr_err("failed to read value for evsel\n");
> +		goto out;
> +	}
> +
> +	for (i = 0; i < 5; i++) {
> +		volatile int count = 0x10000 << i;
> +		__u64 start, end, last = 0;
> +
> +		pr_debug("\tloop = %u, ", count);
> +
> +		perf_evsel__read(evsel, 0, 0, &counts);
> +		start = counts.val;
> +
> +		while (count--) ;
> +
> +		perf_evsel__read(evsel, 0, 0, &counts);
> +		end = counts.val;
> +
> +		if ((end - start) < last) {
> +			pr_err("invalid counter data: end=%llu start=%llu last= %llu\n",
> +				end, start, last);
> +			goto out;
> +		}
> +		last = end - start;
> +		pr_debug("count = %llu\n", end - start);
> +	}
> +	ret = TEST_OK;
> +
> +out:
> +	if (mapped)
> +		perf_evsel__munmap(evsel);
> +	if (opened)
> +		perf_evsel__close(evsel);
> +	perf_evsel__delete(evsel);
> +
> +	perf_thread_map__put(threads);
> +	return ret;
> +}
> +
> +static int test__mmap_user_read_instr(struct test_suite *test __maybe_unused,
> +				      int subtest __maybe_unused)
> +{
> +	return test_stat_user_read(PERF_COUNT_HW_INSTRUCTIONS);
> +}
> +
> +static int test__mmap_user_read_cycles(struct test_suite *test __maybe_unused,
> +				       int subtest __maybe_unused)
> +{
> +	return test_stat_user_read(PERF_COUNT_HW_CPU_CYCLES);
> +}
> +
>  static struct test_case tests__basic_mmap[] = {
>  	TEST_CASE_REASON("Read samples using the mmap interface",
>  			 basic_mmap,
>  			 "permissions"),
> +	TEST_CASE_REASON("User space counter reading of instructions",
> +			 mmap_user_read_instr,
> +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
> +			 "permissions"
> +#else
> +			 "unsupported"
> +#endif
> +		),
> +	TEST_CASE_REASON("User space counter reading of cycles",
> +			 mmap_user_read_cycles,
> +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
> +			 "permissions"
> +#else
> +			 "unsupported"
> +#endif
> +		),
>  	{	.name = NULL, }
>  };
>  
>  struct test_suite suite__basic_mmap = {
> -	.desc = "Read samples using the mmap interface",
> +	.desc = "mmap interface tests",
>  	.test_cases = tests__basic_mmap,
>  };
