Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9EC502F87
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 22:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350943AbiDOUKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 16:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245026AbiDOUKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 16:10:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A2DC1C8E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 13:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650053290; x=1681589290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=toKkPquDR3AGm7Vzv0WyTxG86xwqQ846wTwgVCvCxd0=;
  b=TjYxubP+4bWZHk/42RRqHFwDHGUcu7gQLdBL7EtLbt6SsBT2rMxpC9gI
   y8RRrcnfHoL0+U0T3iR/f9P852LFB3zM2bFrlvGf7CfH3dDVov0QMcJcR
   78vqoJNx33tzAjonmc16OZxoNKXTRl8/76mFAMKrkDCJ9kdqUqnUv9ior
   9/L9iRCjDljEqw4Hvey+nXQ2bkLX1AJ8KGy3pkl8TrtyQ771FaNfsHOnb
   da/UGQiTU8UX9n/uQsS4lL7WbYZRzBpmFU0i5FW/nsV6KpOd8XV5E7xtU
   J/EEikWtWoHeatqdHmqeQxcgC3MMVxfmCY/YUuIWEsIxfjYx90e8EwyGj
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="262078943"
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="262078943"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 13:08:09 -0700
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="574510686"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.209.98.156])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 13:08:09 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mcgrof@kernel.org, rafael@kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v2 1/8] firmware_loader: Clear data and size in fw_free_paged_buf
Date:   Fri, 15 Apr 2022 13:07:58 -0700
Message-Id: <20220415200805.610339-2-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415200805.610339-1-russell.h.weight@intel.com>
References: <20220415200805.610339-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
v1:
  - No change from RFC patch
v2:
  - No change
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

