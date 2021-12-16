Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4E4477F66
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbhLPVmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236945AbhLPVlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:41:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99381C06179E;
        Thu, 16 Dec 2021 13:40:52 -0800 (PST)
Date:   Thu, 16 Dec 2021 21:40:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690850;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yUyUR9kHZetXXjZe+/X0X6K4NA5Cw4ZohjdudKznhMU=;
        b=cvofzCsTHOYaVN4tz31JGs6y5B843s+zM9O1bJ3hjQl8TKPcruoJotoG2lJDv1QAnikFPu
        m1H3F2OqZ5J34kaGH90zXNAC0sWCP5dz5dCM6psm3qgN35cWoD3BuuoAMAmKoChWVoaqJ6
        /hV8Tg8QL+EOeuRiug4sgwjpJTrfrNp5QLlQx0BDiMA4qNajlXnoyohpzw51+7pPK+6V0G
        W65bFQGALWQlr6FMqYfFD2wrkaMSyzcy9bccFkDTZHHao+cz3jzRV8uxSnqFlHr8huS3KR
        0jNjkJl6BkYfPyUUrRnfdCbzkQ8umKjy8d4ucfHbdK6V45f8Rzo9QBprXOVZaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690850;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yUyUR9kHZetXXjZe+/X0X6K4NA5Cw4ZohjdudKznhMU=;
        b=ZFe8tL2JyupDWmFLq4pqgLGt5uC+S88qdhj/4UtDSKv9UzspdvEYQTY5lwiDTKXj/2QDxo
        1Qr42EpwD+e2gfCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] perf/smmuv3: Use msi_get_virq()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211210221815.029143589@linutronix.de>
References: <20211210221815.029143589@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969084973.23020.8140162082102145361.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     848456705565da8de0fac4f6487f2a04813f60cc
Gitweb:        https://git.kernel.org/tip/848456705565da8de0fac4f6487f2a04813f60cc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 10 Dec 2021 23:19:29 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:16:41 +01:00

perf/smmuv3: Use msi_get_virq()

Let the core code fiddle with the MSI descriptor retrieval.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211210221815.029143589@linutronix.de

---
 drivers/perf/arm_smmuv3_pmu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 2263488..fdbc3ec 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -684,7 +684,6 @@ static void smmu_pmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 
 static void smmu_pmu_setup_msi(struct smmu_pmu *pmu)
 {
-	struct msi_desc *desc;
 	struct device *dev = pmu->dev;
 	int ret;
 
@@ -701,9 +700,7 @@ static void smmu_pmu_setup_msi(struct smmu_pmu *pmu)
 		return;
 	}
 
-	desc = first_msi_entry(dev);
-	if (desc)
-		pmu->irq = desc->irq;
+	pmu->irq = msi_get_virq(dev, 0);
 
 	/* Add callback to free MSIs on teardown */
 	devm_add_action(dev, smmu_pmu_free_msis, dev);
