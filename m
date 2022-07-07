Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9350569E3E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbiGGJDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbiGGJDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:03:09 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45D5286DC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 02:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657184588; x=1688720588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D/Z3jg8mUvi9rsToQV7j1faJzfJTLgmyvehdX2zqS6A=;
  b=TdGkmPI9hVUiEDIEdonAovKwYjSHwjD9ZErZrEX5wRYRVCzSGeTwJSTE
   9xgbUSlVn7w9rfftzgGNDChZuB81DbVjOxUgKu6wTEZp8CKRd3Ipybfk+
   P8AH7fWA3hunt5Lu7sq/+HyuT4rH3yIOHjSkzeoepyQXYRbh/6rLyyS0y
   1GqhdxAw+pdtFWO+K9NbB2w7nX8lt3NG+707HSZXw0YiuJ2naBh5kKi0y
   v3IKw+KlWiSUb4jFPlEOx1LkqxKcbJWbbg60ZnSyJFsDarIY6pKF4Iebp
   MxeP8lyv2ULrfCYbNFv/9i1io1MallcOwEzePJKz03o/pgsgNynNUZL+H
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="284715001"
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="284715001"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 02:03:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="770361205"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by orsmga005.jf.intel.com with ESMTP; 07 Jul 2022 02:03:05 -0700
From:   Cezary Rojewski <cezary.rojewski@intel.com>
To:     andy@kernel.org, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, tiwai@suse.com, perex@perex.cz,
        amadeuszx.slawinski@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com,
        peter.ujfalusi@linux.intel.com, ranjani.sridharan@linux.intel.com,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        kai.vehmanen@linux.intel.com, yung-chuan.liao@linux.intel.com,
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 2/2] ASoC: SOF: Remove tokenize_input()
Date:   Thu,  7 Jul 2022 11:13:01 +0200
Message-Id: <20220707091301.1282291-2-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707091301.1282291-1-cezary.rojewski@intel.com>
References: <20220707091301.1282291-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have strsplit_u32_user() tokenize_input() is needed no
longer. Remove it and update all occurrences of its usage.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/sof/sof-client-probes.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/sound/soc/sof/sof-client-probes.c b/sound/soc/sof/sof-client-probes.c
index 48ebbe58e2b9..7a79a529e2b7 100644
--- a/sound/soc/sof/sof-client-probes.c
+++ b/sound/soc/sof/sof-client-probes.c
@@ -411,29 +411,6 @@ static const struct snd_compress_ops sof_probes_compressed_ops = {
 	.copy = sof_probes_compr_copy,
 };
 
-static int tokenize_input(const char __user *from, size_t count,
-			  loff_t *ppos, u32 **tkns, size_t *num_tkns)
-{
-	char *buf;
-	int ret;
-
-	buf = kmalloc(count + 1, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	ret = simple_write_to_buffer(buf, count, ppos, from, count);
-	if (ret != count) {
-		ret = ret >= 0 ? -EIO : ret;
-		goto exit;
-	}
-
-	buf[count] = '\0';
-	ret = strsplit_u32(buf, ",", tkns, num_tkns);
-exit:
-	kfree(buf);
-	return ret;
-}
-
 static ssize_t sof_probes_dfs_points_read(struct file *file, char __user *to,
 					  size_t count, loff_t *ppos)
 {
@@ -508,7 +485,7 @@ sof_probes_dfs_points_write(struct file *file, const char __user *from,
 		return -ENOENT;
 	}
 
-	ret = tokenize_input(from, count, ppos, &tkns, &num_tkns);
+	ret = strsplit_u32_user(from, count, ppos, ",", &tkns, &num_tkns);
 	if (ret < 0)
 		return ret;
 	bytes = sizeof(*tkns) * num_tkns;
@@ -563,7 +540,7 @@ sof_probes_dfs_points_remove_write(struct file *file, const char __user *from,
 		return -ENOENT;
 	}
 
-	ret = tokenize_input(from, count, ppos, &tkns, &num_tkns);
+	ret = strsplit_u32_user(from, count, ppos, ",", &tkns, &num_tkns);
 	if (ret < 0)
 		return ret;
 	if (!num_tkns) {
-- 
2.25.1

