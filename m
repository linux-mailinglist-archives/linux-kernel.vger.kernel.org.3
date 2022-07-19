Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F81E57A83C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 22:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238784AbiGSUdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 16:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbiGSUdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 16:33:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58A65071E;
        Tue, 19 Jul 2022 13:33:05 -0700 (PDT)
Date:   Tue, 19 Jul 2022 20:33:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658262784;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cIsMs7OHJK9RhnvGE3HARSdFL8Srnkh5+LhtxvKw9UU=;
        b=ewfoxlJNTdO6zJDtCG9puVQkj1qXId1QUzYdVAelobhHvQm1pWB2DcxKLd3u80CehvMFCk
        HuHmUwH0tnY1RteNERs1x/Nz5k/W8fEAPgs0o1TGBxqelWx4NOa9bTKHH5LtAiTATtsgz6
        vRhgCscC8KhZB0H1jKLuWhpghwyMOdnqEyiBMH3q8m2pBYj/k+qELZgBRAuXyuKfnOuiPY
        r6VH2aIAcvZCY7dfBtQ1yyh9a+LJ0SOk/+IflIiNWdkXxaAAStLOKww5F79iY2VuXIouxC
        cfk8a5XHTz5U88+yClgE5lUHI8yjrD9ui6iTr5+nVpRd09v50s8Sgg4H/txMFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658262784;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cIsMs7OHJK9RhnvGE3HARSdFL8Srnkh5+LhtxvKw9UU=;
        b=mrpUjl3wiXJxq6fbv4noXPXxXZkc4DpgtdmYQuSz0GKzRYUDHbfUR8FjcxIv83OetB1jRo
        CBFsjVez1VENI/Cg==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] virt: sev-guest: Pass the appropriate argument type
 to iounmap()
Cc:     kernel test robot <lkp@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <202207150617.jqwQ0Rpz-lkp@intel.com>
References: <202207150617.jqwQ0Rpz-lkp@intel.com>
MIME-Version: 1.0
Message-ID: <165826278306.15455.11144334567152643727.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     908fc4c2abdb1835f303cf6827e66676568943e7
Gitweb:        https://git.kernel.org/tip/908fc4c2abdb1835f303cf6827e66676568943e7
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Tue, 19 Jul 2022 12:12:52 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 19 Jul 2022 22:26:02 +02:00

virt: sev-guest: Pass the appropriate argument type to iounmap()

Fix a sparse warning in sev_guest_probe() where the wrong argument type is
provided to iounmap().

Fixes: fce96cf04430 ("virt: Add SEV-SNP guest driver")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/202207150617.jqwQ0Rpz-lkp@intel.com
---
 drivers/virt/coco/sev-guest/sev-guest.c |  9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 90ce16b..f422f9c 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -632,16 +632,19 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct snp_guest_dev *snp_dev;
 	struct miscdevice *misc;
+	void __iomem *mapping;
 	int ret;
 
 	if (!dev->platform_data)
 		return -ENODEV;
 
 	data = (struct sev_guest_platform_data *)dev->platform_data;
-	layout = (__force void *)ioremap_encrypted(data->secrets_gpa, PAGE_SIZE);
-	if (!layout)
+	mapping = ioremap_encrypted(data->secrets_gpa, PAGE_SIZE);
+	if (!mapping)
 		return -ENODEV;
 
+	layout = (__force void *)mapping;
+
 	ret = -ENOMEM;
 	snp_dev = devm_kzalloc(&pdev->dev, sizeof(struct snp_guest_dev), GFP_KERNEL);
 	if (!snp_dev)
@@ -706,7 +709,7 @@ e_free_response:
 e_free_request:
 	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
 e_unmap:
-	iounmap(layout);
+	iounmap(mapping);
 	return ret;
 }
 
