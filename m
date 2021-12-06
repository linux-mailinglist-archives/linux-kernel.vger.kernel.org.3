Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E089469FA2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391867AbhLFPug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:50:36 -0500
Received: from foss.arm.com ([217.140.110.172]:32832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1389177AbhLFPfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:35:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C64CED1;
        Mon,  6 Dec 2021 07:32:14 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5B77A3F5A1;
        Mon,  6 Dec 2021 07:32:13 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Pedro Batista <pedbap.g@gmail.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH] firmware: arm_scpi: Fix string overflow in SCPI genpd driver
Date:   Mon,  6 Dec 2021 15:31:50 +0000
Message-Id: <20211206153150.565685-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without the bound checks for scpi_pd->name, it could result in the buffer
overflow when copying the SCPI device name from the corresponding device
tree node as the name string is set at maximum size of 30.

Let us fix it by using kasprintf and devm_kstrdup so that the string
buffer is allocated dynamically.

Fixes: 8bec4337ad40 ("firmware: scpi: add device power domain support using genpd")
Reported-by: Pedro Batista <pedbap.g@gmail.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/scpi_pm_domain.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/scpi_pm_domain.c b/drivers/firmware/scpi_pm_domain.c
index 51201600d789..377272c06ac3 100644
--- a/drivers/firmware/scpi_pm_domain.c
+++ b/drivers/firmware/scpi_pm_domain.c
@@ -11,12 +11,12 @@
 #include <linux/of_platform.h>
 #include <linux/pm_domain.h>
 #include <linux/scpi_protocol.h>
+#include <linux/slab.h>

 struct scpi_pm_domain {
 	struct generic_pm_domain genpd;
 	struct scpi_ops *ops;
 	u32 domain;
-	char name[30];
 };

 /*
@@ -106,12 +106,18 @@ static int scpi_pm_domain_probe(struct platform_device *pdev)
 		return -ENOMEM;

 	for (i = 0; i < num_domains; i++, scpi_pd++) {
+		const char *name = kasprintf(GFP_KERNEL, "%pOFn%d", np, i);
+
 		domains[i] = &scpi_pd->genpd;

 		scpi_pd->domain = i;
 		scpi_pd->ops = scpi_ops;
-		sprintf(scpi_pd->name, "%pOFn.%d", np, i);
-		scpi_pd->genpd.name = scpi_pd->name;
+		scpi_pd->genpd.name = devm_kstrdup(dev, name, GFP_KERNEL);
+		if (!scpi_pd->genpd.name) {
+			dev_err(dev, "Failed to allocate genpd name for %s\n",
+				name);
+			continue;
+		}
 		scpi_pd->genpd.power_off = scpi_pd_power_off;
 		scpi_pd->genpd.power_on = scpi_pd_power_on;

@@ -122,6 +128,7 @@ static int scpi_pm_domain_probe(struct platform_device *pdev)
 		 * but for reference counting purpose, keep it this way.
 		 */
 		pm_genpd_init(&scpi_pd->genpd, NULL, true);
+		kfree(name);
 	}

 	scpi_pd_data->domains = domains;
--
2.25.1

