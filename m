Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24B45395E7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 20:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346809AbiEaSLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 14:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237803AbiEaSLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 14:11:05 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2195A996A7;
        Tue, 31 May 2022 11:11:04 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id ew15so3127373qtb.2;
        Tue, 31 May 2022 11:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rgG+HZL25+Sq4rfZI6DR4wzIXou34HoqlI0ILL2AkQo=;
        b=L4SKswsHnWJURM/zNqp7hWiCPrd33KTNyD0E6meBIjqLNCRDhbRhi4Qysw4RFW0qvu
         ryDqARfp41mPsdCbsD+NRRX1NH+aypmCZLjfTczclF5fpVZpRjvxgYgCR6pNVlf5ADCb
         roCiW+gcHgqSOESAH48SUi8NAjEYhfqe3fGPJk3aFDUgch0aTjnrn3l/6bbX223Ty8OH
         ajLWp4G3H/Gv6/OLI5jKSFnaYDasEt35i5l2215uRKjhQFJp8WKN2FtcsP+jdoRccAOd
         jlZ3Z7cPLBulBizrfrmiVZyHBN/krfdxun1TGSmdfvaztFjQSYPeq9+1zNKXxwEP1RvT
         3P0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rgG+HZL25+Sq4rfZI6DR4wzIXou34HoqlI0ILL2AkQo=;
        b=54TC2Dlr2s6npCauMM/ZewEXIkCxI5RLsTKOPTgiN+DhlWhyatiNl5y/j2dRjz6Q7d
         H5A7WLeWDLDekBRhzM1n8aTiUiPB5KgG9klka4fcaH1LCXsTQdTEJSBYUfT3pc4DiYYB
         qWw8SSo/MyrGyv6e8LK4PbxfItceDTDJGh28iUN79MmP8SbFDjtKRz+hNvOIFkkIJujy
         Y+QWtGjtu4yPl3Bx8VZwEvX/ugPqeSLGqJydLRz8v0GGrZ3Ce/dLAdYrXLyrAQO2xqEo
         UFafqly3WEjMhHWT1RQgkd3HbuiRGLZ9AMMU6hmCg3x0lpecTvTUZ6RwO0YwsqQnypoZ
         kqeQ==
X-Gm-Message-State: AOAM533GR0VPPfZl34wAyKrrlPMDJqpBtX3hrBxQulqG/BTyw+S+nVkb
        xrdmbH8RtNLLDx23Xav8HiWhP8QmA6P8Aw==
X-Google-Smtp-Source: ABdhPJwNlqdoRbW1B1bqQAoS3EiwJ6y4NzmDgWMkm0IOOiBf8mzjG7Tn1RYtj6Tkf5aApU7V1xChLg==
X-Received: by 2002:ac8:5795:0:b0:2fa:3038:b8f3 with SMTP id v21-20020ac85795000000b002fa3038b8f3mr28911150qta.659.1654020663115;
        Tue, 31 May 2022 11:11:03 -0700 (PDT)
Received: from spruce.. (c-71-206-142-238.hsd1.va.comcast.net. [71.206.142.238])
        by smtp.gmail.com with ESMTPSA id u23-20020a05622a199700b00304b506eec2sm3160554qtc.93.2022.05.31.11.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 11:11:02 -0700 (PDT)
From:   Joe Simmons-Talbott <joetalbott@gmail.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Joe Simmons-Talbott <joetalbott@gmail.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2] iio: Use octal permissions and DEVICE_ATTR_{RO,RW}.
Date:   Tue, 31 May 2022 14:10:16 -0400
Message-Id: <20220531181016.76007-1-joetalbott@gmail.com>
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

As reported by checkpatch.pl.  Where possible use DEVICE_ATTR_RO and
DEVICE_ATTR_RW.  Change function names to be <var>_show() for read and
<var>_store() for write.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Joe Simmons-Talbott <joetalbott@gmail.com>
---

Changes in v2:
  - Use DEVICE_ATTR_RO and DEVICE_ATTR_RW rather than octal permissions
	where applicable.  Rename functions to <var>-show() and
	<var>-store().  Based on review by Joe Perches <joe@perches.com>

 drivers/iio/industrialio-buffer.c  | 62 ++++++++++++++----------------
 drivers/iio/industrialio-core.c    | 35 ++++++++---------
 drivers/iio/industrialio-trigger.c | 32 ++++++++-------
 3 files changed, 61 insertions(+), 68 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index b078eb2f3c9d..4bafadddd1f6 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -630,18 +630,18 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static ssize_t iio_buffer_read_length(struct device *dev,
-				      struct device_attribute *attr,
-				      char *buf)
+static ssize_t length_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
 {
 	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
 
 	return sysfs_emit(buf, "%d\n", buffer->length);
 }
 
