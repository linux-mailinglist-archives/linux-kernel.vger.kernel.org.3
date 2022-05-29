Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858D6536F21
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 04:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiE2C2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 22:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiE2C2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 22:28:00 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784865A2C2
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 19:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653791279; x=1685327279;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WbxGG1Zd/MBUi19lx8KKh+c1DIpnKjvnRPmIoIrfP10=;
  b=BY2DA2Y4JyM0Mm53VdZMOLFfe1pzYFtm5mn7wRONzi6DnYFEquA0hI2G
   CxI8md7s2hlpd1F/2dadc7XFYnJ+7zJUq1WMCmMmFNcrVjQZl9N52ZRE8
   160nn0vky3Aa946YjgHhrMCayua0k88lzHlCUScaMBeAkQWJuSmmYJWxy
   M=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 28 May 2022 19:27:59 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2022 19:27:58 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 28 May 2022 19:27:58 -0700
Received: from [10.253.33.171] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sat, 28 May
 2022 19:27:56 -0700
Message-ID: <57ec5663-573e-1306-0477-aa4e3c761a96@quicinc.com>
Date:   Sun, 29 May 2022 10:27:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] tracing/probes: make match function safe
Content-Language: en-US
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        "Tom Zanussi" <zanussi@kernel.org>
References: <1651397651-30454-1-git-send-email-quic_linyyuan@quicinc.com>
 <1651397651-30454-3-git-send-email-quic_linyyuan@quicinc.com>
 <Yo1dW2w1UIF+KZFw@home.goodmis.org>
 <20220527010314.e5a2d9418cfdf5500d75b9b2@kernel.org>
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
In-Reply-To: <20220527010314.e5a2d9418cfdf5500d75b9b2@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/27/2022 12:03 AM, Masami Hiramatsu (Google) wrote:
> On Tue, 24 May 2022 18:34:03 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> Masami and Tom, what are you thoughts on this?
>>
>> -- Steve
> Thanks for forwarding.
>
>> On Sun, May 01, 2022 at 05:34:11PM +0800, Linyu Yuan wrote:
>>> When delete one kprobe/uprobe/eprobe event entry
>>> using /sys/kernel/debug/tracing/dynamic_events file,
>>> it will loop all dynamic envent entries,
>>> as user will not input dyn_event_operations type,
>>> when call the match function of kprobe/uprobe/eprobe,
>>> the dynamic event may have different dyn_event_operations type,
>>> but currently match function may return a match.
>>>
>>> Fix by check dyn_event_operations type first.
> Sorry, NACK. That check is not necessary, because the 'match' operation
> is chosen by each event::ops as below.
>
> int dyn_event_release(const char *raw_command, struct dyn_event_operations *type)
> {
>          struct dyn_event *pos, *n;
> ...
>          mutex_lock(&event_mutex);
>          for_each_dyn_event_safe(pos, n) {
>                  if (type && type != pos->ops)
>                          continue;
>                  if (!pos->ops->match(system, event,
>                                  argc - 1, (const char **)argv + 1, pos))
>                          continue;
> ...
>
> The @pos is dyn_event. Thus @pos->ops must be the appropriate
> dyn_event_operations for that event. For example, if there is an
> eprobe event @ev, then @ev->ops must be eprobe_dyn_event_ops and
> @ev->ops->match must be eprobe_dyn_event_match() (unless the match
> function is shared with another dyn_event_operations.)
>
> Thank you,
>
thanks,  yes, there is no need to add this match,

if two events have same name and different group, when user delete event,

if only input event name, it will delete two events.

if delete a specific event, it need input group name, it will not delete 
event in another group.

>>> Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
>>> ---
>>>   kernel/trace/trace_eprobe.c | 31 +++++++++++++++++++++++--------
>>>   kernel/trace/trace_kprobe.c |  3 +++
>>>   kernel/trace/trace_uprobe.c |  3 +++
>>>   3 files changed, 29 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
>>> index b16e067..0029840 100644
>>> --- a/kernel/trace/trace_eprobe.c
>>> +++ b/kernel/trace/trace_eprobe.c
>>> @@ -19,6 +19,21 @@
>>>   
>>>   #define EPROBE_EVENT_SYSTEM "eprobes"
>>>   
>>> +static int eprobe_dyn_event_create(const char *raw_command);
>>> +static int eprobe_dyn_event_show(struct seq_file *m, struct dyn_event *ev);
>>> +static bool eprobe_dyn_event_is_busy(struct dyn_event *ev);
>>> +static int eprobe_dyn_event_release(struct dyn_event *ev);
>>> +static bool eprobe_dyn_event_match(const char *system, const char *event,
>>> +			int argc, const char **argv, struct dyn_event *ev);
>>> +
>>> +static struct dyn_event_operations eprobe_dyn_event_ops = {
>>> +	.create = eprobe_dyn_event_create,
>>> +	.show = eprobe_dyn_event_show,
>>> +	.is_busy = eprobe_dyn_event_is_busy,
>>> +	.free = eprobe_dyn_event_release,
>>> +	.match = eprobe_dyn_event_match,
>>> +};
>>> +
>>>   struct trace_eprobe {
>>>   	/* tracepoint system */
>>>   	const char *event_system;
>>> @@ -39,6 +54,11 @@ struct eprobe_data {
>>>   
>>>   static int __trace_eprobe_create(int argc, const char *argv[]);
>>>   
>>> +static bool is_trace_eprobe(struct dyn_event *ev)
>>> +{
>>> +	return ev->ops == &eprobe_dyn_event_ops;
>>> +}
>>> +
>>>   static void trace_event_probe_cleanup(struct trace_eprobe *ep)
>>>   {
>>>   	if (!ep)
>>> @@ -121,6 +141,9 @@ static bool eprobe_dyn_event_match(const char *system, const char *event,
>>>   	struct trace_eprobe *ep = to_trace_eprobe(ev);
>>>   	const char *slash;
>>>   
>>> +	if (!is_trace_eprobe(ev))
>>> +		return false;
>>> +
>>>   	/*
>>>   	 * We match the following:
>>>   	 *  event only			- match all eprobes with event name
>>> @@ -174,14 +197,6 @@ static bool eprobe_dyn_event_match(const char *system, const char *event,
>>>   	return trace_probe_match_command_args(&ep->tp, argc, argv);
>>>   }
>>>   
>>> -static struct dyn_event_operations eprobe_dyn_event_ops = {
>>> -	.create = eprobe_dyn_event_create,
>>> -	.show = eprobe_dyn_event_show,
>>> -	.is_busy = eprobe_dyn_event_is_busy,
>>> -	.free = eprobe_dyn_event_release,
>>> -	.match = eprobe_dyn_event_match,
>>> -};
>>> -
>>>   static struct trace_eprobe *alloc_event_probe(const char *group,
>>>   					      const char *this_event,
>>>   					      struct trace_event_call *event,
>>> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
>>> index 2cd8ef9..f63abfa 100644
>>> --- a/kernel/trace/trace_kprobe.c
>>> +++ b/kernel/trace/trace_kprobe.c
>>> @@ -163,6 +163,9 @@ static bool trace_kprobe_match(const char *system, const char *event,
>>>   {
>>>   	struct trace_kprobe *tk = to_trace_kprobe(ev);
>>>   
>>> +	if (!is_trace_kprobe(ev))
>>> +		return false;
>>> +
>>>   	return (event[0] == '\0' ||
>>>   		strcmp(trace_probe_name(&tk->tp), event) == 0) &&
>>>   	    (!system || strcmp(trace_probe_group_name(&tk->tp), system) == 0) &&
>>> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
>>> index a935c08..ee55ed0 100644
>>> --- a/kernel/trace/trace_uprobe.c
>>> +++ b/kernel/trace/trace_uprobe.c
>>> @@ -312,6 +312,9 @@ static bool trace_uprobe_match(const char *system, const char *event,
>>>   {
>>>   	struct trace_uprobe *tu = to_trace_uprobe(ev);
>>>   
>>> +	if (!is_trace_uprobe(ev))
>>> +		return false;
>>> +
>>>   	return (event[0] == '\0' ||
>>>   		strcmp(trace_probe_name(&tu->tp), event) == 0) &&
>>>   	   (!system || strcmp(trace_probe_group_name(&tu->tp), system) == 0) &&
>>> -- 
>>> 2.7.4
>
