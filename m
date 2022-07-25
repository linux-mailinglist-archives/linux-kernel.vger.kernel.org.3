Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6575F580454
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 21:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbiGYTPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 15:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiGYTPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 15:15:04 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFC1BCAA;
        Mon, 25 Jul 2022 12:15:02 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26PET4Yi008169;
        Mon, 25 Jul 2022 19:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=4h+8hEAjbD14D26rOJM7NwZ8Wa7MWwunf6lkCqVhy6Q=;
 b=jlkZDPpZ9BnPy37pR2U5vLoVYVnfe67LBejfTDZR+zmnI6ObYG6PYpYQ6Ih6mavVyFjU
 hWuHQr8OlVRux2+raLw6vf+pwtD9iiP55wJqiWZEtvaCz071rrsXbvrDAl+HixkuXM7l
 HSecRtobkj2Cxz8XL5OG3Dwzo+1tKL6C96FLtEc7rh17NVMYwXnA/h5DQPCRF0VW2bFi
 y0n+iARpF1xfs9gIkFAwLQQ5zp6yjMIu2HItqSoAgJ2e8TT9unB0BIXyVLVDa/0J2S1H
 YlLHQhOt7QuRwZTDTSh3MXKw/2ri32UsDA3W/Y/q17r13DWK/GOpwIxrvWjdzMvu+Rov OA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hg80engds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 19:14:57 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26PJEuZ8010547
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 19:14:56 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 25 Jul 2022 12:14:56 -0700
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 25 Jul 2022 12:14:55 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <corbet@lwn.net>, <sre@kernel.org>, <robh+dt@kernel.org>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH v4 0/2] add support for PON GEN3 device
Date:   Mon, 25 Jul 2022 12:13:13 -0700
Message-ID: <20220725191314.19456-1-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 50okRts9h7QeDLK_nAsJ0H1J4RE9SdHz
X-Proofpoint-ORIG-GUID: 50okRts9h7QeDLK_nAsJ0H1J4RE9SdHz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_12,2022-07-25_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 mlxscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207250079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v3:
  - Addressed Krysztof's comments on patch 1/2
    - Added missing minItems/maxItems
    - Merged if statments with same constraints together
    - Removed description from "reg-names"
    
Changes from v2:
  - Added new "qcom,pmk8350-pon" compatible string as per Krysztof's
    advice
  - Updated dt logic to use comptaible strings to decide constraints
    as per Krysztof's comment
  - Added new patch (v3 2/2) to support new compatible string

Changes from v1:
  - Updated path which was missing Documentation/devicetree prefix
  - Updated CC list

New patch series to seperate this patch from applied patches.
Comments from original patch can be found
https://lore.kernel.org/linux-arm-msm/27515993-18f3-8891-4835-9b6a8d7f86b0@quicinc.com/

David Collins (1):
  dt-bindings: power: reset: qcom-pon: update "reg" property details

Anjelique Melendez (1):
  power: reset: qcom-pon: add support for qcom,pmk8350-pon compatible string

 Documentation/devicetree/bindings/power/reset/qcom,pon.yaml | 50 +++++++++++++++++++++++++++---
 drivers/power/reset/qcom-pon.c | 1 +
 2 file changed, 47 insertions(+), 4 deletions(-)

-- 
2.35.1

