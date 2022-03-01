Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCFC4C813E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 03:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbiCACuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 21:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiCACua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 21:50:30 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789EE4739D;
        Mon, 28 Feb 2022 18:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646102983; x=1677638983;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8eXFRq2MSU2EHz63ODKG6BPK3XE2iJj4bWnW+A+qYFg=;
  b=IGRGUH3xsfhv7e77bxxJRFdC7172mOtDtAwCfhdJHOhcm4+VLRCF/Xyw
   MjxSmrALaIsUcULobozspnGWXtdEvPrKC5HzJvFsm9R9Oc7u4TwQxL1DE
   61bw5p9+FXFgLxL/KA2BSmdfmXVItaMNa9HK9juyeFovl2nUIGo61JAFp
   a0uitW0eRu/A3js6ZkXwlmxmYTOkvC+5XOblXt9da0ck6NGhteW6JbGkG
   rBjjqq1vv3fwrE0UmOrVCj0kkTJ1o2DVMyOgSckPpVOCDxplp//BmYJ6k
   UEXMdQ85q41IJuoT1Mh7aTL2P24pBz1NlPgDXP89+QhGRWOSHWKi4t0MJ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="233659282"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="233659282"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 18:49:43 -0800
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="507645915"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 18:49:43 -0800
Subject: [PATCH 10/11] libnvdimm: Enable lockdep validation
From:   Dan Williams <dan.j.williams@intel.com>
To:     gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, alison.schofield@intel.com,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        nvdimm@lists.linux.dev
Date:   Mon, 28 Feb 2022 18:49:43 -0800
Message-ID: <164610298296.2682974.14404088631456886039.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164610292916.2682974.12924748003366352335.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164610292916.2682974.12924748003366352335.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register libnvdimm subsystem devices with a non-zero lock_class to
enable the device-core to track lock dependencies.

Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/bus.c     |    3 +++
 drivers/nvdimm/nd-core.h |    9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index f481831929eb..c2f70f9a8b70 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -363,6 +363,7 @@ struct nvdimm_bus *nvdimm_bus_register(struct device *parent,
 	if (rc)
 		goto err;
 
+	nvdimm_set_lock_class(&nvdimm_bus->dev);
 	rc = device_add(&nvdimm_bus->dev);
 	if (rc) {
 		dev_dbg(&nvdimm_bus->dev, "registration failed: %d\n", rc);
@@ -488,6 +489,7 @@ static void nd_async_device_register(void *d, async_cookie_t cookie)
 {
 	struct device *dev = d;
 
+	nvdimm_set_lock_class(dev);
 	if (device_add(dev) != 0) {
 		dev_err(dev, "%s: failed\n", __func__);
 		put_device(dev);
@@ -741,6 +743,7 @@ int nvdimm_bus_create_ndctl(struct nvdimm_bus *nvdimm_bus)
 	if (rc)
 		goto err;
 
+	nvdimm_set_lock_class(dev);
 	rc = device_add(dev);
 	if (rc) {
 		dev_dbg(&nvdimm_bus->dev, "failed to register ndctl%d: %d\n",
diff --git a/drivers/nvdimm/nd-core.h b/drivers/nvdimm/nd-core.h
index 90c4029c87d2..40065606a6e6 100644
--- a/drivers/nvdimm/nd-core.h
+++ b/drivers/nvdimm/nd-core.h
@@ -214,5 +214,14 @@ static inline int nvdimm_lock_class(struct device *dev)
 	else
 		return -1;
 }
+
+static inline void nvdimm_set_lock_class(struct device *dev)
+{
+	device_set_lock_class(dev, nvdimm_lock_class(dev));
+}
+#else
+static inline void nvdimm_set_lock_class(struct device *dev)
+{
+}
 #endif
 #endif /* __ND_CORE_H__ */

