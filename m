Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F59152E778
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347081AbiETIa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347091AbiETIaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:30:35 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE17C14B676;
        Fri, 20 May 2022 01:30:06 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24K3tLia028145;
        Fri, 20 May 2022 10:30:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=ELzzZyzi9IIRB85sZHLytKa0QsJoVdFk2Y4D4aQAVAo=;
 b=1t9eTyznf9T4JFHDbh8VG8RC/ucYGYT01BYBBxUFQCAdBPo3LbaZpEV3B0VpJOlPT47Y
 z9zBj2dM1dBRFdWAKxNLiHvNgu2tqnfeo6SqIquE7wsdTU1ZFwIsUzIQ/xMisK5c2B5n
 owV16Vfe8v0KtNgQ0ppzZNoadAu4XGr8NoqQxR7SHzA+8ZOQ4lLB1dIiTo0b317M9TwU
 eK38LqNtlkCidS2ncVH6CKOomVWti61EjxKWPwyaqR0qaBUy8nb1U4j0iNiOJUTtdjFK
 Nogumxsx5vUwU+JbmP9AZP9PqeAddSsL/nGYJtdFTdgqVgf373Y4df/WcZUDuzIqZZwx zw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3g23s22tk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 10:30:00 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3C61A10003A;
        Fri, 20 May 2022 10:29:58 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3572A214D3E;
        Fri, 20 May 2022 10:29:58 +0200 (CEST)
Received: from localhost (10.75.127.44) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 20 May
 2022 10:29:57 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Chris Lew <quic_clew@quicinc.com>,
        <arnaud.pouliquen@foss.st.com>
Subject: [RFC PATCH 03/10] rpmsg: core: Add rpmsg device remote flow control announcement ops
Date:   Fri, 20 May 2022 10:29:33 +0200
Message-ID: <20220520082940.2984914-4-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520082940.2984914-1-arnaud.pouliquen@foss.st.com>
References: <20220520082940.2984914-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_03,2022-05-19_03,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This ops is called by the rpmsg flow control service to inform
a rpmsg local device of a remote endpoint flow control state.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/rpmsg/rpmsg_core.c     | 24 ++++++++++++++++++++++++
 drivers/rpmsg/rpmsg_internal.h |  7 +++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 8de8aadd9b27..6bbc3b3ace50 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -67,6 +67,30 @@ int rpmsg_release_channel(struct rpmsg_device *rpdev,
 }
 EXPORT_SYMBOL(rpmsg_release_channel);
 
+/**
+ * rpmsg_channel_remote_fc() - announce remote endpoint flow control state
+ * using source and destination endpoint address info.
+ * @rpdev: rpmsg device
+ * @chinfo: channel_info
+ * @enable: state of the remote endpoint
+ *
+ * Return: 0 on success or an appropriate error value.
+ */
+int rpmsg_channel_remote_fc(struct rpmsg_device *rpdev,
+			    struct rpmsg_channel_info *chinfo,
+			    bool enable)
+{
+	if (WARN_ON(!rpdev))
+		return -EINVAL;
+	if (!rpdev->ops || !rpdev->ops->announce_remote_fc) {
+		dev_err(&rpdev->dev, "no flow control ops found\n");
+		return -ENXIO;
+	}
+
+	return rpdev->ops->announce_remote_fc(rpdev, chinfo, enable);
+}
+EXPORT_SYMBOL(rpmsg_channel_remote_fc);
+
 /**
  * rpmsg_create_ept() - create a new rpmsg_endpoint
  * @rpdev: rpmsg channel device
diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index 4ce58e68af30..44e2c0f2f5ea 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -43,6 +43,9 @@ struct rpmsg_device_ops {
 
 	int (*announce_create)(struct rpmsg_device *ept);
 	int (*announce_destroy)(struct rpmsg_device *ept);
+	int (*announce_remote_fc)(struct rpmsg_device *rpdev,
+				  struct rpmsg_channel_info *chinfo,
+				  bool enable);
 };
 
 /**
@@ -87,6 +90,10 @@ struct rpmsg_device *rpmsg_create_channel(struct rpmsg_device *rpdev,
 					  struct rpmsg_channel_info *chinfo);
 int rpmsg_release_channel(struct rpmsg_device *rpdev,
 			  struct rpmsg_channel_info *chinfo);
+
+int rpmsg_channel_remote_fc(struct rpmsg_device *rpdev,
+			    struct rpmsg_channel_info *chinfo,
+			    bool enable);
 /**
  * rpmsg_ctrldev_register_device() - register a char device for control based on rpdev
  * @rpdev:	prepared rpdev to be used for creating endpoints
-- 
2.25.1

