Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BFA4FEF2C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbiDMGEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbiDMGEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:04:21 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C985132A;
        Tue, 12 Apr 2022 23:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649829721; x=1681365721;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=71SXlL7E70/JQd0lNPz9C9v0IgR6KTTs4c9CnrGttxc=;
  b=MHCTqULph0N04BwRbY+O0FQ0+NQJD7hdcy5ef3ZW3zPunCALQDlLnupd
   n/HKFo3tPaGAX5sSjl1EkSCqomAYk8NOovDCML54Bw9IG47xUl4xyphvq
   Or3k1pn6SRPMN/cuTw0q1DNw1I11aT0al1x4mzWUuKeMnjz5Kwy0TFzR3
   4LEbb3vxQ2arUrWFjuZ3I1neAopS6Gsb7t1kGun5Srajf92W/qmXFHiVB
   UWgqwbSiDq/fKG3oeqLFxEA4Vm7NlDfq0O7tZtmuYwvmDS6GH6MA3ZXMl
   GT54skJcoUFhWlBcRqFhmidva4U6XpBrIAdfeMEKSMdGI4H2U4y2EBi3z
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="261430845"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="261430845"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 23:02:00 -0700
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="507854405"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 23:02:00 -0700
Subject: [PATCH v2 06/12] cxl/core: Use dev->lock_class for device_lock()
 lockdep validation
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kevin Tian <kevin.tian@intel.com>, peterz@infradead.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev
Date:   Tue, 12 Apr 2022 23:02:00 -0700
Message-ID: <164982972055.684294.1452258386098745666.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164982968798.684294.15817853329823976469.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164982968798.684294.15817853329823976469.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update CONFIG_PROVE_CXL_LOCKING to use the common device-core helpers
for device_lock validation.

When CONFIG_PROVE_LOCKING is enabled, and device_set_lock_class() is
passed a non-zero lock class , the core acquires the 'struct device'
@lockdep_mutex everywhere it acquires the device_lock. Where
lockdep_mutex does not skip lockdep validation like device_lock.

cxl_set_lock_class() arranges to turn off CXL lock validation depending
on the value of CONFIG_PROVE_CXL_LOCKING, which is a Kconfig 'choice'
between the all subsystems that want to use dev->lockdep_mutex for
lockdep validation. For now, that 'choice' is just between the NVDIMM
and CXL subsystems.

Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/memdev.c |    1 +
 drivers/cxl/core/pmem.c   |    2 ++
 drivers/cxl/core/port.c   |    2 ++
 drivers/cxl/cxl.h         |    9 +++++++++
 4 files changed, 14 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 1f76b28f9826..ad8c9f61c38a 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -343,6 +343,7 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 	cxlmd->cxlds = cxlds;
 
 	cdev = &cxlmd->cdev;
+	cxl_set_lock_class(dev);
 	rc = cdev_device_add(cdev, dev);
 	if (rc)
 		goto err;
diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index 60f71caa5dbd..b0eb0b795140 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -165,6 +165,7 @@ struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
 	if (rc)
 		goto err;
 
+	cxl_set_lock_class(dev);
 	rc = device_add(dev);
 	if (rc)
 		goto err;
@@ -261,6 +262,7 @@ int devm_cxl_add_nvdimm(struct device *host, struct cxl_memdev *cxlmd)
 	if (rc)
 		goto err;
 
+	cxl_set_lock_class(dev);
 	rc = device_add(dev);
 	if (rc)
 		goto err;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 437e8a71e5dc..eb450397104b 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -469,6 +469,7 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 	if (rc)
 		goto err;
 
+	cxl_set_lock_class(dev);
 	rc = device_add(dev);
 	if (rc)
 		goto err;
@@ -1349,6 +1350,7 @@ int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map)
 	if (is_root_decoder(dev))
 		cxld->platform_res.name = dev_name(dev);
 
+	cxl_set_lock_class(dev);
 	return device_add(dev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_decoder_add_locked, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b86aac8cde4f..fddbcb380e84 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -456,5 +456,14 @@ static inline int cxl_lock_class(struct device *dev)
 	else
 		return CXL_ANON_LOCK;
 }
+
+static inline void cxl_set_lock_class(struct device *dev)
+{
+	device_set_lock_class(dev, cxl_lock_class(dev));
+}
+#else
+static inline void cxl_set_lock_class(struct device *dev)
+{
+}
 #endif
 #endif /* __CXL_H__ */

