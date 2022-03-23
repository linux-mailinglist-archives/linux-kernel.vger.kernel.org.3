Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581E94E4DAC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 08:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242372AbiCWH7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 03:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242360AbiCWH7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:59:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9570C2DCC;
        Wed, 23 Mar 2022 00:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648022289; x=1679558289;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rPUKJWuNJoHsledVN2xoxSUAZH+6NB+vRcBiCSP/bdY=;
  b=Yz+xCDULEh+ZULk1rea+pIQh5EvPNnbqbZuowsXKpa9CEk7pTolgTXDv
   KrcRJWv8N9lqV9LisUkAN6+nutR/UukgQSSYMMCMc7GbLM3eLT0iTmUMS
   OHOhSxQnrlG7SJBoN7fCSNs76jtUaTFMRjwnp9dg0fS1Lu+P2OS/55ln1
   /dyJe+lOC4OG8x7hSTa4khBL+OOedairViW8jNhHtFzzqalKrogh7wCA2
   gryoz0+XA2e+ULgPOpUoHRIUXUdvIEURPQ43twg3Cqq2vut231ddEKBoZ
   /++IY2NP6G125AClzW3J4aEcElN46ops2NOXGdZXh2gTJefUfdXr94MkQ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="237991306"
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="237991306"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 00:58:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="583596605"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by orsmga001.jf.intel.com with ESMTP; 23 Mar 2022 00:58:03 -0700
Message-ID: <52d31321-66e1-f189-2ffc-7c93239eea74@intel.com>
Date:   Wed, 23 Mar 2022 09:58:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v3] perf intel-pt: Synthesize cycle events
Content-Language: en-US
To:     "Steinar H. Gunderson" <sesse@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220322082452.1429091-1-sesse@google.com>
 <YjpAYjdgHWwkid5N@kernel.org> <YjpFcLiCTjHZWzzA@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <YjpFcLiCTjHZWzzA@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2022 23:53, Steinar H. Gunderson wrote:
> On Tue, Mar 22, 2022 at 06:32:18PM -0300, Arnaldo Carvalho de Melo wrote:
>> I saw there was some issue, should I proceed and apply this v3 patch or
>> wait for some v4?
> 
> There are two issues in play:
> 
>  1. PT event synth doesn't support reading inline information from DWARF
>     yet, and my patch to add it runs into some problems. This is not
>     relevant for this patch at all.
>  2. The results from v3 don't quite match the ones from v1, and neither
>     of us are entirely sure why. My personal feeling is that the one
>     from v1 are the wrong ones, but it's up to Adrian to say whether we
>     want to try to investigate deeply here.

V3 is good.  Please take that.
