Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546DC481089
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 07:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbhL2GxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 01:53:06 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:26640 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229807AbhL2GxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 01:53:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640760786; x=1672296786;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ufkN8F8jUwn12NCyF940qBL0NdqCnffF+m6Y42RDBvc=;
  b=C2yPZWs207HsAeLxNAXs7fbCG/WKevmPoyvIcHMKBgobzl4ZVtGTrwBl
   BmA++8ltT6tvgRPztpDPQWUi4xLx8libQagtZ1/kcXV9dCiCDvnuvoFK9
   yVtLB91BVXbtaGKqa/8G57N3OMLzkHPJPX8q3+ZK0/zS1sQNdGvQcq96G
   0=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Dec 2021 22:53:05 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 22:53:05 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 28 Dec 2021 22:53:05 -0800
Received: from [10.216.19.24] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 28 Dec
 2021 22:53:01 -0800
Message-ID: <cf6cfba0-816f-ca1e-3bb1-aad693e5a0b3@quicinc.com>
Date:   Wed, 29 Dec 2021 12:22:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] thermal/core: Clear all mitigation when thermal zone is
 disabled
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1640083318-19277-1-git-send-email-quic_manafm@quicinc.com>
 <YcSNIJVnCQvx6ttg@google.com>
From:   Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
In-Reply-To: <YcSNIJVnCQvx6ttg@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/23/2021 8:22 PM, Matthias Kaehlcke wrote:
> On Tue, Dec 21, 2021 at 04:11:58PM +0530, Manaf Meethalavalappu Pallikunhi wrote:
>> Whenever a thermal zone is in trip violated state, there is a chance
>> that the same thermal zone mode can be disabled either via thermal
>> core API or via thermal zone sysfs. Once it is disabled, the framework
>> bails out any re-evaluation of thermal zone. It leads to a case where
>> if it is already in mitigation state, it will stay the same state
>> until it is re-enabled.
>>
>> To avoid above mentioned issue, on thermal zone disable request
>> reset thermal zone and clear mitigation for each trip explicitly.
>>
>> Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
>> ---
>>   drivers/thermal/thermal_core.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index 51374f4..a8ae340 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -427,6 +427,7 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
>>   					enum thermal_device_mode mode)
>>   {
>>   	int ret = 0;
>> +	int count;
>>   
>>   	mutex_lock(&tz->lock);
>>   
>> @@ -449,8 +450,14 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
>>   
>>   	if (mode == THERMAL_DEVICE_ENABLED)
>>   		thermal_notify_tz_enable(tz->id);
>> -	else
>> +	else {
>> +		/* make sure all previous throttlings are cleared */
>> +		thermal_zone_device_init(tz);
>> +		for (count = 0; count < tz->trips; count++)
>> +			handle_thermal_trip(tz, count);
> nit: s/count/trip/
Updated in V2
