Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2A2575131
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239468AbiGNO4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238743AbiGNO4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:56:19 -0400
X-Greylist: delayed 1487 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Jul 2022 07:56:19 PDT
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EDF5C369;
        Thu, 14 Jul 2022 07:56:19 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26EBFpls031152;
        Thu, 14 Jul 2022 14:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=f7RaRgDoZZGQ1vuyDsPSY35GCbn3E4x7n2cFx773AbU=;
 b=hPFEFLXgOWebDJdlCkAGDRrohGCls/EdZo51pwO5FHsUtf5F+V+3DE9wZ++75NrbqwvQ
 dOtR7rUal82ygv/5s2syx/Phe1fygKYse/nr05XwoKJ8JMmQtidDlK8Ia88tr+ikocM4
 laqrp2SXDzx4tvwO87YMFrznweJTN4j/E6Z3eoqjDPV66o/d+nDutGsECvnYEBDyPKGg
 PJe3ecaVkRT8u8MH+VxkCptXHwgLK2Jmj0mjnf1jbAZVhvhqxUqngklk7cvmAukgjgod
 aBJZH7e22aJCbEArKudn1Qtx9trMhdcCDwCH5emrcu8c5wj0A6+MeyLzfKLBHUSJEuS0 4A== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3habdxhen5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 14:31:24 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26EEVNpL000573
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 14:31:23 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Jul 2022 07:31:23 -0700
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Jul 2022 07:31:20 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH] usb: dwc3: qcom: Defer dwc3-qcom probe if dwc3 isn't probed properly
Date:   Thu, 14 Jul 2022 20:01:07 +0530
Message-ID: <1657809067-25815-1-git-send-email-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NTHbb-mJtXegfmadFR-BxpUZlypN0hJH
X-Proofpoint-GUID: NTHbb-mJtXegfmadFR-BxpUZlypN0hJH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_10,2022-07-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 clxscore=1011 phishscore=0
 adultscore=0 mlxscore=0 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207140061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On SC7180 devices, it is observed that dwc3 probing is deferred
because device_links_check_suppliers() finds that '88e3000.phy'
isn't ready yet.

As a part of its probe call, dwc3-qcom driver checks if dwc3 core
is wakeup capable or not. If the dwc3 core is wakeup capable, driver
configures dwc-qcom's power domain to be always ON. Also it configures
dp/dm interrupts accordingly to support wakeup from system suspend.

More info regarding the same can be found at:
commit d9be8d5c5b03 ("usb: dwc3: qcom: Keep power domain on to retain controller status"
commit 6895ea55c385 ("usb: dwc3: qcom: Configure wakeup interrupts during suspend")

In the event, dwc3 probe gets deferred and is processed after dwc3-qcom
probe, driver ends up reading the wakeup capability of dwc3 core as false
leading to instability in suspend/resume path.

To avoid this scenario, ensure dwc3_probe is successful by checking
if appropriate driver is assigned to it or not after the of_platform_populate
call. If it isn't then defer dwc3-qcom probe as well.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 7703655..096d1414 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -722,6 +722,9 @@ static int dwc3_qcom_of_register_core(struct platform_device *pdev)
 		dev_err(dev, "failed to get dwc3 platform device\n");
 	}
 
+	if (!qcom->dwc3->dev.driver)
+		return -EPROBE_DEFER;
+
 node_put:
 	of_node_put(dwc3_np);
 
-- 
2.7.4

