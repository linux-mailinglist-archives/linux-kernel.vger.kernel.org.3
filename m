Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9651F597D00
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 06:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243177AbiHRERj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 00:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242983AbiHRERa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 00:17:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8ADB95AE5;
        Wed, 17 Aug 2022 21:17:29 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27I28I8L006244;
        Thu, 18 Aug 2022 04:17:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=7/Dlb7opb1zHeDvNOlDvqLTNKaGONEslYGnrJDLSevg=;
 b=k7Nh+coZDc3xx0pigDWj1uY9XpltHEFdA2taT/7dVzsECYLHPwzqWV8zXkJ27zGMx0Du
 IoHDQVG1+3Ju2nrGN0CZAnknWq3ZBb9OxJUWDfpG4BYSRCMjt3NBfpyOKEO1yB0hvOap
 qxM4X/ZvVx20WkjkS4wRpIuSFrUuI7ee4R63/s7vg0RQ0XlB3vkTJydULGWPuRJf+g63
 EuOEmIJAn/AMKKd2YwTWDhrx2a5TRXXN5i9s1MF9MU+gdiPVXTMIsKXJFf8iHUhuBSR3
 CklsfwDsYIjFjkHeQ7xuPArurqMBqUbB+vyZnXccvjwgEufAv3eZzV8Zq04qV/Drvmhw CA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j0w7hm3rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 04:17:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27I4HJlA018189
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 04:17:21 GMT
Received: from hyd-lnxbld559.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 17 Aug 2022 08:15:06 -0700
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
To:     freedreno <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>
CC:     Matthias Kaehlcke <mka@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Douglas Anderson <dianders@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        "Abhinav Kumar" <quic_abhinavk@quicinc.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        Wang Qing <wangqing@vivo.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 7/7] drm/msm/a6xx: Handle GMU prepare-slumber hfi failure
Date:   Wed, 17 Aug 2022 20:44:20 +0530
Message-ID: <20220817204224.v4.7.I54815c7c36b80d4725cd054e536365250454452f@changeid>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1660749261-7602-1-git-send-email-quic_akhilpo@quicinc.com>
References: <1660749261-7602-1-git-send-email-quic_akhilpo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: t24avLC5JYHADwChdhlRERvHbP6cvKu6
X-Proofpoint-GUID: t24avLC5JYHADwChdhlRERvHbP6cvKu6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_02,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 mlxlogscore=862 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180014
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When prepare-slumber hfi fails, we should follow a6xx_gmu_force_off()
sequence.

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
---

(no changes since v1)

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index db05942..3d00ef9 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1082,7 +1082,11 @@ static void a6xx_gmu_shutdown(struct a6xx_gmu *gmu)
 		a6xx_bus_clear_pending_transactions(adreno_gpu);
 
 		/* tell the GMU we want to slumber */
-		a6xx_gmu_notify_slumber(gmu);
+		ret = a6xx_gmu_notify_slumber(gmu);
+		if (ret) {
+			a6xx_gmu_force_off(gmu);
+			return;
+		}
 
 		ret = gmu_poll_timeout(gmu,
 			REG_A6XX_GPU_GMU_AO_GPU_CX_BUSY_STATUS, val,
-- 
2.7.4

