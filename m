Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6DA550E48
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 03:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237447AbiFTBDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 21:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238056AbiFTBDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 21:03:38 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902315FC3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 18:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655687016; x=1687223016;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TuxIGco71jaVaJIEuquq4AaCuR5x1f2GY72Xc62P4Vw=;
  b=cwdVLDae/Yr+8lUkYl8S+0avr58Iei8GVEKrCBDahQ3MRa5BVB/W5LBL
   a4/9VXX5PMfnQ0jCD+/+SvRWpHDrHk51x6tcpcVY7qcQRunmSH8oNDmFi
   psSGLr3jhSYnC/CPoTt/QYZ3fuv+jZHIgvsoelbBuxn7Z5x8hXKT7CaPj
   Q=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 19 Jun 2022 18:03:35 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 18:03:35 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 19 Jun 2022 18:03:35 -0700
Received: from [10.253.79.24] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 19 Jun
 2022 18:03:33 -0700
Message-ID: <e1a484a5-b14e-ab6d-09e7-645b1e740beb@quicinc.com>
Date:   Mon, 20 Jun 2022 09:03:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 1/3] tracing: eprobe: remove duplicate is_good_name()
 operation
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
References: <1655168698-19898-1-git-send-email-quic_linyyuan@quicinc.com>
 <1655168698-19898-2-git-send-email-quic_linyyuan@quicinc.com>
 <20220617214942.1dbfb55b@gandalf.local.home>
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
In-Reply-To: <20220617214942.1dbfb55b@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

hi tom,

On 6/18/2022 9:49 AM, Steven Rostedt wrote:
> On Tue, 14 Jun 2022 09:04:56 +0800
> Linyu Yuan <quic_linyyuan@quicinc.com> wrote:
>
>> traceprobe_parse_event_name() already validate group and event name,
>> there is no need to call is_good_name() after it.
>>
>> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>> Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
>> ---
>> v2: drop v1 change as it is NACK.
>>      add it to remove duplicate is_good_name().
>> v3: move it as first patch.
>> v4: no change
>> v5: add Acked-by tag
>>
>>   kernel/trace/trace_eprobe.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
>> index 7d44785..17d64e3 100644
>> --- a/kernel/trace/trace_eprobe.c
>> +++ b/kernel/trace/trace_eprobe.c
>> @@ -878,16 +878,12 @@ static int __trace_eprobe_create(int argc, const char *argv[])
>>   		sanitize_event_name(buf1);
>>   		event = buf1;
>>   	}
>> -	if (!is_good_name(event) || !is_good_name(group))
>> -		goto parse_error;
>>   
> Tom replied that the above may be an issue. You ignored his response.
>
> -- Steve
>
i reply his mail in V4 
https://lore.kernel.org/lkml/d14f0409-351f-873e-b7ca-82ff444bf809@quicinc.com/,

form my view, i think it is safe, in !event case Tom mentioned, we will 
generate event from SYSTEM.EVENT

which is verified by traceprobe_parse_event_name().


Tom, could you review it again ?

>>   	sys_event = argv[1];
>>   	ret = traceprobe_parse_event_name(&sys_event, &sys_name, buf2,
>>   					  sys_event - argv[1]);
>>   	if (ret || !sys_name)
>>   		goto parse_error;
>> -	if (!is_good_name(sys_event) || !is_good_name(sys_name))
>> -		goto parse_error;
>>   
>>   	mutex_lock(&event_mutex);
>>   	event_call = find_and_get_event(sys_name, sys_event);
