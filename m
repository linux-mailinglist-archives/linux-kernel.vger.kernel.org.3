Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F92585B0E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 17:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbiG3Psm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 11:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiG3Psk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 11:48:40 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A43915836;
        Sat, 30 Jul 2022 08:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659196119; x=1690732119;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/lkRKIKf5NUPYe0Arklh0YQ8Fp95nZE0357TMlZXoCw=;
  b=D0YmyrevmNFfNisdSPANV9FT8GbkmVVhaAQYhRBBtEgRxF8ViBQM/DXk
   nHDrK1p6VTrp+XNjuNy8rG4MqLFuB7J3mpTqt0eDeiY6/bB7Q524oBB8F
   wuCLxVlVhXyJgr1nAwfCF78YccaPzoNjrHCnCuCObgtDv6ghZQJ61pARl
   0vwfm9CuB/+opiX5SC14zaS64T4jCvPRZt7jagQf74HS1uTNfMrptPQhO
   g+v//YTuzxMKBJUAXOlp9N6a8XAoK3RXso0848uJzDQjR2RSfH0hli3KQ
   NH8+8YUYj8mJPXM07lnD0yymNwhUv96/d7Z+pSvNm8jf57r1RefzqMYOJ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="289695187"
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="289695187"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 08:48:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="660611414"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 30 Jul 2022 08:48:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E3A03F1; Sat, 30 Jul 2022 18:48:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yong Zhi <yong.zhi@intel.com>, Bingbu Cao <bingbu.cao@intel.com>,
        Dan Scally <djrscally@gmail.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] media: ipu3-cio2: Don't dereference fwnode handle
Date:   Sat, 30 Jul 2022 18:48:44 +0300
Message-Id: <20220730154844.89556-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use acpi_fwnode_handle() instead of dereferencing an fwnode handle directly,
which is a better coding practice.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/pci/intel/ipu3/cio2-bridge.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.c b/drivers/media/pci/intel/ipu3/cio2-bridge.c
index df6c94da2f6a..5998541d331c 100644
--- a/drivers/media/pci/intel/ipu3/cio2-bridge.c
+++ b/drivers/media/pci/intel/ipu3/cio2-bridge.c
@@ -263,7 +263,7 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
 				      struct cio2_bridge *bridge,
 				      struct pci_dev *cio2)
 {
-	struct fwnode_handle *fwnode;
+	struct fwnode_handle *fwnode, *current;
 	struct cio2_sensor *sensor;
 	struct acpi_device *adev;
 	acpi_status status;
@@ -322,7 +322,9 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
 		}
 
 		sensor->adev = acpi_dev_get(adev);
-		adev->fwnode.secondary = fwnode;
+
+		current = acpi_fwnode_handle(adev);
+		current->secondary = fwnode;
 
 		cio2_bridge_instantiate_vcm_i2c_client(sensor);
 
-- 
2.35.1

