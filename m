Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D77A4DAECA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 12:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355292AbiCPLVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 07:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348129AbiCPLVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 07:21:09 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2F33BF84;
        Wed, 16 Mar 2022 04:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647429595; x=1678965595;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WOZPX280h/gDeG6eQLXb35wKGPqTHaoiFvqKuqkEwNg=;
  b=IlYui+VZshSHfhBilyE1Fa5IfIXrFlPbWcYR9NVc+bO1aLJvHUDfGzNz
   Qv6Ze3Ej9jrNZy/GRKpzOSYO2z35WcfJcxviXeIsoTDXkdeqr9oD91dg2
   wx5ViquMl16akcuEUmaouItpssNIXQn2uIo+mti2VxLzxgi1Dpn7ZWd+0
   YUj9YHRnl/dWfNEJuQM7V55SUdIGpPGWRnmrI2B03+3xjiwVHPiVEBxAC
   oKdYum+p/ByteXCsET9QXTkcAeYlOP+MTq8wOxKu4cYSVoyDh6s7yKbEG
   AydpU2AUdAVvTX+iRT1lRt5/h08CJ/CeEJVPvcWAgbXGpdZRsv6iv5zwA
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="255383241"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="255383241"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 04:19:55 -0700
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="557392932"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.28])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 04:19:52 -0700
Message-ID: <ef780335-7dc6-3a23-54a8-b6fc9c8a2ed3@intel.com>
Date:   Wed, 16 Mar 2022 13:19:46 +0200
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
References: <20220310093844.982656-1-sesse@google.com>
 <586de5fc-858b-2693-1986-5c77e8c0e3d0@intel.com>
 <YiuKAk7SaXP7B7Ee@google.com>
 <ba2c49da-22c5-06ea-e953-82211b953ca8@intel.com>
 <YjBnet2813sEGjZY@google.com>
 <c50bb87d-9fee-c4f9-a350-8729e503e43a@intel.com>
 <YjDUO6bbyfGw/u0C@google.com>
 <52903e58-e74c-5ea0-36b4-277ea3610af4@intel.com>
 <YjGdoGy4Z2UUG9S9@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <YjGdoGy4Z2UUG9S9@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.3.2022 10.19, Steinar H. Gunderson wrote:
> On Tue, Mar 15, 2022 at 10:11:54PM +0200, Adrian Hunter wrote:
>> Sorry, my first suggestion has issues, but the second is better.
> 
> I tried your second one, but can't see much difference. The original and
> your patched version still differ by a lot, and I still see various
> non-branch instructions getting very tiny fractions. (PSB packets
> _might_ be it, as there are ~1000 of them in the 165M-cycle trace.)
> 
> I guess the good news is that the perf report coming out of your version
> looks more likely to me; I have some functions that are around 1% that
> shouldn't intuitively be that much (and, if I write some Perl to sum up
> the cycles from the IPC lines in perf script, are more around 0.1%).
> So perhaps we should stop chasing the difference? I don't know.

That doesn't sound right.  I will look at it more closely in the next few days.
