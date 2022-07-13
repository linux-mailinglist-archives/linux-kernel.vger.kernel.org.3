Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAF8573143
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbiGMIhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbiGMIhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:37:18 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92152C48C3;
        Wed, 13 Jul 2022 01:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657701436; x=1689237436;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TwuPam4BS9UKOoy0JogxR8Q0k598YrPB4nNp1nN5o3I=;
  b=q7XWkzKAjdbc6cSQUxhumh7lHQx62vkywmC1ossbZ8TvBH+EEOz9qfKl
   WhpbsMPL2eKwfoPuhmdcsj7VrtEhizCnF28ICPRndfrvczWZM+ThpV2/C
   xx9wwCanAYaNsGrMu6PgfsiXT1MqiMOZZ8VYNlwKG+vY68y1Ek+o7nv1T
   o=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Jul 2022 01:37:16 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 01:37:15 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Jul 2022 01:37:15 -0700
Received: from [10.216.9.126] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 13 Jul
 2022 01:37:12 -0700
Message-ID: <a4f9eefd-79fc-e9cf-88b8-efef424fb7c9@quicinc.com>
Date:   Wed, 13 Jul 2022 14:07:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] PM: QoS: Add check to make sure CPU freq is non-negative
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220623064605.2538969-1-quic_kshivnan@quicinc.com>
 <CAJZ5v0hX6H1Z-2bAJvV92YO95N_D=uNotVxJRcA9cmGQwsr1fQ@mail.gmail.com>
From:   Shivnandan Kumar <quic_kshivnan@quicinc.com>
In-Reply-To: <CAJZ5v0hX6H1Z-2bAJvV92YO95N_D=uNotVxJRcA9cmGQwsr1fQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,


Thanks for taking the time to review my patch and providing feedback.

Please find answer inline.

Thanks,

Shivnandan

On 7/13/2022 12:07 AM, Rafael J. Wysocki wrote:
> On Thu, Jun 23, 2022 at 8:47 AM Shivnandan Kumar
> <quic_kshivnan@quicinc.com> wrote:
>>          CPU frequency should never be negative.
> Do you mean "always be non-negative"?
Yes,corrected subject now.
>
>>          If some client driver calls freq_qos_update_request with some
>>          value greater than INT_MAX, then it will set max CPU freq at
>>          fmax but it will add plist node with some negative priority.
>>          plist node has priority from INT_MIN (highest) to INT_MAX
>>          (lowest). Once priority is set as negative, another client
>>          will not be able to reduce max CPU frequency. Adding check
>>          to make sure CPU freq is non-negative will fix this problem.
>> Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
>>
>> ---
>>   kernel/power/qos.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
>> index ec7e1e85923e..41e96fe34bfd 100644
>> --- a/kernel/power/qos.c
>> +++ b/kernel/power/qos.c
>> @@ -531,7 +531,8 @@ int freq_qos_add_request(struct freq_constraints *qos,
>>   {
>>          int ret;
>>
>> -       if (IS_ERR_OR_NULL(qos) || !req)
>> +       if (IS_ERR_OR_NULL(qos) || !req || value < FREQ_QOS_MIN_DEFAULT_VALUE
>> +               || value > FREQ_QOS_MAX_DEFAULT_VALUE)
> Why do you check against the defaults?
Want to make sure to guard against negative value.
>
>>                  return -EINVAL;
>>
>>          if (WARN(freq_qos_request_active(req),
>> @@ -563,7 +564,8 @@ EXPORT_SYMBOL_GPL(freq_qos_add_request);
>>    */
>>   int freq_qos_update_request(struct freq_qos_request *req, s32 new_value)
>>   {
>> -       if (!req)
>> +       if (!req || new_value < FREQ_QOS_MIN_DEFAULT_VALUE ||
>> +               new_value > FREQ_QOS_MAX_DEFAULT_VALUE)
>>                  return -EINVAL;
>>
>>          if (WARN(!freq_qos_request_active(req),
>> --
> I agree that it should guard against adding negative values, but I
> don't see why s32 can be greater than INT_MAX.
yes, checking against negative values will be sufficient.
I will share patch v2 with only check against negative values.
>
> Also why don't you put the guard into freq_qos_apply() instead of
> duplicating it in the callers of that function?
Because function  freq_qos_remove_request calls freq_qos_apply with 
PM_QOS_DEFAULT_VALUE which is actually negative.
So I do not want to break that.
