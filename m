Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA285953B1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiHPHZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiHPHZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:25:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265AC174190;
        Mon, 15 Aug 2022 20:41:39 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27G1UcRN027224;
        Tue, 16 Aug 2022 03:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BsK9PeAq/h1GT35Lqur6CpEoN9c/zvD5S37RYKxNAOs=;
 b=FuK8LNwRixMaTm7/FOrgQYi5TW/PkeYN4cm53kx7UzsI7QY02HrTN0jmiBmPM43vaBs2
 QA0RLLGPR4gKCrf90R31vP1UKu21nomqusZ5GmYLoOS6a3Rpn8Z9IZSAR+yjJLiZMIm5
 J6pyn5hPiGkWs9d/g6t2tMPrNRdbzshcvexqgaWYyzykuRH897uBcjEbr+wEGhFWLCGg
 f5F6SbIBEcGFjmibzenABsA+y+ftOucOMK4gpF3TN7BxTqSwaquKBqnfNNJteEPz5tKi
 u+kdtsDGjLJw3koMVL+qIgw46rHoxBC5K3xKNXQW3PYBQvRaJU80bBjhhLv8pJrSdK6b Ww== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hx4bdqc30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 03:41:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27G3fY11030286
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 03:41:34 GMT
Received: from [10.50.22.158] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 15 Aug
 2022 20:41:30 -0700
Message-ID: <6f9fb41b-abe4-3a98-d19b-7e814ef3f238@quicinc.com>
Date:   Tue, 16 Aug 2022 09:11:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V15 6/9] mfd: pm8008: Use i2c_new_dummy_device() API
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
CC:     Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_collinsd@quicinc.com>,
        <quic_subbaram@quicinc.com>, <quic_jprakash@quicinc.com>,
        Lee Jones <lee@kernel.org>
References: <Yr6oLlmfWRkiAZG7@google.com> <Yr66ZZqEnBApHYMA@google.com>
 <0481d3cc-4bb9-4969-0232-76ba57ff260d@quicinc.com>
 <YsLhxx+L3+GJDRyO@google.com>
 <bcc5f059-b991-296a-bba6-9cb1236097f2@quicinc.com>
 <Ys1tYAO39LKzEAOE@google.com>
 <dc737abb-041b-491a-14f1-a584f9e64a3d@quicinc.com>
 <CAE-0n528QaTtZFp=WAaHShegFRpKVN_67jQfUJTtsRPr6s--zA@mail.gmail.com>
 <52039cd1-4390-7abb-d296-0eb7ac0c3b15@quicinc.com>
 <Yuz2O+lZ5W7RviuA@google.com>
 <CAE-0n507SLeYB7XVzGFk=RO6YjOPoGpux+_N2AyrmL354mQJ-g@mail.gmail.com>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
In-Reply-To: <CAE-0n507SLeYB7XVzGFk=RO6YjOPoGpux+_N2AyrmL354mQJ-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VcpnfY2ZLDm5pbgyNLP8bSqBVkrYYHr6
X-Proofpoint-GUID: VcpnfY2ZLDm5pbgyNLP8bSqBVkrYYHr6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=947 spamscore=0 bulkscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208160013
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,


Could you please share your thoughts on this?


On 8/9/2022 12:39 AM, Stephen Boyd wrote:
> Quoting Lee Jones (2022-08-05 03:51:39)
>
>>>> I was happy with the previous version of the DT node. That had one node
>>>> for the "pm8008 chip", which is important because it really is one
>>>> package. Why isn't that possible to implement and also register i2c
>>>> devices on the i2c bus for the second address?
>> If devices have different addresses, they should have their own nodes, no?
> There are nodes for the devices at different addresses in the design we
> had settled on earlier.
>
>          pm8008: pmic@8 {
>                  compatible = "qcom,pm8008";
>                  reg = <0x8>;
>                  #address-cells = <2>;
>                  #size-cells = <0>;
>                  #interrupt-cells = <2>;
>
>                  pm8008_l1: ldo1@1,4000 {
>                          compatible = "qcom,pm8008-regulator";
>                          reg = <0x1 0x4000>;
>                          regulator-name = "pm8008_ldo1";
>                  };
>
> 		...
>
> 	};
>
> pmic@8 is the i2c device at i2c address 8. ldo1@1,4000 is the i2c device
> at address 9 (8 + 1) with control for ldo1 at register offset 0x4000.
>
> I think your concern is more about the fact that the regulator sub-nodes
> are platform device drivers instead of i2c device drivers. I'm not an
> i2c expert but from what I can tell we only describe one i2c address in
> DT and then do something like this to describe the other i2c addresses
> when one physical chip responds to multiple addresses on the i2c bus.
> See i2c_new_dummy_device() and i2c_new_ancillary_device() kerneldoc for
> slightly more background.
>
> It may need some modifications to the i2c core to make the regulator
> nodes into i2c devices. I suspect the qcom,pm8008 i2c driver needs to
> look at the 'reg' property and translate that to the parent node's reg
> property (8) plus the first cell (1) to determine the i2c device's final
> i2c address. Then the i2c core needs to register i2c devices that are
> bound to the lifetime of the "primary" i2c device (pmic@8). The driver
> for the regulator can parse the second cell of the reg property to
> determine the register offset within that i2c address to use to control
> the regulator. That would make it possible to create an i2c device for
> each regulator node, but I don't think that is correct because the
> second reg property isn't an i2c address, it's a register offset inside
> the i2c address.
>
> It sort of looks like we need to use i2c_new_ancillary_device() here. IF
> we did that the DT would look like this:
>
>          pm8008: pmic@8 {
>                  compatible = "qcom,pm8008";
>                  reg = <0x8>, <0x9>;
> 		reg-names = "core", "regulators";
>                  #address-cells = <2>;
>                  #size-cells = <0>;
>                  #interrupt-cells = <2>;
>
>                  pm8008_l1: ldo1@1,4000 {
>                          compatible = "qcom,pm8008-regulator";
>                          reg = <0x1 0x4000>;
>                          regulator-name = "pm8008_ldo1";
>                  };
>
> 		...
>
> 	};
>
> And a dummy i2c device would be created for i2c address 0x9 bound to the
> dummy i2c driver when we called i2c_new_ancillary_device() with
> "regulators" for the name. The binding of the dummy driver is preventing
> us from binding another i2c driver to the i2c address. Why can't we call
> i2c_new_client_device() but avoid binding a dummy driver to it like
> i2c_new_ancillary_device() does? If that can be done, then the single
> i2c device at 0x9 can be a pm8008-regulators (plural) device that probes
> a single i2c driver that parses the subnodes looking for regulator
> nodes.
>
> Note: There is really one i2c device at address 0x9, that corresponds to
> the regulators, but in DT we need to have one node per regulator so we
> can configure constraints.
