Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D081D5B085F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiIGPVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiIGPVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:21:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF97A57277;
        Wed,  7 Sep 2022 08:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662564074; x=1694100074;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rRsBBK5P+iWsCOv0vz51IyAFsHGDuEDPtf7MYkuqaMM=;
  b=EtyF/qDMFqEw4+2xLkJW6T5n6WT3noFzX93AGFnrfKMXmzmf3c44Ecr0
   0iJICR2UpS0zM+aFZub1zuflkPG8R7g+uEnbPaYMw3cczh3l2tjc33JwK
   q3WQvvYlbEukCJZMCfn26kW/SjZZRCezAykIXgymdElJXsVX1ZrrSQeCE
   YRmMn39Bocd+I1ZQEx8AKBhSm+CwofS+GHxU9bGPCVImugKzbxF84iYAE
   deu4phSv6tlTpn9Voc3c7zsi8e/p3qEfyF0R6BEzsFbhIjPkIoRa/xEvh
   HIT4Z6CtXYf9tTVqF2t4OgTQDdSUA2AnKiRQUmkYmDfI5nWHKPwNCe/rm
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="283902717"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="283902717"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 08:20:34 -0700
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="676229783"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.58.27])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 08:20:31 -0700
Message-ID: <b72e2b9f-b7b6-5f93-69bc-2e98636f32ba@intel.com>
Date:   Wed, 7 Sep 2022 18:20:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 4/6] perf test: Add system-wide mode in perf record tests
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
 <20220907064645.1197894-5-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220907064645.1197894-5-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/09/22 09:46, Namhyung Kim wrote:
> Add system wide recording test with the same pattern.  It'd skip the
> test when it failes to run perf record.  For system-wide mode, it needs
> to avoid build-id collection and synthesis because the test only cares
> about the test program and kernel would generates necessary events as
> the process starts.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/tests/shell/record.sh | 34 ++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 3331fb092654..bd4ef60948bd 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -134,10 +134,44 @@ test_register_capture() {
>    echo "Register capture test [Success]"
>  }
>  
> +test_system_wide() {
> +  echo "Basic --system-wide mode test"
> +  if ! perf record -aB --synth=no ${testopt} -o ${perfdata} ${testprog} 2> /dev/null
> +  then
> +    echo "System-wide record [Skipped not supported]"
> +    if [ $err -ne 1 ]
> +    then
> +      err=2
> +    fi
> +    return
> +  fi
> +  if ! perf report -i ${perfdata} -q | egrep -q ${testsym}
> +  then
> +    echo "System-wide record [Failed missing output]"
> +    err=1
> +    return
> +  fi
> +  if ! perf record -aB --synth=no -e cpu-clock,cs --threads=cpu ${testopt} \
> +    -o ${perfdata} ${testprog} 2> /dev/null
> +  then
> +    echo "System-wide test [Failed recording with threads]"
> +    err=1
> +    return
> +  fi
> +  if ! perf report -i ${perfdata} -q | egrep -q ${testsym}
> +  then
> +    echo "System-wide record [Failed missing output]"
> +    err=1
> +    return
> +  fi
> +  echo "Basic --system-wide mode test [Success]"
> +}
> +
>  build_test_program
>  
>  test_per_thread
>  test_register_capture
> +test_system_wide
>  
>  cleanup
>  exit $err

