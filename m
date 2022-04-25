Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B99050D9F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbiDYHUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiDYHUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:20:41 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2929BC87E;
        Mon, 25 Apr 2022 00:17:34 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23P5rPtt009535;
        Mon, 25 Apr 2022 09:17:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=Opi8juyUDHiPfz1wuT/aeqe/MAuCKQKlaH9etNKYKA8=;
 b=r05JG4F6PeA9O9I9iqS4DMqVc8VDTdrvPqI8c1G5KjL3au/IL7UbV2kHW7d2iMqCZhQ2
 gG1IAA1Auyywe+gJnH4Vf3quqLeqVPOxdbYTWlZXyZBPCxUj2EArYitLVzVSFtPWEOP9
 /Yd7CZSViEHQ8OOW9xqgf73hnDvWLBTCqqVaRDEmHjOtClGADH95UFzqOParHiK5IicM
 tGPxiCFvebt6tX6EMOSdVRgqebh98C4kqYCGCtvCA5knJ2dchqGEq4bHT9y1n12mhoKV
 7hovfNyzWuilQXAhW+K38vGh8GHeVD2EUlgqxRo1jNgOZM+9SbPvR6logf7t4O1TXnSE BQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3fm6vk7gq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 09:17:32 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 48FC010002A;
        Mon, 25 Apr 2022 09:17:30 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C26272128D1;
        Mon, 25 Apr 2022 09:17:30 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 25 Apr 2022 09:17:30
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@foss.st.com>
Subject: [PATCH] rpmsg: Fix parameter naming for announce_create/destroy ops.
Date:   Mon, 25 Apr 2022 09:17:23 +0200
Message-ID: <20220425071723.774050-1-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.24.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_02,2022-04-22_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameter associated to the announce_create and
announce_destroy ops functions is not an endpoint but a rpmsg device.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
No fixed sha1 indicated in commit message as issue is present since a
while, it does not fix a specific sha1.

git blame highlight the sha1 [1], but issue was present before.
The commit [1] just moves declaration from rpmsg.h to rpmsg_internal.

[1] fade037e0fd5 ("rpmsg: Hide rpmsg indirection tables")
---
 drivers/rpmsg/rpmsg_internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index d4b23fd019a8..ff0b12122235 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -41,8 +41,8 @@ struct rpmsg_device_ops {
 					    rpmsg_rx_cb_t cb, void *priv,
 					    struct rpmsg_channel_info chinfo);
 
-	int (*announce_create)(struct rpmsg_device *ept);
-	int (*announce_destroy)(struct rpmsg_device *ept);
+	int (*announce_create)(struct rpmsg_device *rpdev);
+	int (*announce_destroy)(struct rpmsg_device *rpdev);
 };
 
 /**
-- 
2.24.3

