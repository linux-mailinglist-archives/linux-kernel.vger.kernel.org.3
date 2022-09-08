Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEA65B1EB4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiIHNYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbiIHNYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:24:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F63A29CA4;
        Thu,  8 Sep 2022 06:24:48 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288Cxn9T027789;
        Thu, 8 Sep 2022 13:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=JLV8vyIyEHMwqLSl0mQtIqtCADyA+Rea/0zj9pZh91w=;
 b=Mthw3Jdb6oxWoIc7sbqlRWl6aqnYPlldHeIzLwJsEwhxIc2yBKz9IhjQ+fZBakBs1ZdA
 X9Y/WCMlcmfvv0wRM0g1Ax178Fz4EDWWTM3NdmZ9xUtVbk75Q8nyF2GY1eQInrVGjao+
 iu4m4ov58XqeTBaB4pOnyM0ctyPbK0Q8zO840ZU2itD6pzZ3dDa79wZ+zCbS8wCto1Pv
 ltnyQspfIKYNDXGVpj5HJkKPkdVE35lgupETHHqvH+0H+loH5ob3TxxeHX/mpN9zsqDT
 u2nJLnjiqVqXQffAa/sgI852V0CO6A+RpF2RmeZflBmezMz63rKPWEw/f35ho7RkY4mj mg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jfeuurcen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 13:24:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 288DO58g000999
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Sep 2022 13:24:05 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 8 Sep 2022 06:23:59 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v6 0/8] Update ADSP pil loader for SC7280 platform
Date:   Thu, 8 Sep 2022 18:53:34 +0530
Message-ID: <1662643422-14909-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vWFLdUAVzGYT7dEPUqn7M1V1TrBLPCK5
X-Proofpoint-GUID: vWFLdUAVzGYT7dEPUqn7M1V1TrBLPCK5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_08,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1011 phishscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209080049
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update ADSP pil loader driver for SC7280 platforms.

Changes since V5:
	-- Remove adsp_rproc_unmap_smmu, adsp_of_unmap_smmu, adsp_of_map_smmu and 
	   adsp_rproc_map_smmu functions.
	-- Remove find_loaded_rsc_table call back initialization.
	-- Rename adsp_sandbox_needed to has_iommu.
	-- Update parse_fw callback in rproc ops.
	-- Remove qcom,adsp-memory-regions property in dt-bindings.
	-- Change adsp binary extention name.
Changes since V4:
	-- Update halt registers description in dt bindings.
	-- Update Memory sandboxing with proper APIs for resource
	   allocation and free.
Changes since V3:
	-- Rename is_adsp_sb_needed to adsp_sandbox_needed.
	-- Update sc7280 compatible name entry in sorted order.
	-- Add smmu unmapping in error case and in adsp stop.
	-- Revert converting sdm845 dt bindings to generic and 
	   create new dt bindings for sc7280.
Changes since V2:
	-- Generated patch with -M flag.
	-- Add Clock property in dt bindings.
	-- Add qcom,adsp-memory-regions property.
	-- Add is_adsp_sb_needed flag instead of is_wpss.
	-- Initialize is_adsp_sb_needed flag.
	-- Remove empty proxy pds array.
	-- Replace platform_bus_type with adsp->dev->bus.
	-- Use API of_parse_phandle_with_args() instead of 
	    of_parse_phandle_with_fixed_args().
	-- Replace adsp->is_wpss with adsp->is_adsp.
	-- Update error handling in adsp_start().
Changes since V1:
	-- Change reg property maxItems to minItems and update description.
	-- Fix typo errors.

Srinivasa Rao Mandadapu (8):
  dt-bindings: remoteproc: qcom: Add SC7280 ADSP support
  remoteproc: qcom: Add flag in adsp private data structure
  remoteproc: qcom: Add compatible name for SC7280 ADSP
  remoteproc: qcom: Update rproc parse firmware callback
  remoteproc: qcom: Replace hard coded values with macros
  remoteproc: qcom: Add efuse evb selection control
  remoteproc: qcom: Add support for memory sandbox
  remoteproc: qcom: Update QDSP6 out-of-reset timeout value

 .../bindings/remoteproc/qcom,sc7280-adsp-pil.yaml  | 175 +++++++++++++++++++++
 drivers/remoteproc/qcom_q6v5_adsp.c                | 110 ++++++++++++-
 2 files changed, 279 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml

-- 
2.7.4

