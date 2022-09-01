Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADA45A987D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbiIANXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbiIANX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:23:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993C03B7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662038605; x=1693574605;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Uf4uabdWV4txRLk2bqOo6gQ1Ue/HvWqnSFldAB4rgj0=;
  b=RFiTqGAjzQariw3b+H0eHYF4n70Wn6+XolmoWU8erdFNm96Me/QZb3cx
   KYW5UUx2lyZJMHXdjsd/yQ6MZpF8dOnohvU17pMPNsKJhsCxFJzP921Mh
   AoLZqJLSIgz2t3amgf6KezZfJt995Pjr4/3n6zhyzknh+n3dYzqBaGPaU
   qMiRv+xuyiRMurc3wuZiOTo2GpwGU8fAdR4ikQmBR925ihpSYuxCyV6Bd
   1h1ML1lMr2fe+E+kW2VcNKj8Javvhvi6yITJVxp35ddLMDMiWaIsYTPKU
   nyYPTFVJS3DccgRR/oEDeBFMyRJ8hT+WzlsbknYzAyMOZF9CuUt/07ULk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="276113223"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="276113223"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 06:23:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="612489901"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 01 Sep 2022 06:23:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 67840238; Thu,  1 Sep 2022 16:23:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 1/3] regmap: trace: Remove useless check for NULL for bulk ops
Date:   Thu,  1 Sep 2022 16:23:34 +0300
Message-Id: <20220901132336.33234-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the buffer pointer is NULL we already are in troubles since
regmap bulk API expects caller to provide valid parameters,
it dereferences that without any checks before we call for
traces.

Moreover, the current code will print garbage in the case of
buffer is NULL and length is not 0.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/trace.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/regmap/trace.h b/drivers/base/regmap/trace.h
index 04329ba68ec5..e92edc4f4ca5 100644
--- a/drivers/base/regmap/trace.h
+++ b/drivers/base/regmap/trace.h
@@ -82,8 +82,7 @@ DECLARE_EVENT_CLASS(regmap_bulk,
 		__assign_str(name, regmap_name(map));
 		__entry->reg = reg;
 		__entry->val_len = val_len;
-		if (val)
-			memcpy(__get_dynamic_array(buf), val, val_len);
+		memcpy(__get_dynamic_array(buf), val, val_len);
 	),
 
 	TP_printk("%s reg=%x val=%s", __get_str(name),
-- 
2.35.1

