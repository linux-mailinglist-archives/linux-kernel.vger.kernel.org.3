Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7BC5588B3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiFWT0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiFWT0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:26:01 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5239953A53
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 11:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656009700; x=1687545700;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xVaegYbeiScVqeZQE4TDmBcfyEdSyMuophK0vQ36ly4=;
  b=Rtf2lUApaVkIsyvsV4VR+GwOrSoLn06lK+yJ2Ryf/z+IN+HDwts1k64m
   qeYvuwyLnD4+V9gM/bjxGSrb4DR5vzlzBfsqOerEToqphUONJ/6tNmV6E
   CU9XTg82yqHz01XX+24MDWWkWtYpOR+e6vv0P7mPFuB6DeaXzwehL8P5T
   5JEZdMXo8Pg6ljhIjDnt8adx+Au+vS46Q05DYvbeMJNEXRpD3Bace3qFb
   Fw+2G1mJPTaBhCxMfZMnS2Hvg3fd70b6aY7M6GO8OtHdPUo76WZ3QBXaM
   JmKfOyfaLCDI3PBFuI811JHGq8DW54eBBTQ8/H/kqcjbnUsh6kzvgeVpR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="261236630"
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="261236630"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 11:41:39 -0700
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="592835104"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.61.96])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 11:41:37 -0700
Message-ID: <4751b9ed-9cac-be81-aa93-e9989bdcdec3@intel.com>
Date:   Thu, 23 Jun 2022 21:41:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH 4/5] perf record: Add finished init event
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20220610113316.6682-1-adrian.hunter@intel.com>
 <20220610113316.6682-5-adrian.hunter@intel.com> <YrRtiqE3gm/zQxfj@kernel.org>
 <YrRuqp988gFrE3YY@kernel.org> <YrRwwMtOc/5kZC9r@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <YrRwwMtOc/5kZC9r@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/22 16:55, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jun 23, 2022 at 10:46:18AM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Thu, Jun 23, 2022 at 10:41:31AM -0300, Arnaldo Carvalho de Melo escreveu:
>>> Em Fri, Jun 10, 2022 at 02:33:15PM +0300, Adrian Hunter escreveu:
>>>> In preparation for recording sideband events in a virtual machine guest so
>>>> that they can be injected into a host perf.data file.
>>>>
>>>> This is needed to enable injecting events after the initial synthesized
>>>> user events (that have an all zero id sample) but before regular events.
>>>
>>> Humm, can't we consider the first FINISHED_ROUND as a good enough marker
>>> for this?
>>
>> Nope, synthesize_flush() may be called multiple times during the
>> initialization (the synthesizing of PERF_RECORD_ events for pre-existing
>> threads)...
>>
>> I'm reapplying this patch.
> 
> And add this, please check:
> 
> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
> index f56d0e0fbff6ef66..bc9f0aa113d8b6d4 100644
> --- a/tools/perf/Documentation/perf.data-file-format.txt
> +++ b/tools/perf/Documentation/perf.data-file-format.txt
> @@ -607,6 +607,16 @@ struct compressed_event {
>         char                            data[];
>  };
> 
> +       PERF_RECORD_FINISHED_INIT                       = 82,
> +
> +Marks the end of records for the system, pre-existing threads in system wide
> +sessions, etc. Those are the ones prefixed PERF_RECORD_USER_*.
> +
> +This is used, for instance, to 'perf inject' events after init and before
> +regular events, those emitted by the kernel, to support combining guest and
> +host records.
> +
> +
>  The header is followed by compressed data frame that can be decompressed
>  into array of perf trace records. The size of the entire compressed event
>  record including the header is limited by the max value of header.size.
> ⬢[acme@toolbox perf]$

That's great!  Thank you!

