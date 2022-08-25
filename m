Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7169D5A104A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241635AbiHYMXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241454AbiHYMW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:22:59 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACE0AE9ED
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:22:58 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27P5nj9d003635;
        Thu, 25 Aug 2022 07:22:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=F89FFReRi1zqDj//baBjB5HIEbobACoV3vAIIeNB3ec=;
 b=hZdnWo58dExaHs8WhdAWFx8hNyyvGy8ZRmqBNWX6Ja6iGhDzHPZimIZuHoAjfcG56gZo
 5QzsBl2t8x13BruiFYft9FQHXkkba1PuA4HRJ2Q6qKKj64OiU9TVz0WoYWkQctBOLsrn
 f3S/2mLBMGltzUVcXxRTDZ/B6pHQe333GCg+lrXPLxdLOI1t3xOm/txUHEm1zeb+MEs2
 NGc7D8dCMNhEEZfqBGo1AigbJKKG+qPu+ywB+GdvzHV8WTiHgPJM+xXSewNMzOhOUurB
 P5LxKySA55kvgH31fvT6qsgE4UGL6wTYc6phZMdXN+Fok0OkXcnNp1dx+maB6RNtHgAV gw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3j4dgmbu3r-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 07:22:44 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Thu, 25 Aug
 2022 07:22:41 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.9 via Frontend
 Transport; Thu, 25 Aug 2022 07:22:41 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AAA18B16;
        Thu, 25 Aug 2022 12:22:41 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 2/3] soundwire: bus: Don't lose unattach notifications
Date:   Thu, 25 Aug 2022 13:22:40 +0100
Message-ID: <20220825122241.273090-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220825122241.273090-1-rf@opensource.cirrus.com>
References: <20220825122241.273090-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: R4M0MCMXsa_dW2vMEZQ1Wk1YwQqcZd6P
X-Proofpoint-GUID: R4M0MCMXsa_dW2vMEZQ1Wk1YwQqcZd6P
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that if sdw_handle_slave_status() sees a peripheral
has dropped off the bus it reports it to the client driver.

If there are any devices reporting on address 0 it bails out
after programming the device IDs. So it never reaches the second
loop that calls sdw_update_slave_status().

If the missing device is one that is now showing as unenumerated
it has been given a device ID so will report as attached next
time sdw_handle_slave_status() runs.

With the previous code the client driver would only see another
ATTACHED notification because the UNATTACHED state was lost when
sdw_handle_slave_status() bailed out after programming the
device ID.

This shows up most when the peripheral has to be reset after
downloading updated firmware and there are multiple of these
peripherals on the bus. They will all return to unenumerated state
after the reset, and then there is a mix of unattached, attached
and unenumerated PING states from the peripherals, as each is reset
and they reboot.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/soundwire/bus.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 704f75c0bae2..bb8ce26c68b3 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1756,6 +1756,11 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 			dev_warn(&slave->dev, "Slave %d state check1: UNATTACHED, status was %d\n",
 				 i, slave->status);
 			sdw_modify_slave_status(slave, SDW_SLAVE_UNATTACHED);
+
+			/* Ensure driver knows that peripheral unattached */
+			ret = sdw_update_slave_status(slave, status[i]);
+			if (ret < 0)
+				dev_warn(&slave->dev, "Update Slave status failed:%d\n", ret);
 		}
 	}
 
-- 
2.30.2

