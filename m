Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E45E500CD3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243034AbiDNMNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243137AbiDNMNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:13:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CF81E3E6;
        Thu, 14 Apr 2022 05:10:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA05661EF9;
        Thu, 14 Apr 2022 12:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13984C385A1;
        Thu, 14 Apr 2022 12:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649938238;
        bh=sCjbfo7MFncMSD/5mqtlVwuMMmB2dTxvAkK69ISsNRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D3Q91ABAtVwfRmcASmfk+OlKbKDwHpJhJUGV4HApUBvnhaMQW/WsdMIr2DoQIxLJR
         qz6lPUN8TFYwZtfy+HDZwpK205S+M+F/jx6tQaVMdmnfQE1vMa+TpR6R/w0DuEfxpi
         FvjgSVixnl1JFOe+NEPWG4CErAvVRXtmTBmK0SG9ZC89WpDxMijZ6qE1+BXyYNzQuX
         IcfzJFQ5iECCKfuhDeYlkD787qNaD0dgAV/6Z8Qs0b0f+fvzjqSus4Wm/nXQ3pi5t2
         XKVxqyflBYy9ed3isTT4YDc4ktt+JywBLzZ1iU8/1GcU5JGQzSLvRPEKYeciTDWu14
         kmTP5pwz1pZxg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B15F140407; Thu, 14 Apr 2022 09:10:35 -0300 (-03)
Date:   Thu, 14 Apr 2022 09:10:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Alexey Bayduraev <alexey.bayduraev@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 3/3] perf test: Add basic perf record tests
Message-ID: <YlgPOz24mPm4NBuj@kernel.org>
References: <20220414014642.3308206-1-irogers@google.com>
 <20220414014642.3308206-3-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414014642.3308206-3-irogers@google.com>
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

Em Wed, Apr 13, 2022 at 06:46:42PM -0700, Ian Rogers escreveu:
> Test the --per-thread flag.
> Test Intel machine state capturing.

Thanks, applied to perf/core.

- Arnaldo

 
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/record.sh | 42 ++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100755 tools/perf/tests/shell/record.sh
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> new file mode 100755
> index 000000000000..cd1cf14259b8
> --- /dev/null
> +++ b/tools/perf/tests/shell/record.sh
> @@ -0,0 +1,42 @@
> +#!/bin/sh
> +# perf record tests
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +err=0
> +test_per_thread() {
> +  echo "Basic --per-thread mode test"
> +  perf record -e instructions:u --per-thread -o- true 2> /dev/null \
> +    | perf report -i- -q \
> +    | egrep -q true
> +  echo "Basic --per-thread mode test [Success]"
> +}
> +
> +test_register_capture() {
> +  echo "Register capture test"
> +  if ! perf list | egrep -q 'br_inst_retired.near_call'
> +  then
> +    echo "Register capture test [Skipped missing instruction]"
> +    return
> +  fi
> +  if ! perf record --intr-regs=\? 2>&1 | egrep -q 'available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10 R11 R12 R13 R14 R15'
> +  then
> +    echo "Register capture test [Skipped missing registers]"
> +    return
> +  fi
> +  if ! perf record -o - --intr-regs=di,r8,dx,cx -e cpu/br_inst_retired.near_call/p \
> +    -c 1000 --per-thread true 2> /dev/null \
> +    | perf script -F ip,sym,iregs -i - 2> /dev/null \
> +    | egrep -q "DI:"
> +  then
> +    echo "Register capture test [Failed missing output]"
> +    err=1
> +    return
> +  fi
> +  echo "Register capture test [Success]"
> +}
> +
> +test_per_thread
> +test_register_capture
> +exit $err
> -- 
> 2.36.0.rc0.470.gd361397f0d-goog

-- 

- Arnaldo
