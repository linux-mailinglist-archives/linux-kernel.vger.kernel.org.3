Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789F958E67E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 06:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiHJE5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 00:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiHJE53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 00:57:29 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5349582FA9;
        Tue,  9 Aug 2022 21:57:27 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27A3MZHF025226;
        Wed, 10 Aug 2022 04:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=b3lHvo5NSq1RBNlMVkqgqy4ALKo8tFbviurkS4jAHoA=;
 b=KJlYokbay6Y25NnG0UtPXagG+StIK/mw40thO+ftoG3B6VTjAXN17Z+IS9cneMjD62b2
 SNyNyR/tG8wO/R/UsTB/L4Jiaiwz+JrqVtoB+AR7RmWqMT4WW8ZfGGUw8AVqub1Ed5Tu
 Up6o/Xg3++/0slisEeAqlZU7qbYsNyRjnDsWqgTZS4iqfCNLfWacMIas6BMWBh5DePqm
 xVZA1b5P5lF6fP0cZ+U1t2Z+E+F2g41UVyQMeAlZryvGWgQuGoYt0CrAAjnoIWNOhVAo
 N21Iq/1Wk546CieteCG/uuKxjOzXll/IpRMzybv/iIackd+iGfgC5DCkXWHVHIXubqVN zQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3huwr8s825-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 04:57:19 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27A4vITY031378
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 04:57:18 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 9 Aug 2022 21:57:18 -0700
Received: from [10.79.136.17] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 9 Aug 2022
 21:57:16 -0700
Message-ID: <3d5586c8-5d60-a127-e2b3-6072c0610209@quicinc.com>
Date:   Wed, 10 Aug 2022 10:27:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] soc: qcom: rpmhpd: Use highest corner until sync_state
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
References: <20220806155035.968340-1-bjorn.andersson@linaro.org>
 <cb0c6fbd-bf5c-b5ce-b4c5-8a605836204d@quicinc.com> <YvLJsm29h8eQwaQc@baldur>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <YvLJsm29h8eQwaQc@baldur>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dyQNzwbjFeI0Zj8RVmf2WbPIJ7BaJ8Ln
