Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7FE5AA92A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbiIBHy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbiIBHyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:54:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CB9B5E77
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 00:54:12 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MJqp50HDwz683hj;
        Fri,  2 Sep 2022 15:50:21 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Fri, 2 Sep 2022 09:54:10 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 2 Sep 2022 08:54:08 +0100
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@hisilicon.com>
CC:     <andriy.shevchenko@linux.intel.com>, <linuxarm@huawei.com>,
        <rafael.j.wysocki@intel.com>, <linux-kernel@vger.kernel.org>,
        <soc@kernel.org>, <yangyingliang@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 4/5] bus: hisi_lpc: Don't guard ACPI IDs with ACPI_PTR()
Date:   Fri, 2 Sep 2022 15:47:20 +0800
Message-ID: <1662104841-55360-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1662104841-55360-1-git-send-email-john.garry@huawei.com>
References: <1662104841-55360-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The OF ID table is not guarded, and the ACPI table does not needs it either.
The IDs do not depend on the configuration. Hence drop ACPI_PTR() from the
code and move ID table closer to its user.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/bus/hisi_lpc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index a6513a571d7b..74f4448bff9d 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -589,11 +589,6 @@ static int hisi_lpc_acpi_probe(struct device *hostdev)
 
 	return ret;
 }
-
-static const struct acpi_device_id hisi_lpc_acpi_match[] = {
-	{"HISI0191"},
-	{}
-};
 #else
 static int hisi_lpc_acpi_probe(struct device *dev)
 {
@@ -688,11 +683,16 @@ static const struct of_device_id hisi_lpc_of_match[] = {
 	{}
 };
 
+static const struct acpi_device_id hisi_lpc_acpi_match[] = {
+	{"HISI0191"},
+	{}
+};
+
 static struct platform_driver hisi_lpc_driver = {
 	.driver = {
 		.name           = DRV_NAME,
 		.of_match_table = hisi_lpc_of_match,
-		.acpi_match_table = ACPI_PTR(hisi_lpc_acpi_match),
+		.acpi_match_table = hisi_lpc_acpi_match,
 	},
 	.probe = hisi_lpc_probe,
 	.remove = hisi_lpc_remove,
-- 
2.35.3

