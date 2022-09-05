Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2597E5ACD81
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237275AbiIEIQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237158AbiIEIQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:16:18 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC003123F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 01:16:16 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id q15so7934288pfn.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 01:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=osBqiJaYCcdSOMrgUz97U3jA0MdVQ300bRjV6yXUVIc=;
        b=VH6xAL0PkzJAwu9OdJQFBsHN8Li9N+zBHoNiNJPAY/rU/ppidAEqybz8POUKxWQ28p
         eNlBafxje4PIOVTXjyXdT2sLoYEunERQev53o8hz4KtE0zna2uv1rL9LyaAsZkiWdisi
         LUjNI+iJv5n3L+YiWIyx4eejiibTp3l4zIHtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=osBqiJaYCcdSOMrgUz97U3jA0MdVQ300bRjV6yXUVIc=;
        b=1Wdnc+T7wjsDin3/Xwr9pdlsb8ilFCfX6sZdCCGG8H/wWhWSZYF0tFptIDTcvwuk5h
         Q4SNOhQeZz5d6nONtGQTmbY4tmqY/RJBnNmvjCER76GC3pUJ5JH5v15WyihEL+2MUuXw
         Iz+k7ExSfsgufvQCn6/tUbPdL/3HLs8TXuXvRoxaUQ69UWJwXG4x4nktDq5Vh/tHFdrg
         0icU82sBm6AxEHPMGVg73bwoFFwFp77J0P7KeAjb3VTWbRjg3eVNQ/CpgA33xxsG5wRj
         3QoKWfF/VI57CZPvSwYJZ4PXpmFMGZWlSW4zUQY1jxN9PCOCufL7L59OzwTD0igam4g7
         RYag==
X-Gm-Message-State: ACgBeo1JWPyYKaqvN0TQvTSp3FDiS+xYE1pyixcb1sJvY0N3tUQB8073
        QQksfDSkichrkRwx1zQGq3GRGg==
X-Google-Smtp-Source: AA6agR6GjRbBWTyc+V8pCm8asUgTVUt9lUB5KeMfalBIDXvdD+2glPLaFLYRDmal19Z5jLmADZ82zw==
X-Received: by 2002:a63:cc42:0:b0:41d:c915:ffd with SMTP id q2-20020a63cc42000000b0041dc9150ffdmr40194108pgi.161.1662365774828;
        Mon, 05 Sep 2022 01:16:14 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:71e2:8444:42d9:4bb0])
        by smtp.gmail.com with ESMTPSA id w12-20020aa79a0c000000b005363bc65bafsm7075864pfj.57.2022.09.05.01.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:16:14 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH RFC 2/7] zram: Add recompression algorithm sysfs knob
Date:   Mon,  5 Sep 2022 17:15:46 +0900
Message-Id: <20220905081552.2740917-5-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220905081552.2740917-1-senozhatsky@chromium.org>
References: <20220905081552.2740917-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce recomp_algorithm sysfs knob that controls
secondary algorithm selection used for recompression.
This device attribute works in a similar way with
comp_algorithm attribute.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 111 +++++++++++++++++++++++++++-------
 1 file changed, 90 insertions(+), 21 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 4ad1daa1283e..694c8c426cb2 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -41,7 +41,12 @@ static DEFINE_IDR(zram_index_idr);
 static DEFINE_MUTEX(zram_index_mutex);
 
 static int zram_major;
-static const char *default_compressor = CONFIG_ZRAM_DEF_COMP;
+static const char *default_comp_algs[ZRAM_MAX_ZCOMPS] = {
+	CONFIG_ZRAM_DEF_COMP,
+#ifdef CONFIG_ZRAM_MULTI_COMP
+	"zstd",
+#endif
+};
 
 /* Module params (documentation at end) */
 static unsigned int num_devices = 1;
@@ -1011,31 +1016,37 @@ static ssize_t max_comp_streams_store(struct device *dev,
 	return len;
 }
 
-static ssize_t comp_algorithm_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+static void comp_algorithm_set(struct zram *zram, u32 idx, const char *alg)
 {
-	size_t sz;
-	struct zram *zram = dev_to_zram(dev);
+	bool default_alg = false;
+	int i;
 
-	down_read(&zram->init_lock);
-	sz = zcomp_available_show(zram->comp_algs[ZRAM_PRIMARY_ZCOMP], buf);
-	up_read(&zram->init_lock);
+	/* Do not kfree() algs that we didn't allocate, IOW the default ones */
+	for (i = 0; i < ZRAM_MAX_ZCOMPS; i++) {
+		if (zram->comp_algs[idx] == default_comp_algs[i]) {
+			default_alg = true;
+			break;
+		}
+	}
 
-	return sz;
+	if (!default_alg)
+		kfree(zram->comp_algs[idx]);
+	zram->comp_algs[idx] = alg;
 }
 
