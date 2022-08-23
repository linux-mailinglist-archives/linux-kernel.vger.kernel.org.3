Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B8959E985
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiHWRct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237624AbiHWRbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:31:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A4C106F9C;
        Tue, 23 Aug 2022 08:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661267468; x=1692803468;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jjiwMuWeqdFPYRf2a09O9x3igdhPit5rsRrfCbx9zoY=;
  b=fmTXMMC13lK4LLM7CAZCddwLfpuL9AI9HWCFC7aPpU1NkBfM1fiwHUxj
   ulAVl5wbwvaDnNtQ3stSSSFLPQqpjz4X5LvVyu0woE5MUSqmJdg5UnaJq
   PWzPINHpd/KaCIkeGXMlMcgLoy+KpvU4zkJYa7NLisycE3YuhkGDth2+/
   rZBHAnpSAqfnfqocprfLm6imwsGh9gVECNR8BKcI78dh/+mIG7BMaO8Qy
   vFKhRUE63aJs6jY/XHISNRdA8frzefXPXZWn2LFMxFzYztt7F9fSbt+NL
   6vepOtys5A6/EA9rRPxjrvJdG/ZHxfTfWWtIbBlhMPKSASpa38zq1HUx7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="294502943"
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="294502943"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 08:10:56 -0700
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="586027125"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.239.19]) ([10.212.239.19])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 08:10:55 -0700
Message-ID: <dc07fcb8-9a7c-7f74-375f-99ce192c4f39@linux.intel.com>
Date:   Tue, 23 Aug 2022 17:10:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1 1/2] perf stat: Clear reset_group for each stat run
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
References: <20220822213352.75721-1-irogers@google.com>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <20220822213352.75721-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/22/2022 11:33 PM, Ian Rogers wrote:
> If a weak group is broken then the reset_group flag remains set for
> the next run. Having reset_group set means the counter isn't created
> and ultimately a segfault.
>
> A simple reproduction of this is:
> perf stat -r2 -e '{cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles}:W
> which will be added as a test in the next patch.
>
> Fixes: 4804e0111662 ("perf stat: Use affinity for opening events")
> Signed-off-by: Ian Rogers <irogers@google.com>


Makes sense


Reviewed-by: Andi Kleen <ak@linux.intel.com>


