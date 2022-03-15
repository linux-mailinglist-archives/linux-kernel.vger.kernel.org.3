Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0624D9670
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346070AbiCOIiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346165AbiCOIiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:38:07 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EA547554;
        Tue, 15 Mar 2022 01:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647333415; x=1678869415;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n0A3plTvIIoubhjtpKetM9js3bT0UPpG0+z4b0bbcEY=;
  b=Ms1c+8bbM6HP8ff/HwcDHRy9HmAijJJqRo7kIi44QcQKWnH8LmT7P4/f
   r5FTZ+CaT5R7cfA9SkU0kUYxoPhq2oYjw2d6wTSAW9ne798nBbZMQnD+z
   zbXubvT4jpA99crrQevNU4lCVpGcb7CaGDklQ8GUJu0ZoTaa3CZw8AqDL
   g=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Mar 2022 01:36:55 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 01:36:55 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Mar 2022 01:36:54 -0700
Received: from [10.253.9.165] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 15 Mar
 2022 01:36:51 -0700
Message-ID: <9cbb2e86-640f-4b5d-22ff-00c63a1b9743@quicinc.com>
Date:   Tue, 15 Mar 2022 16:36:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v3] coresight: core: Fix coresight device probe failure
 issue
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Tingwei Zhang" <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
References: <20220309142206.15632-1-quic_jinlmao@quicinc.com>
 <a1790ad9-b5e0-9a00-debc-fc8ef2c757cb@arm.com>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <a1790ad9-b5e0-9a00-debc-fc8ef2c757cb@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

On 3/10/2022 5:10 PM, Suzuki K Poulose wrote:
> Hi Jinlong
>
>
> On 09/03/2022 14:22, Mao Jinlong wrote:
>> It is possibe that probe failure issue happens when the device
>> and its child_device's probe happens at the same time.
>> In coresight_make_links, has_conns_grp is true for parent, but
>> has_conns_grp is false for child device as has_conns_grp is set
>> to true in coresight_create_conns_sysfs_group. The probe of parent
>> device will fail at this condition. Add has_conns_grp check for
>> child device before make the links and make the process from
>> device_register to connection_create be atomic to avoid this
>> probe failure issue.
>>
>> Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Suggested-by: Mike Leach <mike.leach@linaro.org>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>
> Thanks for the rework. The patch looks good to me.
>
> Suzuki
Thanks Suzuki.

Hi Mathieu & Mike,

Could you please help to review and provide your comments for the PATCH V3 ?

Thanks
Jinlong Mao
