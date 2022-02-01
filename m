Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FFF4A5A92
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 11:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236875AbiBAKwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 05:52:37 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:13007 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiBAKwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 05:52:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643712755; x=1675248755;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Cpo8UZI1wG2GAE6up4u4Iw0Ycz/5sgQ0G828pkyJAXE=;
  b=Ezk/Vn7cWGyEtJyuFSlxM2lVUuf74G67PzjWQ1pdTM1o0VXASVDukeEY
   DiSEA8/592xV+N6XhEm+T4Mn0dKQ/LPpsZa4/bbD1IWXWVG9gR/GUMxPc
   SwXO3AB9DQ6E0Li8c5Zl3aHK59XNoU645nbnfHiGK75opNsYl9hHy8/vd
   k=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 01 Feb 2022 02:52:34 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 02:52:33 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 1 Feb 2022 02:52:33 -0800
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 1 Feb 2022 02:52:28 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <ohad@wizery.com>,
        <mathieu.poirier@linaro.org>, <p.zabel@pengutronix.de>
CC:     <linux-remoteproc@vger.kernel.org>, <swboyd@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_sibis@quicinc.com>,
        <kuabhs@chromium.org>, <quic_pillair@quicinc.com>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v10 0/3] Add support for sc7280 WPSS PIL loading
Date:   Tue, 1 Feb 2022 16:22:01 +0530
Message-ID: <1643712724-12436-1-git-send-email-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for PIL loading of WPSS co-processor for SC7280 SOCs.

Changes from v9:
- Minor cosmetic changes

Changes from v8:
- Disallow num_proxy_pds to be more than the max allowed
- Add "additionalProperties: false" for glink-edge property in wpss dt-bindings.

Changes from v7:
- Use "interrupts" instead of "interrupts-extended" in DT bindings.
- Add glink-edge properties in DT bindings.
- Use size_t for "proxy_pd_count" in wpss remoteproc driver

Changes from v6:
- Fixed the dt-bindings check in qcom,sc7280-wpss-pil.yaml
- Fixed CDSP dt-bindings example node (compatible, glink-edge)
- Fixed the clock-names used in wpss driver
- Add support to get firmware-name from DTSI entry for wpss.

Changes from v4/v5:
- Add yaml conversion for adsp/cdsp dt-bindings
- Change clock names in wpss dt-bindings
- Correct mistake in signed-off email ID

Rakesh Pillai (3):
  dt-bindings: remoteproc: qcom: adsp: Convert binding to YAML
  dt-bindings: remoteproc: qcom: Add SC7280 WPSS support
  remoteproc: qcom: q6v5_wpss: Add support for sc7280 WPSS

 .../bindings/remoteproc/qcom,hexagon-v56.txt       | 140 -------------
 .../bindings/remoteproc/qcom,qcs404-cdsp-pil.yaml  | 161 +++++++++++++++
 .../bindings/remoteproc/qcom,sc7280-wpss-pil.yaml  | 219 ++++++++++++++++++++
 .../bindings/remoteproc/qcom,sdm845-adsp-pil.yaml  | 160 +++++++++++++++
 drivers/remoteproc/qcom_q6v5_adsp.c                | 227 +++++++++++++++++++--
 5 files changed, 751 insertions(+), 156 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,hexagon-v56.txt
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,qcs404-cdsp-pil.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml

-- 
2.7.4

