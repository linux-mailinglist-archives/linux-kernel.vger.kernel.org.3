Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7215AFBA5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 07:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiIGFTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 01:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIGFTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 01:19:40 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525406578;
        Tue,  6 Sep 2022 22:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662527978; x=1694063978;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rN2sCIy/q49w+B3VQ4o0ZIAby9RVgbPnBx7iKkBemUI=;
  b=PZJmbRRFtC50mD3L60+7TyPwdDB6b8YFMfRq186DaLSnfe2tU0/VQ5W+
   BxQSRDNz5krZlJ+1BXhcrvhRWyJRygFxKu+i0ssbY+dqNWdvWuj1iQMT8
   aaCGbMbfJ1+Dvy8v5oVjAynBhTOR3BPhnB7lo6BNAriTyhXBxUg9ZBTLT
   z9fG+1n+7AiDgL2zSMEY13UpUKimKuL9CjCfvsCPXkqnXeXRRlHGtEeiX
   2VUZdQGgqptHdYOwqtpBWYlThV25goUc6Ic4UrUL1TWTWtWAZ0ykDlPzW
   HgrL1mueRpvOtDj6ZyeZLWmUKAG19WuiAG4cxYXbbjQhFbUG4qo/fsYf+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="296782261"
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="296782261"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 22:19:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="942744229"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.113]) ([10.238.4.113])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 22:19:34 -0700
Message-ID: <78bedcf4-3ef8-2ccf-d846-74d0de0c67ad@linux.intel.com>
Date:   Wed, 7 Sep 2022 13:19:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] perf script: Skip dummy event attr check
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hongtao Yu <hoy@fb.com>, lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>
References: <20220831124041.219925-1-jolsa@kernel.org>
 <CAP-5=fX-=ph8g3VKbQXSRT8SiOZ3XqQLd3T9-ZTNZ5L+ye5L-A@mail.gmail.com>
 <Yw+LCN2cX9peweWV@kernel.org>
 <3aa4c863-24cc-9fdf-9960-2b1983b3322b@linux.intel.com>
 <CAM9d7chpoqB18r3TXPuTAA4_4TsCYq+p+j90vKspv++X1RBU+w@mail.gmail.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <CAM9d7chpoqB18r3TXPuTAA4_4TsCYq+p+j90vKspv++X1RBU+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/2022 12:50 PM, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Sep 6, 2022 at 7:49 PM Xing Zhengjun
