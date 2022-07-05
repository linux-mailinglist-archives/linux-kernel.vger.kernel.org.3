Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43FE566CBD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 14:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbiGEMSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 08:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbiGEMJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:09:04 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0A310AF;
        Tue,  5 Jul 2022 05:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657022944; x=1688558944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=shTB0DnuQEAQMrBnn3hQIHFMKfWKIyiEX/Amn09n/BM=;
  b=HhwnmPTdLApE9RNsPw/SkvmThpgEmkJsNqxGyygOxtamdYJeoZuq3OZC
   raB/ct330TJa+xAsZg951Gk+a//bH4KC6BhBjs5AX7J7vWo5qay2+fu21
   0KpqR8CCNTfwV8U/8zGAVJuh5C/SJcns5fs4eDAztVm7PAJl3oipFqaoj
   E=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 05 Jul 2022 05:09:03 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 05:09:03 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Jul 2022 05:09:03 -0700
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Jul 2022 05:09:00 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <bjorn.andersson@linaro.org>
CC:     <agross@kernel.org>, <mathieu.poirier@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konrad.dybcio@somainline.org>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [V3 7/7] remoteproc: sysmon: Send sysmon state only for running rprocs
Date:   Tue, 5 Jul 2022 17:38:20 +0530
Message-ID: <1657022900-2049-8-git-send-email-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1657022900-2049-1-git-send-email-quic_sibis@quicinc.com>
References: <1657022900-2049-1-git-send-email-quic_sibis@quicinc.com>
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

