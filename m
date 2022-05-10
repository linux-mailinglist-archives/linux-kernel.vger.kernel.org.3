Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D347452224B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347929AbiEJRZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347937AbiEJRZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:25:18 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FEB47555
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652203280; x=1683739280;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=08SY71Ng4G0N/rI2hS7Vun0kGMOGwN2roqdqEDegvnE=;
  b=FBBT3FQsiTv0uCACu5tqI4iNagU6i5C7xS/bTVBn0fWo2an5ePP7M72x
   o9TI89KheymuFYFpkwyNj5kr5bice4TGRAfSaxjTfNxorZmROOCS6I+Lk
   WAefj3D2XRpFmIJxROZHHG0NHADexDzD9N8kxYT9YAZpUULXQ4YXzJMyB
   oaMiYQ0hHSXvmmMj3XZGzHVr/WXZHUReVnjLVFRFqSlVtKHKy8xAwGcs/
   Er+W8KUClK1EsnczGKETs9PsQVvD3H9Bf5yH/ALxw9MFTZ8C+WZqQ4IaW
   rxxfysWYluKAojY0eFz05Be9+thjJKGnCN3rmCdaNNt8hYbfKtPXlERSK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="268286920"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="268286920"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 10:21:19 -0700
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="593633218"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.3])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 10:21:17 -0700
Message-ID: <aba8a38f-3d91-b925-dc26-61a48597089c@intel.com>
Date:   Tue, 10 May 2022 20:21:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH V2 01/23] perf intel-pt: Add a test for system-wide side
 band
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
References: <20220506122601.367589-1-adrian.hunter@intel.com>
 <20220506122601.367589-2-adrian.hunter@intel.com>
 <YnqedF9WI//2oXw2@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <YnqedF9WI//2oXw2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/22 20:18, Arnaldo Carvalho de Melo wrote:
> Em Fri, May 06, 2022 at 03:25:39PM +0300, Adrian Hunter escreveu:
>> Add a test for system-wide side band even when tracing selected CPUs.
>>
>> Tested-by: Ian Rogers <irogers@google.com>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> 
> [root@quaco ~]# uname -a
> Linux quaco 5.16.13-200.fc35.x86_64 #1 SMP PREEMPT Tue Mar 8 22:50:58 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
> [root@quaco ~]# grep -m1 -i "model name" /proc/cpuinfo 
> model name	: Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz
> [root@quaco ~]# perf test -v Misc
>  97: Miscellaneous Intel PT testing                                  :
> --- start ---
> test child forked, pid 769475
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 1.352 MB /tmp/tmp.Ty4Rqnz4vz ]
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 1.352 MB /tmp/tmp.Ty4Rqnz4vz ]
> Linux
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 1.446 MB /tmp/tmp.TnEqenwzZv ]
> Failed to record MMAP events on CPU 1 when tracing CPU 0
> test child finished with -1
> ---- end ----
> Miscellaneous Intel PT testing: FAILED!
> [root@quaco ~]# 
> 
> Do I need some more recent machine or kernel?

I put it only in the cover letter sorry but "The first patch is a small Intel PT test for system-wide side band.  The
test fails before the patches are applied, passed afterwards."
