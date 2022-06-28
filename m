Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F8955F140
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 00:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbiF1WWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 18:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbiF1WVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 18:21:44 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C687F3F8AD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 15:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656454713; x=1687990713;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GP4TKULo+0dCE2MYjkjdDu6d3CLiHVGP97oZm3iFrnA=;
  b=WvQgC5T1MHD5mdb5WVbJkBUhd8ruhP/7YdsMbRNyBDUTHJOPcum/6FA9
   cSWG1Aej7TCm/gyoGYjB2VHbBVT2t00N9VyZlzc5pziIWXT5YWjKYFt/o
   XKCwCMhYNSw0Ca70Xj43SFcWoHHIgy2aQp8VCFmigg8lKzUouPXpoXVPi
   aD79Q6vojuphuBXsL10r3IMjwratlu2s7F+GJLyGP3g0XiLfwBYkke1qv
   f2vz2ZTUrWX9Uw3xMxXMjRttSXjHZ9fw/xJx6n2by7RkvI2S+lq1Fqmae
   /7EEcSEFqSePKO+iciUQknec0A7ZtO4Trdc8k+p3K42TQVhBMlRoPyuIF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="280624287"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="280624287"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 15:17:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="647103471"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jun 2022 15:17:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2A4796E7; Wed, 29 Jun 2022 01:17:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 09/11] mfd: intel_soc_pmic_bxtwc: Use sysfs_emit() instead of sprintf()
Date:   Wed, 29 Jun 2022 01:17:45 +0300
Message-Id: <20220628221747.33956-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220628221747.33956-1-andriy.shevchenko@linux.intel.com>
References: <20220628221747.33956-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sysfs_emit() is preferred over sprintf() when formatting the value to be
returned to user space in show() functions, because it knows about sysfs
buffer specifics and has sanity checks.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
v2: added tag (Lee)

 drivers/mfd/intel_soc_pmic_bxtwc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index 5ac623eda1c1..db7bda114d2d 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -334,7 +334,7 @@ static unsigned long bxtwc_reg_addr;
 static ssize_t addr_show(struct device *dev,
 			 struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "0x%lx\n", bxtwc_reg_addr);
+	return sysfs_emit(buf, "0x%lx\n", bxtwc_reg_addr);
 }
 
 static ssize_t addr_store(struct device *dev,
@@ -362,7 +362,7 @@ static ssize_t val_show(struct device *dev,
 		return ret;
 	}
 
-	return sprintf(buf, "0x%02x\n", val);
+	return sysfs_emit(buf, "0x%02x\n", val);
 }
 
 static ssize_t val_store(struct device *dev,
-- 
2.35.1

