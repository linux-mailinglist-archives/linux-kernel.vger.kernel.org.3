Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9B1567E2A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 08:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiGFGDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 02:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGFGCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 02:02:55 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0842922292;
        Tue,  5 Jul 2022 23:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657087373; x=1688623373;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=N05CHbczPI9zZVzdDqPThkTIquD1MZLOkgQOD3jseKU=;
  b=coCxXaRqmQJjHjmkfH0iqcXXFpvkC58ov5BhJcUsAVUvNS+zjn6cBIVz
   DUVN0eP9+5Q1xy9uc2sFjm3udqRUwpl/1jpu6+LxBnRWgEcx/El1W0bUW
   mbaswMUCOl1sCA7xsogyUzVjUD0eqqDWp97M6L51nqd3h1zmGv0ROblJ9
   Y=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 05 Jul 2022 23:02:52 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 23:02:52 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Jul 2022 23:02:51 -0700
Received: from hu-clew-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Jul 2022 23:02:51 -0700
From:   Chris Lew <quic_clew@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <konrad.dybcio@somainline.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_clew@quicinc.com>
Subject: [PATCH 0/4] Add smp2p retrigger support
Date:   Tue, 5 Jul 2022 23:02:07 -0700
Message-ID: <1657087331-32455-1-git-send-email-quic_clew@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
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

The remoteproc framework keeps interrupts disabled until it powers on a
remote proc to prevent spurious interrupts. There is a case where the
remote proc can finish booting before remoteproc enables the interrupt.
If this happens, the remoteproc framework will miss the notification
and eventually timeout waiting for the remoteproc to finish "booting".

Add support into smp2p to retrigger an interrupt if it was missed while
the interrupt was disabled. The interrupt should retrigger once the
interrupt is enabled. This will make the bootup sequence for remoteproc
less racy.

Chris Lew (3):
  soc: qcom: smp2p: Introduce pending state for virtual irq
  soc: qcom: smp2p: Add proper retrigger detection
  soc: qcom: smp2p: Add memory barrier for irq_pending

Tao Zhang (1):
  soc: qcom: smp2p: Add remote_id into irq name

 drivers/soc/qcom/smp2p.c | 42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

-- 
2.7.4

