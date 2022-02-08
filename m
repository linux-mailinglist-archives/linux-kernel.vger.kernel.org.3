Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852904AE48C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388115AbiBHWcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386225AbiBHTop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:44:45 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE714C0613CB;
        Tue,  8 Feb 2022 11:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644349484; x=1675885484;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=B0beRUcpy6mm/IC1BcwaxatHK/JKj1WU47oyT+N03mg=;
  b=PmOrBH44twkgttlFTrbNznHsN82tq/QyRPYBRGwKespy+V1TQ7XMOuuQ
   d39cTRA8h5t8m34AxiK2mz7FTOLeM7Ais3fD73M80b6wnWbjL43yAliuQ
   JJhLBoU46nnjAhA5TmZmfMyqCiaMVtvzKgY1XnbTtsL9u8kxe6k/hiQjd
   w=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 08 Feb 2022 11:44:44 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 11:44:43 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 11:44:43 -0800
Received: from abhinavk-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 11:44:42 -0800
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-kernel@vger.kernel.org>
CC:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <robdclark@gmail.com>, <dri-devel@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
        <seanpaul@chromium.org>, <swboyd@chromium.org>,
        <nganji@codeaurora.org>, <aravindh@codeaurora.org>,
        <khsieh@codeaurora.org>, <daniel@ffwll.ch>,
        <dmitry.baryshkov@linaro.org>
Subject: [PATCH] devcoredump: increase the device delete timeout to 10 mins
Date:   Tue, 8 Feb 2022 11:44:32 -0800
Message-ID: <1644349472-31077-1-git-send-email-quic_abhinavk@quicinc.com>
X-Mailer: git-send-email 2.7.4
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

There are cases where depending on the size of the devcoredump and the speed
at which the usermode reads the dump, it can take longer than the current 5 mins
timeout.

This can lead to incomplete dumps as the device is deleted once the timeout expires.

One example is below where it took 6 mins for the devcoredump to be completely read.

04:22:24.668 23916 23994 I HWDeviceDRM::DumpDebugData: Opening /sys/class/devcoredump/devcd6/data
04:28:35.377 23916 23994 W HWDeviceDRM::DumpDebugData: Freeing devcoredump node

Increase the timeout to 10 mins to accommodate system delays and large coredump
sizes.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---
 drivers/base/devcoredump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index f4d794d..6b83ae5 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -18,8 +18,8 @@ static struct class devcd_class;
 /* global disable flag, for security purposes */
 static bool devcd_disabled;
 
-/* if data isn't read by userspace after 5 minutes then delete it */
-#define DEVCD_TIMEOUT	(HZ * 60 * 5)
+/* if data isn't read by userspace after 10 minutes then delete it */
+#define DEVCD_TIMEOUT	(HZ * 60 * 10)
 
 struct devcd_entry {
 	struct device devcd_dev;
-- 
2.7.4

