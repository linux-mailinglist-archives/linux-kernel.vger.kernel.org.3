Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08EFF477F5C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237317AbhLPVmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:42:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57126 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241738AbhLPVlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:41:06 -0500
Date:   Thu, 16 Dec 2021 21:41:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690865;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=slrX2pl+WFOWs/15zNN0qiX50qdZobQtVBfeMsh/+Sk=;
        b=YgvyZ3zLA66nEoGxot6NJEHZpWoWvEC1EgFlNCpEzuBzS9PMfk+UmOnY8bxSJHhZUSB2/A
        2QQASCbIuzMPukCdD15ZY1hzQ2NdE4aHwWvu5L+7Q0vmwNQq6X7GENnBhuAeKA2dlVN1n2
        XsmrbbOyWIoFgys2TRGpmrdQ5uDBEnxFmTA2aGr5l9Rarg+QNO0RqRH1r3EZnJr+ICfLQ/
        7rf5PFDqVqzh3k5IbXqw20A+dcliwiN0ffflDcgij6g189MIGdVWfG/3b439B79pOcsV9+
        +BEGYhCwE+Ldpi5TpOF9z5lr439bCUgeL9mqB6z/bXyrJkG8qnUWeVcdc7Wh0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690865;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=slrX2pl+WFOWs/15zNN0qiX50qdZobQtVBfeMsh/+Sk=;
        b=YB5kpBgp1Q+FQoDrgzyhV5WHXpQoqXQ0xjbxwwFSeG43so9DjQlV9VGC1caq0fAlZLdu+8
        1PKfEBRd/qyuimBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] soc: ti: ti_sci_inta_msi: Allocate MSI device data on
 first use
Cc:     Thomas Gleixner <tglx@linutronix.de>, Nishanth Menon <nm@ti.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211210221813.928842960@linutronix.de>
References: <20211210221813.928842960@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969086476.23020.7981993290223113745.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     686073e9f8466de259971f1acd81b19a39e2162b
Gitweb:        https://git.kernel.org/tip/686073e9f8466de259971f1acd81b19a39e2162b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 10 Dec 2021 23:19:01 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:16:39 +01:00

soc: ti: ti_sci_inta_msi: Allocate MSI device data on first use

Allocate the MSI device data on first invocation of the allocation function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Nishanth Menon <nm@ti.com>
Link: https://lore.kernel.org/r/20211210221813.928842960@linutronix.de

---
 drivers/soc/ti/ti_sci_inta_msi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/ti/ti_sci_inta_msi.c b/drivers/soc/ti/ti_sci_inta_msi.c
index 428a482..a89bcbc 100644
--- a/drivers/soc/ti/ti_sci_inta_msi.c
+++ b/drivers/soc/ti/ti_sci_inta_msi.c
@@ -120,6 +120,10 @@ int ti_sci_inta_msi_domain_alloc_irqs(struct device *dev,
 	if (pdev->id < 0)
 		return -ENODEV;
 
+	ret = msi_setup_device_data(dev);
+	if (ret)
+		return ret;
+
 	nvec = ti_sci_inta_msi_alloc_descs(dev, res);
 	if (nvec <= 0)
 		return nvec;
