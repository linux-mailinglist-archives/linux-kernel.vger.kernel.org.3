Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B8E4784F2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 07:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbhLQGc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 01:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbhLQGcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 01:32:54 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3DEC06173E;
        Thu, 16 Dec 2021 22:32:54 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id g14so3956786edb.8;
        Thu, 16 Dec 2021 22:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jVz5gmWkvfHnwl1AICB+LrD0LvfkSYpF7pSTjzPszEs=;
        b=Z/NKcsvrzrquLzVkgn3SArWeTGGKsArSdqDxuzHRyxgYJdTUMmZFGqNx218o4KZ3bi
         Ji9rMNoA0YP/dXmNbAgN3HetOR14Jbs+vqKfeqU3vrqfhOx/nw3kLxusOR2ZsTUs5j9G
         5ZHf/W6RXEyoIDe5ljmek6lYSUPZ07YMnDh/nWuTXXU3PhfI5lB0Sb4G71pt4S5I1LIV
         RfSHP/p9sRZVfOejmRl9lmsb7cwBky5ZGvH1d8BJAECVAV1v2IwuM417movY/kn71kwT
         ZiWFLvQ4jOROFx0f4l1j3/dzfDDS9PB1NRa31vuxbPabUeqlobZ0Os+oMSlulozH7lIu
         pwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jVz5gmWkvfHnwl1AICB+LrD0LvfkSYpF7pSTjzPszEs=;
        b=I5rp13Lpec+9+aHGuU8Cov6CRPzgS/mSEXfIY9m/ddseGvi5omxqakBme+RNSWL8qL
         UzIrSV6saeNcI/UCXzqGaIta0QD5BJXFxuABVQDcMm/LTGW1zNpDlCPpC1Q2OYRZmO+c
         D6Q+iVAi6eUgQRTB+oM004hgOcn/fWQcR2RhE+wMDSYWwY9zHNai2O3WwRorgRAL9ghi
         ouuu/B9gGlYoF9eAz/vcV2tehA7MS7EY3xhWRhyRiNhMglT6e/NAo0OtBUGMKJ1eA2tH
         3B65M1KouWgo/1dqjfrv6bb756jtyfePog53wkXAPSVXyGHOvytpzsnLUS8iIZw9SbNd
         YYXA==
X-Gm-Message-State: AOAM531jdXxf9r+4hIEBsKEI55/wxwT5/TxzIj4xVbh/hxNCr913dAkq
        uX1cbPqjHPuaFaQrAFqJaCA=
X-Google-Smtp-Source: ABdhPJzel5vzdE3ikJ2oPZCrG4tkSHvvw24nnRQFJNtnW88H0qM7WrEzXjsy8HG1Ycdrc7rQBhxJPA==
X-Received: by 2002:aa7:d495:: with SMTP id b21mr1486049edr.363.1639722773000;
        Thu, 16 Dec 2021 22:32:53 -0800 (PST)
Received: from zenorus.myxoz.lan (81-224-108-56-no2390.tbcn.telia.com. [81.224.108.56])
        by smtp.gmail.com with ESMTPSA id e20sm2490148ejl.189.2021.12.16.22.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 22:32:52 -0800 (PST)
From:   Miko Larsson <mikoxyzzz@gmail.com>
To:     minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Miko Larsson <mikoxyzzz@gmail.com>, hch@infradead.org
Subject: [PATCH v2 2/2] zram: zram_drv: replace 'strlcpy()'
Date:   Fri, 17 Dec 2021 07:32:24 +0100
Message-Id: <20211217063224.3474-3-mikoxyzzz@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217063224.3474-1-mikoxyzzz@gmail.com>
References: <20211217063224.3474-1-mikoxyzzz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'strlcpy()' shouldn't be used, and should be replaced with safer
alternatives. Cristoph Hellwig suggested [1] that 'kmemdup_nul()' should
be used in two cases instead of 'strscpy()', and that a regular
'strcpy()' should be used in the third case. [2][3]

[1] https://lore.kernel.org/all/YbsRlDYT2BfgrXRX@infradead.org/
[2] https://lore.kernel.org/all/Ybt8wY3U2ETjQijH@infradead.org/
[3] https://lore.kernel.org/all/Ybt8554NZpscKx2K@infradead.org/

Signed-off-by: Miko Larsson <mikoxyzzz@gmail.com>
---
 drivers/block/zram/zram_drv.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 4de6fe13edaf..c7c751e6ca2e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -482,7 +482,7 @@ static ssize_t backing_dev_store(struct device *dev,
 	int err;
 	struct zram *zram = dev_to_zram(dev);
 
-	file_name = kmalloc(PATH_MAX, GFP_KERNEL);
+	file_name = kmemdup_nul(buf, PATH_MAX, GFP_KERNEL);
 	if (!file_name)
 		return -ENOMEM;
 
@@ -493,7 +493,6 @@ static ssize_t backing_dev_store(struct device *dev,
 		goto out;
 	}
 
-	strlcpy(file_name, buf, PATH_MAX);
 	/* ignore trailing newline */
 	sz = strlen(file_name);
 	if (sz > 0 && file_name[sz - 1] == '\n')
@@ -1024,10 +1023,10 @@ static ssize_t comp_algorithm_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
-	char compressor[ARRAY_SIZE(zram->compressor)];
+	char *compressor;
 	size_t sz;
 
-	strlcpy(compressor, buf, sizeof(compressor));
+	compressor = kmemdup_nul(buf, sizeof(zram->compressor), GFP_KERNEL);
 	/* ignore trailing newline */
 	sz = strlen(compressor);
 	if (sz > 0 && compressor[sz - 1] == '\n')
@@ -1981,7 +1980,7 @@ static int zram_add(void)
 	if (ret)
 		goto out_cleanup_disk;
 
-	strlcpy(zram->compressor, default_compressor, sizeof(zram->compressor));
+	strcpy(zram->compressor, default_compressor);
 
 	zram_debugfs_register(zram);
 	pr_info("Added device: %s\n", zram->disk->disk_name);
-- 
2.34.1

