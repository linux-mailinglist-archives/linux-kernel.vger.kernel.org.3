Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D695528D5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 02:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239840AbiFUA6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 20:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242106AbiFUA5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 20:57:40 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EDC186F0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 17:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655773060; x=1687309060;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=25vqwF/B0JGw7RtSnJn5GZoy7OaZTGmwTWDmcGboL0c=;
  b=uNiKZwOMqFmHBC/d2KKg4R0bhTf1uBMjyn1Et1iuZIziW0dhlXm+v/bV
   yIIq+8NlqBlVtcy5g0hMKaiUUIvHA3hMKyNQZHjhlzHXqjzMk9tY1xD3Y
   9Afs/+MN5RIxnAhZ87R7euGBWMLkmpYkNHGB/dXHm2h6IODiZU1z1zdFh
   U=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 20 Jun 2022 17:57:40 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 17:57:39 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 20 Jun 2022 17:56:59 -0700
Received: from [10.253.10.101] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 20 Jun
 2022 17:56:57 -0700
Message-ID: <2f1555ac-709f-8b8b-4a54-cbb653189f30@quicinc.com>
Date:   Tue, 21 Jun 2022 08:56:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 1/3] tracing: eprobe: remove duplicate is_good_name()
 operation
Content-Language: en-US
To:     Tom Zanussi <zanussi@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>
References: <1654171861-24014-1-git-send-email-quic_linyyuan@quicinc.com>
 <1654171861-24014-2-git-send-email-quic_linyyuan@quicinc.com>
 <9a7e0b6087540c9f868d60cbfc88ccefa8070a1b.camel@kernel.org>
 <d14f0409-351f-873e-b7ca-82ff444bf809@quicinc.com>
 <e5501570657870e3cdbbce591b0def973f5a20b6.camel@kernel.org>
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
In-Reply-To: <e5501570657870e3cdbbce591b0def973f5a20b6.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Tom,

On 6/21/2022 2:38 AM, Tom Zanussi wrote:
> Hi Linyu,
>
> On Tue, 2022-06-14 at 08:48 +0800, Linyu Yuan wrote:
>> hi Tom,
>>
>> On 6/14/2022 5:01 AM, Tom Zanussi wrote:
>>> Hi Linhu,
>>>
>>> On Thu, 2022-06-02 at 20:10 +0800, Linyu Yuan wrote:
>>>> traceprobe_parse_event_name() already validate group and event
>>>> name,
>>>> there is no need to call is_good_name() after it.
>>>>
>>>> Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
>>>> ---
>>>> v2: drop v1 change as it is NACK.
>>>>       add it to remove duplicate is_good_name().
>>>> v3: move it as first patch.
>>>> v4: no change
>>>>
>>>>    kernel/trace/trace_eprobe.c | 4 ----
>>>>    1 file changed, 4 deletions(-)
>>>>
>>>> diff --git a/kernel/trace/trace_eprobe.c
>>>> b/kernel/trace/trace_eprobe.c
>>>> index 7d44785..17d64e3 100644
>>>> --- a/kernel/trace/trace_eprobe.c
>>>> +++ b/kernel/trace/trace_eprobe.c
>>>> @@ -878,16 +878,12 @@ static int __trace_eprobe_create(int argc,
>>>> const char *argv[])
>>>>                   sanitize_event_name(buf1);
>>>>                   event = buf1;
>>>>           }
>>>> -       if (!is_good_name(event) || !is_good_name(group))
>>>> -               goto parse_error;
>>> traceprobe_parse_event_name() is only called if (event).  In the
>>> !event case, wouldn't the is_good_name() checks still be needed
>>> (since
>>> in that case buf1 is assigned to event)?
>> when user input no  event name, it will generate event name from
>> second
>> SYSTEM.EVENT,
>>
>> and it will validate with following traceprobe_parse_event_name().
>>
>>
> Right, but that happens in your second patch '[PATCH v5 2/3] tracing:
> auto generate event name when create a group of events', not this one.
>   
> So if you apply only this patch, the !event case will assign event but
> it will remain unchecked when used later in this function.
>
> It would make more sense to remove this check in patch 2/3 along with
> the code that does the generating...
thanks, will do like this.
>
>> (
>>
>> if you agree, i will send a new version to update a minor issue in
>> second patch,
>>
>>
>>           sys_event = argv[1];
>> -       ret = traceprobe_parse_event_name(&sys_event, &sys_name,
>> buf2,
>> -                                         sys_event - argv[1]);
>> -       if (ret || !sys_name)
>> +       ret = traceprobe_parse_event_name(&sys_event, &sys_name,
>> buf2, 0);
>> +       if (!sys_event || !sys_name)
>>                   goto parse_error;
>>
>> )
>>
>>>>    
>>>>           sys_event = argv[1];
>>>>           ret = traceprobe_parse_event_name(&sys_event, &sys_name,
>>>> buf2,
>>>>                                             sys_event - argv[1]);
>>>>           if (ret || !sys_name)
>>>>                   goto parse_error;
>>>> -       if (!is_good_name(sys_event) || !is_good_name(sys_name))
>>>> -               goto parse_error;
>>> I agree this one isn't needed.
> But keep this one in this patch, since it's useful on its own as a
> standalone cleanup regardless of whether or not patch 2/3 gets merged.
>
> Tom
>
>>> Thanks,
>>>
>>> Tom
>>>
>>>>    
>>>>           mutex_lock(&event_mutex);
>>>>           event_call = find_and_get_event(sys_name, sys_event);
