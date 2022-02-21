Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF24D4BEAD2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbiBUSqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 13:46:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbiBUSqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 13:46:25 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A0F195
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 10:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645469161; x=1677005161;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D+gbvhd+YzrBn/qP+Xn3UeOMt71YnVFf+SNtwwrBFDM=;
  b=MOqWT9Q/ewbiMRa4T2YMjXWxFi+GDTStm9OZYAbCv8HBgVKNXD2eWLvh
   PMqaoHEguMej+QK0/kYrIE51PP0F6CPR3f7Is/hly+sq6ue7+ZfpuwDpy
   GqfkgOsgbhFBszz4GXaKxnapadVSNjCdoZnutA55AX5JDsesK3iAKMFtd
   k7ifQIgam9FawJJFQq+vHgJDS7vkQ0fqV09Fal4r1XIDDdBvKw/LTVixe
   UqoYyUi82v/0Il7hjVxyoDX7LkH9YYsJbRRHDgw6bxv05JT6t6lH30U0O
   8J3n5fpLUL7H+VN7pcmlJApXKPFrBXTiF08MqXhpG7PJGvq0atxnYnc96
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="314817976"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="314817976"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 10:46:01 -0800
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="547430782"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.228.66]) ([10.249.228.66])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 10:45:57 -0800
Message-ID: <f5a97d51-fa64-0e48-d150-e8a983f88a32@linux.intel.com>
Date:   Mon, 21 Feb 2022 21:45:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH core] perf data: Adding error message if
 perf_data__create_dir fails
Content-Language: en-GB
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>
References: <20220218152341.5197-1-alexey.v.bayduraev@linux.intel.com>
 <YhLEHCttvXmRu78G@krava>
 <60253e6d-e8c5-550e-73b5-40720114c2a4@linux.intel.com>
 <YhPY3B3QumIZWukQ@krava>
From:   "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Organization: Intel Corporation
In-Reply-To: <YhPY3B3QumIZWukQ@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21.02.2022 21:24, Jiri Olsa wrote:
> On Mon, Feb 21, 2022 at 04:24:28PM +0300, Bayduraev, Alexey V wrote:
>> On 21.02.2022 1:43, Jiri Olsa wrote:
>>> On Fri, Feb 18, 2022 at 06:23:40PM +0300, Alexey Bayduraev wrote:
>>>> There is no notification about data directory creation failure. Add it.
>>>>
>>>> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
>>>> ---
>>>>  tools/perf/builtin-record.c | 4 +++-
>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>>>> index 0bc6529814b2..0306d5911de2 100644
>>>> --- a/tools/perf/builtin-record.c
>>>> +++ b/tools/perf/builtin-record.c
>>>> @@ -1186,8 +1186,10 @@ static int record__mmap_evlist(struct record *rec,
>>>>  
>>>>  	if (record__threads_enabled(rec)) {
>>>>  		ret = perf_data__create_dir(&rec->data, evlist->core.nr_mmaps);
>>>> -		if (ret)
>>>> +		if (ret) {
>>>> +			pr_err("Failed to create data directory: %s\n", strerror(errno));
>>>
>>> errno will be misleading in here, because perf_data__create_dir
>>> calls other syscalls on error path
>>
>> Mostly I want to output something like:
>>
>>   Failed to create data dir: Too many open files
>>
>> This will trigger the user to increase the open files limit.
>> Would it be better to place such message to perf_data__create_dir after 
>> open() syscall?
> 
> how about something like below (with your change)

Looks better, I will apply this to my patch.

Thanks,
Alexey

> 
> jirka
> 
> 
> ---
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index 15a4547d608e..d3382098d6f9 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -52,8 +52,10 @@ int perf_data__create_dir(struct perf_data *data, int nr)
>  			goto out_err;
>  
>  		ret = open(file->path, O_RDWR|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			ret = -errno;
>  			goto out_err;
> +		}
>  
>  		file->fd = ret;
>  	}
