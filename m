Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEF755FEA6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbiF2Lap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbiF2LaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:30:15 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEB43EF0A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 04:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656502210; x=1688038210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eYpHqgejGxKVMlKtUl8TSzJgNDz4KWjyR7Pp9lUoBnA=;
  b=RihxpAZhJjpog4hod1yStwMVe9S411FnaDqLtwN7QXIYlLQhBepOdU7U
   CccoZx6rOajjpTJW4bal1C2IcbmdHnYrYS+LSd8V/cia3YU8FTHtdOQxX
   Sf/mp6ew9ESCCfJOyMjA9zOqrOuTq67TC4k5obfZeCQ1PxTWIMh79Dr5E
   3kPnfu6LHb1b78TYrIyUJ2DiHXWvbt6kG6o1StcDa9mECzoY/Lsf3URce
   U2PSjz9mB2a7HFDxvmYNXfiiFJU+FX3/i7r93I0wYxlaK2ZYt4sKlXibw
   M3tOGyYqAiyQckU3D5cTCIlsuLVq4gXnc6/Ix4Ctm8TtaOmStGknTqAhD
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="368319365"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="368319365"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 04:30:10 -0700
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="647353411"
Received: from sannilnx.jer.intel.com ([10.12.26.157])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 04:30:07 -0700
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
Subject: [PATCH v4 13/14] mei: debugfs: add pxp mode to devstate in debugfs
Date:   Wed, 29 Jun 2022 14:29:12 +0300
Message-Id: <20220629112913.1210933-14-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220629112913.1210933-1-alexander.usyskin@intel.com>
References: <20220629112913.1210933-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomas Winkler <tomas.winkler@intel.com>

Add pxp mode devstate to debugfs to monitor
pxp state machine progress. During debug
it is important to understand in what state
the pxp handshake is.

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
2.34.1

