Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B4E54DEBD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 12:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376434AbiFPKM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 06:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbiFPKMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 06:12:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D8E7C34;
        Thu, 16 Jun 2022 03:12:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACCB012FC;
        Thu, 16 Jun 2022 03:12:45 -0700 (PDT)
Received: from [10.1.28.141] (e127744.cambridge.arm.com [10.1.28.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF76B3F792;
        Thu, 16 Jun 2022 03:12:42 -0700 (PDT)
Subject: Re: [PATCH] perf test: Add ARM SPE system wide test
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
References: <20220615190735.1298213-1-namhyung@kernel.org>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <9242ecfa-36ab-c425-999c-fad44056223b@arm.com>
Date:   Thu, 16 Jun 2022 11:12:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220615190735.1298213-1-namhyung@kernel.org>
Content-Type: multipart/mixed;
 boundary="------------BAAAD7BE465EE9EDF2F47BC3"
Content-Language: en-US
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------BAAAD7BE465EE9EDF2F47BC3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Thanks for the patch, Namhyung

On 15/06/2022 20:07, Namhyung Kim wrote:
> In the past it had a problem not setting the pid/tid on the sample
> correctly when system-wide mode is used.  Although it's fixed now it'd
> be nice if we have a test case for it.
>
> Cc: German Gomez <german.gomez@arm.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/shell/test_arm_spe.sh | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/tools/perf/tests/shell/test_arm_spe.sh b/tools/perf/tests/shell/test_arm_spe.sh
> index e59044edc406..b9c588ae393b 100755
> --- a/tools/perf/tests/shell/test_arm_spe.sh
> +++ b/tools/perf/tests/shell/test_arm_spe.sh
> @@ -23,6 +23,7 @@ glb_err=0
>  cleanup_files()
>  {
>  	rm -f ${perfdata}
> +	rm -f ${perfdata}.old
>  	exit $glb_err
>  }
>  
> @@ -85,5 +86,19 @@ arm_spe_snapshot_test() {
>  	arm_spe_report "SPE snapshot testing" $err
>  }
>  
> +arm_spe_system_wide_test() {
> +	echo "Recording trace with system-wide mode $perfdata"
> +	perf record -o ${perfdata} -e arm_spe// -a \
> +		-- dd if=/dev/zero of=/dev/null count=100000 > /dev/null 2>&1
> +

Should we skip if we don't have privileges for CPU tracing? (attached diff)

German

> +	perf_script_samples dd &&
> +	perf_report_samples dd
> +
> +	err=$?
> +	arm_spe_report "SPE system-wide testing" $err
> +}
> +
>  arm_spe_snapshot_test
> +arm_spe_system_wide_test
> +
>  exit $glb_err

--------------BAAAD7BE465EE9EDF2F47BC3
Content-Type: text/plain; charset=UTF-8;
 name="diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff"

ZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdGVzdHMvc2hlbGwvdGVzdF9hcm1fc3BlLnNoIGIv
dG9vbHMvcGVyZi90ZXN0cy9zaGVsbC90ZXN0X2FybV9zcGUuc2gKaW5kZXggYjljNTg4YWUz
Li45NjI4NDFhNTEgMTAwNzU1Ci0tLSBhL3Rvb2xzL3BlcmYvdGVzdHMvc2hlbGwvdGVzdF9h
cm1fc3BlLnNoCisrKyBiL3Rvb2xzL3BlcmYvdGVzdHMvc2hlbGwvdGVzdF9hcm1fc3BlLnNo
CkBAIC0zMCwxMSArMzAsMTMgQEAgY2xlYW51cF9maWxlcygpCiB0cmFwIGNsZWFudXBfZmls
ZXMgZXhpdCB0ZXJtIGludAogCiBhcm1fc3BlX3JlcG9ydCgpIHsKLQlpZiBbICQyICE9IDAg
XTsgdGhlbgorCWlmIFsgJDIgPSAwIF07IHRoZW4KKwkJZWNobyAiJDE6IFBBU1MiCisJZWxp
ZiBbICQyID0gMiBdOyB0aGVuCisJCWVjaG8gIiQxOiBTS0lQUEVEIgorCWVsc2UKIAkJZWNo
byAiJDE6IEZBSUwiCiAJCWdsYl9lcnI9JDIKLQllbHNlCi0JCWVjaG8gIiQxOiBQQVNTIgog
CWZpCiB9CiAKQEAgLTkxLDYgKzkzLDExIEBAIGFybV9zcGVfc3lzdGVtX3dpZGVfdGVzdCgp
IHsKIAlwZXJmIHJlY29yZCAtbyAke3BlcmZkYXRhfSAtZSBhcm1fc3BlLy8gLWEgXAogCQkt
LSBkZCBpZj0vZGV2L3plcm8gb2Y9L2Rldi9udWxsIGNvdW50PTEwMDAwMCA+IC9kZXYvbnVs
bCAyPiYxCiAKKwlpZiBbICQ/ICE9IDAgXTsgdGhlbgorCQlhcm1fc3BlX3JlcG9ydCAiU1BF
IHN5c3RlbS13aWRlIHRlc3RpbmciIDIKKwkJcmV0dXJuCisJZmkKKwogCXBlcmZfc2NyaXB0
X3NhbXBsZXMgZGQgJiYKIAlwZXJmX3JlcG9ydF9zYW1wbGVzIGRkCiAK
--------------BAAAD7BE465EE9EDF2F47BC3--
