Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD82558D31
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 04:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiFXCTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 22:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiFXCTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 22:19:16 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83DB51E64;
        Thu, 23 Jun 2022 19:19:13 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id cs6so2746500qvb.6;
        Thu, 23 Jun 2022 19:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uzzh72mHiSVMomouiy6J+rgHPUmk/fQgjJAGuIjU8IY=;
        b=Ljlwkr+H31043E4By2jpn2Bfhip4RB0bqd0aVyFh+p8QH3j4pOhRSXn6Q35qhWwsR2
         v2SvEAD/TOYIIlHm9hJ0qTeACCZxrjsHfSxl29/qGUj8VXJY5u1t/wdFkiwKoWbBcmTo
         VMu7Lev5hBOP6D5Vc2q2qST2ZGRhU3Jwcgq+pTdPgzbOEEC6uByaMPRdXHr2Y9Zac5ne
         zGui3ryO5MVFGShmQ6aVtjRrYcaYse7HhZzx8Q8BGwevWib9EtIFvcx1WjQydHcAjROV
         zsWFeu4yw4cvzD9i0V0iJdCL6os9sSHJ8StxUzPBsT4pGnRhdVuQVQ/7iz1veSsmmlkS
         9T9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uzzh72mHiSVMomouiy6J+rgHPUmk/fQgjJAGuIjU8IY=;
        b=3p3qdYj6CCNDy42vxqTuMq8tMbwTN5WfjQ3wMi+nsZSdxl3DvQJ9P+CTA86SfBJVyX
         8AEkakktGmzMeCTE052bETmMhQ+dJsKg3PH8Z+Py8DHiL0zZTb0QSU2Ru6UYLQbDksst
         165PZdZsY85wlgo6A++hj/w9/tswHWzSy2tNbpi4ATq8YP17u+kZsZ5qyMrafWa9gozp
         aY9iZWP460RjVLrNxkO/w6QARoZFyInyXmoFlVStiHb7loBZWheLOSylsGSI3auGASnV
         sT1LpHhcR54uCK2oQEDiCBCKLbeUqUp8BScIogzSNz8NkjLwEYtg/Cw6QKh6Gj4kmu+k
         o9wA==
X-Gm-Message-State: AJIora8uRJ7DJqghQorw6vTfB+Xgk0oX5283ij4PxqZ14xldSVVj4Ct1
        qiX4eKG2cAHiUyYAQ/P1U79YGDJ1dXvOVQ==
X-Google-Smtp-Source: AGRyM1vYeOxQBxJFgHrfpsq2lpIkDfnv8bYxpM/4XO4EatHKOyqL+Ma1clPdf67gvzsyFoZpakC3/Q==
X-Received: by 2002:a05:622a:355:b0:305:2f9:9ce8 with SMTP id r21-20020a05622a035500b0030502f99ce8mr10789505qtw.297.1656037153082;
        Thu, 23 Jun 2022 19:19:13 -0700 (PDT)
Received: from spruce.. (c-71-206-142-238.hsd1.va.comcast.net. [71.206.142.238])
        by smtp.gmail.com with ESMTPSA id i19-20020a05620a151300b006a91da2fc8dsm983064qkk.0.2022.06.23.19.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 19:19:12 -0700 (PDT)
From:   Joe Simmons-Talbott <joetalbott@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Joe Simmons-Talbott <joetalbott@gmail.com>
Subject: [PATCH] iio: Don't use bare "unsigned"
Date:   Thu, 23 Jun 2022 22:18:06 -0400
Message-Id: <20220624021806.1010962-1-joetalbott@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use "unsigned int" rather than bare "unsigned". Reported by checkpatch.pl.

Signed-off-by: Joe Simmons-Talbott <joetalbott@gmail.com>
---
 drivers/iio/industrialio-buffer.c     | 10 +++++-----
 drivers/iio/industrialio-core.c       |  4 ++--
 drivers/iio/industrialio-sw-device.c  |  2 +-
 drivers/iio/industrialio-sw-trigger.c |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index b078eb2f3c9d..513a34a0b593 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -705,7 +705,7 @@ static unsigned int iio_storage_bytes_for_timestamp(struct iio_dev *indio_dev)
 static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
 				const unsigned long *mask, bool timestamp)
 {
-	unsigned bytes = 0;
+	unsigned int bytes = 0;
 	int length, i, largest = 0;
 
 	/* How much space will the demuxed element take? */
@@ -934,9 +934,9 @@ static int iio_verify_update(struct iio_dev *indio_dev,
  * @l:		list head used for management
  */
 struct iio_demux_table {
-	unsigned from;
-	unsigned to;
-	unsigned length;
+	unsigned int from;
+	unsigned int to;
+	unsigned int length;
 	struct list_head l;
 };
 
@@ -974,7 +974,7 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
 				   struct iio_buffer *buffer)
 {
 	int ret, in_ind = -1, out_ind, length;
-	unsigned in_loc = 0, out_loc = 0;
+	unsigned int in_loc = 0, out_loc = 0;
 	struct iio_demux_table *p = NULL;
 
 	/* Clear out any old demux */
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index e1ed44dec2ab..ca28f76b8f40 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -384,7 +384,7 @@ static ssize_t iio_debugfs_read_reg(struct file *file, char __user *userbuf,
 {
 	struct iio_dev *indio_dev = file->private_data;
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
-	unsigned val = 0;
+	unsigned int val = 0;
 	int ret;
 
 	if (*ppos > 0)
@@ -414,7 +414,7 @@ static ssize_t iio_debugfs_write_reg(struct file *file,
 {
 	struct iio_dev *indio_dev = file->private_data;
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
-	unsigned reg, val;
+	unsigned int reg, val;
 	char buf[80];
 	int ret;
 
diff --git a/drivers/iio/industrialio-sw-device.c b/drivers/iio/industrialio-sw-device.c
index 49f775f16ad5..cdaf30a3f233 100644
--- a/drivers/iio/industrialio-sw-device.c
+++ b/drivers/iio/industrialio-sw-device.c
@@ -27,7 +27,7 @@ static DEFINE_MUTEX(iio_device_types_lock);
 
 static
 struct iio_sw_device_type *__iio_find_sw_device_type(const char *name,
-						     unsigned len)
+						     unsigned int len)
 {
 	struct iio_sw_device_type *d = NULL, *iter;
 
diff --git a/drivers/iio/industrialio-sw-trigger.c b/drivers/iio/industrialio-sw-trigger.c
index 9ae793a70b8b..994f03a71520 100644
--- a/drivers/iio/industrialio-sw-trigger.c
+++ b/drivers/iio/industrialio-sw-trigger.c
@@ -27,7 +27,7 @@ static DEFINE_MUTEX(iio_trigger_types_lock);
 
 static
 struct iio_sw_trigger_type *__iio_find_sw_trigger_type(const char *name,
-						       unsigned len)
+						       unsigned int len)
 {
 	struct iio_sw_trigger_type *t = NULL, *iter;
 
-- 
2.35.3

