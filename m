Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED36D532AE8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 15:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237574AbiEXNOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 09:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiEXNOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 09:14:00 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA5C93445;
        Tue, 24 May 2022 06:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653398038; x=1684934038;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=vp1vfOlJGynDJAlchIl308iQIcq3SLWhkOGl9EWAas4=;
  b=LKREc5Fc7KHXn6t8NSWgIfQQ2/hhqSdpMbkTtnWYaTdKGaC6brkp7CAA
   /T9IvyMTKSGfd/+EWi13nRkNiErRZ8c+Dxy1j0aM5DZn/Tej3Z2pcdBxV
   xZK9gC/d+Sj+4JkNRNKOx4B7Hp9xNBL267H3z9ha23sX0jyxzMRPLkQM3
   c=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 May 2022 06:13:58 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 06:13:57 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 24 May 2022 06:13:57 -0700
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 24 May 2022 06:13:54 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <bjorn.andersson@linaro.org>
CC:     <agross@kernel.org>, <mathieu.poirier@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Sibi Sankar" <quic_sibis@quicinc.com>
Subject: [PATCH 0/7] Miscellaneous PAS fixes
Date:   Tue, 24 May 2022 18:43:30 +0530
Message-ID: <1653398017-28426-1-git-send-email-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

A collection of misc. fixes for the remoteproc PAS driver in general
and SM8450 remoteprocs in paticular.

Sibi Sankar (1):
  remoteproc: qcom: pas: Add decrypt shutdown support for modem

Siddharth Gupta (5):
  remoteproc: qcom: pas: Mark va as io memory
  remoteproc: qcom: pas: Mark devices as wakeup capable
  remoteproc: qcom: pas: Check if coredump is enabled
  remoteproc: qcom: Check elf class before minidump
  remoteproc: q6v5: Set q6 state to offline on receiving wdog irq

Yogesh Lal (1):
  remoteproc: qcom: pas: Fixup the elf class for SM8450 remoteprocs

 drivers/remoteproc/qcom_common.c   |   6 +-
 drivers/remoteproc/qcom_q6v5.c     |   4 ++
 drivers/remoteproc/qcom_q6v5_pas.c | 127 +++++++++++++++++++++++++++++++++++--
 3 files changed, 131 insertions(+), 6 deletions(-)

-- 
2.7.4

