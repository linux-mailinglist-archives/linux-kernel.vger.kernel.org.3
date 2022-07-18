Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22404578236
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbiGRMXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbiGRMXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:23:36 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0051225595
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658147014; x=1689683014;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jz5cpYq86nZh92glinpz2Zo/OMEGYZaVz7jRMfspFQo=;
  b=etaqL/ABXmur0gsJFuthaSDlPwPhDdPHhwROtu9s55zjDtBiqxu6QCbw
   6C7x2xNJaSf2ZF3m/wYPTWW5d6eDyOCWDhdFrdXNTJk+cGZHiwRU2ETtd
   Wi/MEDO9sEeuL9hgvmH82AaQA+PlBF1I4CQYbKBU0ahjN792KBWNBJvBS
   P7jQSJKIz7xQL7yUiDm+etEzAM7+wCj92jqb/OaWrYx4fK0/7U3VRL9jv
   bbeyhp/qDBnfsLwseuyVJ5WCcmYC6pBkkbyH97tmcDTHPTvs3eY8NVzLn
   UYQJXZ1ac48WF0BAIiTKfWdrwmtkFp3+uoUxLS8d/kp4nzKP+62GtUC1f
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="311887737"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="311887737"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 05:23:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="686717795"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Jul 2022 05:23:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 87EE7195; Mon, 18 Jul 2022 15:23:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>
Subject: [RESEND][PATCH v1 9/9] Revert "mfd: intel_soc_pmic_bxtwc: Support IRQ chip hierarchy"
Date:   Mon, 18 Jul 2022 15:23:28 +0300
Message-Id: <20220718122328.8287-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220718122328.8287-1-andriy.shevchenko@linux.intel.com>
References: <20220718122328.8287-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 4a34dfdfcc185efea44da958b2e4a6005a70e7d4.
---
 drivers/mfd/intel_soc_pmic_bxtwc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index f9842ff44b3f..8dac0d41f64f 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -422,10 +422,8 @@ static int bxtwc_add_chained_irq_chip(struct intel_soc_pmic *pmic,
 		return dev_err_probe(pmic->dev, irq, "Failed to get parent vIRQ(%d) for chip %s\n",
 				     pirq, chip->name);
 
-	return __devm_regmap_add_irq_chip(pmic->dev, pmic->regmap, irq,
-					  irq_flags, 0,
-					  regmap_irq_get_domain(pdata),
-					  chip, data);
+	return devm_regmap_add_irq_chip(pmic->dev, pmic->regmap, irq, irq_flags,
+					0, chip, data);
 }
 
 static int bxtwc_probe(struct platform_device *pdev)
-- 
2.35.1

