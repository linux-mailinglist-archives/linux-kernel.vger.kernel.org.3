Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB48350DA8A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbiDYHzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237584AbiDYHw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:52:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00732113
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650872997; x=1682408997;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Olr/UAxz6mOZ13vGKwY6QrXads5Ij3YBYs7osIbTZXI=;
  b=jzvIJn8dqJNbXt/hB1idZNMMqQ4zsFrotknlD9Xq/D83DwR8NrMSRDMC
   Bk3KP3dTpZJod25Vmhomk8OLQPfmBJgspHr69va5De4xJFOKHIsAJ+MQ7
   MElq9bVrwOrvuk6iGr0k8kn8aRpTb/CBDmCjl38JyQoI2C0/1r2uPPny+
   oZn9hhCft0nZIzkOwijCRIUiQBf9zoifuQvzi9k/02KxzhX4OnU9nJQox
   +3NoNcmIrg1j337Dq/EHZF0GWXM4+rsSVUdQG6sQrFNMDQr18tMApBrpZ
   /VjKW9vHY2MIgaCP9jIMcKScpKYe257pna3D2iFU9cyn+vPmNy4t0p82C
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="264973804"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="264973804"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 00:49:56 -0700
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="557600075"
Received: from sannilnx.jer.intel.com ([10.12.231.73])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 00:49:53 -0700
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/14] mei: debugfs: add pxp mode to devstate in debugfs
Date:   Mon, 25 Apr 2022 10:49:00 +0300
Message-Id: <20220425074901.3991274-14-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220425074901.3991274-1-alexander.usyskin@intel.com>
References: <20220425074901.3991274-1-alexander.usyskin@intel.com>
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

From: Tomas Winkler <tomas.winkler@intel.com>

CC: Vitaly Lubart <vitaly.lubart@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/debugfs.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/misc/mei/debugfs.c b/drivers/misc/mei/debugfs.c
index 1ce61e9e24fc..4074fec866a6 100644
--- a/drivers/misc/mei/debugfs.c
+++ b/drivers/misc/mei/debugfs.c
@@ -86,6 +86,20 @@ static int mei_dbgfs_active_show(struct seq_file *m, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(mei_dbgfs_active);
 
+static const char *mei_dev_pxp_mode_str(enum mei_dev_pxp_mode state)
+{
+#define MEI_PXP_MODE(state) case MEI_DEV_PXP_##state: return #state
+	switch (state) {
+	MEI_PXP_MODE(DEFAULT);
+	MEI_PXP_MODE(INIT);
+	MEI_PXP_MODE(SETUP);
+	MEI_PXP_MODE(READY);
+	default:
+		return "unknown";
+	}
+#undef MEI_PXP_MODE
+}
+
 static int mei_dbgfs_devstate_show(struct seq_file *m, void *unused)
 {
 	struct mei_device *dev = m->private;
@@ -112,6 +126,9 @@ static int mei_dbgfs_devstate_show(struct seq_file *m, void *unused)
 	seq_printf(m, "pg:  %s, %s\n",
 		   mei_pg_is_enabled(dev) ? "ENABLED" : "DISABLED",
 		   mei_pg_state_str(mei_pg_state(dev)));
+
+	seq_printf(m, "pxp: %s\n", mei_dev_pxp_mode_str(dev->pxp_mode));
+
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(mei_dbgfs_devstate);
-- 
2.32.0

