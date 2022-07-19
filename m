Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE9E5797D7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbiGSKqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiGSKqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:46:06 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0D5637B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 03:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658227563; x=1689763563;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wFZZuEAnMChHcl1zG98D2Cn/4RFaJhpOx2El5z8ssBU=;
  b=SxAMH7U4q/b9tlumgFSfpHRCi7A7CE0iHUOKaXiE+uYTIz53NbSsmiK/
   6hCCg6m3naQyAj2l+Mg71Z2Ik53G8pwXO/nWzP5kBMmQnUP2mNICkHIAJ
   x0xN35sWa1Qf4csb4rjAInTbRAFaEUVljrw1ZTK1mBRfF+85tvwNIZ07P
   oP8wzvYT7cLG649IjBgQy5snp5glOCewVPMouJLRsCkJgBE9m98qOuMKp
   ndrYYFbYKTLMaMsm+aU5XdMydEWmR1NXtawaN/RHajRQeaup/cwbDwomg
   oLW0sbToqy0thOMd1rWsBA3nQYdoaJNP4ObhwGO08oVw1/xiRqSl480zs
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="285212172"
X-IronPort-AV: E=Sophos;i="5.92,283,1650956400"; 
   d="scan'208";a="285212172"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 03:46:03 -0700
X-IronPort-AV: E=Sophos;i="5.92,283,1650956400"; 
   d="scan'208";a="572803002"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.41.111])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 03:46:01 -0700
Message-ID: <5d7c9f8a-76f7-7c77-62a3-f94adc083497@intel.com>
Date:   Tue, 19 Jul 2022 13:45:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] perf parse-events: Fix segfault when event parser
 gets an error
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20220712112824.28770-1-adrian.hunter@intel.com>
 <20220712112824.28770-2-adrian.hunter@intel.com>
 <CAP-5=fUaDsuYxQRkqWFThX3Su2me-caXxdQqJd0WH-dx-yRaug@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fUaDsuYxQRkqWFThX3Su2me-caXxdQqJd0WH-dx-yRaug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/22 04:10, Ian Rogers wrote:
> On Tue, Jul 12, 2022 at 4:28 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> parse_events() is often called with parse_events_error set to NULL.
>> Make parse_events_error__handle() not segfault in that case.
>>
>> Fixes: 43eb05d06679 ("perf tests: Support 'Track with sched_switch' test for hybrid")
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  tools/perf/util/parse-events.c | 14 +++++++++++---
>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
>> index 7ed235740431..700c95eafd62 100644
>> --- a/tools/perf/util/parse-events.c
>> +++ b/tools/perf/util/parse-events.c
>> @@ -2391,9 +2391,12 @@ void parse_events_error__exit(struct parse_events_error *err)
>>  void parse_events_error__handle(struct parse_events_error *err, int idx,
>>                                 char *str, char *help)
>>  {
>> -       if (WARN(!str, "WARNING: failed to provide error string\n")) {
>> -               free(help);
>> -               return;
>> +       if (WARN(!str, "WARNING: failed to provide error string\n"))
>> +               goto out_free;
>> +       if (!err) {
>> +               /* Assume caller does not want message printed */
>> +               pr_debug("event syntax error: %s\n", str);
>> +               goto out_free;
> 
> 
> It feels like a simpler invariant (as done elsewhere) to have the
> caller always pass err and then in the caller to call
> parse_events_error__exit. Any reason for behavior change?

This is a bug fix. More complicated changes can be done separately,
if desired, but it is wrong to segfault here in any case.

> 
> Thanks,
> Ian
> 
>>         }
>>         switch (err->num_errors) {
>>         case 0:
>> @@ -2419,6 +2422,11 @@ void parse_events_error__handle(struct parse_events_error *err, int idx,
>>                 break;
>>         }
>>         err->num_errors++;
>> +       return;
>> +
>> +out_free:
>> +       free(str);
>> +       free(help);
>>  }
>>
>>  #define MAX_WIDTH 1000
>> --
>> 2.25.1
>>

