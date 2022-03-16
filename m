Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C388B4DB72A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 18:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357602AbiCPRbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 13:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiCPRbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 13:31:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E48EC5B3E5;
        Wed, 16 Mar 2022 10:30:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E79A1476;
        Wed, 16 Mar 2022 10:30:04 -0700 (PDT)
Received: from [10.57.44.7] (unknown [10.57.44.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 527CE3F7D7;
        Wed, 16 Mar 2022 10:30:03 -0700 (PDT)
Message-ID: <592a32d6-b618-951c-9db9-711d022ff85e@arm.com>
Date:   Wed, 16 Mar 2022 17:30:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/1] perf test arm64: Test unwinding using fame-pointer
 (fp) mode
Content-Language: en-US
To:     German Gomez <german.gomez@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org
Cc:     mark.rutland@arm.com, namhyung@kernel.org, leo.yan@linaro.org,
        Alexandre.Truong@arm.com, Jiri Olsa <jolsa@kernel.org>
References: <20220316172015.98000-1-german.gomez@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220316172015.98000-1-german.gomez@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/03/2022 17:20, German Gomez wrote:
> Add a shell script to check that the call-graphs generated using frame
> pointers (--call-graph fp) are complete and not missing leaf functions:
> 
>   | $ perf test 88 -v
>   |  88: Check Arm64 callgraphs are complete in fp mode                  :
>   | --- start ---
>   | test child forked, pid 8734
>   |  + Compiling test program (/tmp/test_program.Cz3yL)...
>   |  + Recording (PID=8749)...
>   |  + Stopping perf-record...
>   | test_program.Cz
>   |                  728 leaf
>   |                  753 parent
>   |                  76c main
>   | test child finished with 0
>   | ---- end ----
>   | Check Arm SPE callgraphs are complete in fp mode: Ok
> 

Ran it on N1SDP and it passes, and it fails if b9f6fbb3b2c2 isn't applied.

Reviewed-by: James Clark <james.clark@arm.com>

> Fixes: b9f6fbb3b2c2 ("perf arm64: Inject missing frames when using 'perf record --call-graph=fp'")
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: German Gomez <german.gomez@arm.com>
> ---
> Changes since v1: https://lore.kernel.org/all/a6ba0ea8-f070-9f79-f018-f638ff677c7c@arm.com/
>  - Add explicit '-g' flag to GCC command
> ---
>  .../perf/tests/shell/test_arm_callgraph_fp.sh | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100755 tools/perf/tests/shell/test_arm_callgraph_fp.sh
> 
> diff --git a/tools/perf/tests/shell/test_arm_callgraph_fp.sh b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> new file mode 100755
> index 000000000..ea1b4e6bb
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> @@ -0,0 +1,68 @@
> +#!/bin/sh
> +# Check Arm64 callgraphs are complete in fp mode
> +# SPDX-License-Identifier: GPL-2.0
> +
> +lscpu | grep -q "aarch64" || exit 2
> +
> +if ! [ -x "$(command -v cc)" ]; then
> +	echo "failed: no compiler, install gcc"
> +	exit 2
> +fi
> +
> +PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +TEST_PROGRAM_SOURCE=$(mktemp /tmp/test_program.XXXXX.c)
> +TEST_PROGRAM=$(mktemp /tmp/test_program.XXXXX)
> +
> +cleanup_files()
> +{
> +	rm -f $PERF_DATA
> +	rm -f $TEST_PROGRAM_SOURCE
> +	rm -f $TEST_PROGRAM
> +}
> +
> +trap cleanup_files exit term int
> +
> +cat << EOF > $TEST_PROGRAM_SOURCE
> +int a = 0;
> +void leaf(void) {
> +  for (;;)
> +    a += a;
> +}
> +void parent(void) {
> +  leaf();
> +}
> +int main(void) {
> +  parent();
> +  return 0;
> +}
> +EOF
> +
> +echo " + Compiling test program ($TEST_PROGRAM)..."
> +
> +CFLAGS="-g -O0 -fno-inline -fno-omit-frame-pointer"
> +cc $CFLAGS $TEST_PROGRAM_SOURCE -o $TEST_PROGRAM || exit 1
> +
> +# Add a 1 second delay to skip samples that are not in the leaf() function
> +perf record -o $PERF_DATA --call-graph fp -e cycles//u -D 1000 -- $TEST_PROGRAM 2> /dev/null &
> +PID=$!
> +
> +echo " + Recording (PID=$PID)..."
> +sleep 2
> +echo " + Stopping perf-record..."
> +
> +kill $PID
> +wait $PID
> +
> +# expected perf-script output:
> +#
> +# program 
> +# 	728 leaf
> +# 	753 parent
> +# 	76c main
> +# ...
> +
> +perf script -i $PERF_DATA -F comm,ip,sym | head -n4
> +perf script -i $PERF_DATA -F comm,ip,sym | head -n4 | \
> +	awk '{ if ($2 != "") sym[i++] = $2 } END { if (sym[0] != "leaf" ||
> +						       sym[1] != "parent" ||
> +						       sym[2] != "main") exit 1 }'
