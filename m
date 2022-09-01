Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4873D5A9E61
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbiIARo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbiIARnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:43:21 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E035D96FC5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662054059; x=1693590059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QpLq53kDMbsQj6L9fHeAwbwgO0XWugT9uvq/PRVvdGI=;
  b=b+qQpURoZ3u8TLQ5Ss4yIyQ+gZaTIBb9qbBZ9f6G1OzxkU+bbBe380JL
   mU7qtbE5v86u9yEcuSlhrNP7bsp08AOaL1EgmAFbVuZKyF+2avgXwccRI
   kjljGhvNZE9CuP5tr+i3aJHTmrLDBqiGuJC710ZFk76gIucEtYw4/YBAL
   hPUUNaQJYYNDD60e4lldycEgVHCWN+3NALiO8oqjdTyBFYy4q40zGsiQN
   p0yC1tfpApuzIdyUr8d6YqekJbTVX7UrNjyAAah5xItMPn1VxhtagPlDK
   4EaBchLq12yx+CWi8t+Hi1NZx4+ht1Le5zsjdinZwbfWrvN0LPBMhe3Rh
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="293360779"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="293360779"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 10:40:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="680960379"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmsmga004.fm.intel.com with ESMTP; 01 Sep 2022 10:40:29 -0700
From:   Cezary Rojewski <cezary.rojewski@intel.com>
To:     alsa-devel@alsa-project.org, broonie@kernel.org
Cc:     tiwai@suse.com, perex@perex.cz,
        amadeuszx.slawinski@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com,
        lgirdwood@gmail.com, kai.vehmanen@linux.intel.com,
        peter.ujfalusi@linux.intel.com, ranjani.sridharan@linux.intel.com,
        yung-chuan.liao@linux.intel.com, andy@kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 1/2] lib/string_helpers: Introduce tokenize_user_input()
Date:   Thu,  1 Sep 2022 19:50:21 +0200
Message-Id: <20220901175022.334824-2-cezary.rojewski@intel.com>
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

Add new helper function to allow for splitting specified user string
into a sequence of integers. Internally it makes use of get_options() so
the returned sequence contains the integers extracted plus an additional
element that begins the sequence and specifies the integers count.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 include/linux/string_helpers.h |  2 ++
 lib/string_helpers.c           | 45 ++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index 4d72258d42fd..97583dae556f 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -21,6 +21,8 @@ enum string_size_units {
 void string_get_size(u64 size, u64 blk_size, enum string_size_units units,
 		     char *buf, int len);
 
+int tokenize_user_input(const char __user *from, size_t count, int **tkns);
+
 #define UNESCAPE_SPACE		BIT(0)
 #define UNESCAPE_OCTAL		BIT(1)
 #define UNESCAPE_HEX		BIT(2)
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 5ed3beb066e6..f878afccab4c 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -131,6 +131,51 @@ void string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
 }
 EXPORT_SYMBOL(string_get_size);
 
+/**
+ * tokenize_user_input - Split string into a sequence of integers
+ * @from:	The user space buffer to read from
+ * @ppos:	The current position in the buffer
+ * @count:	The maximum number of bytes to read
+ * @tkns:	Returned pointer to sequence of integers
+ *
+ * On success @tkns is allocated and initialized with a sequence of
+ * integers extracted from the @from plus an additional element that
+ * begins the sequence and specifies the integers count.
+ *
+ * Caller takes responsibility for freeing @tkns when it is no longer
+ * needed.
+ */
+int tokenize_user_input(const char __user *from, size_t count, int **tkns)
+{
+	int *ints, nints;
+	char *buf;
+	int ret = 0;
+
+	buf = memdup_user_nul(from, count);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	get_options(buf, 0, &nints);
+	if (!nints) {
+		ret = -ENOENT;
+		goto free_buf;
+	}
+
+	ints = kcalloc(nints + 1, sizeof(*ints), GFP_KERNEL);
+	if (!ints) {
+		ret = -ENOMEM;
+		goto free_buf;
+	}
+
+	get_options(buf, nints + 1, ints);
+	*tkns = ints;
+
+free_buf:
+	kfree(buf);
+	return ret;
+}
+EXPORT_SYMBOL(tokenize_user_input);
+
 static bool unescape_space(char **src, char **dst)
 {
 	char *p = *dst, *q = *src;
-- 
2.25.1

