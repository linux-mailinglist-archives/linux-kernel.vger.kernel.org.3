Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7A95B016C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 12:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiIGKPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 06:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiIGKO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 06:14:59 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF59D252AD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 03:14:57 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2877rCJt005930;
        Wed, 7 Sep 2022 05:14:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=aqYA40ruUCIZdevPe+N+w30xxDeh8yKvlyprFh48KdA=;
 b=J0NLYU/DxQ6iZYVgO/9tl61Cpxb4DpCWYeQOAtd0iSlkZr/BAjqBcq5c8YLPcGbDovEk
 3cxBDGDYpF+FdhudjRjbAwH/E4l+yE4Q0Ap3S1yU5Pr4QRq2lW9mEpaP7H8aHm2RxQxp
 jGe3H1p1+rZb9kzoeL8GRceb0HbLBYQyjOm6NZLzBp9km83fw5UQUzV4M93+HCOzTErw
 jnOpnGuN35UNSLiVa8UgAj1t3soLmesi3tyUs3sj4Vfx+oXp6Rfd8n9ChNfZpY5X/6a9
 xrEQwgMmCnQFJr641gHdInOMMdmk5hdlFvLLUVIlHSrVkruqpnISswPWB4uhJ4+JOIGC kQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3jc3bpw4sr-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 05:14:16 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Wed, 7 Sep
 2022 05:14:14 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.12 via Frontend Transport; Wed, 7 Sep 2022 05:14:14 -0500
Received: from debianA11184.ad.cirrus.com (unknown [198.61.65.149])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 30067B10;
        Wed,  7 Sep 2022 10:14:14 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <lgirdwood@gmail.com>,
        <peter.ujfalusi@linux.intel.com>,
        <ranjani.sridharan@linux.intel.com>,
        <kai.vehmanen@linux.intel.com>, <daniel.baluta@nxp.com>,
        <sanyog.r.kale@intel.com>, <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>,
        <sound-open-firmware@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 4/7] soundwire: bus: Add remove callback to struct sdw_master_ops
Date:   Wed, 7 Sep 2022 11:13:59 +0100
Message-ID: <20220907101402.4685-5-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220907101402.4685-1-rf@opensource.cirrus.com>
References: <20220907101402.4685-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: PcezryGsWGuJWSoJf8gsZ1-ET6M7BAOB
X-Proofpoint-ORIG-GUID: PcezryGsWGuJWSoJf8gsZ1-ET6M7BAOB
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During removal of a bus driver the bus must stay operational while
child drivers are being removed, since (a) they might have been busy
when the bus driver removal started and (b) the might need to access
the bus to run their shutdown procedures. Only after that can the bus
driver disable the bus.

Add a new remove callback to struct sdw_master_ops that the bus driver
can implement to disable the bus after children are removed.

This is modeled on the ASoC component_remove, which indicates that the
driver is no longer required.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/soundwire/bus.c       | 5 +++++
 include/linux/soundwire/sdw.h | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 99429892221b..1327a312be86 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -176,6 +176,11 @@ static int sdw_delete_slave(struct device *dev, void *data)
 void sdw_bus_master_delete(struct sdw_bus *bus)
 {
 	device_for_each_child(bus->dev, NULL, sdw_delete_slave);
+
+	/* Children have been removed so it is now safe for the bus to stop */
+	if (bus->ops->remove)
+		bus->ops->remove(bus);
+
 	sdw_master_device_del(bus);
 
 	sdw_bus_debugfs_exit(bus);
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index a2b31d25ea27..aa492173d5eb 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -839,6 +839,7 @@ struct sdw_defer {
  * @set_bus_conf: Set the bus configuration
  * @pre_bank_switch: Callback for pre bank switch
  * @post_bank_switch: Callback for post bank switch
+ * @remove: Called when it is safe to stop the bus controller.
  */
 struct sdw_master_ops {
 	int (*read_prop)(struct sdw_bus *bus);
@@ -855,7 +856,7 @@ struct sdw_master_ops {
 			struct sdw_bus_params *params);
 	int (*pre_bank_switch)(struct sdw_bus *bus);
 	int (*post_bank_switch)(struct sdw_bus *bus);
-
+	void (*remove)(struct sdw_bus *bus);
 };
 
 /**
-- 
2.30.2

