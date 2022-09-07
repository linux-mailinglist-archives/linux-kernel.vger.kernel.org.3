Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535F35B0207
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 12:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiIGKpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 06:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiIGKpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 06:45:06 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB9D40565;
        Wed,  7 Sep 2022 03:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662547504; x=1694083504;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CS9G31DSFuHg1NRAtruzjLC9/pg4sb0QXPWD8EfCHi8=;
  b=KT34o6p0wy5vr5GtnofHvxzkXI3x62+PqAgbyRJOnkiU8+h61T3Vh3FT
   gw35a/VFxfPz7r9FpF1eGCoCu6hgvoRCDQTrzNZkwOKZnS+GUt71Z0F76
   NDFsaujx8jbHsHqhqTeihCkkLrriDu7S/E4VwsLLvQ034BbYQELs3t1mA
   g4mLiiiZ0H5vagT7tMLFQ0H7egDGSghEQoPekwJBTh3dj7FJONexn9r+b
   Mwyg0lezyUUeFJhpziI0nrYwaKLnq4ZmuW2rwa2R4xA2KES9IqfV2QYrG
   KNKA/zQ/BA6GsOXP7+RdxeAt/K7VfjRrPtC4jWYnScW/5Dt6tdz4Oto8c
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="294423502"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="294423502"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 03:45:04 -0700
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="676130417"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.58.27])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 03:45:01 -0700
Message-ID: <eea20a5c-df2a-979b-ff85-a7e2b978a4b8@intel.com>
Date:   Wed, 7 Sep 2022 13:44:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 2/6] perf test: Use a test program in perf record tests
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
References: <20220907064645.1197894-1-namhyung@kernel.org>
 <20220907064645.1197894-3-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220907064645.1197894-3-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/09/22 09:46, Namhyung Kim wrote:
> If the system has cc it could build a test program with two threads
> and then use it for more detailed testing.  Also it adds initial delay
> of 3ms to profile a multi-threaded target.  This change make the test
> failing but that's what we want to check for now.

So the delay is just to get a separate dummy event?

I hit the issue from this patch:

https://lore.kernel.org/lkml/20220711180706.3418612-1-kan.liang@linux.intel.com/

That is, if I apply the patch above then the test passes, otherwise it fails always.

> 
> If cc is not found, it falls back to use the default value 'true'.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/shell/record.sh | 58 +++++++++++++++++++++++++++++---
>  1 file changed, 54 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 40b087bfdb76..cea3c7b7e2cd 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -6,10 +6,18 @@ set -e
>  
>  err=0
>  perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +testprog=$(mktemp /tmp/__perf_test.prog.XXXXXX)
> +testsym="test_loop"
> +testopt="-D 3"
>  
>  cleanup() {
>    rm -f ${perfdata}
>    rm -f ${perfdata}.old
> +
> +  if [ "${testprog}" != "true" ]; then
> +    rm -f ${testprog}
> +  fi
> +
>    trap - exit term int
>  }
>  
> @@ -19,9 +27,49 @@ trap_cleanup() {
>  }
>  trap trap_cleanup exit term int
>  
> +build_test_program() {
> +  if ! [ -x "$(command -v cc)" ]; then
> +    # No CC found. Fall back to 'true'
> +    testprog=true
> +    testsym=true
> +    testopt=''
> +    return
> +  fi
> +
> +  echo "Build a test program"
> +  cat <<EOF | cc -o ${testprog} -xc - -pthread
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <pthread.h>
> +
> +void test_loop(void) {
> +  volatile int count = 1000000;
> +
> +  // wait for perf record
> +  usleep(5000);
> +
> +  while (count--)
> +    continue;
> +}
> +
> +void *thfunc(void *arg) {
> +  test_loop();
> +  return NULL;
> +}
> +
> +int main(void) {
> +  pthread_t th;
> +  pthread_create(&th, NULL, thfunc, NULL);
> +  test_loop();
> +  pthread_join(th, NULL);
> +  return 0;
> +}
> +EOF
> +}
> +
>  test_per_thread() {
>    echo "Basic --per-thread mode test"
> -  if ! perf record -o /dev/null --quiet true 2> /dev/null
> +  if ! perf record -o /dev/null --quiet ${testprog} 2> /dev/null
>    then
>      echo "Per-thread record [Skipped event not supported]"
>      if [ $err -ne 1 ]
> @@ -30,13 +78,13 @@ test_per_thread() {
>      fi
>      return
>    fi
> -  if ! perf record --per-thread -o ${perfdata} true 2> /dev/null
> +  if ! perf record --per-thread ${testopt} -o ${perfdata} ${testprog} 2> /dev/null
>    then
>      echo "Per-thread record [Failed record]"
>      err=1
>      return
>    fi
> -  if ! perf report -i ${perfdata} -q | egrep -q true
> +  if ! perf report -i ${perfdata} -q | egrep -q ${testsym}
>    then
>      echo "Per-thread record [Failed missing output]"
>      err=1
> @@ -62,7 +110,7 @@ test_register_capture() {
>      return
>    fi
>    if ! perf record -o - --intr-regs=di,r8,dx,cx -e cpu/br_inst_retired.near_call/p \
> -    -c 1000 --per-thread true 2> /dev/null \
> +    -c 1000 --per-thread ${testopt} ${testprog} 2> /dev/null \
>      | perf script -F ip,sym,iregs -i - 2> /dev/null \
>      | egrep -q "DI:"
>    then
> @@ -73,6 +121,8 @@ test_register_capture() {
>    echo "Register capture test [Success]"
>  }
>  
> +build_test_program
> +
>  test_per_thread
>  test_register_capture
>  