X-Proofpoint-ORIG-GUID: dyQNzwbjFeI0Zj8RVmf2WbPIJ7BaJ8Ln
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_01,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208100014
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/10/2022 2:25 AM, Bjorn Andersson wrote:
> On Mon 08 Aug 03:17 CDT 2022, Rajendra Nayak wrote:
> 
>>
>> On 8/6/2022 9:20 PM, Bjorn Andersson wrote:
>>> In some cases the hardware that the bootloader has left configured
>>> depends on RPMH power domains for their operation up until the point
>>> where the related Linux device driver probes and can inherit that
>>> configuration, or power down the hardware gracefully.
>>>
>>> Unfortunately as Linux probes the releavant drivers in sequence there
>>> are periods during the Linux boot flow where either the genpd refcount
>>> will reach 0, or worse where the active performance_state votes does not
>>> meet the requirements of the state that the hardware was left in.
>>>
>>> One specific example of this is during boot of e.g. SM8150/SC8180X,
>>> where the display clock controller probes, without any particular
>>> performance state needs (to access its registers). This will drop the
>>> MMCX rail to MIN_SVS, which isn't sufficient to sustain the clock rates
>>> that the later probing MDP is configured to. This results in an
>>> unrecoverable system state.
>>>
>>> Handle both these cases by keeping the RPMH power-domais that are
>>> referenced voted for highest state, until sync_state indicates that all
>>> devices referencing the RPMH power-domain driver has been probed.
>>>
>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>> ---
>>>    drivers/soc/qcom/rpmhpd.c | 35 ++++++++++++++++++++++++++++++++++-
>>>    1 file changed, 34 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
>>> index 092f6ab09acf..494bb6c75ed7 100644
>>> --- a/drivers/soc/qcom/rpmhpd.c
>>> +++ b/drivers/soc/qcom/rpmhpd.c
>>> @@ -39,6 +39,7 @@
>>>     * @res_name:		Resource name used for cmd-db lookup
>>>     * @addr:		Resource address as looped up using resource name from
>>>     *			cmd-db
>>> + * @state_synced:       Indicator that sync_state has been invoked for the rpmhpd resource
>>>     */
>>>    struct rpmhpd {
>>>    	struct device	*dev;
>>> @@ -54,6 +55,7 @@ struct rpmhpd {
>>>    	bool		enabled;
>>>    	const char	*res_name;
>>>    	u32		addr;
>>> +	bool		state_synced;
>>>    };
>>>    struct rpmhpd_desc {
>>> @@ -493,7 +495,13 @@ static int rpmhpd_aggregate_corner(struct rpmhpd *pd, unsigned int corner)
>>>    	unsigned int this_active_corner = 0, this_sleep_corner = 0;
>>>    	unsigned int peer_active_corner = 0, peer_sleep_corner = 0;
>>> -	to_active_sleep(pd, corner, &this_active_corner, &this_sleep_corner);
>>> +	if (pd->state_synced) {
>>> +		to_active_sleep(pd, corner, &this_active_corner, &this_sleep_corner);
>>> +	} else {
>>> +		/* Clamp to highest corner if sync_state hasn't happened */
>>> +		this_active_corner = pd->level_count - 1;
>>> +		this_sleep_corner = pd->level_count - 1;
>>> +	}
>>>    	if (peer && peer->enabled)
>>>    		to_active_sleep(peer, peer->corner, &peer_active_corner,
>>> @@ -708,11 +716,36 @@ static int rpmhpd_probe(struct platform_device *pdev)
>>>    	return of_genpd_add_provider_onecell(pdev->dev.of_node, data);
>>>    }
>>> +static void rpmhpd_sync_state(struct device *dev)
>>> +{
>>> +	const struct rpmhpd_desc *desc = of_device_get_match_data(dev);
>>> +	struct rpmhpd **rpmhpds = desc->rpmhpds;
>>> +	unsigned int corner;
>>> +	struct rpmhpd *pd;
>>> +	unsigned int i;
>>> +
>>> +	mutex_lock(&rpmhpd_lock);
>>> +	for (i = 0; i < desc->num_pds; i++) {
>>> +		pd = rpmhpds[i];
>>> +		if (!pd)
>>> +			continue;
>>> +
>>> +		pd->state_synced = true;
>> []
>>
>>> +		if (pd->enabled)
>>> +			corner = max(pd->corner, pd->enable_corner);
>>> +		else
>>> +			corner = 0;
>>> +		rpmhpd_aggregate_corner(pd, corner);
>>
>> can't this be
>> 		if (pd->enabled) {
>> 			corner = max(pd->corner, pd->enable_corner);
>> 			rpmhpd_aggregate_corner(pd, corner);
>> 		}
> 
> Please correct me if I'm wrong, but that would imply that if the
> power-domain was disabled by all clients when we hit the sync_state we
> would be left at max state until one of them tickles it again.
> 
> The way it's written here means that in addition to keeping things at
> the highest corner we also keep it on until sync_state hits - but no
> longer.

ah, that's right, seems like the right thing to do.

>>
>> also, we do check for return value of rpmhpd_aggregate_corner() but I guess
>> here there isn't much different we would do even if there is an error?
>>
> 
> You're right, ignoring the return value here means that an error would
> be completely silent. There's not much we can do about it, but it might
> be useful to the developer to know that this happened.
> 
> So a dev_err() seems in order.
> 
> Thanks,
> Bjorn
> 
>>> +	}
>>> +	mutex_unlock(&rpmhpd_lock);
>>> +}
>>> +
>>>    static struct platform_driver rpmhpd_driver = {
>>>    	.driver = {
>>>    		.name = "qcom-rpmhpd",
>>>    		.of_match_table = rpmhpd_match_table,
>>>    		.suppress_bind_attrs = true,
>>> +		.sync_state = rpmhpd_sync_state,
>>>    	},
>>>    	.probe = rpmhpd_probe,
>>>    };
