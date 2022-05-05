Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590F051C67A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382895AbiEERsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382959AbiEERsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:48:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37CA3DDEF;
        Thu,  5 May 2022 10:44:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C17B61EF3;
        Thu,  5 May 2022 17:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A9DC385A4;
        Thu,  5 May 2022 17:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651772683;
        bh=Teb3Q304BRPr9GHaFHkSX1FTTJZAg7bcpJ2gS2O1gUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fyZnxm6EmNhd5VkUQQOadMjjpQ3ZBsdNhvPIKRNH4I5RMAV8E9Y1HXwvdEGjpIlqh
         4GVvJuLTsrIJzQAMFNH3w+IfFdmWXZ1az03YUcBOqfhX24h05OMFWpH1v+qJui1jA3
         ylJzkoL959AO0ibK/zq7NkKOqM1qNwTk8Rq1uXyguOFfnMNDmuCmjMPH0GIB51jZOP
         yuSXZxVa0NYmIOEK8b2XuftHhl0CCUiXgOVl6zlqxtm/SaSy/c7tgiuUUdU7z/qwji
         IpWT3/L2clXQVeV5K/Kq85QY/PbfG1wW8NRbt/KWCDBDJUaKh3GhIWE0uKK6h4sYBk
         1aLgQvUMCafdg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 08FED400B1; Thu,  5 May 2022 14:44:40 -0300 (-03)
Date:   Thu, 5 May 2022 14:44:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, svens@linux.ibm.com,
        gor@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com
Subject: Re: [PATCH v2] perf test: Add skip to --per-thread test
Message-ID: <YnQNCN2qbCBvkyqr@kernel.org>
References: <20220503043400.2374052-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503043400.2374052-1-irogers@google.com>
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

Em Mon, May 02, 2022 at 09:34:00PM -0700, Ian Rogers escreveu:
> As reported in:
> https://lore.kernel.org/linux-perf-users/20220428122821.3652015-1-tmricht@linux.ibm.com/
> the 'instructions:u' event may not be supported. Add a skip using 'perf
> record'.
> 
> Switch some code away from pipe to make the failures clearer.

Can you please resubmit this on top of my perf/core branch? I had
already applied Thomas fix and published perf/core publicly, so I rather
not rebase at this point.

Basically get your current tools/perf/tests/shell/record.sh file, with
this fix, copy it, clone my perf/core branch, copy
tools/perf/tests/shell/record.sh there and commit, then please resubmit
:-)

- Arnaldo
 
> Reported-by: Thomas Richter <tmricht@linux.ibm.com>
> Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/record.sh | 44 +++++++++++++++++++++++++++++---
>  1 file changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index cd1cf14259b8..00c7285ce1ac 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -5,11 +5,43 @@
>  set -e
>  
>  err=0
> +perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +
> +cleanup() {
> +  rm -f ${perfdata}
> +  rm -f ${perfdata}.old
> +  trap - exit term int
> +}
> +
> +trap_cleanup() {
> +  cleanup
> +  exit 1
> +}
> +trap trap_cleanup exit term int
> +
>  test_per_thread() {
>    echo "Basic --per-thread mode test"
> -  perf record -e instructions:u --per-thread -o- true 2> /dev/null \
> -    | perf report -i- -q \
> -    | egrep -q true
> +  if ! perf record -e instructions:u -o ${perfdata} --quiet true 2> /dev/null
> +  then
> +    echo "Per-thread record [Skipped instructions:u not supported]"
> +    if [ $err -ne 1 ]
> +    then
> +      err=2
> +    fi
> +    return
> +  fi
> +  if ! perf record -e instructions:u --per-thread -o ${perfdata} true 2> /dev/null
> +  then
> +    echo "Per-thread record of instructions:u [Failed]"
> +    err=1
> +    return
> +  fi
> +  if ! perf report -i ${perfdata} -q | egrep -q true
> +  then
> +    echo "Per-thread record [Failed missing output]"
> +    err=1
> +    return
> +  fi
>    echo "Basic --per-thread mode test [Success]"
>  }
>  
> @@ -18,6 +50,10 @@ test_register_capture() {
>    if ! perf list | egrep -q 'br_inst_retired.near_call'
>    then
>      echo "Register capture test [Skipped missing instruction]"
> +    if [ $err -ne 1 ]
> +    then
> +      err=2
> +    fi
>      return
>    fi
>    if ! perf record --intr-regs=\? 2>&1 | egrep -q 'available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10 R11 R12 R13 R14 R15'
> @@ -39,4 +75,6 @@ test_register_capture() {
>  
>  test_per_thread
>  test_register_capture
> +
> +cleanup
>  exit $err
> -- 
> 2.36.0.464.gb9c8b46e94-goog

-- 

- Arnaldo
