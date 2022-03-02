Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4366D4CADCD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 19:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244696AbiCBSqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 13:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236449AbiCBSqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:46:32 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E1DD21EB;
        Wed,  2 Mar 2022 10:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646246749; x=1677782749;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sAJLGY3CYWoZ9I7K46EUZ5x5/6daf2o0KT10Pq8KtRw=;
  b=mi9CIGrOtk83bk5Qcplcqr/D3Vc/3II1AaD8WaBUBAccKCLz3CBkLdvu
   qJWp+yLy4zqNt+RI9f7qWmddqu5rCnn2M6zhAHzJxyZYKirXIp8vQ3ZfH
   dePLS1Oy4AyvB57Yva69CtFJGbuzWc+lUSGkMmFL3Gir8YmLVQrr6j9Ff
   Q=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 02 Mar 2022 10:45:48 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 10:45:48 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 2 Mar 2022 10:45:47 -0800
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 2 Mar 2022 10:45:47 -0800
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <collinsd@codeaurora.org>,
        <bjorn.andersson@linaro.org>, <swboyd@chromium.org>,
        <skakit@codeaurora.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [RESEND PATCH v4 0/4] Extend pm8941-pwrkey driver
Date:   Wed, 2 Mar 2022 10:45:21 -0800
Message-ID: <20220302184525.19781-1-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

David Collins (2):
  input: misc: pm8941-pwrkey: add software key press debouncing support
  input: misc: pm8941-pwrkey: simulate missed key press events

 drivers/input/misc/pm8941-pwrkey.c | 124 +++++++++++++++++++++++++----
 1 file changed, 110 insertions(+), 14 deletions(-)

-- 
2.34.1

