Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484AC5AAE0B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 14:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbiIBMBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 08:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbiIBMBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 08:01:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4889552451
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 05:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662120069; x=1693656069;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MA2F1NX+R2+2eM0M3J1/D21ak0GR9GaYbn0h6g67VsY=;
  b=dmbTOAVNneYdqKg0xmaODbEskgagSBypDTIn/2G/xCBFp+fmdmlvcI4a
   6LV6DEwr+DMCqhDE+uT82D6Pq/hZixWzxdK2gz3mEmAnfwMW46P5AElwt
   tS+OnnVcxPfwffpu9C3ustZovx4vprLeWtVyabtDHR1H9bxXRj8KSQU0L
   H0p6nyucX1lifnMvbR/+rZxuFZGQt4TYVqH1EIbB9bHBpMzTFtwyPeqrM
   k7Xwyqy2RwBHYjOcwOqOXzBvFWaWfAJ6dFLM1ArTRwOYMXKV2etcVva/t
   U4Y/z3/xpFvgfb/gnp+MzXnhU8OVuMN9yw1zIlOUbpZsaWWiNJ9lLWD76
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="295971295"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="295971295"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 05:01:07 -0700
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="674331452"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.42.34])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 05:01:05 -0700
Message-ID: <bf500303-394a-4806-361a-7cc559d80e98@intel.com>
Date:   Fri, 2 Sep 2022 15:01:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 5/5] perf intel-pt: Support itrace option flag d+e to log
 on error
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20220901110032.9226-1-adrian.hunter@intel.com>
 <20220901110032.9226-6-adrian.hunter@intel.com>
 <dadd6179-4867-211a-ad6e-30fcd66a8e0a@linux.intel.com>
 <1a7aaa51-1858-bb59-834c-7e8f6a58bc39@intel.com>
 <CAM9d7chiutXEZfpQbayJ3bgraLZ_YFGC15yDn7sQBT4asdEfjA@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAM9d7chiutXEZfpQbayJ3bgraLZ_YFGC15yDn7sQBT4asdEfjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/09/22 04:34, Namhyung Kim wrote:
> On Thu, Sep 1, 2022 at 9:29 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 1/09/22 17:31, Andi Kleen wrote:
>>>
>>> On 9/1/2022 4:00 AM, Adrian Hunter wrote:
> 
> [SNIP]
>>>> +
>>>> +static void log_buf__dump(struct log_buf *b)
>>>> +{
>>>> +    if (!b->buf)
>>>> +        return;
>>>> +
>>>> +    fflush(f);
>>>> +    fprintf(b->backend, "Dumping debug log buffer (first line may be sliced)\n");
>>>
>>>
>>> Should be easy to skip the first line, no?
>>
>> Not as easy as typing " (first line may be sliced)" ;-)
>>
>> Still not sure it is worth having the extra complication, but here
>> is the change as a separate patch:
>>
>> From: Adrian Hunter <adrian.hunter@intel.com>
>> Date: Thu, 1 Sep 2022 19:01:33 +0300
>> Subject: [PATCH] perf intel-pt: Remove first line of log dumped on error
>>
>> Instead of printing "(first line may be sliced)", always remove the
>> first line of the debug log when dumping on error.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  .../perf/util/intel-pt-decoder/intel-pt-log.c | 27 ++++++++++++++++---
>>  1 file changed, 24 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-log.c b/tools/perf/util/intel-pt-decoder/intel-pt-log.c
>> index ea96dcae187a7..6cc465d1f7a9e 100644
>> --- a/tools/perf/util/intel-pt-decoder/intel-pt-log.c
>> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-log.c
>> @@ -143,16 +143,37 @@ static FILE *log_buf__open(struct log_buf *b, FILE *backend, unsigned int sz)
>>         return file;
>>  }
>>
>> +static bool remove_first_line(const char **p, size_t *n)
>> +{
>> +       for (; *n && **p != '\n'; ++*p, --*n)
>> +               ;
>> +       if (*n) {
>> +               *p += 1;
>> +               *n -= 1;
>> +               return true;
>> +       }
>> +       return false;
>> +}
>> +
>> +static void write_lines(const char *p, size_t n, FILE *fp, bool *remove_first)
>> +{
>> +       if (*remove_first)
>> +               *remove_first = !remove_first_line(&p, &n);
>> +       fwrite(p, n, 1, fp);
>> +}
>> +
>>  static void log_buf__dump(struct log_buf *b)
>>  {
>> +       bool remove_first = true;
> 
> Isn't it only required when the buf is wrapped?

Very true! Thanks for spotting that!

I will send a new version.

> 
> Thanks,
> Namhyung
> 
> 
>> +
>>         if (!b->buf)
>>                 return;
>>
>>         fflush(f);
>> -       fprintf(b->backend, "Dumping debug log buffer (first line may be sliced)\n");
>> +       fprintf(b->backend, "Dumping debug log buffer\n");
>>         if (b->wrapped)
>> -               fwrite(b->buf + b->head, b->buf_sz - b->head, 1, b->backend);
>> -       fwrite(b->buf, b->head, 1, b->backend);
>> +               write_lines(b->buf + b->head, b->buf_sz - b->head, b->backend, &remove_first);
>> +       write_lines(b->buf, b->head, b->backend, &remove_first);
>>         fprintf(b->backend, "End of debug log buffer dump\n");
>>
>>         b->head = 0;
>> --
>> 2.34.1
>>

