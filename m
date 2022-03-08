Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A474D23A3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 22:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350574AbiCHVul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 16:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350542AbiCHVuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:50:35 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44F055776
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 13:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646776178; x=1678312178;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GOiAjTPeaO1Y67tWOWbtPHqr4adIVhLTpNaSxGdkoOM=;
  b=K71S3bytmDK9Z1Q//mQib1iYNoN/h+K/wN+JvTldNasTtPWvITulPbGy
   FMe3GBMZicua9n76fOLeDvkZ25ydfIwtePho/GwY2e6DvfCtqNsn2JLNv
   JF9nkgJt/3VWaWZV0iClXtCKG0gzA9GZUrCTF1h1J/iPaF0MwTxCKdyts
   JdYUdobmj9/CC4Zo/PaD5ABwIidS828rooh3pqStGuQ0xUB6d7SlxDS7M
   ZBLM6jlD/kA8lfvSiB01QbJBCr3mDkhGGKahJwMSTewD5NdNLgUBwqUDI
   OZi9JBQHfPyJOiqnPD993RkLumXU9qRI3lisr6W5orvwxwYNhZbuYa6Ws
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="254553225"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="254553225"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 13:49:37 -0800
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="495612828"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.212.239.204])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 13:49:37 -0800
From:   Russ Weight <russell.h.weight@intel.com>
To:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v1 1/8] firmware_loader: Clear data and size in fw_free_paged_buf
Date:   Tue,  8 Mar 2022 13:49:25 -0800
Message-Id: <20220308214932.24477-2-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308214932.24477-1-russell.h.weight@intel.com>
References: <20220308214932.24477-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

