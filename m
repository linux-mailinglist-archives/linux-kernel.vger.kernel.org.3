Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56309530E47
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbiEWJYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbiEWJYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:24:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DD12483A8;
        Mon, 23 May 2022 02:24:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9EA0ED1;
        Mon, 23 May 2022 02:24:40 -0700 (PDT)
Received: from [10.57.34.201] (unknown [10.57.34.201])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F0E13F73D;
        Mon, 23 May 2022 02:24:38 -0700 (PDT)
Message-ID: <c6c37c9c-c68d-a945-d4df-526212924678@arm.com>
Date:   Mon, 23 May 2022 10:24:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v7 04/10] coresight-tpdm: Add DSB dataset support
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20220509133947.20987-1-quic_jinlmao@quicinc.com>
 <20220509133947.20987-5-quic_jinlmao@quicinc.com>
 <00c30f02-de4e-6bd1-f220-00ae114ef91f@arm.com>
In-Reply-To: <00c30f02-de4e-6bd1-f220-00ae114ef91f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2022 10:11, Suzuki K Poulose wrote:
> Hi
> 
> On 09/05/2022 14:39, Mao Jinlong wrote:
>> TPDM serves as data collection component for various dataset types.
>> DSB(Discrete Single Bit) is one of the dataset types. DSB subunit
>> can be enabled for data collection by writing 1 to the first bit of
>> DSB_CR register. This change is to add enable/disable function for
>> DSB dataset by writing DSB_CR register.
> 
> The patch looks good to me, except for some minor comment below.
> 
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-tpdm.c | 58 ++++++++++++++++++++
>>   drivers/hwtracing/coresight/coresight-tpdm.h | 23 ++++++++
>>   2 files changed, 81 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>> index 6a4e2a35053d..70df888ac565 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -20,7 +20,28 @@
>>   DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
>> +static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>> +{
>> +    u32 val;
>> +
>> +    /* Set the enable bit of DSB control register to 1 */
>> +    val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
>> +    val |= TPDM_DSB_CR_ENA;
>> +    writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
>> +}
>> +



>>   /* TPDM enable operations */
>> +static void _tpdm_enable(struct tpdm_drvdata *drvdata)


>>   /* TPDM disable operations */
>> +static void _tpdm_disable(struct tpdm_drvdata *drvdata)

Missed this. The general convention is to use:

__tpdm_disable()
__tpdm_enable();

So, please switch to the names above.

Suzuki
