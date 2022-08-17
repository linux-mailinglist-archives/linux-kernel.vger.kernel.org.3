Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B68D596D17
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 12:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239049AbiHQKzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238885AbiHQKyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:54:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A3C15D124;
        Wed, 17 Aug 2022 03:54:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2048D1576;
        Wed, 17 Aug 2022 03:54:50 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50EBE3F67D;
        Wed, 17 Aug 2022 03:54:47 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        daniel.lezcano@linaro.org, tarek.el-sherbiny@arm.com,
        adrian.slatineanu@arm.com, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, wbartczak@marvell.com,
        dan.carpenter@oracle.com
Subject: [PATCH 3/3] powercap: arm_scmi: Fix a NULL vs IS_ERR() bug
Date:   Wed, 17 Aug 2022 11:54:24 +0100
Message-Id: <20220817105424.3124006-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220817105424.3124006-1-cristian.marussi@arm.com>
References: <20220817105424.3124006-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

The powercap_register_control_type() return error pointers.  It never
returns NULL.

Fixes: 31afdd34f2b9 ("powercap: arm_scmi: Add SCMI powercap based driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/powercap/arm_scmi_powercap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index dc26cbb32b35..9993b7fa4993 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -521,8 +521,8 @@ static int __init scmi_powercap_init(void)
 	int ret;
 
 	scmi_top_pcntrl = powercap_register_control_type(NULL, "arm-scmi", NULL);
-	if (!scmi_top_pcntrl)
-		return -ENODEV;
+	if (IS_ERR(scmi_top_pcntrl))
+		return PTR_ERR(scmi_top_pcntrl);
 
 	ret = scmi_register(&scmi_powercap_driver);
 	if (ret)
-- 
2.32.0

