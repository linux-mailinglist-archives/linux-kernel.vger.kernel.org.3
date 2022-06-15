Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A930D54D127
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 20:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357500AbiFOSt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 14:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358156AbiFOStT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 14:49:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805834B1E6;
        Wed, 15 Jun 2022 11:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655318953; x=1686854953;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wn5NiHZZ5IcNI7uGKQLVRm318DxREBFo5acevQoydbM=;
  b=ixNy89eZGoR5fjmsx1BbP5GPtIyDN/+pCZmdgplP15p8bfDqYQ4mX7DM
   WoFEUKypxvpFW4+WDnRep4+TTUihPpiIyml7w5mKjtyqHwx42XpnLf5OI
   PU/DWKoBmddjo992XMYPR/Zq/bhmujUC9zSAzGCfDZB19zxReI1TqrFQk
   Byn4VozmaaNtC0BPWU2dq69NfMgAWgaIIkP8CkQVKOlDY+9EjHL64fMhf
   KeB7uwOUnP2KUOqd91fN80IgWzuyTUjoEwvv8NSg5+FdmL3Iw8LQCfqZC
   MSQEdhtaCtz9QX48ho977Ymht9owQqj0tzvtbJP18MRLh1cLKH95u7nik
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="365424895"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="365424895"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 11:33:12 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="612868968"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.51.207]) ([10.209.51.207])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 11:33:10 -0700
Message-ID: <11db049c-c288-71c2-de37-545fd695d486@linux.intel.com>
Date:   Wed, 15 Jun 2022 11:33:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] perf io: Make open and read calls more robust
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Song Liu <songliubraving@fb.com>, Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Kan Liang <kan.liang@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        German Gomez <german.gomez@arm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Denis Nikitin <denik@chromium.org>,
        Lexi Shao <shaolexi@huawei.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
References: <20220615060354.1763693-1-irogers@google.com>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <20220615060354.1763693-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/14/2022 11:03 PM, Ian Rogers wrote:
> Wrap open and read calls with TEMP_FAILURE_RETRY in case a signal
> causes the syscall to need to restart.


Why not just use SA_RESTART on the signals?


-Andi

