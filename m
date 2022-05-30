Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808995374A0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiE3GXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 02:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiE3GX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 02:23:28 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEE7B487;
        Sun, 29 May 2022 23:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653891807; x=1685427807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=shTB0DnuQEAQMrBnn3hQIHFMKfWKIyiEX/Amn09n/BM=;
  b=Q+EXTRUfBlfgZrTKmjbC2c+8fT4OL+zkUWMJe2jqskfatjPyHTSJfVv6
   gN8JMV0qy9Z8gp3oyzB2If0gcucoKd9eV9B3fnEi+OLvxqZjc+STSJ2Pj
   2AMGWW3qWsQwTxQ7COxhh4++2CkEHpeonh+lLxpjF8McI6s5XfgKT4ruW
   A=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 29 May 2022 23:23:27 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2022 23:23:26 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 29 May 2022 23:23:26 -0700
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 29 May 2022 23:23:23 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <bjorn.andersson@linaro.org>
CC:     <agross@kernel.org>, <mathieu.poirier@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konrad.dybcio@somainline.org>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [V2 6/6] remoteproc: sysmon: Send sysmon state only for running rprocs
Date:   Mon, 30 May 2022 11:52:51 +0530
Message-ID: <1653891771-17103-7-git-send-email-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1653891771-17103-1-git-send-email-quic_sibis@quicinc.com>
References: <1653891771-17103-1-git-send-email-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

From: Siddharth Gupta <sidgup@codeaurora.org>

When a new remoteproc boots up, send the sysmon state notification
of only running remoteprocs. Sending state of remoteprocs booting
up in parallel can cause a race between SSR clients of the remoteproc
that is booting up and the sysmon notification for the same remoteproc,
resulting in an inconsistency between which state the remoteproc that
is booting up in parallel.

For example - if remoteproc A and B crash one after the other, after
remoteproc A boots up, if the remoteproc A tries to get the state of
remoteproc B before the sysmon subdevice for B is invoked but after
the ssr subdevice of B has been invoked, clients on remoteproc A
might get confused when the sysmon notification indicates a different
state.

Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/remoteproc/qcom_sysmon.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_sysmon.c b/drivers/remoteproc/qcom_sysmon.c
index a9f04dd83ab6..57dde2a69b9d 100644
--- a/drivers/remoteproc/qcom_sysmon.c
+++ b/drivers/remoteproc/qcom_sysmon.c
@@ -512,10 +512,12 @@ static int sysmon_start(struct rproc_subdev *subdev)
 
 	mutex_lock(&sysmon_lock);
 	list_for_each_entry(target, &sysmon_list, node) {
-		if (target == sysmon)
+		mutex_lock(&target->state_lock);
+		if (target == sysmon || target->state != SSCTL_SSR_EVENT_AFTER_POWERUP) {
+			mutex_unlock(&target->state_lock);
 			continue;
+		}
 
-		mutex_lock(&target->state_lock);
 		event.subsys_name = target->name;
 		event.ssr_event = target->state;
 
-- 
2.7.4

