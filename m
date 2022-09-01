Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78035AA06A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbiIATvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbiIATvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:51:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E027A27FC5;
        Thu,  1 Sep 2022 12:51:04 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 281Jopnd029250;
        Thu, 1 Sep 2022 19:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7GuCFAoovORTcSpNtNYYzOR3vGaNMS7KdBKlD9RkxfU=;
 b=N0xFMFZ3j9qZGc72DcoI3ok/oFy96h7s4x+bE2LvpsX3b1cdYoExaXPfpYvOt7GvjmK0
 fV8BGpMaOLguVM0qziFZscV1epSASU68yiNHxQ6OX6B0TO2z9DvT0ecwwyS0Iv1NTVGc
 RtNC0IFZaxvIOO1L6Pl/VFZkuDL2dhqJz3RpIoDYYQpynHGrlDPupXQLW30n6hSINQHq
 B0f7m2TjnbVmYJJ5oxM0mogjayF71CkTHJXazBlq07QjGFOnYM7+Awg9L+im2zGHOaxc
 hgZqZdQlkTLyN4Yj577tFPmLLGEU3ODV4YaP5Q/K+sXNd6cOWYl7Arn28XdM+ecjjJxC zA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jashfa5q3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 19:50:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 281Jonhd001892
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Sep 2022 19:50:49 GMT
Received: from [10.216.21.90] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 1 Sep 2022
 12:50:44 -0700
Message-ID: <c00b9174-c4b4-1324-5e5a-121fe463ba14@quicinc.com>
Date:   Fri, 2 Sep 2022 01:20:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [Freedreno] [PATCH v6 2/6] clk: qcom: Allow custom reset ops
Content-Language: en-US
To:     Philipp Zabel <p.zabel@pengutronix.de>
CC:     Stephen Boyd <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Douglas Anderson <dianders@chromium.org>,
        <dri-devel@lists.freedesktop.org>,
        Stephen Boyd <swboyd@chromium.org>,
        <krzysztof.kozlowski@linaro.org>, Rob Clark <robdclark@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1661923108-789-1-git-send-email-quic_akhilpo@quicinc.com>
 <20220831104741.v6.2.I75baff799a363bbb960376539e3a0f737377c3f1@changeid>
 <20220901101734.GA32271@pengutronix.de>
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <20220901101734.GA32271@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Yo4DIjGhol3YIwhVzINeDvANwqw8jInw
X-Proofpoint-ORIG-GUID: Yo4DIjGhol3YIwhVzINeDvANwqw8jInw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010086
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/2022 3:47 PM, Philipp Zabel wrote:
> Hi Akhil,
>
> On Wed, Aug 31, 2022 at 10:48:23AM +0530, Akhil P Oommen wrote:
>> Allow soc specific clk drivers to specify a custom reset operation. We
>> will use this in an upcoming patch to allow gpucc driver to specify a
>> differet reset operation for cx_gdsc.
>>
>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>
>> (no changes since v3)
>>
>> Changes in v3:
>> - Use pointer to const for "struct qcom_reset_ops" in qcom_reset_map (Krzysztof)
>>
>> Changes in v2:
>> - Return error when a particular custom reset op is not implemented. (Dmitry)
>>
>>   drivers/clk/qcom/reset.c | 27 +++++++++++++++++++++++++++
>>   drivers/clk/qcom/reset.h |  8 ++++++++
>>   2 files changed, 35 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/reset.c b/drivers/clk/qcom/reset.c
>> index 819d194..b7ae4a3 100644
>> --- a/drivers/clk/qcom/reset.c
>> +++ b/drivers/clk/qcom/reset.c
>> @@ -13,6 +13,21 @@
>>   
>>   static int qcom_reset(struct reset_controller_dev *rcdev, unsigned long id)
>>   {
>> +	struct qcom_reset_controller *rst;
>> +	const struct qcom_reset_map *map;
>> +
>> +	rst = to_qcom_reset_controller(rcdev);
>> +	map = &rst->reset_map[id];
>> +
>> +	if (map->ops && map->ops->reset)
>> +		return map->ops->reset(map->priv);
>> +	/*
>> +	 * If custom ops is implemented but just not this callback, return
>> +	 * error
>> +	 */
>> +	else if (map->ops)
>> +		return -EOPNOTSUPP;
>> +
> It doesn't seem necessary to stack reset_ops -> qcom_reset_ops for what
> you need here.
> Just add an optional const struct reset_ops * to qcom_cc_desc and feed
> that into qcom_cc_really_probe to replace &qcom_reset_ops.
>
> [...]
>> +struct qcom_reset_ops {
>> +	int (*reset)(void *priv);
>> +	int (*assert)(void *priv);
>> +	int (*deassert)(void *priv);
> Why add assert and deassert ops? There doesn't seem to be any user.
I had a more minimal implementation in v1. But this makes it more 
complete and make it less prone to trip up ourselves in future.
>
>> +};
>> +
>>   struct qcom_reset_map {
>>   	unsigned int reg;
>>   	u8 bit;
>> +	const struct qcom_reset_ops *ops;
>> +	void *priv;
> Adding per-reset ops + priv counters seems excessive to me.
>
> Are you expecting different reset controls in the same reset controller
> to have completely different ops at some point? If so, I would wonder
> whether it wouldn't be better to split the reset controller in that
> case. Either way, for the GDSC collapse workaround this does not seem
> to be required at all.
Yes, like I responded in patch 4, we need different ops for the same 
reset controller in some gpucc implementations.
For eg: 
https://elixir.bootlin.com/linux/v6.0-rc3/source/drivers/clk/qcom/gpucc-sdm660.c

-Akhil
>
> regards
> Philipp

