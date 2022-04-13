Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06C64FFC3D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 19:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237244AbiDMRTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 13:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbiDMRTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:19:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 395126A076;
        Wed, 13 Apr 2022 10:17:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6C5D1576;
        Wed, 13 Apr 2022 10:17:28 -0700 (PDT)
Received: from [10.1.33.136] (e127744.cambridge.arm.com [10.1.33.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26DA13F73B;
        Wed, 13 Apr 2022 10:17:24 -0700 (PDT)
From:   German Gomez <german.gomez@arm.com>
Subject: Re: [PATCH] perf arm-spe: Test memory samples
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220413010221.81332-1-leo.yan@linaro.org>
Message-ID: <21978774-356b-bc08-ba68-80d877e2b6b4@arm.com>
Date:   Wed, 13 Apr 2022 18:17:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220413010221.81332-1-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/04/2022 02:02, Leo Yan wrote:
> Add a new test to verify the Arm SPE synthesized memory samples with
> 'perf mem report' command.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Reviewed-by: German Gomez <german.gomez@arm.com>

Thanks for the patch.

There are some tests for perf_event_attr fields. We added one for SPE
recently [1], but it's not checking the sample_type attribute yet.

We could update it from our side and send another patch, to test the
DATA_SRC bit is not missing.

[1] https://lore.kernel.org/all/20220126160710.32983-1-german.gomez@arm.com/

Thanks,
German

> ---
>  tools/perf/tests/shell/test_arm_spe.sh | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/test_arm_spe.sh b/tools/perf/tests/shell/test_arm_spe.sh
> index e59044edc406..b36125e127eb 100755
> --- a/tools/perf/tests/shell/test_arm_spe.sh
> +++ b/tools/perf/tests/shell/test_arm_spe.sh
> @@ -62,6 +62,18 @@ perf_report_samples() {
>  		egrep " +[0-9]+\.[0-9]+% +[0-9]+\.[0-9]+% +$1 " > /dev/null 2>&1
>  }
>  
> +perf_mem_report_samples() {
> +	echo "Looking at perf.data file for reporting memory samples:"
> +
> +	# Below is an example of the memory samples reporting:
> +	#   20.71%    1696    27    L1 hit     [k] el0t_64_sync_handler    [kernel.kallsyms]    ...
> +	#   17.21%    1903    20    L1 hit     [k] el0t_64_sync            [kernel.kallsyms]    ...
> +	#    8.52%     897    21    L1 hit     [k] ksys_read               [kernel.kallsyms]    ...
> +	#    0.12%      16    17    L1 hit     [.] 0x0000000000004ce8      dd                   ...
> +	perf mem report --stdio -i ${perfdata} 2>&1 | \
> +		egrep " +[0-9]+\.[0-9]+% +[0-9]+ +[0-9]+ .* +$1 " > /dev/null 2>&1
> +}
> +
>  arm_spe_snapshot_test() {
>  	echo "Recording trace with snapshot mode $perfdata"
>  	perf record -o ${perfdata} -e arm_spe// -S \
> @@ -79,7 +91,8 @@ arm_spe_snapshot_test() {
>  	wait $PERFPID
>  
>  	perf_script_samples dd &&
> -	perf_report_samples dd
> +	perf_report_samples dd &&
> +	perf_mem_report_samples dd
>  
>  	err=$?
>  	arm_spe_report "SPE snapshot testing" $err
