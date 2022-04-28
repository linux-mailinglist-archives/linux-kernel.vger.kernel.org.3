Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0636A51357F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbiD1Nq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347571AbiD1Nqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:46:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AA51B3DCC;
        Thu, 28 Apr 2022 06:43:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B51541477;
        Thu, 28 Apr 2022 06:43:39 -0700 (PDT)
Received: from [10.1.30.157] (e127744.cambridge.arm.com [10.1.30.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD4CE3F5A1;
        Thu, 28 Apr 2022 06:43:37 -0700 (PDT)
Subject: Re: [PATCH] perf test: Fix test case 81 on s390x
To:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, irogers@google.com
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
References: <20220428122821.3652015-1-tmricht@linux.ibm.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <768de4e7-7bf1-62b5-4446-28420c3a82d5@arm.com>
Date:   Thu, 28 Apr 2022 14:43:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220428122821.3652015-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28/04/2022 13:28, Thomas Richter wrote:
> perf test -F 81 -v fails on s390x on the linux-next branch.
> The test case is x86 specific can not be executed on s390x.
> The test case depends on x86 register names such as
>
>   ... | egrep -q 'available registers: AX BX CX DX ....'
>
> Skip this test case on s390x.
>
> Output before:
>  # perf test -F 81
>  81: perf record tests                       : FAILED!
>  #
>
> Output after:
>  # perf test -F 81
>  81: perf record tests                       : Skip
>  #
>
> Fixes: 24f378e66021 ("perf test: Add basic perf record tests")
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/tests/shell/record.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index cd1cf14259b8..d98f4d4a00e1 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -37,6 +37,8 @@ test_register_capture() {
>    echo "Register capture test [Success]"
>  }
>  
> +# Test for platform support and return TEST_SKIP
> +[ $(uname -m) = s390x ] && exit 2
>  test_per_thread

The "test_per_thread" might still be valid though, right?

In my case, the register test skips gracefully (arm64).

$ ./perf test 82 -v
 82: perf record tests                                               :
--- start ---
test child forked, pid 54345
Basic --per-thread mode test
Basic --per-thread mode test [Success]
Register capture test
Register capture test [Skipped missing instruction]
test child finished with 0
---- end ----
perf record tests: Ok

>  test_register_capture
>  exit $err
