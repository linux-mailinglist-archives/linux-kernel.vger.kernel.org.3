Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7AD583AFF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 11:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbiG1JJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 05:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbiG1JJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 05:09:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9FD6655A6;
        Thu, 28 Jul 2022 02:09:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26A01106F;
        Thu, 28 Jul 2022 02:09:53 -0700 (PDT)
Received: from [10.57.43.118] (unknown [10.57.43.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34EDC3F73B;
        Thu, 28 Jul 2022 02:09:51 -0700 (PDT)
Message-ID: <3adff726-c3a1-e1db-0506-a3c2b742c9ea@arm.com>
Date:   Thu, 28 Jul 2022 10:09:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] perf/tests: Fix test case 95 on s390 and use same event
Content-Language: en-US
To:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, german.gomez@arm.com
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
References: <20220727141439.712582-1-tmricht@linux.ibm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220727141439.712582-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/07/2022 15:14, Thomas Richter wrote:
> On linux-next tree perf test 95 was added recently.
> s390 does not support branch sampling at all and the test case fails
> despite for checking branch support before hand.
> The check for support of branching
> uses the software event named dummy, as seen in the line:
> 
>  perf record -b -o- -e dummy -B true > /dev/null 2>&1 || exit 2
> 
> However when the branch recording is actually done, a different
> event is used, as seen in the line:
> 
>  perf record -o $TMPDIR/... --branch-filter any,save_type,u -- ...
> 
> The event is omitted and for perf record the default event is
> cycles, which is not supported by s390 and this fails when executed
> on s390:
> 
>  # perf record --branch-filter any,save_type,u -- \
> 	/tmp/__perf_test.program.iDSmQ/a.out
>  Error:
>  cycles: PMU Hardware or event type doesn't support branch stack sampling.
>  #
> 
> Therefore fix this and use the same event cycles for testing support
> and actually running the test.
> 
> Output before:
>  # ./perf test -Fv 95
>  95: Check branch stack sampling                                     :
>  --- start ---
>  Testing user branch stack sampling
>  ---- end ----
>  Check branch stack sampling: FAILED!
>  #
> 
> Output after:
>  # ./perf test -Fv 95
>  95: Check branch stack sampling                                     :
>  --- start ---
>  ---- end ----
>  Check branch stack sampling: Skip
>  #
> 
> Fixes: b55878c90ab9 ("perf test: Add test for branch stack sampling")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Looks good to me.

Reviewed-by: James Clark <james.clark@arm.com>

> ---
>  tools/perf/tests/shell/test_brstack.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
> index 113ccd17bf03..c644f94a6500 100755
> --- a/tools/perf/tests/shell/test_brstack.sh
> +++ b/tools/perf/tests/shell/test_brstack.sh
> @@ -12,7 +12,7 @@ if ! [ -x "$(command -v cc)" ]; then
>  fi
>  
>  # skip the test if the hardware doesn't support branch stack sampling
> -perf record -b -o- -e dummy -B true > /dev/null 2>&1 || exit 2
> +perf record -b -o- -B true > /dev/null 2>&1 || exit 2
>  
>  TMPDIR=$(mktemp -d /tmp/__perf_test.program.XXXXX)
>  
