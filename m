Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3555A4B5AD2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 21:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiBNUFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 15:05:31 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiBNUF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:05:29 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DBE1A3768;
        Mon, 14 Feb 2022 12:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644869110; x=1676405110;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GFe66AWLT+MQYAQ2dAVPVsypw1KVTvBSrIl/sWoPZfA=;
  b=FyWJAbI+/JzzL7QCZC/oAPiCVqdFhDxMVbArs2ebLRfOLD5amJxN7E8I
   co9/C9cCTdWj2JOZu7jaRObF+UT3rP+/iELXGdjV1qeMy2JB7WZvTVsGa
   Rbz2YbVQDd356cyuxHIo/PxmGS/uLqqYLskBS7en0qwalS3D0K/K+JVBh
   w=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 14 Feb 2022 12:00:14 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 12:00:14 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 14 Feb 2022 12:00:13 -0800
Received: from [10.216.29.10] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 14 Feb
 2022 12:00:09 -0800
Message-ID: <c02d28ce-bef4-0b71-e90a-991ef4fae9d3@quicinc.com>
Date:   Tue, 15 Feb 2022 01:30:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v5] drivers: thermal: clear all mitigation when thermal
 zone is disabled
To:     Lukasz Luba <lukasz.luba@arm.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Amit Kucheria" <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
References: <1643307093-22501-1-git-send-email-quic_manafm@quicinc.com>
 <4024218b-7938-e181-f456-bff4b3fb157a@arm.com>
From:   Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
In-Reply-To: <4024218b-7938-e181-f456-bff4b3fb157a@arm.com>
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


On 1/31/2022 12:55 PM, Lukasz Luba wrote:
> Hi Manaf,
>
> On 1/27/22 6:11 PM, Manaf Meethalavalappu Pallikunhi wrote:
>> Whenever a thermal zone is in trip violated state, there is a chance
>> that the same thermal zone mode can be disabled either via
>> thermal core API or via thermal zone sysfs. Once it is disabled,
>> the framework bails out any re-evaluation of thermal zone. It leads
>> to a case where if it is already in mitigation state, it will stay
>> the same state forever.
>>
>> To avoid above mentioned issue, add support to bind/unbind
>> governor from thermal zone during thermal zone mode change request
>> and clear all existing throttling in governor unbind_from_tz()
>> callback.
>
> I have one use case:
> This would be a bit dangerous, e.g. to switch governors while there is a
> high temperature. Although, sounds reasonable to left a 'default' state
> for a next governor.
>
I believe only way to change the governror via userspace at runtime.

Just re-evaluate thermal zone  (thermal_zone_device_update) immediately  
after

thermal_zone_device_set_policy()  in same policy_store() context, isn't 
it good enough ?

Not sure how a "default" state  can be reverted once governor change is 
done.

Re-evaluating thermal zone doesn't guarantee that it will recover previous

set default state for all governors, right ?

>>
>> Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Signed-off-by: Manaf Meethalavalappu Pallikunhi 
>> <quic_manafm@quicinc.com>
>> ---
>>   drivers/thermal/gov_power_allocator.c |  3 +++
>>   drivers/thermal/gov_step_wise.c       | 26 ++++++++++++++++++++++++++
>>   drivers/thermal/thermal_core.c        | 31 
>> +++++++++++++++++++++++++++----
>>   3 files changed, 56 insertions(+), 4 deletions(-)
>
> Why only two governors need that change and not all?
> Because they don't have 'bind/unbind' callbacks, then maybe we should
> change that as well to make it consistent?
I will update other governors as well in v6
>
> Regards,
> Lukasz
