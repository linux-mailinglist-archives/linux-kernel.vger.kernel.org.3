Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29314E5BDA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 00:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346084AbiCWXfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 19:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346014AbiCWXfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 19:35:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C40074DCC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 16:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648078416; x=1679614416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GOiAjTPeaO1Y67tWOWbtPHqr4adIVhLTpNaSxGdkoOM=;
  b=Zfa0alzxX9dYntwo6fZ+b69hENuH6GeKsc9eUk7hmI67SH//OUfWB+dX
   ZhUzvl8ZqL9E9YErs4kvZleK6eEkKM2yaXbSvMMrIVdfsrd5/wQAgB0NX
   o4+8jFt8j/sLiOqhuD2+qfg1J06JLqqLmOz9PvD3FNrjCAuRUuG9+taSu
   o/RL+AKEUkvMDkJWBKnlwtrkRyQF+wdEp5u2ADtgytakYahbU7VpEZ83u
   N6b3P6oIZ7D+A9wDH7uueUZ+MFGl56g9I5YAL3JPIYGDPM87cK61Q+ieH
   QDzwCk6lJN0nvqBmJA46tuDOPV09Ovl3oJBJtmzK3uFj5Xm99531OV7pK
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="258202352"
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="258202352"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 16:33:36 -0700
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="583880264"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.212.130.166])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 16:33:35 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [RESEND PATCH v1 1/8] firmware_loader: Clear data and size in fw_free_paged_buf
Date:   Wed, 23 Mar 2022 16:33:24 -0700
Message-Id: <20220323233331.155121-2-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220323233331.155121-1-russell.h.weight@intel.com>
References: <20220323233331.155121-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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

