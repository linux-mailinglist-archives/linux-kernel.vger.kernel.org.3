Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BB7515060
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359081AbiD2QKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378835AbiD2QJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:09:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3689AD119
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:06:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55892622B5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 16:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5661FC385A7;
        Fri, 29 Apr 2022 16:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651248380;
        bh=zphIDwAlOx4AraOOpD9qnDgF92vp43HYR2ijqIVQ3FE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IiFOBefnCpp/En8xQTvZ0PLkn4TvB7+NX9zVBmzzidQwa0t3tkv9AgZ1NQpB9JR7d
         mJka6SIIwY1hWbFWN3GVy/JpTe9PxpFvQef+d1fzlQDCgMje+Vpt85XSm5VDdp0gmI
         5BhajQSaRmBs0azcQzuHhDVfQ1IR7o6m3XYFgccVHE7zZCbc0QgdJys1doeu9Fphz+
         ImFemJCNSgn+cNRgpkCqFgw8vNix1/hFQnvOylQs+KN0nTNgEi9Ds3QmSl52mpBkxQ
         Gf4fjkhYSgmL3b5fgtu3BSC8CCNGJCRFGFhm8yoKwYOuvJe1wcPoGGPPcdU93KWqVF
         fKT+4lYmnxUhQ==
From:   sj@kernel.org
To:     akpm@linux-foundation.org
Cc:     linux-damon@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 09/14] mm/damon/sysfs: use enum for 'state' input handling
Date:   Fri, 29 Apr 2022 16:06:01 +0000
Message-Id: <20220429160606.127307-10-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429160606.127307-1-sj@kernel.org>
References: <20220429160606.127307-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sj@kernel.org>

DAMON sysfs 'state' file handling code is using string literals in both
'state_show()' and 'state_store()'.  This makes the code error prone and
inflexible for future extensions.

To improve the sitaution, this commit defines possible input strings and
'enum' for identifying each input keyword only once, and refactors the
code to reuse those.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 72 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 62 insertions(+), 10 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 0d6cb9b5bd5b..460af481189a 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2053,6 +2053,32 @@ static bool damon_sysfs_ctx_running(struct damon_ctx *ctx)
 	return running;
 }
 
+/*
+ * enum damon_sysfs_cmd - Commands for a specific kdamond.
+ */
+enum damon_sysfs_cmd {
+	/* @DAMON_SYSFS_CMD_ON: Turn the kdamond on. */
+	DAMON_SYSFS_CMD_ON,
+	/* @DAMON_SYSFS_CMD_OFF: Turn the kdamond off. */
+	DAMON_SYSFS_CMD_OFF,
+	/*
+	 * @DAMON_SYSFS_CMD_UPDATE_SCHEMES_STATS: Update scheme stats sysfs
+	 * files.
+	 */
+	DAMON_SYSFS_CMD_UPDATE_SCHEMES_STATS,
+	/*
+	 * @NR_DAMON_SYSFS_CMDS: Total number of DAMON sysfs commands.
+	 */
+	NR_DAMON_SYSFS_CMDS,
+};
+
+/* Should match with enum damon_sysfs_cmd */
+static const char * const damon_sysfs_cmd_strs[] = {
+	"on",
+	"off",
+	"update_schemes_stats",
+};
+
 static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
 		char *buf)
 {
@@ -2066,7 +2092,9 @@ static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
 	else
 		running = damon_sysfs_ctx_running(ctx);
 
-	return sysfs_emit(buf, "%s\n", running ? "on" : "off");
+	return sysfs_emit(buf, "%s\n", running ?
+			damon_sysfs_cmd_strs[DAMON_SYSFS_CMD_ON] :
+			damon_sysfs_cmd_strs[DAMON_SYSFS_CMD_OFF]);
 }
 
 static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
@@ -2324,23 +2352,47 @@ static int damon_sysfs_update_schemes_stats(struct damon_sysfs_kdamond *kdamond)
 	return 0;
 }
 
+/*
+ * damon_sysfs_handle_cmd() - Handle a command for a specific kdamond.
+ * @cmd:	The command to handle.
+ * @kdamond:	The kobject wrapper for the associated kdamond.
+ *
+ * This function handles a DAMON sysfs command for a kdamond.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+static int damon_sysfs_handle_cmd(enum damon_sysfs_cmd cmd,
+		struct damon_sysfs_kdamond *kdamond)
+{
+	switch (cmd) {
+	case DAMON_SYSFS_CMD_ON:
+		return damon_sysfs_turn_damon_on(kdamond);
+	case DAMON_SYSFS_CMD_OFF:
+		return damon_sysfs_turn_damon_off(kdamond);
+	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_STATS:
+		return damon_sysfs_update_schemes_stats(kdamond);
+	default:
+		break;
+	}
+	return -EINVAL;
+}
+
 static ssize_t state_store(struct kobject *kobj, struct kobj_attribute *attr,
 		const char *buf, size_t count)
 {
 	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
 			struct damon_sysfs_kdamond, kobj);
-	ssize_t ret;
+	enum damon_sysfs_cmd cmd;
+	ssize_t ret = -EINVAL;
 
 	if (!mutex_trylock(&damon_sysfs_lock))
 		return -EBUSY;
-	if (sysfs_streq(buf, "on"))
-		ret = damon_sysfs_turn_damon_on(kdamond);
-	else if (sysfs_streq(buf, "off"))
-		ret = damon_sysfs_turn_damon_off(kdamond);
-	else if (sysfs_streq(buf, "update_schemes_stats"))
-		ret = damon_sysfs_update_schemes_stats(kdamond);
-	else
-		ret = -EINVAL;
+	for (cmd = 0; cmd < NR_DAMON_SYSFS_CMDS; cmd++) {
+		if (sysfs_streq(buf, damon_sysfs_cmd_strs[cmd])) {
+			ret = damon_sysfs_handle_cmd(cmd, kdamond);
+			break;
+		}
+	}
 	mutex_unlock(&damon_sysfs_lock);
 	if (!ret)
 		ret = count;
-- 
2.25.1