-static void comp_algorithm_set(struct zram *zram, u32 idx, const char *alg)
+static ssize_t __comp_algorithm_show(struct zram *zram, u32 idx, char *buf)
 {
-	/* Do not kfree() algs that we didn't allocate, IOW the default ones */
-	if (zram->comp_algs[idx] != default_compressor)
-		kfree(zram->comp_algs[idx]);
-	zram->comp_algs[idx] = alg;
+	ssize_t sz;
+
+	down_read(&zram->init_lock);
+	sz = zcomp_available_show(zram->comp_algs[idx], buf);
+	up_read(&zram->init_lock);
+
+	return sz;
 }
 
-static ssize_t comp_algorithm_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
+static int __comp_algorithm_store(struct zram *zram, u32 idx, const char *buf)
 {
-	struct zram *zram = dev_to_zram(dev);
 	char *compressor;
 	size_t sz;
 
@@ -1064,11 +1075,55 @@ static ssize_t comp_algorithm_store(struct device *dev,
 		return -EBUSY;
 	}
 
-	comp_algorithm_set(zram, ZRAM_PRIMARY_ZCOMP, compressor);
+	comp_algorithm_set(zram, idx, compressor);
 	up_write(&zram->init_lock);
-	return len;
+	return 0;
+}
+
+static ssize_t comp_algorithm_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct zram *zram = dev_to_zram(dev);
+
+	return __comp_algorithm_show(zram, ZRAM_PRIMARY_ZCOMP, buf);
+}
+
+static ssize_t comp_algorithm_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf,
+				    size_t len)
+{
+	struct zram *zram = dev_to_zram(dev);
+	int ret;
+
+	ret = __comp_algorithm_store(zram, ZRAM_PRIMARY_ZCOMP, buf);
+	return ret ? ret : len;
 }
 
+#ifdef CONFIG_ZRAM_MULTI_COMP
+static ssize_t recomp_algorithm_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct zram *zram = dev_to_zram(dev);
+
+	return __comp_algorithm_show(zram, ZRAM_SECONDARY_ZCOMP, buf);
+}
+
+static ssize_t recomp_algorithm_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf,
+				      size_t len)
+{
+	struct zram *zram = dev_to_zram(dev);
+	int ret;
+
+	ret = __comp_algorithm_store(zram, ZRAM_SECONDARY_ZCOMP, buf);
+	return ret ? ret : len;
+}
+#endif
+
 static ssize_t compact_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 {
@@ -1770,7 +1825,11 @@ static void zram_reset_device(struct zram *zram)
 	memset(&zram->stats, 0, sizeof(zram->stats));
 	reset_bdev(zram);
 
-	comp_algorithm_set(zram, ZRAM_PRIMARY_ZCOMP, default_compressor);
+	comp_algorithm_set(zram, ZRAM_PRIMARY_ZCOMP,
+			   default_comp_algs[ZRAM_PRIMARY_ZCOMP]);
+	if (IS_ENABLED(CONFIG_ZRAM_MULTI_COMP))
+		comp_algorithm_set(zram, ZRAM_SECONDARY_ZCOMP,
+				   default_comp_algs[ZRAM_SECONDARY_ZCOMP]);
 	up_write(&zram->init_lock);
 }
 
@@ -1912,6 +1971,9 @@ static DEVICE_ATTR_WO(writeback);
 static DEVICE_ATTR_RW(writeback_limit);
 static DEVICE_ATTR_RW(writeback_limit_enable);
 #endif
+#ifdef CONFIG_ZRAM_MULTI_COMP
+static DEVICE_ATTR_RW(recomp_algorithm);
+#endif
 
 static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_disksize.attr,
@@ -1935,6 +1997,9 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_bd_stat.attr,
 #endif
 	&dev_attr_debug_stat.attr,
+#ifdef CONFIG_ZRAM_MULTI_COMP
+	&dev_attr_recomp_algorithm.attr,
+#endif
 	NULL,
 };
 
@@ -2014,7 +2079,11 @@ static int zram_add(void)
 	if (ret)
 		goto out_cleanup_disk;
 
-	zram->comp_algs[ZRAM_PRIMARY_ZCOMP] = default_compressor;
+	zram->comp_algs[ZRAM_PRIMARY_ZCOMP] =
+		default_comp_algs[ZRAM_PRIMARY_ZCOMP];
+	if (IS_ENABLED(CONFIG_ZRAM_MULTI_COMP))
+		zram->comp_algs[ZRAM_SECONDARY_ZCOMP] =
+			default_comp_algs[ZRAM_SECONDARY_ZCOMP];
 
 	zram_debugfs_register(zram);
 	pr_info("Added device: %s\n", zram->disk->disk_name);
-- 
2.37.2.789.g6183377224-goog

