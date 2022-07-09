Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4AA56CB8B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 23:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiGIVRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 17:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiGIVQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 17:16:51 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3950E03C;
        Sat,  9 Jul 2022 14:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657401410; x=1688937410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NJDMm0L4h/dOQ6h5gnqt5/SsVOUXEVrkRUats68PgGs=;
  b=Yh5dsTUffq2fvCaqJq1CbO1+ZpIav6NJN/4bzIhOFqwyZn+lEEli9jwF
   cISCmWk9Pe9dtUAoPN6ZnlZksVjvyUFCfMLRd3DLJormkC2XJkaGhO70D
   VJzpBIU4Rdlb1PsQe7UflZ25qD4nyopjVbt/tQaC5Kt0MZ9Cnpcm31zQM
   nVhQo+6Wwt9GDNH3Mx8NMnV5f/4gpCrZIZZ45sfSpWIIBUwrDzyen4P7m
   nNIsISZwASkAoz5Ww8qaFKnla7MaD2gGyg7iUhQBh/WFkWBmloziozClR
   ItiEcIlMBsaMM/8hgGU8e33yRcxTvxDxQY0+XTQxM4t2PyKPLwlYgmg1E
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="264872815"
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="264872815"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 14:16:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="683991134"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jul 2022 14:16:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DB7B65CC; Sun, 10 Jul 2022 00:16:54 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 5/6] platform/x86: serial-multi-instantiate: Get rid of redundant 'else'
Date:   Sun, 10 Jul 2022 00:16:52 +0300
Message-Id: <20220709211653.18938-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220709211653.18938-1-andriy.shevchenko@linux.intel.com>
References: <20220709211653.18938-1-andriy.shevchenko@linux.intel.com>
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

In the snippets like the following

	if (...)
		return / goto / break / continue ...;
	else
		...

the 'else' is redundant. Get rid of it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
v2: added tag (Hans)
 drivers/platform/x86/serial-multi-instantiate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
index 0a2335693f4f..24f915bbdec1 100644
--- a/drivers/platform/x86/serial-multi-instantiate.c
+++ b/drivers/platform/x86/serial-multi-instantiate.c
@@ -98,7 +98,7 @@ static int smi_spi_probe(struct platform_device *pdev, struct smi *smi,
 	ret = acpi_spi_count_resources(adev);
 	if (ret < 0)
 		return ret;
-	else if (!ret)
+	if (!ret)
 		return -ENOENT;
 
 	count = ret;
@@ -180,7 +180,7 @@ static int smi_i2c_probe(struct platform_device *pdev, struct smi *smi,
 	ret = i2c_acpi_client_count(adev);
 	if (ret < 0)
 		return ret;
-	else if (!ret)
+	if (!ret)
 		return -ENOENT;
 
 	count = ret;
-- 
2.35.1

