Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C004FC56B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 22:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349771AbiDKUHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 16:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiDKUHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 16:07:50 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D171CB32;
        Mon, 11 Apr 2022 13:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649707536; x=1681243536;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jhv6EkHDtQ4ltXXOFpDhNcSEV9W9C2fd4dh3zQjQ+Ew=;
  b=ATLnV1hHO3j2PkiXGH3TrFOUZE4+l4oyTd4LO+nPN8s7D/P4xK0g01rp
   fB/mOE1ufMo5ZzG/eW0qnaYR16wPIHmHHmaVZxvVQvXT4appyZ4rIMPOP
   4NpRERJRK18Ek30Ye6/cdSrEJXrcvEVa/YuB/L/CD+cGumu09JE4irjZh
   M=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 11 Apr 2022 13:05:35 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 13:05:35 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 11 Apr 2022 13:05:34 -0700
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 11 Apr 2022 13:05:33 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <dmitry.torokhov@gmail.com>, <corbet@lwn.net>, <sre@kernel.org>,
        <robh+dt@kernel.org>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <collinsd@codeaurora.org>,
        <bjorn.andersson@linaro.org>, <swboyd@chromium.org>,
        <skakit@codeaurora.org>, <linux-doc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH v5 0/5] Extend pm8941-pwrkey driver
Date:   Mon, 11 Apr 2022 13:05:01 -0700
Message-ID: <20220411200506.22891-1-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v4:
  - Added new dt-binding patch as 1/5
 
Changes from v3:
  - Fixed dereference issue in 2/4
  - Added Stephen's reviewed by tag for 2/4

Changes from v2:
  - Addressed Stephen's comments
    - Add Stephen's reviewed by tag for 1/4
    - Fixed style for 2/4
    - Corrected function call to use correct function for 3/4

Changes from v1:
  - Removed Change-Id from all patches
  - Updated subject line of cover letter
  - Addressed Stephen's comments for v1 1/3
    - Separated error message fix to own patch (v2 1/4)
    - Separated PON GEN3 base address changes to own patch (v2 2/4)
    - Added new variables and functions to make code more readable
  - Removed v1 3/3 as per Bjorn's comments

Anjelique Melendez (2):
  input: misc: pm8941-pwrkey: fix error message
  input: misc: pm8941-pwrkey: add support for PON GEN3 base addresses

David Collins (3):
  dt-bindings: power: reset: qcom-pon: update "reg" property details
  input: misc: pm8941-pwrkey: add software key press debouncing support
  input: misc: pm8941-pwrkey: simulate missed key press events

 Documentation/devicetree/bindings/power/reset/qcom,pon.yaml | 20 +++++++++++++++++++-
 drivers/input/misc/pm8941-pwrkey.c | 124 +++++++++++++++++++++++++----
 2 files changed, 129 insertions(+), 15 deletions(-)

-- 
2.35.1

