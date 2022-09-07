Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F485B0530
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiIGNdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiIGNdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:33:52 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE227CB50;
        Wed,  7 Sep 2022 06:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662557631; x=1694093631;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+rS8UGUXd9neU7r0L9drWbeOWqJUfXtu3UQQDtb2UE0=;
  b=fXK1+jO687gUgZRDOlhLVhsywkZ0chjSNRTVQj7oza3MD4e4zIbsbH6X
   k2vJEADLQRBS61Rq31biKrVXSLDeROHouSiRoskloi5iEmk41o+usnB9P
   X7d1PazyKCxAQG6X0V4ZwzsZ1XWTgfqLE8DqLtqAjaT58gFPobftmj0KU
   p/tB1dkz6rujQ8YO1g9gn55tXS+WGVJ+JPpVkXVculNDMy1U6EQr5fxif
   AJhWCFS2F6M2mftFNbpp6nYOoIIKdZI6X5UIvHuorHVTbXednTyN/9xXr
   5AKECuxJyh4ooxvE8Rf5O5P769UiPyK6rUoGx0+zM0DbCGmZGDllAr7Fw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="298186686"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="298186686"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 06:33:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="676186251"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.58.27])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 06:33:48 -0700
Message-ID: <2546f051-95be-1d8d-133c-2dac639b317d@intel.com>
Date:   Wed, 7 Sep 2022 16:33:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 3/6] perf test: Test record with --threads option
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
 <20220907064645.1197894-4-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220907064645.1197894-4-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/09/22 09:46, Namhyung Kim wrote:
> To verify per-thread mode is working with multi-thread recording.
> Use two software events for testing to check event set-output handling.
> Also update the cleanup routine because threads recording produces data
> in a directory.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/shell/record.sh | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index cea3c7b7e2cd..3331fb092654 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -11,8 +11,8 @@ testsym="test_loop"
>  testopt="-D 3"
>  
>  cleanup() {
> -  rm -f ${perfdata}
> -  rm -f ${perfdata}.old
> +  rm -rf ${perfdata}
> +  rm -rf ${perfdata}.old
>  
>    if [ "${testprog}" != "true" ]; then
>      rm -f ${testprog}
> @@ -90,6 +90,19 @@ test_per_thread() {
>      err=1
>      return
>    fi
> +  if ! perf record -e cpu-clock,cs --per-thread --threads=core ${testopt} \
> +    -o ${perfdata} ${testprog} 2> /dev/null

This does not seem to be possible, because it gives the error:

--per-thread option is mutually exclusive to parallel streaming mode.
Failed to initialize parallel data streaming masks 

> +  then
> +    echo "Per-thread record with --threads [Failed]"
> +    err=1
> +    return
> +  fi
> +  if ! perf report -i ${perfdata} -q | egrep -q ${testsym}
> +  then
> +    echo "Per-thread record with --threads [Failed missing output]"
> +    err=1
> +    return
> +  fi
>    echo "Basic --per-thread mode test [Success]"
>  }
>  

