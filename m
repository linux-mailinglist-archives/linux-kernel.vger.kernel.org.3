Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF974F0E2F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 06:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377127AbiDDEoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 00:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbiDDEoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 00:44:01 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154F2329AA;
        Sun,  3 Apr 2022 21:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649047326; x=1680583326;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2SWGyekWbm1WpT9pdBiZkc9bxDcv2hhKwhV12QIkak0=;
  b=FfCePAS4GgE19J8eXjNppsRlQOfW75Vm1rabb6gaRzrkY5vk0tJTXwrY
   8jLsfzN7BQ1/RX4NA+2q5SWHCCSqwlsf/NSd0ei0IxkfjJM0YHTsq6gY6
   jJaU15s2g7f1wMDbhbCYFj2Y5urL57vHCDoRXmHv0lrxK6P6E26P+UV7a
   Bx5XvSWiERJMZsjlOI0FWvv86zVM2dqPYlKL7tDdB3pgLgeeUzxqaUm6Z
   wjvxs+prBcAIYMkI6NFOmmPObEGntn3o9deimyejnG1v1qXtHxmKw2B5S
   7XOphqTRgMP9ua37JKHbfdVtNWotz6hlCur1T9jDXhVcHihe9JqhR2jhb
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="258018007"
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="258018007"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 21:42:05 -0700
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="569228322"
Received: from ysandami-mobl2.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.39.83])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 21:42:01 -0700
Message-ID: <9914dba4-7ff0-b6a3-cf6e-bdc426bc594c@intel.com>
Date:   Mon, 4 Apr 2022 07:41:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH] perf test tsc: Fix error message report when not
 supported.
Content-Language: en-US
To:     Chengdong Li <brytonlee01@gmail.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     ak@linux.intel.com, likexu@tencent.com, chengdongli@tencent.com
References: <20220402114218.14131-1-chengdongli@tencent.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220402114218.14131-1-chengdongli@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2022 14.42, Chengdong Li wrote:
> By default `perf test tsc` does not return the error message
> when child process detected kernel does not support. Instead, child
> process print error message to stderr, unfortunately the stderr is
> redirected to /dev/null when verbose <= 0.
> This patch add a helper function test__perf_test_tsc_skip_reason() to
> help parent process to get the appropriate error message and force child
> process returns TEST_SKIP instead of TEST_OK.
> 
> Signed-off-by: Chengdong Li <chengdongli@tencent.com>
> ---
>  tools/perf/tests/builtin-test.c     |  3 +++
>  tools/perf/tests/perf-time-to-tsc.c | 17 +++++++++++------
>  tools/perf/tests/tests.h            |  1 +
>  3 files changed, 15 insertions(+), 6 deletions(-)
> 

Please base on current source, for example perf/core branch of:

	git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