-static ssize_t iio_buffer_write_length(struct device *dev,
-				       struct device_attribute *attr,
-				       const char *buf, size_t len)
+static ssize_t length_store(struct device *dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
@@ -672,9 +672,9 @@ static ssize_t iio_buffer_write_length(struct device *dev,
 	return ret ? ret : len;
 }
 
-static ssize_t iio_buffer_show_enable(struct device *dev,
-				      struct device_attribute *attr,
-				      char *buf)
+static ssize_t enable_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
 {
 	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
 
@@ -1289,10 +1289,10 @@ void iio_disable_all_buffers(struct iio_dev *indio_dev)
 	iio_buffer_deactivate_all(indio_dev);
 }
 
-static ssize_t iio_buffer_store_enable(struct device *dev,
-				       struct device_attribute *attr,
-				       const char *buf,
-				       size_t len)
+static ssize_t enable_store(struct device *dev,
+			    struct device_attribute *attr,
+			    const char *buf,
+			    size_t len)
 {
 	int ret;
 	bool requested_state;
@@ -1322,19 +1322,19 @@ static ssize_t iio_buffer_store_enable(struct device *dev,
 	return (ret < 0) ? ret : len;
 }
 
-static ssize_t iio_buffer_show_watermark(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
+static ssize_t watermark_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
 {
 	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
 
 	return sysfs_emit(buf, "%u\n", buffer->watermark);
 }
 
-static ssize_t iio_buffer_store_watermark(struct device *dev,
-					  struct device_attribute *attr,
-					  const char *buf,
-					  size_t len)
+static ssize_t watermark_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf,
+			       size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
@@ -1366,9 +1366,9 @@ static ssize_t iio_buffer_store_watermark(struct device *dev,
 	return ret ? ret : len;
 }
 
-static ssize_t iio_dma_show_data_available(struct device *dev,
-						struct device_attribute *attr,
-						char *buf)
+static ssize_t data_available_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
 {
 	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
 
@@ -1391,18 +1391,14 @@ static ssize_t direction_show(struct device *dev,
 	}
 }
 
-static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
-		   iio_buffer_write_length);
+static DEVICE_ATTR_RW(length);
 static struct device_attribute dev_attr_length_ro = __ATTR(length,
-	S_IRUGO, iio_buffer_read_length, NULL);
-static DEVICE_ATTR(enable, S_IRUGO | S_IWUSR,
-		   iio_buffer_show_enable, iio_buffer_store_enable);
-static DEVICE_ATTR(watermark, S_IRUGO | S_IWUSR,
-		   iio_buffer_show_watermark, iio_buffer_store_watermark);
+	0444, length_show, NULL);
+static DEVICE_ATTR_RW(enable);
+static DEVICE_ATTR_RW(watermark);
 static struct device_attribute dev_attr_watermark_ro = __ATTR(watermark,
-	S_IRUGO, iio_buffer_show_watermark, NULL);
-static DEVICE_ATTR(data_available, S_IRUGO,
-		iio_dma_show_data_available, NULL);
+	0444, watermark_show, NULL);
+static DEVICE_ATTR_RO(data_available);
 static DEVICE_ATTR_RO(direction);
 
 /*
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index e1ed44dec2ab..bb1dd00b99ac 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1114,12 +1114,12 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
 	dev_attr->attr.name = name;
 
 	if (readfunc) {
-		dev_attr->attr.mode |= S_IRUGO;
+		dev_attr->attr.mode |= 0444;
 		dev_attr->show = readfunc;
 	}
 
 	if (writefunc) {
-		dev_attr->attr.mode |= S_IWUSR;
+		dev_attr->attr.mode |= 0200;
 		dev_attr->store = writefunc;
 	}
 
@@ -1393,29 +1393,29 @@ void iio_free_chan_devattr_list(struct list_head *attr_list)
 	}
 }
 
-static ssize_t iio_show_dev_name(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
+static ssize_t name_show(struct device *dev,
+			 struct device_attribute *attr,
+			 char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	return sysfs_emit(buf, "%s\n", indio_dev->name);
 }
 
-static DEVICE_ATTR(name, S_IRUGO, iio_show_dev_name, NULL);
+static DEVICE_ATTR_RO(name);
 
-static ssize_t iio_show_dev_label(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
+static ssize_t label_show(struct device *dev,
+			  struct device_attribute *attr,
+			  char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	return sysfs_emit(buf, "%s\n", indio_dev->label);
 }
 
-static DEVICE_ATTR(label, S_IRUGO, iio_show_dev_label, NULL);
+static DEVICE_ATTR_RO(label);
 
-static ssize_t iio_show_timestamp_clock(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
+static ssize_t current_timestamp_clock_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
 {
 	const struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	const clockid_t clk = iio_device_get_clock(indio_dev);
@@ -1459,9 +1459,9 @@ static ssize_t iio_show_timestamp_clock(struct device *dev,
 	return sz;
 }
 
-static ssize_t iio_store_timestamp_clock(struct device *dev,
-					 struct device_attribute *attr,
-					 const char *buf, size_t len)
+static ssize_t current_timestamp_clock_store(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf, size_t len)
 {
 	clockid_t clk;
 	int ret;
@@ -1509,8 +1509,7 @@ int iio_device_register_sysfs_group(struct iio_dev *indio_dev,
 	return 0;
 }
 
-static DEVICE_ATTR(current_timestamp_clock, S_IRUGO | S_IWUSR,
-		   iio_show_timestamp_clock, iio_store_timestamp_clock);
+static DEVICE_ATTR_RW(current_timestamp_clock);
 
 static int iio_device_register_sysfs(struct iio_dev *indio_dev)
 {
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index f504ed351b3e..21f113c0ee96 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -37,7 +37,7 @@ static LIST_HEAD(iio_trigger_list);
 static DEFINE_MUTEX(iio_trigger_list_lock);
 
 /**
- * iio_trigger_read_name() - retrieve useful identifying name
+ * name_show() - retrieve useful identifying name
  * @dev:	device associated with the iio_trigger
  * @attr:	pointer to the device_attribute structure that is
  *		being processed
@@ -46,15 +46,15 @@ static DEFINE_MUTEX(iio_trigger_list_lock);
  * Return: a negative number on failure or the number of written
  *	   characters on success.
  */
