Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA5F566500
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiGEI1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 04:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiGEI1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 04:27:01 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B78D70
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 01:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657009620; x=1688545620;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZwgOyO8x7ekBRoriCEMkMwJo2RJQ5YECyfn3XeLMN74=;
  b=ioaSGYagOltySpJ5dA5pUq5GItIpeCT784WTatKgdTDaK3IrX763DIqN
   fyKocAWrAN3UiT2U18wAK3Nyfjfg7CXYtIzXgKK27cy7mnm1UDOh9CoyW
   ahvgO9vZoUfdqgmmG0glznZy9M8un3Ol/gWtb571wM0CRvl/gDbQHfWBA
   xW3HmsarzYD2AEikM3yPrxto15pe4wMqO1Rbn91xr59GedSAY4nLGE1GD
   6RhiI6hZvwJvBt3YtFlUH3DwDG5VIgV7sVWKi93MTTl2+W6NhqGByMsWi
   pPIETtpIqiLn90tzI84kqmrljK7F9PyrHZx7MyNBQGAT+ansDKSajJsPk
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="263713127"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="263713127"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 01:26:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="592834128"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 05 Jul 2022 01:26:58 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/6] intel_th: Fix a resource leak in an error handling path
Date:   Tue,  5 Jul 2022 11:26:32 +0300
Message-Id: <20220705082637.59979-2-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220705082637.59979-1-alexander.shishkin@linux.intel.com>
References: <20220705082637.59979-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

If an error occurs after calling 'pci_alloc_irq_vectors()',
'pci_free_irq_vectors()' must be called as already done in the remove
function.

Fixes: 7b7036d47c35 ("intel_th: pci: Use MSI interrupt signalling")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwtracing/intel_th/pci.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index 7da4f298ed01..fcd0aca75007 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -100,8 +100,10 @@ static int intel_th_pci_probe(struct pci_dev *pdev,
 		}
 
 	th = intel_th_alloc(&pdev->dev, drvdata, resource, r);
-	if (IS_ERR(th))
-		return PTR_ERR(th);
+	if (IS_ERR(th)) {
+		err = PTR_ERR(th);
+		goto err_free_irq;
+	}
 
 	th->activate   = intel_th_pci_activate;
 	th->deactivate = intel_th_pci_deactivate;
@@ -109,6 +111,10 @@ static int intel_th_pci_probe(struct pci_dev *pdev,
 	pci_set_master(pdev);
 
 	return 0;
+
+err_free_irq:
+	pci_free_irq_vectors(pdev);
+	return err;
 }
 
 static void intel_th_pci_remove(struct pci_dev *pdev)
-- 
2.35.1

