Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0764E6504
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350734AbiCXOY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242197AbiCXOY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:24:58 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E545D5C4;
        Thu, 24 Mar 2022 07:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648131806; x=1679667806;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WWNNb/PA88lHxiO0UiGi9BGlWMjAzl8VpxXqTLSP07I=;
  b=dKDJpdjZypM6pU4tXT85uQtCTWt/hGL8wiQfZs/+EA230h0yXLw7+luT
   Pw9wsul3tqu2u0CldCMUv67MDxz+SH/+tGpDg6UMat3Ge8m2EkZVe4LYu
   WNxoeoM/i7S7U+Ma8/yqSMohN3/+xre5jyi9ToLNddDrZLgL4Os1Jrk0J
   8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Mar 2022 07:23:26 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 07:23:25 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 24 Mar 2022 07:23:25 -0700
Received: from [10.253.74.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 24 Mar
 2022 07:23:21 -0700
Message-ID: <e78ff137-fc5e-ff00-0e57-91304288d860@quicinc.com>
Date:   Thu, 24 Mar 2022 22:23:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v4 01/10] Use IDR to maintain all the enabled sources'
 paths.
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
References: <20220324121734.21531-1-quic_jinlmao@quicinc.com>
 <20220324121734.21531-2-quic_jinlmao@quicinc.com>
 <YjxjXnXAXVXfZqr/@kroah.com>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <YjxjXnXAXVXfZqr/@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Greg,

Thanks for your review.

On 3/24/2022 8:26 PM, Greg Kroah-Hartman wrote:
> On Thu, Mar 24, 2022 at 08:17:25PM +0800, Mao Jinlong wrote:
>> Use hash length of the source's device name to map to the pointer
>> of the enabled path. Using IDR will be more efficient than using
>> the list. And there could be other sources except STM and CPU etms
>> in the new HWs. It is better to maintain all the paths together.
>>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-core.c | 75 +++++++-------------
>>   1 file changed, 26 insertions(+), 49 deletions(-)
> Your subject line is odd.  Please put back the driver subsystem in the
> subject line so that it makes more sense.
I will update the subject in next version.
>
> And how have you measured "more efficient"?

Using IDR would be better than doing a sequential search as there will 
be much more device  in future.

>
> thanks,
>
> greg k-h

Thanks

Jinlong Mao

