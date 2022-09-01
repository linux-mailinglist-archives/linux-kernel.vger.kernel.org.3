Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FED5A9E5B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbiIARoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbiIARnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:43:20 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4618B5A82A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662054060; x=1693590060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pdh/wSauElxjtjAHzr+4IBhDH7DzSJXcvsr+mokavSw=;
  b=fMMCK3DlC0F4W3+JR7W3FOaHA6e6l4PJsuf0CNzAAMVYvOla8cLX0/jt
   suogUadVuak+dXQe0nn0ol/EJT5/rkwLKCVL4Gqt+emMMFt7CNB9lh+31
   QfhDkkdf2cKoooUsMvTFJiQU2Us3qT1BdkHkm7VpR09E5jRfNbHbWTUkT
   ef6eUDChWIPUjyLQhItY+pFfl91q/ovOFT+QcVzlu0WxQuJZQefzAOWTV
   5NaIxgcgIrtfVfWyecuqkNgs/IGpgXUmCUCdsHAM99/UgSEZuovza5aGz
   6hv9Wj6NAxMnuCxwJyUESWhc7fnJGfRVUpPrrg9kdqnZARnDypqRqMm0C
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="293360799"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="293360799"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 10:40:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="680960395"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmsmga004.fm.intel.com with ESMTP; 01 Sep 2022 10:40:33 -0700
From:   Cezary Rojewski <cezary.rojewski@intel.com>
To:     alsa-devel@alsa-project.org, broonie@kernel.org
Cc:     tiwai@suse.com, perex@perex.cz,
        amadeuszx.slawinski@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com,
        lgirdwood@gmail.com, kai.vehmanen@linux.intel.com,
        peter.ujfalusi@linux.intel.com, ranjani.sridharan@linux.intel.com,
        yung-chuan.liao@linux.intel.com, andy@kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v3 2/2] ASoC: SOF: Remove strsplit_u32() and tokenize_input()
Date:   Thu,  1 Sep 2022 19:50:22 +0200
Message-Id: <20220901175022.334824-3-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220901175022.334824-1-cezary.rojewski@intel.com>
References: <20220901175022.334824-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of global user input tokenization helper instead of the
internal one as both serve same purpose. With that, both strsplit_u32()
and tokenize_input() become unused so remove them.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/sof/sof-client-probes.c | 93 ++++---------------------------
 1 file changed, 12 insertions(+), 81 deletions(-)

diff --git a/sound/soc/sof/sof-client-probes.c b/sound/soc/sof/sof-client-probes.c
index eb246b823461..e9c44831fae1 100644
--- a/sound/soc/sof/sof-client-probes.c
+++ b/sound/soc/sof/sof-client-probes.c
@@ -12,6 +12,7 @@
 #include <linux/debugfs.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
+#include <linux/string_helpers.h>
 #include <sound/soc.h>
 #include <sound/sof/header.h>
 #include "sof-client.h"
@@ -410,79 +411,6 @@ static const struct snd_compress_ops sof_probes_compressed_ops = {
 	.copy = sof_probes_compr_copy,
 };
 
-/**
- * strsplit_u32 - Split string into sequence of u32 tokens
- * @buf:	String to split into tokens.
- * @delim:	String containing delimiter characters.
- * @tkns:	Returned u32 sequence pointer.
- * @num_tkns:	Returned number of tokens obtained.
- */
-static int strsplit_u32(char *buf, const char *delim, u32 **tkns, size_t *num_tkns)
-{
-	char *s;
-	u32 *data, *tmp;
-	size_t count = 0;
-	size_t cap = 32;
-	int ret = 0;
-
-	*tkns = NULL;
-	*num_tkns = 0;
-	data = kcalloc(cap, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	while ((s = strsep(&buf, delim)) != NULL) {
-		ret = kstrtouint(s, 0, data + count);
-		if (ret)
-			goto exit;
-		if (++count >= cap) {
-			cap *= 2;
-			tmp = krealloc(data, cap * sizeof(*data), GFP_KERNEL);
-			if (!tmp) {
-				ret = -ENOMEM;
-				goto exit;
-			}
-			data = tmp;
-		}
-	}
-
-	if (!count)
-		goto exit;
-	*tkns = kmemdup(data, count * sizeof(*data), GFP_KERNEL);
-	if (!(*tkns)) {
-		ret = -ENOMEM;
-		goto exit;
-	}
-	*num_tkns = count;
-
-exit:
-	kfree(data);
-	return ret;
-}
-
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
@@ -548,8 +476,8 @@ sof_probes_dfs_points_write(struct file *file, const char __user *from,
 	struct sof_probes_priv *priv = cdev->data;
 	struct device *dev = &cdev->auxdev.dev;
 	struct sof_probe_point_desc *desc;
-	size_t num_tkns, bytes;
-	u32 *tkns;
+	size_t bytes;
+	u32 num_tkns, *tkns;
 	int ret, err;
 
 	if (priv->extractor_stream_tag == SOF_PROBES_INVALID_NODE_ID) {
@@ -557,16 +485,18 @@ sof_probes_dfs_points_write(struct file *file, const char __user *from,
 		return -ENOENT;
 	}
 
-	ret = tokenize_input(from, count, ppos, &tkns, &num_tkns);
+	ret = tokenize_user_input(from, count, (int **)&tkns);
 	if (ret < 0)
 		return ret;
+
+	num_tkns = *tkns;
 	bytes = sizeof(*tkns) * num_tkns;
 	if (!num_tkns || (bytes % sizeof(*desc))) {
 		ret = -EINVAL;
 		goto exit;
 	}
 
-	desc = (struct sof_probe_point_desc *)tkns;
+	desc = (struct sof_probe_point_desc *)&tkns[1];
 
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0 && ret != -EACCES) {
@@ -603,8 +533,7 @@ sof_probes_dfs_points_remove_write(struct file *file, const char __user *from,
 	struct sof_client_dev *cdev = file->private_data;
 	struct sof_probes_priv *priv = cdev->data;
 	struct device *dev = &cdev->auxdev.dev;
-	size_t num_tkns;
-	u32 *tkns;
+	u32 num_tkns, *tkns;
 	int ret, err;
 
 	if (priv->extractor_stream_tag == SOF_PROBES_INVALID_NODE_ID) {
@@ -612,9 +541,11 @@ sof_probes_dfs_points_remove_write(struct file *file, const char __user *from,
 		return -ENOENT;
 	}
 
-	ret = tokenize_input(from, count, ppos, &tkns, &num_tkns);
+	ret = tokenize_user_input(from, count, (int **)&tkns);
 	if (ret < 0)
 		return ret;
+
+	num_tkns = *tkns;
 	if (!num_tkns) {
 		ret = -EINVAL;
 		goto exit;
@@ -626,7 +557,7 @@ sof_probes_dfs_points_remove_write(struct file *file, const char __user *from,
 		goto exit;
 	}
 
-	ret = sof_probes_points_remove(cdev, tkns, num_tkns);
+	ret = sof_probes_points_remove(cdev, &tkns[1], num_tkns);
 	if (!ret)
 		ret = count;
 
-- 
2.25.1

