Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B779A50AAB9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 23:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441940AbiDUVZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 17:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441929AbiDUVZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 17:25:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11A04BFE3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 14:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650576128; x=1682112128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bhT7Q8/ADSBtr63pT3T/HE2mvjBAH3w7Yptf5Y/H4HU=;
  b=ZZv4q1arXrsizz7D1pJHKVn61Gz4Mm92zoKgIUcjGYDwXH2QDd3ADXxc
   h59YW2SlJ9c4rYTGdTMu0mXxSl1ve5gLhPikdmcjJ2bzei6l73X4bA+wo
   9UG9eefYzPNZTo8wFfV4M8ZmuxocqbxT38NphPM3D4ytvFBMil2bj2urc
   +H5NJ0ChkGjiPE+citzS50HhEZrp1/2QMbaMHfzweptktYZER7bIP38CC
   AhZcJp0ds9AZ4wIumnNWjpMm+6DKFLevMU6mYGMzzKzPUwTTcPwpKb7tt
   0rnhWGlp1U+pPV43fp/XK2cI2/P6hzvQIrJW8ktwOJ1y6OWdLhVXSIgPF
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="350924990"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="350924990"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 14:22:08 -0700
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="658704071"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.209.56.239])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 14:22:07 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, marpagan@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v5 1/8] firmware_loader: Clear data and size in fw_free_paged_buf
Date:   Thu, 21 Apr 2022 14:21:57 -0700
Message-Id: <20220421212204.36052-2-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421212204.36052-1-russell.h.weight@intel.com>
References: <20220421212204.36052-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fw_free_paged_buf() function resets the paged buffer information in
the fw_priv data structure. Additionally, clear the data and size members
of fw_priv in order to facilitate the reuse of fw_priv. This is being
done in preparation for enabling userspace to initiate multiple firmware
uploads using this sysfs interface.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Tianfei zhang <tianfei.zhang@intel.com>
Tested-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
v1:
  - No change from RFC patch
v2:
  - No change
v3:
  - Added Reviewed-by tag
v4:
  - Added Reviewed-by tag
v5:
  - Added Tested-by tag
---
 drivers/base/firmware_loader/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 94d1789a233e..2cc11d93753a 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -253,6 +253,8 @@ void fw_free_paged_buf(struct fw_priv *fw_priv)
 	fw_priv->pages = NULL;
 	fw_priv->page_array_size = 0;
 	fw_priv->nr_pages = 0;
+	fw_priv->data = NULL;
+	fw_priv->size = 0;
 }
 
 int fw_grow_paged_buf(struct fw_priv *fw_priv, int pages_needed)
-- 
2.25.1

