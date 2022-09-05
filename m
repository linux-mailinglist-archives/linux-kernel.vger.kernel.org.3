Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043535ACE12
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbiIEInE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbiIEIm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:42:58 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19192BB;
        Mon,  5 Sep 2022 01:42:56 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 285798qD026381;
        Mon, 5 Sep 2022 08:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=eLaQrz6sT3ta9nYcNtkFQOVwO8nrElyImBIyHL7uR0E=;
 b=cEw+8xTyMgzWaPvdfItWeBdYLQc+Ub8TfxLwlu5T12FVeiR+XIEVJnFV+IMPm0WLqUEM
 R4A3+zxiPSv4GGpzdf0fCmx9UK2dUCLwHqOlc7EAJzQVOEjVjwZXMFPrZTdkFnhuvHgt
 n8zitDL0QXJVt1q3GZMZIKdEPQnLa/78PC9h/Iv4qkikLcmf1huyoWxbXSCNpG2UIkA7
 9yLPiRhl8x3VQK0z/VKbnGDrWF0LspmtKufj09IZAUDb+MrkX466W8NPeW5Oecn8W061
 GwtQIBho4GhFWbEs7XxjcWdmLNVEMSSXWooJ7aDIwQGuqcaJTeW7DQUuZ4Or2G0aOlrA Dw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jbvmnby1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 08:42:52 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2858gmJS011981;
        Mon, 5 Sep 2022 08:42:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3jc00k48ng-1;
        Mon, 05 Sep 2022 08:42:48 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2858gm4P011975;
        Mon, 5 Sep 2022 08:42:48 GMT
Received: from vboma-linux.qualcomm.com (vboma-linux.qualcomm.com [10.204.65.94])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 2858gmoj011974;
        Mon, 05 Sep 2022 08:42:48 +0000
Received: by vboma-linux.qualcomm.com (Postfix, from userid 72083)
        id CC6AD900883; Mon,  5 Sep 2022 14:12:47 +0530 (IST)
From:   quic_vboma@quicinc.com
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Viswanath Boma <quic_vboma@quicinc.com>
Subject: [PATCH 0/1] Enabling sufficient sequence change support for VP9
Date:   Mon,  5 Sep 2022 14:12:26 +0530
Message-Id: <20220905084227.24028-1-quic_vboma@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: F5TionFF6DLGXGrQtir8SVkpxOrDH9kX
X-Proofpoint-ORIG-GUID: F5TionFF6DLGXGrQtir8SVkpxOrDH9kX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-05_05,2022-09-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=973 lowpriorityscore=0 phishscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209050041
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viswanath Boma <quic_vboma@quicinc.com>

The fix was tested on v5.4 kernel with supporting firmware 
release VIDEO.VE.5.4-00051-PROD-1 .

Ensured verification of the fix on chrome CRD device.


Viswanath Boma (1):
  venus : Enabling sufficient sequence change support for VP9 on
    sc7180-venus

 drivers/media/platform/qcom/venus/core.h       |  2 ++
 drivers/media/platform/qcom/venus/hfi_cmds.c   |  1 +
 drivers/media/platform/qcom/venus/hfi_helper.h |  2 ++
 drivers/media/platform/qcom/venus/hfi_msgs.c   | 13 ++++++-------
 drivers/media/platform/qcom/venus/vdec.c       | 16 +++++++++++++++-
 5 files changed, 26 insertions(+), 8 deletions(-)

-- 
2.17.1