> 
> 
> - Arnaldo
>  
>> - Arnaldo
>>  
>>> 0 0x4fc8 [0x48]: PERF_RECORD_KSYMBOL addr ffffffffc10d0650 len 255 type 1 flags 0x0 name bpf_prog_ee0e253c78993a24
>>>
>>> 0x5010@perf.data [0x28]: event: 18
>>> .
>>> . ... raw event: size 40 bytes
>>> .  0000:  12 00 00 00 00 00 28 00 01 00 00 00 28 00 00 00  ......(.....(...
>>> .  0010:  ee 0e 25 3c 78 99 3a 24 00 00 00 00 00 00 00 00  ..%<x.:$........
>>> .  0020:  00 00 00 00 00 00 00 00                          ........
>>>
>>> 0 0x5010 [0x28]: PERF_RECORD_BPF_EVENT type 1, flags 0, id 40
>>>
>>> 0x5038@perf.data [0x30]: event: 3
>>> .
>>> . ... raw event: size 48 bytes
>>> .  0000:  03 00 00 00 00 00 30 00 3a 5d 00 00 3a 5d 00 00  ......0.:]..:]..
>>> .  0010:  70 65 72 66 2d 65 78 65 63 00 00 00 00 00 00 00  perf-exec.......
>>> .  0020:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>
>>> 0 0x5038 [0x30]: PERF_RECORD_COMM: perf-exec:23866/23866
>>>
>>> 0x5068@perf.data [0x8]: event: 82
>>> .
>>> . ... raw event: size 8 bytes
>>> .  0000:  52 00 00 00 00 00 08 00                          R.......
>>>
>>> 0 0x5068 [0x8]: PERF_RECORD_FINISHED_INIT: unhandled!
>>>
>>> 0x5390@perf.data [0x8]: event: 68
>>> .
>>> . ... raw event: size 8 bytes
>>> .  0000:  44 00 00 00 00 00 08 00                          D.......
>>>
>>> 0 0x5390 [0x8]: PERF_RECORD_FINISHED_ROUND
>>>
>>> 0x5070@perf.data [0x28]: event: 9
>>> .
>>> . ... raw event: size 40 bytes
>>> .  0000:  09 00 00 00 01 00 28 00 50 b5 16 a7 ff ff ff ff  ......(.P.......
>>> .  0010:  3a 5d 00 00 3a 5d 00 00 54 90 f5 bf 52 01 00 00  :]..:]..T...R...
>>> .  0020:  01 00 00 00 00 00 00 00                          ........
>>>
>>> 1454919487572 0x5070 [0x28]: PERF_RECORD_SAMPLE(IP, 0x1): 23866/23866: 0xffffffffa716b550 period: 1 addr: 0
>>>
>>>  
>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>>> ---
>>>>  tools/lib/perf/include/perf/event.h |  1 +
>>>>  tools/perf/builtin-inject.c         |  1 +
>>>>  tools/perf/builtin-record.c         | 27 +++++++++++++++++++++++++++
>>>>  tools/perf/util/event.c             |  1 +
>>>>  tools/perf/util/session.c           |  4 ++++
>>>>  tools/perf/util/tool.h              |  3 ++-
>>>>  6 files changed, 36 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
>>>> index e7758707cadd..9f7ca070da87 100644
>>>> --- a/tools/lib/perf/include/perf/event.h
>>>> +++ b/tools/lib/perf/include/perf/event.h
>>>> @@ -389,6 +389,7 @@ enum perf_user_event_type { /* above any possible kernel type */
>>>>  	PERF_RECORD_TIME_CONV			= 79,
>>>>  	PERF_RECORD_HEADER_FEATURE		= 80,
>>>>  	PERF_RECORD_COMPRESSED			= 81,
>>>> +	PERF_RECORD_FINISHED_INIT		= 82,
>>>>  	PERF_RECORD_HEADER_MAX
>>>>  };
>>>>  
>>>> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
>>>> index a75bf11585b5..42e2918fd1cc 100644
>>>> --- a/tools/perf/builtin-inject.c
>>>> +++ b/tools/perf/builtin-inject.c
>>>> @@ -1059,6 +1059,7 @@ int cmd_inject(int argc, const char **argv)
>>>>  			.stat		= perf_event__repipe_op2_synth,
>>>>  			.stat_round	= perf_event__repipe_op2_synth,
>>>>  			.feature	= perf_event__repipe_op2_synth,
>>>> +			.finished_init	= perf_event__repipe_op2_synth,
>>>>  			.compressed	= perf_event__repipe_op4_synth,
>>>>  			.auxtrace	= perf_event__repipe_auxtrace,
>>>>  		},
>>>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>>>> index 40dca1fba4e3..cf5c5379ceaa 100644
>>>> --- a/tools/perf/builtin-record.c
>>>> +++ b/tools/perf/builtin-record.c
>>>> @@ -1388,6 +1388,11 @@ static struct perf_event_header finished_round_event = {
>>>>  	.type = PERF_RECORD_FINISHED_ROUND,
>>>>  };
>>>>  
>>>> +static struct perf_event_header finished_init_event = {
>>>> +	.size = sizeof(struct perf_event_header),
>>>> +	.type = PERF_RECORD_FINISHED_INIT,
>>>> +};
>>>> +
>>>>  static void record__adjust_affinity(struct record *rec, struct mmap *map)
>>>>  {
>>>>  	if (rec->opts.affinity != PERF_AFFINITY_SYS &&
>>>> @@ -1696,6 +1701,14 @@ static int record__synthesize_workload(struct record *rec, bool tail)
>>>>  	return err;
>>>>  }
>>>>  
>>>> +static int write_finished_init(struct record *rec, bool tail)
>>>> +{
>>>> +	if (rec->opts.tail_synthesize != tail)
>>>> +		return 0;
>>>> +
>>>> +	return record__write(rec, NULL, &finished_init_event, sizeof(finished_init_event));
>>>> +}
>>>> +
>>>>  static int record__synthesize(struct record *rec, bool tail);
>>>>  
>>>>  static int
>>>> @@ -1710,6 +1723,8 @@ record__switch_output(struct record *rec, bool at_exit)
>>>>  
>>>>  	record__aio_mmap_read_sync(rec);
>>>>  
>>>> +	write_finished_init(rec, true);
>>>> +
>>>>  	record__synthesize(rec, true);
>>>>  	if (target__none(&rec->opts.target))
>>>>  		record__synthesize_workload(rec, true);
>>>> @@ -1764,6 +1779,7 @@ record__switch_output(struct record *rec, bool at_exit)
>>>>  		 */
>>>>  		if (target__none(&rec->opts.target))
>>>>  			record__synthesize_workload(rec, false);
>>>> +		write_finished_init(rec, false);
>>>>  	}
>>>>  	return fd;
>>>>  }
>>>> @@ -2419,6 +2435,15 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>>>>  	trigger_ready(&auxtrace_snapshot_trigger);
>>>>  	trigger_ready(&switch_output_trigger);
>>>>  	perf_hooks__invoke_record_start();
>>>> +
>>>> +	/*
>>>> +	 * Must write FINISHED_INIT so it will be seen after all other
>>>> +	 * synthesized user events, but before any regular events.
>>>> +	 */
>>>> +	err = write_finished_init(rec, false);
>>>> +	if (err < 0)
>>>> +		goto out_child;
>>>> +
>>>>  	for (;;) {
>>>>  		unsigned long long hits = thread->samples;
>>>>  
>>>> @@ -2563,6 +2588,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>>>>  		fprintf(stderr, "[ perf record: Woken up %ld times to write data ]\n",
>>>>  			record__waking(rec));
>>>>  
>>>> +	write_finished_init(rec, true);
>>>> +
>>>>  	if (target__none(&rec->opts.target))
>>>>  		record__synthesize_workload(rec, true);
>>>>  
>>>> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
>>>> index 0476bb3a4188..1fa14598b916 100644
>>>> --- a/tools/perf/util/event.c
>>>> +++ b/tools/perf/util/event.c
>>>> @@ -76,6 +76,7 @@ static const char *perf_event__names[] = {
>>>>  	[PERF_RECORD_TIME_CONV]			= "TIME_CONV",
>>>>  	[PERF_RECORD_HEADER_FEATURE]		= "FEATURE",
>>>>  	[PERF_RECORD_COMPRESSED]		= "COMPRESSED",
>>>> +	[PERF_RECORD_FINISHED_INIT]		= "FINISHED_INIT",
>>>>  };
>>>>  
>>>>  const char *perf_event__name(unsigned int id)
>>>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
>>>> index 0aa818977d2b..37f833c3c81b 100644
>>>> --- a/tools/perf/util/session.c
>>>> +++ b/tools/perf/util/session.c
>>>> @@ -562,6 +562,8 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
>>>>  		tool->feature = process_event_op2_stub;
>>>>  	if (tool->compressed == NULL)
>>>>  		tool->compressed = perf_session__process_compressed_event;
>>>> +	if (tool->finished_init == NULL)
>>>> +		tool->finished_init = process_event_op2_stub;
>>>>  }
>>>>  
>>>>  static void swap_sample_id_all(union perf_event *event, void *data)
>>>> @@ -1706,6 +1708,8 @@ static s64 perf_session__process_user_event(struct perf_session *session,
>>>>  		if (err)
>>>>  			dump_event(session->evlist, event, file_offset, &sample, file_path);
>>>>  		return err;
>>>> +	case PERF_RECORD_FINISHED_INIT:
>>>> +		return tool->finished_init(session, event);
>>>>  	default:
>>>>  		return -EINVAL;
>>>>  	}
>>>> diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
>>>> index f2352dba1875..c957fb849ac6 100644
>>>> --- a/tools/perf/util/tool.h
>>>> +++ b/tools/perf/util/tool.h
>>>> @@ -76,7 +76,8 @@ struct perf_tool {
>>>>  			stat_config,
>>>>  			stat,
>>>>  			stat_round,
>>>> -			feature;
>>>> +			feature,
>>>> +			finished_init;
>>>>  	event_op4	compressed;
>>>>  	event_op3	auxtrace;
>>>>  	bool		ordered_events;
>>>> -- 
>>>> 2.25.1
>>>
>>> -- 
>>>
>>> - Arnaldo
>>
>> -- 
>>
>> - Arnaldo
> 