-static ssize_t iio_trigger_read_name(struct device *dev,
-				     struct device_attribute *attr,
-				     char *buf)
+static ssize_t name_show(struct device *dev,
+			 struct device_attribute *attr,
+			 char *buf)
 {
 	struct iio_trigger *trig = to_iio_trigger(dev);
 	return sysfs_emit(buf, "%s\n", trig->name);
 }
 
-static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
+static DEVICE_ATTR_RO(name);
 
 static struct attribute *iio_trig_dev_attrs[] = {
 	&dev_attr_name.attr,
@@ -395,7 +395,7 @@ void iio_dealloc_pollfunc(struct iio_poll_func *pf)
 EXPORT_SYMBOL_GPL(iio_dealloc_pollfunc);
 
 /**
- * iio_trigger_read_current() - trigger consumer sysfs query current trigger
+ * current_trigger_show() - trigger consumer sysfs query current trigger
  * @dev:	device associated with an industrial I/O device
  * @attr:	pointer to the device_attribute structure that
  *		is being processed
@@ -407,9 +407,9 @@ EXPORT_SYMBOL_GPL(iio_dealloc_pollfunc);
  * Return: a negative number on failure, the number of characters written
  *	   on success or 0 if no trigger is available
  */
-static ssize_t iio_trigger_read_current(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
+static ssize_t current_trigger_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 
@@ -419,7 +419,7 @@ static ssize_t iio_trigger_read_current(struct device *dev,
 }
 
 /**
- * iio_trigger_write_current() - trigger consumer sysfs set current trigger
+ * current_trigger_store() - trigger consumer sysfs set current trigger
  * @dev:	device associated with an industrial I/O device
  * @attr:	device attribute that is being processed
  * @buf:	string buffer that holds the name of the trigger
@@ -432,10 +432,10 @@ static ssize_t iio_trigger_read_current(struct device *dev,
  * Return: negative error code on failure or length of the buffer
  *	   on success
  */
-static ssize_t iio_trigger_write_current(struct device *dev,
-					 struct device_attribute *attr,
-					 const char *buf,
-					 size_t len)
+static ssize_t current_trigger_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf,
+				     size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
@@ -494,9 +494,7 @@ static ssize_t iio_trigger_write_current(struct device *dev,
 	return ret;
 }
 
-static DEVICE_ATTR(current_trigger, S_IRUGO | S_IWUSR,
-		   iio_trigger_read_current,
-		   iio_trigger_write_current);
+static DEVICE_ATTR_RW(current_trigger);
 
 static struct attribute *iio_trigger_consumer_attrs[] = {
 	&dev_attr_current_trigger.attr,
-- 
2.35.3

