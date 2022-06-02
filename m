Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1C953B104
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 03:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbiFBBOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 21:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbiFBBOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 21:14:32 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5652528DC2D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 18:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654132471; x=1685668471;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bWFXcQnKXY8a/m8TcSxijScjYvDHTQN+fntbc/HLins=;
  b=iyOIbIgjCkBmttCel7iA3PP6P222Y0OQoH4/R8GETDEOWcClb4WoYMsR
   3+rtPSw98v4WImSyxHky2oblfOXqMOFvgkPX2+iKLlVeNaZyWmaCLZESe
   LJoRCJ9b4JxIe45a5077AWereP+Us371jyXdE7Hv3LDUniX4y6yQl3qbp
   M=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 01 Jun 2022 18:14:31 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 18:14:31 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 1 Jun 2022 18:14:30 -0700
Received: from [10.253.74.162] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 1 Jun 2022
 18:14:28 -0700
Message-ID: <44ae3cc5-12ea-ada3-aee9-2b572c2343f7@quicinc.com>
Date:   Thu, 2 Jun 2022 09:14:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 3/3] selftests/ftrace: add test case for GRP/ only
 input
Content-Language: en-US
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
References: <1653978552-18637-1-git-send-email-quic_linyyuan@quicinc.com>
 <1653978552-18637-4-git-send-email-quic_linyyuan@quicinc.com>
 <20220601235744.93ba3c80951680c3d6bb6961@kernel.org>
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
In-Reply-To: <20220601235744.93ba3c80951680c3d6bb6961@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Masami,

thanks for review, will update your comment in next V4.

thanks

On 6/1/2022 10:57 PM, Masami Hiramatsu (Google) wrote:
> Hi Linyu,
>
> On Tue, 31 May 2022 14:29:12 +0800
> Linyu Yuan <quic_linyyuan@quicinc.com> wrote:
>
>> add kprobe and eprobe event test for new GRP/ only format.
>>
>> Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
>> ---
>> v3: first add in this version
>>
>>   .../testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc  | 7 ++++++-
>>   .../testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc  | 7 ++++++-
>>   2 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
>> index 60c02b4..97856df 100644
>> --- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
>> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
>> @@ -1,7 +1,7 @@
>>   #!/bin/sh
>>   # SPDX-License-Identifier: GPL-2.0
>>   # description: Generic dynamic event - add/remove eprobe events
>> -# requires: dynamic_events events/syscalls/sys_enter_openat "e[:[<group>/]<event>] <attached-group>.<attached-event> [<args>]":README
>> +# requires: dynamic_events events/syscalls/sys_enter_openat "e[:[<group>/][<event>]] <attached-group>.<attached-event> [<args>]":README
> Hmm, this is too restricted. With this change, this entire test only runs after
> patching this series.
> Can you change the requires so that skip checking the first half, like
>    "<attached-group>.<attached-event> [<args>]":README
> and check whether "e[:[<group>/][<event>]]" is in the README for the new
> test code?
>   
>>   echo 0 > events/enable
>>   
>> @@ -87,4 +87,9 @@ echo "-:eprobes/$EPROBE $SYSTEM/$EVENT $OPTIONS" >> dynamic_events
>>   ! grep -q "$EPROBE" dynamic_events
>>   ! test -d events/eprobes/$EPROBE
>>   
>> +echo "e:mygroup/ $SYSTEM/$EVENT $OPTIONS" >> dynamic_events
>> +test -d events/mygroup
>> +echo "-:mygroup/" >> dynamic_events
>> +! test -d events/mygroup
>> +
>>   clear_trace
>> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
>> index b4da41d..6b102a7 100644
>> --- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
>> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
>> @@ -1,7 +1,7 @@
>>   #!/bin/sh
>>   # SPDX-License-Identifier: GPL-2.0
>>   # description: Generic dynamic event - add/remove kprobe events
>> -# requires: dynamic_events "place: [<module>:]<symbol>":README "place (kretprobe): [<module>:]<symbol>":README
>> +# requires: dynamic_events "p[:[<group>/][<event>]] <place> [<args>]":README
> Ditto. In this case, don't touch the requires line (because it is not
> updated) and just add a README check for below new code.
>
> Thank you,
>
>
>>   
>>   echo 0 > events/enable
>>   echo > dynamic_events
>> @@ -23,4 +23,9 @@ grep -q myevent1 dynamic_events
>>   
>>   echo > dynamic_events
>>   
>> +echo "p:mygroup/ $PLACE" >> dynamic_events
>> +test -d events/mygroup
>> +echo "-:mygroup/" >> dynamic_events
>> +! test -d events/mygroup
>> +
>>   clear_trace
>> -- 
>> 2.7.4
>>
>
