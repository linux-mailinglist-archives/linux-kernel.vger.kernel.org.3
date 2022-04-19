Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AD3507D23
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 01:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358435AbiDSXTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 19:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358416AbiDSXTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 19:19:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCCD38BC3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 16:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650410223; x=1681946223;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6SzQX/by75bQNuDYVkjrzN87rgNCffZYmvkskNk4Gtg=;
  b=E0yQG6iiJiGAWmh4OYVflCWsIkNgdQuAsQDAmPpKH/BwohJqYUeUB1VN
   9nKiSypAMfWThhpz1UD8jjSSqyQtnSecr9BPYpBfvkQWoVqf4ku7XkA21
   cwTGPodnsRC3MqWeOQ83yOVg9Ra+MLneFvqoMC95yM0NJXn8pecVBnrJj
   M1HfaMv0opQ5W5n0hAFmUt34jsYn/jdyR/jgap/srd4rY8zgkMQWNQBW5
   p6pxpayX3rwXtuj+x2FDZjL4ZxMzorzbZgJksRXCtnvCfZh3uY10m2bKC
   a9CqsQkRxNOE9rVNi2HdJYKBXlMcGBcGJpUiXBDzSMJ0tKdLA81TO/DJQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="263656650"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="263656650"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 16:17:02 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="862277655"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.209.68.17])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 16:17:01 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mcgrof@kernel.org, rafael@kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v4 1/8] firmware_loader: Clear data and size in fw_free_paged_buf
Date:   Tue, 19 Apr 2022 16:16:51 -0700
Message-Id: <20220419231658.664388-2-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220419231658.664388-1-russell.h.weight@intel.com>
References: <20220419231658.664388-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Tianfei zhang <tianfei.zhang@intel.com>
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

