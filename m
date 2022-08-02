Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134EB5882F6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 22:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbiHBUJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 16:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbiHBUJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 16:09:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF64853D27
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 13:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659470990; x=1691006990;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U59KtBgaCpfNIdztFpCknLJxnYxEbEefieDqDELq+as=;
  b=epwQHJcJuxL6b4EaRiOTRjxzkqueYJTVluGkN4hd9UBm3cWZozy82PR8
   Y2eXUT80h2QbfkkVUJwEs8pIeGGK7N7vMGAhRZTj0FYTnz7NOPkK6SdBa
   Yyi/bjGvAvoETggxB4GasAgDOaL5PUjku+VjTWT8XylcNPlddXr3VAGq9
   7IS31lh5Ihq8AV3CvVfArLr20NVLbGT05847y0viD2ErCQoMmLB/vdQqD
   eMP21MQOj3SO6hvIHxWU4XAfbaQPzFwo+oYBzC/KuOuFtgk6Ls7TTlXFi
   yS5vUNzMy3jlKh4jcPQUWSC/gRYPrDcG+Bbf3uFaAO/EGcyDjENbOkdWb
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="272555807"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="272555807"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 13:09:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="670586220"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.212.185.95])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 13:09:49 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mcgrof@kernel.org, rafael@kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v1 1/1] firmware_loader: Fix use-after-free during unregister
Date:   Tue,  2 Aug 2022 13:09:42 -0700
Message-Id: <20220802200942.98149-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the following code within firmware_upload_unregister(), the call
to device_unregister() results in the dev_release function freeing the
fw_upload_priv structure before it is dereferenced for the call to
module_put():

  device_unregister(&fw_sysfs->dev);
  module_put(fw_upload_priv->module);

This is fixed by copying fw_upload_priv->module to a local variable
before calling device_unregister() and then using the local variable
for the call to module_put().

Reported-by: kernel test robot <oliver.sang@intel.com>
Fixes: 97730bbb242c (firmware_loader: Add firmware-upload support)
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
 drivers/base/firmware_loader/sysfs_upload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
index 87044d52322a..63e15bddd80c 100644
--- a/drivers/base/firmware_loader/sysfs_upload.c
+++ b/drivers/base/firmware_loader/sysfs_upload.c
@@ -377,6 +377,7 @@ void firmware_upload_unregister(struct fw_upload *fw_upload)
 {
 	struct fw_sysfs *fw_sysfs = fw_upload->priv;
 	struct fw_upload_priv *fw_upload_priv = fw_sysfs->fw_upload_priv;
+	struct module *module = fw_upload_priv->module;
 
 	mutex_lock(&fw_upload_priv->lock);
 	if (fw_upload_priv->progress == FW_UPLOAD_PROG_IDLE) {
@@ -392,6 +393,6 @@ void firmware_upload_unregister(struct fw_upload *fw_upload)
 
 unregister:
 	device_unregister(&fw_sysfs->dev);
-	module_put(fw_upload_priv->module);
+	module_put(module);
 }
 EXPORT_SYMBOL_GPL(firmware_upload_unregister);
-- 
2.25.1