> <zhengjun.xing@linux.intel.com> wrote:
>>
>> Hi,
>>
>> On 9/1/2022 12:23 AM, Arnaldo Carvalho de Melo wrote:
>>> Em Wed, Aug 31, 2022 at 09:02:46AM -0700, Ian Rogers escreveu:
>>>> On Wed, Aug 31, 2022 at 5:40 AM Jiri Olsa <jolsa@kernel.org> wrote:
>>>>>
>>>>> Hongtao Yu reported problem when displaying uregs in perf script
>>>>> for system wide perf.data:
>>>>>
>>>>>     # perf script -F uregs | head -10
>>>>>     Samples for 'dummy:HG' event do not have UREGS attribute set. Cannot print 'uregs' field.
>>>>>
>>>>> The problem is the extra dummy event added for system wide,
>>>>> which does not have proper sample_type setup.
>>>>>
>>>>> Skipping attr check completely for dummy event as suggested
>>>>> by Namhyung, because it does not have any samples anyway.
>>>>>
>>>>> Reported-by: Hongtao Yu <hoy@fb.com>
>>>>> Suggested-by: Namhyung Kim <namhyung@kernel.org>
>>>>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>>>>
>>>> Acked-by: Ian Rogers <irogers@google.com>
>>>
>>> Thanks, applied to perf/urgent.
>>>
>>> - Arnaldo
>>
>> I have met a similar issue on hybrid systems such as ADL, I apply the
>> patch, and it works OK for the normal mode.
>>    # ./perf record  --intr-regs=di,r8,dx,cx -e
>> br_inst_retired.near_call:p -c 1000 --per-thread true
>> [ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 0.024 MB perf.data (25 samples) ]
>>
>> # ./perf script -F iregs |head -5
>>    ABI:2    CX:0xffff90e19d024ed8    DX:0x1    DI:0xffff90e19d024ed8
>> R8:0xffffba5e437e7b30
>>    ABI:2    CX:0x7f5239783000    DX:0x80000000    DI:0xffff90e1801eea00
>>    R8:0x71
>>    ABI:2    CX:0x40    DX:0x60    DI:0xffffffff9fde5ab8    R8:0x40
>>    ABI:2    CX:0x0    DX:0xffffffffffffffff    DI:0xffff90e1877408e8
>> R8:0x1
>>    ABI:2    CX:0xcc0    DX:0x1    DI:0xffff90e187d17c60    R8:0x40
>>
>> But the issue still happened when running the test in the pipe mode. In
>> the pipe mode, it calls process_attr() which still checks the attr for
>> the dummy event, so the issue happened.
>>
>>    # ./perf record -o - --intr-regs=di,r8,dx,cx -e
>> br_inst_retired.near_call:p -c 1000 --per-thread true 2>/dev/null|./perf
>> script -F iregs |head -5
>> Samples for 'dummy:HG' event do not have IREGS attribute set. Cannot
>> print 'iregs' field.
>> 0x120 [0x90]: failed to process type: 64
>>
>> I have one test patch which can fix the pipe mode issue.
>>
>>    ./perf record -o - --intr-regs=di,r8,dx,cx -e
>> br_inst_retired.near_call:p -c 1000 --per-thread true 2>/dev/null|./perf
>> script -F iregs |head -5
>>    ABI:2    CX:0xffff90e18119e278    DX:0x0    DI:0xffff90e18119f858
>> R8:0xffff90e18119e278
>>    ABI:2    CX:0x0    DX:0x1    DI:0xfffffa2844a91580    R8:0x402
>>    ABI:2    CX:0x0    DX:0x0    DI:0x100cca    R8:0x0
>>    ABI:2    CX:0x0    DX:0x0    DI:0xffffffff9e997ca5    R8:0x0
>>    ABI:2    CX:0x113ce8000    DX:0xffff90e198f46600
>> DI:0xffff90e189de8000    R8:0x290
>>
>>
>> Fixes: b91e5492f9d7 ("perf record: Add a dummy event on hybrid systems
>> to collect metadata records")
>> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>> ---
>>    tools/perf/builtin-script.c | 2 ++
>>    1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
>> index 9152e3e45b69..2d863cdb19fe 100644
>> --- a/tools/perf/builtin-script.c
>> +++ b/tools/perf/builtin-script.c
>> @@ -2429,6 +2429,8 @@ static int process_attr(struct perf_tool *tool,
>> union perf_event *event,
>>           }
>>
>>           if (evsel->core.attr.sample_type) {
>> +               if (evsel__is_dummy_event(evsel))
>> +                       return 0;
> 
> Maybe we can move this into evsel__check_attr().
> 
> Thanks,
> Namhyung

Yes, the following changes in evsel__check_attr() can fix both normal 
and pipe mode issues, Otherwise, we have to patch everywhere when 
evsel__check_attr() is called.

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 13580a9c50b8..fb76e3191858 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -451,6 +451,9 @@ static int evsel__check_attr(struct evsel *evsel, 
struct perf_session *session)
         allow_user_set = perf_header__has_feat(&session->header,
                                                HEADER_AUXTRACE);

+       if (evsel__is_dummy_event(evsel))
+               allow_user_set = true;
+
         if (PRINT_FIELD(TRACE) &&
             !perf_session__has_traces(session, "record -R"))
                 return -EINVAL;
--
2.25.1

> 
> 
>>                   err = evsel__check_attr(evsel, scr->session);
>>                   if (err)
>>                           return err;
>> --
>> 2.25.1
>>
>> --
>> Zhengjun Xing

-- 
Zhengjun Xing
