Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A43450C413
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbiDVWKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbiDVWIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:08:14 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C67B1DFE78;
        Fri, 22 Apr 2022 13:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650660876; x=1682196876;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Yhh9Ox6gWEy5WyqGfCoP9kTx2lrAgn2h1flSuBeiyak=;
  b=XYOGMIPiSF5FUuqyXzh+bWHtx0r8uqrmxsX7V1nLlIk2Oqclw5clK93f
   /dU06yXbzlg8taNrypbNQeT8m7y+pRAyATwjHjc/x5+lvsAuXz41SqrwW
   qMKz9uIkpF5JJcIrJM78KaUQdaS11T4BiveDQTn8Px/MmmOStt3Y39Soa
   8=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 22 Apr 2022 12:13:23 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 12:13:20 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 22 Apr 2022 12:13:20 -0700
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 22 Apr 2022 12:13:19 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <dmitry.torokhov@gmail.com>, <corbet@lwn.net>, <sre@kernel.org>,
        <robh+dt@kernel.org>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <bjorn.andersson@linaro.org>,
        <swboyd@chromium.org>, <linux-doc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH v6 0/5] Extend pm8941-pwrkey driver
Date:   Fri, 22 Apr 2022 12:12:35 -0700
Message-ID: <20220422191239.6271-1-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed from v5:
  - Addressed Rob's comment in 1/5 and fixed reg property
  - Addressed Dmitry's comment in 3/5 ang got rid of declaring
    properties as false

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

 Documentation/devicetree/bindings/power/reset/qcom,pon.yaml | 19 ++++++++++++++++++-
 drivers/input/misc/pm8941-pwrkey.c | 124 +++++++++++++++++++++++++----
 2 files changed, 129 insertions(+), 14 deletions(-)

-- 
2.35.1

