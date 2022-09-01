Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC3C5A987E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbiIANXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiIANX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:23:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B0630E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662038605; x=1693574605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PXxOKoGywk+ZZAqueqtRGLpoP26979U19XLkh+q4+jI=;
  b=fyaX4fCIv3/GvzDxTTBeLjDnpeJBsVT6s7vOqTu8Kfvae7JFuM4DTHjc
   lGCGZ0aePgpNVuad+CVjD6s8JSuvvWoGAh+8WUVHaREajuUm4GXliCMsw
   SpFYfiwyuQ4Lp+DSnJTfkqjhEX/XJ7yQrMkTlOYOwkgcDv+JNyTvD4aRV
   WAGXGT8AUBkyzO0gqLbuiGX/Gvxidza/NxsGZGT3MFMGRra3kyLNrP91T
   2/UtTJQJpcsqgOgoh925uDwJUYt/3WiVPxmb67ZXLtsHQx2CCRkuDiikN
   ZczkJ4NtPqUcougfO08Sz8u3tyN0CVqOG4jCbtYPlrHoV0sEDytkePKsL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="278728850"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="278728850"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 06:23:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="680853423"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 01 Sep 2022 06:23:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7F21849F; Thu,  1 Sep 2022 16:23:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 2/3] regmap: trace: Remove explicit castings
Date:   Thu,  1 Sep 2022 16:23:35 +0300
Message-Id: <20220901132336.33234-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220901132336.33234-1-andriy.shevchenko@linux.intel.com>
References: <20220901132336.33234-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to have explicit castings to the same type the
variables are of. Remove the explicit castings.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/trace.h | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/base/regmap/trace.h b/drivers/base/regmap/trace.h
index e92edc4f4ca5..a0f83e44a9d1 100644
--- a/drivers/base/regmap/trace.h
+++ b/drivers/base/regmap/trace.h
@@ -32,9 +32,7 @@ DECLARE_EVENT_CLASS(regmap_reg,
 		__entry->val = val;
 	),
 
-	TP_printk("%s reg=%x val=%x", __get_str(name),
-		  (unsigned int)__entry->reg,
-		  (unsigned int)__entry->val)
+	TP_printk("%s reg=%x val=%x", __get_str(name), __entry->reg, __entry->val)
 );
 
 DEFINE_EVENT(regmap_reg, regmap_reg_write,
@@ -85,8 +83,7 @@ DECLARE_EVENT_CLASS(regmap_bulk,
 		memcpy(__get_dynamic_array(buf), val, val_len);
 	),
 
-	TP_printk("%s reg=%x val=%s", __get_str(name),
-		  (unsigned int)__entry->reg,
+	TP_printk("%s reg=%x val=%s", __get_str(name), __entry->reg,
 		  __print_hex(__get_dynamic_array(buf), __entry->val_len))
 );
 
@@ -124,9 +121,7 @@ DECLARE_EVENT_CLASS(regmap_block,
 		__entry->count = count;
 	),
 
-	TP_printk("%s reg=%x count=%d", __get_str(name),
-		  (unsigned int)__entry->reg,
-		  (int)__entry->count)
+	TP_printk("%s reg=%x count=%d", __get_str(name), __entry->reg, __entry->count)
 );
 
 DEFINE_EVENT(regmap_block, regmap_hw_read_start,
@@ -196,8 +191,7 @@ DECLARE_EVENT_CLASS(regmap_bool,
 		__entry->flag = flag;
 	),
 
-	TP_printk("%s flag=%d", __get_str(name),
-		  (int)__entry->flag)
+	TP_printk("%s flag=%d", __get_str(name), __entry->flag)
 );
 
 DEFINE_EVENT(regmap_bool, regmap_cache_only,
@@ -283,8 +277,7 @@ TRACE_EVENT(regcache_drop_region,
 		__entry->to = to;
 	),
 
-	TP_printk("%s %u-%u", __get_str(name), (unsigned int)__entry->from,
-		  (unsigned int)__entry->to)
+	TP_printk("%s %u-%u", __get_str(name), __entry->from, __entry->to)
 );
 
 #endif /* _TRACE_REGMAP_H */
-- 
2.35.1

