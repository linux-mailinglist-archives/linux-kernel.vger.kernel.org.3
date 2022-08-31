Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A005A764E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiHaGM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiHaGM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:12:57 -0400
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015F4BCC0D;
        Tue, 30 Aug 2022 23:12:52 -0700 (PDT)
X-QQ-mid: bizesmtp63t1661926291twgncv13
Received: from localhost.localdomain ( [123.114.60.34])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 31 Aug 2022 14:11:30 +0800 (CST)
X-QQ-SSF: 01400000000000D0U000000A0000000
X-QQ-FEAT: jQKiaYrAUW4ZlxG/h6O0gpeDTaMLfo5pIe2W1kqFQ22usg+63OAX2iOgoePpB
        WCl1i88e5zaPk/hx1uae+M6BW+4iLGBZitEZBalO5/Oxc6hMJ4PCjv0eTd67eVmB/9MlP56
        v4pwGdztY2szTp1l7wx1x6ILpZ+J9I6uXIKt8x1M/itDdfZcC9Rj2vY4T+7YMORwHp2Jg+B
        MTXEgODeOIPdb6ufH6GeD1qGvhzKzqUaB7Az4CcnhaT6lhbFF/3/IIVm0B9eAN4ht8CJVM9
        cZWZWVsUCb/nMXq8Ln8R7UnQ03BbAQOZAODJ486ofIJEJsBrTpZVaHLWceHN1h6WIU8UYcr
        2+ldp5CHySPGNbvT7ZYRpBKvUN1HZRryUpQ0ykC
X-QQ-GoodBg: 1
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     heikki.krogerus@linux.intel.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH] usb:mux:intel_pmc_mux: Use the helper acpi_dev_get_memory_resources()
Date:   Wed, 31 Aug 2022 14:11:26 +0800
Message-Id: <20220831061126.25172-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It removes the need to check the resource data type separately.

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 drivers/usb/typec/mux/intel_pmc_mux.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index 47b733f78fb0..6207c8f54240 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -569,13 +569,6 @@ static int pmc_usb_register_port(struct pmc_usb *pmc, int index,
 	return ret;
 }
 
-static int is_memory(struct acpi_resource *res, void *data)
-{
-	struct resource r;
-
-	return !acpi_dev_resource_memory(res, &r);
-}
-
 /* IOM ACPI IDs and IOM_PORT_STATUS_OFFSET */
 static const struct acpi_device_id iom_acpi_ids[] = {
 	/* TigerLake */
@@ -606,7 +599,7 @@ static int pmc_usb_probe_iom(struct pmc_usb *pmc)
 		return -ENODEV;
 
 	INIT_LIST_HEAD(&resource_list);
-	ret = acpi_dev_get_resources(adev, &resource_list, is_memory, NULL);
+	ret = acpi_dev_get_memory_resources(adev, &resource_list);
 	if (ret < 0)
 		return ret;
 
-- 
2.20.1

