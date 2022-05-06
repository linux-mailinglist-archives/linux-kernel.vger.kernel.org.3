Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0551451DEF3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 20:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385504AbiEFSTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 14:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbiEFSTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 14:19:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B084A4D9FE;
        Fri,  6 May 2022 11:15:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D03B1B83882;
        Fri,  6 May 2022 18:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52452C385A8;
        Fri,  6 May 2022 18:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651860947;
        bh=HZhuEiXqbxhd9fR3VaMws+c8YgJggiG/REZXjlbhj18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SbmKMuE4NMYBwSFmCjQO0fmQYNuHL4sHqBwee1oxEcLsDZ/hLL8UAq2s3MUOr5Z8w
         y565I0qstxIOWuzcW428eNk1WunYU+neAu+5eCwcn0oKMEZZo6lVrQddWyqoYal8Hg
         umu5w8HFMKhvDtlMucA3qqav0ZNVhO9KWViRPaUreU4K9ZfQOu5H+/2IGJmUw5D1qs
         p9mdDlhuBa3He8mklEiSWFIP0VCuEyRo2MVwKKNdgpWYzsYm/w0tO/Jr/mUW/rQfrU
         LctRvFwD3/xgvQ/l5sF5TU4e/ORTOmmDLQE5Uup1xLrrvqGemKRykhaJYPGtxuKPLo
         9OOjWq+J5IJRg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8796F400B1; Fri,  6 May 2022 15:15:44 -0300 (-03)
Date:   Fri, 6 May 2022 15:15:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, svens@linux.ibm.com,
        gor@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com
Subject: Re: [PATCH v3] perf test: Add skip to --per-thread test
Message-ID: <YnVl0PxKboCxuke4@kernel.org>
References: <20220505182505.3313191-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505182505.3313191-1-irogers@google.com>
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

Em Thu, May 05, 2022 at 11:25:05AM -0700, Ian Rogers escreveu:
> As reported in:
> https://lore.kernel.org/linux-perf-users/20220428122821.3652015-1-tmricht@linux.ibm.com/
> the 'instructions:u' event may not be supported. Add a skip using 'perf
> record'.
> 
> Switch some code away from pipe to make the failures clearer.

Thanks, applied.

- Arnaldo

 
> Reported-by: Thomas Richter <tmricht@linux.ibm.com>
> Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/record.sh | 46 ++++++++++++++++++++++++++++----
>  1 file changed, 41 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index d98f4d4a00e1..00c7285ce1ac 100755
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
> @@ -37,8 +73,8 @@ test_register_capture() {
>    echo "Register capture test [Success]"
>  }
>  
> -# Test for platform support and return TEST_SKIP
> -[ $(uname -m) = s390x ] && exit 2
>  test_per_thread
>  test_register_capture
> +
> +cleanup
>  exit $err
> -- 
> 2.36.0.512.ge40c2bad7a-goog

-- 

- Arnaldo
