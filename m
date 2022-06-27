Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E7855B4AB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 02:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiF0Adu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 20:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiF0Ads (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 20:33:48 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2611ED8F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 17:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656290027; x=1687826027;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0w3fR5dFNaU97jWfVx9KomMSpa0jR4GXte5D1bSThjY=;
  b=skxmJNiCuHs5MMjpTEpLPcsnq3U+O8Q/Eajp0tZT3R7DFT9nI5TYFPpY
   EbM5hwS08oQx5F6sa3lpFG15ei28L39vz3GNWb1d7R2lfFm8Lw0YGr4Xi
   RmyCb5ukOdWa46NC0nFtJtsm+s3BOHPhrQEcv07CEr7wBWh0K3vWJP5hM
   w=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 26 Jun 2022 17:33:46 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 17:33:46 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 26 Jun 2022 17:33:46 -0700
Received: from [10.253.34.55] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 26 Jun
 2022 17:33:44 -0700
Message-ID: <02eb1afc-3e1f-0d3f-d082-1ce6aaf9924f@quicinc.com>
Date:   Mon, 27 Jun 2022 08:33:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 1/3] tracing: eprobe: remove duplicate is_good_name()
 operation
Content-Language: en-US
To:     Tom Zanussi <zanussi@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
References: <1655776787-18133-1-git-send-email-quic_linyyuan@quicinc.com>
 <1655776787-18133-2-git-send-email-quic_linyyuan@quicinc.com>
 <3f1b974be23b058cc0f004b518df21716b9dfcfd.camel@kernel.org>
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
In-Reply-To: <3f1b974be23b058cc0f004b518df21716b9dfcfd.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

hi Tom,

On 6/26/2022 1:25 AM, Tom Zanussi wrote:
> Hi Linyu,
>
> On Tue, 2022-06-21 at 09:59 +0800, Linyu Yuan wrote:
>> traceprobe_parse_event_name() already validate SYSTEM and EVENT name,
>> there is no need to call is_good_name() after it.
>>
>> Add trace_probe_log_set_index(1) to allow report correct error
>> if user input wrong SYSTEM.EVENT format.
>>
>> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>> Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
>> ---
>> v2: drop v1 change as it is NACK.
>>      add it to remove duplicate is_good_name().
>> v3: move it as first patch.
>> v4: no change
>> v5: add Acked-by tag
>> v6: keep is_good_name() check for group and event name
>>      add trace_probe_log_set_index(1) to report correct error message.
>>
>>   kernel/trace/trace_eprobe.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/kernel/trace/trace_eprobe.c
>> b/kernel/trace/trace_eprobe.c
>> index 7d44785..8979cb9e 100644
>> --- a/kernel/trace/trace_eprobe.c
>> +++ b/kernel/trace/trace_eprobe.c
>> @@ -881,13 +881,12 @@ static int __trace_eprobe_create(int argc,
>> const char *argv[])
>>          if (!is_good_name(event) || !is_good_name(group))
>>                  goto parse_error;
>>   
>> +       trace_probe_log_set_index(1);
> Is this something that you noticed missing in the original code and are
> adding now?  If so, please make this a separate patch.  Or is this
> something that's needed for the new 'generating event name' code?  If
> that's the case, please move this to the other patch.
>
> This one should only contain the code related to the duplicate
> is_good_name() removal mentioned in the subject.  Or if this really
> does belong here, please provide more explanation of why it's needed if
> you remove the duplicate is_good_name() code.
thanks, the original code should have this setting, i will create a 
separate patch.
>
> Thanks,
>
> Tom
>
>>          sys_event = argv[1];
>>          ret = traceprobe_parse_event_name(&sys_event, &sys_name,
>> buf2,
>>                                            sys_event - argv[1]);
>>          if (ret || !sys_name)
>>                  goto parse_error;
>> -       if (!is_good_name(sys_event) || !is_good_name(sys_name))
>> -               goto parse_error;
>>   
>>          mutex_lock(&event_mutex);
>>          event_call = find_and_get_event(sys_name, sys_event);
