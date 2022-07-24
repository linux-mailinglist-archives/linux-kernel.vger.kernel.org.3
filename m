Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D432157F417
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 10:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiGXI0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 04:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbiGXIZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 04:25:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122271839C
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 01:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658651134; x=1690187134;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zgXW6g56cfZ9+X6oI75kHF9jUi+w24ZeOkTQZ7+mCHM=;
  b=E5/0fv+l7OE2ckoojIO77c0G5rR2KDr2OVe3izT/As8ig5WLQr7xRGwr
   JOKda6MJlp9dZHwHV+X1Uhnv2kqCMRkgdM95G3o1Eh1MPu3mRCWQJb53f
   R97lQyLkhYbPNChBLEmtIlde1Wc/d1XYX4My6t+DSpVCeEdI8qSJLRysO
   rbDDnnCnU9Z5d3xwmOlJ6V15yed50HtordX2eX21R7a+wOVysQhtGx7Ie
   F/D3YNwGbOW0vyYYZMOAZza/RHsHckrKKY75wAYe+WpYfwDEB/ztSn5xl
   Trww09lM6qQV4/M2oFfqwv+n/f/m1vx02OYSdf6HlJeWL8f+97DpIJITm
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="288708514"
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="288708514"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 01:25:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="657756420"
Received: from twinkler-lnx.jer.intel.com ([10.12.87.143])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 01:25:27 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>
Subject: [PATCH v6 12/14] mei: debugfs: add pxp mode to devstate in debugfs
Date:   Sun, 24 Jul 2022 11:24:26 +0300
Message-Id: <20220724082428.218628-13-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220724082428.218628-1-tomas.winkler@intel.com>
References: <20220724082428.218628-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pxp mode devstate to debugfs to monitor pxp state machine progress.
This is useful to debug issues in scenarios in which the pxp state
needs to be re-initialized, like during power transitions such as
suspend/resume. With this debugfs the state could be monitored
to ensure that pxp is in the ready state.

CC: Vitaly Lubart <vitaly.lubart@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
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
2.35.3

