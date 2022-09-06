Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2025AEF20
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbiIFPmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239140AbiIFPiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:38:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9F06C7432;
        Tue,  6 Sep 2022 07:48:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29BCC1AC1;
        Tue,  6 Sep 2022 07:24:37 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6E023F7B4;
        Tue,  6 Sep 2022 07:24:28 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        daniel.lezcano@linaro.org, tarek.el-sherbiny@arm.com,
        adrian.slatineanu@arm.com, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, wbartczak@marvell.com,
        dan.carpenter@oracle.com, lukasz.luba@arm.com
Subject: [PATCH v2 2/3] powercap: arm_scmi: Fix signedness bug in probe
Date:   Tue,  6 Sep 2022 15:23:36 +0100
Message-Id: <20220906142337.1697569-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220906142337.1697569-1-cristian.marussi@arm.com>
References: <20220906142337.1697569-1-cristian.marussi@arm.com>
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

The "pr->num_zones" variable is an unsigned int so it can't be less than
zero.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/powercap/arm_scmi_powercap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index a91438867f8c..76200c004cad 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -389,11 +389,12 @@ static int scmi_powercap_probe(struct scmi_device *sdev)
 	if (!pr)
 		return -ENOMEM;
 
-	pr->num_zones = powercap_ops->num_domains_get(ph);
-	if (pr->num_zones < 0) {
+	ret = powercap_ops->num_domains_get(ph);
+	if (ret < 0) {
 		dev_err(dev, "number of powercap domains not found\n");
-		return pr->num_zones;
+		return ret;
 	}
+	pr->num_zones = ret;
 
 	pr->spzones = devm_kcalloc(dev, pr->num_zones,
 				   sizeof(*pr->spzones), GFP_KERNEL);
-- 
2.32.0

