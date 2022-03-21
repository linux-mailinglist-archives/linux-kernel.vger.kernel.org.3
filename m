Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AA04E2F3E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349926AbiCURmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345896AbiCURmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:42:04 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2453650E3C;
        Mon, 21 Mar 2022 10:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647884439; x=1679420439;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=88Sb97FF2mT4zGdmyNozW0OvxQ2rZhAh4hxyWWz9lcw=;
  b=UbcRsaKCfmnWZLyXe+LInQR4Ke16PNJwtMR8+aZHIvZWeg5TY0Vuw28T
   T3t55acTLIgX4+1HTbEWfAtNiIHa+SsEZJh4HKkWIXgk+92gC8pSop/07
   SxMkiUfFDiV7eD8CgiP6XwDkA4vy5iSMbqlk16R509GMIy6Pt9PuLj2kO
   HEw0YkwCgC98yajv9p+aguhfYYI6r9EXnknGFYWIHijnql8a9LQyWPLAA
   VCrhw1g6QT/kf4dDj8YXtm8kNr/pBeIsi3zqmPJ4jayx2gVSh0fP56Qe6
   ICREUSYOAUCvW+BKEFXF1O2z3/tY/YyfwMZUfeMNuHiIJDQo3DZyrwCpG
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="344041806"
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="344041806"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 10:40:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="582943620"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by orsmga001.jf.intel.com with ESMTP; 21 Mar 2022 10:40:34 -0700
Message-ID: <ff7ac17b-06ba-cf56-dca2-94c4ccca5df8@intel.com>
Date:   Mon, 21 Mar 2022 19:40:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH] perf intel-pt: Synthesize cycle events
Content-Language: en-US
To:     "Steinar H. Gunderson" <sesse@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <YjBnet2813sEGjZY@google.com>
 <c50bb87d-9fee-c4f9-a350-8729e503e43a@intel.com>
 <YjDUO6bbyfGw/u0C@google.com>
 <52903e58-e74c-5ea0-36b4-277ea3610af4@intel.com>
 <YjGdoGy4Z2UUG9S9@google.com>
 <ef780335-7dc6-3a23-54a8-b6fc9c8a2ed3@intel.com>
 <YjHfGrZovk3N/H0f@google.com>
 <371faf0d-f794-4a2e-0a1c-9d454d7c8b12@intel.com>
 <YjhUjotmo+kYvoNP@google.com>
 <ffa56520-09b5-9c5d-7733-6767d2f8e350@intel.com>
 <YjiuoEUL6jH32cBi@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <YjiuoEUL6jH32cBi@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2022 18:58, Steinar H. Gunderson wrote:
> On Mon, Mar 21, 2022 at 03:09:08PM +0200, Adrian Hunter wrote:
>> Yes, it can cross calls and returns.  'returns' due to "Return Compression"
>> which can be switched off at record time with config term noretcomp, but
>> that may cause more overflows / trace data loss.
>>
>> To get accurate times for a single function there is Intel PT
>> address filtering.
>>
>> Otherwise LBRs can have cycle times.
> 
> Many interesting points, I'll be sure to look into them.
> 
> Meanwhile, should I send a new patch with your latest changes?

Yes please.
