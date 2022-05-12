Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347CE525210
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348472AbiELQGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242546AbiELQGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:06:36 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24CF5A5B8
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:06:34 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CCwbiG027802;
        Thu, 12 May 2022 18:06:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=aCPJszZbF0EkvfaNWtnvz2O8HhqAUWnZMspB/XLlJTc=;
 b=jSrqAe5w3uLXCt30iO79ToQxWlMmcrDrZuAQlBvMbhGHpAAmPJ7pErYGt/fer/BJ5/HB
 HCgn8jRV8LqQHfyLN+iMrrarW6Q1fqkfe7wSytdCxLJgTtqA5sFIPow1SJSK2r8bOXf4
 zZAw/kVpBlPuF7ziOLwKhAN13u3I2nCrruQuol3MqLDBaq4zzlAaCpJfmxooDP/FunEW
 144QXcgLbY1UKkXmqs198rwgzSVNR0KsVL+7mT0FiIwOgtX+db47y9DVOr34PbMMbwxo
 beqHFkAmwvkhXmzO/I/fP+ZgLqti8yYI+MZQiXq2iaSnr/DvPx8lO0aUwKPDj0amxY2U pQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3g083j3p08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 18:06:11 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 93A2110002A;
        Thu, 12 May 2022 18:06:10 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CA71322ECC9;
        Thu, 12 May 2022 18:06:09 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 12 May 2022 18:06:09
 +0200
From:   Antonio Borneo <antonio.borneo@foss.st.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Antonio Borneo <antonio.borneo@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] genirq: Don't return error on missing optional irq_request_resources()
Date:   Thu, 12 May 2022 18:05:44 +0200
Message-ID: <20220512160544.13561-1-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_12,2022-05-12_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function irq_chip::irq_request_resources() is reported as optional
in the declaration of struct irq_chip.
If the parent irq_chip does not implement it, we should ignore it
and return.

Don't return error if the functions is missing.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---

As follow-up of discussion in
https://lore.kernel.org/lkml/875ymd6xdu.wl-maz@kernel.org/
here is a proposal for changing the returned value.

A similar issue is present for the optional function
irq_set_vcpu_affinity(), to be covered separately, if needed.

---
 kernel/irq/chip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 54af0deb239b..eb921485930f 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1513,7 +1513,8 @@ int irq_chip_request_resources_parent(struct irq_data *data)
 	if (data->chip->irq_request_resources)
 		return data->chip->irq_request_resources(data);
 
-	return -ENOSYS;
+	/* no error on missing optional irq_chip::irq_request_resources */
+	return 0;
 }
 EXPORT_SYMBOL_GPL(irq_chip_request_resources_parent);
 

base-commit: c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a
-- 
2.36.0

