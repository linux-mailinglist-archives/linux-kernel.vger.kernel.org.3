Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5BB247A517
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 07:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237588AbhLTGsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 01:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbhLTGsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 01:48:01 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA54BC061574;
        Sun, 19 Dec 2021 22:48:00 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id l7so14331395lja.2;
        Sun, 19 Dec 2021 22:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OZK8I8DJMk78yfNAEBH1J2MfMzMrX2iK0Dh2ltSlAL0=;
        b=ClCt5pr/wzbDlmKyld3PrMLzGHdkIWrGIBwRmxeSTqDgKHHJkKfWjpqHG52PJk+Fzw
         d8890MKBRmbzGeQJXHyXqYXfbzMcSQvNrvVNUQNT32l4FRa3uLocDjaDeqMoDB3NNQis
         UpjGFf9bga9feTIKZhNC+CacEYuMUfVJ+AZqb0vbXfbxd5hCqsLoKEa+A+/0xOjaQBy9
         WoyBuNCpc9BXZl3pXylv0lLNKHRNwkE0gUYfBZlUDtVguaP8+9cGA1X2KGgXvlI/PMNE
         o/L432R1GBvUzoL6RO3guDomxg2WV64he+1wIjDKZY9vqDsP2HRpkub6aqu7fOvTqFm7
         IIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OZK8I8DJMk78yfNAEBH1J2MfMzMrX2iK0Dh2ltSlAL0=;
        b=yBMG3EtrqJP0N49eZLkB+61qLpUtXo0zvw/wXf/awoxscyxv31t3bYFZIspw+HKdxb
         AkMmwhDWwVqDXL2WIG2Cpon73zuM01luNJLwamCDoJnYkuRgYS+lBT5hwGatN5ErizGO
         0ImFYnW/aKcAm+9M6XcHOYVscCBUtadm16PgRvtXVRJFyhJoC6ftCxCUcjjHC6fd12PJ
         cWilsFdA11VvwYCQzIdiiXNg4nONrIe8SIZM+yHo88tdEs1GZLIQutHrO8x8j+uiHHFh
         0uhwBfmmPxroCalns7zSsu3GkwkzWyTFN5R6mkIL79z4H6dIsnd6K2g+AggPvxjlFn4s
         bXuw==
X-Gm-Message-State: AOAM530D/p4kBAecJ3EyjXyj4hsw7jtnVMfSd0Y72ub+RQsT74VkvgcC
        9kREwG6z61KSqSmtGsAOpQ0=
X-Google-Smtp-Source: ABdhPJyoFKqmYCoDbYJJPG//JduXI2jqovIzqUHIbZG7adJWjV+nOyc7kKa+DKRsQp1FqZTyvjBTdQ==
X-Received: by 2002:a05:651c:2116:: with SMTP id a22mr8140675ljq.435.1639982878492;
        Sun, 19 Dec 2021 22:47:58 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id z39sm210260lfu.52.2021.12.19.22.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 22:47:58 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/2] sysfs: add sysfs_add_bin_file_to_group()
Date:   Mon, 20 Dec 2021 07:47:29 +0100
Message-Id: <20211220064730.28806-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

There already is sysfs_add_file_to_group() for adding "attribute" to a
group. This new function allows adding "bin_attribute" as well.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 fs/sysfs/file.c       | 31 +++++++++++++++++++++++++++----
 include/linux/sysfs.h |  3 +++
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 42dcf96881b6..30c798c38d89 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -376,14 +376,19 @@ EXPORT_SYMBOL_GPL(sysfs_create_files);
  * @attr: attribute descriptor.
  * @group: group name.
  */
-int sysfs_add_file_to_group(struct kobject *kobj,
-		const struct attribute *attr, const char *group)
+int __sysfs_add_file_to_group(struct kobject *kobj,
+			      const struct attribute *attr,
+			      const struct bin_attribute *battr,
+			      const char *group)
 {
 	struct kernfs_node *parent;
 	kuid_t uid;
 	kgid_t gid;
 	int error;
 
+	if (WARN_ON((attr && battr) || (!attr && !battr)))
+		return -EINVAL;
+
 	if (group) {
 		parent = kernfs_find_and_get(kobj->sd, group);
 	} else {
@@ -395,14 +400,32 @@ int sysfs_add_file_to_group(struct kobject *kobj,
 		return -ENOENT;
 
 	kobject_get_ownership(kobj, &uid, &gid);
-	error = sysfs_add_file_mode_ns(parent, attr, attr->mode, uid, gid,
-				       NULL);
+	if (attr)
+		error = sysfs_add_file_mode_ns(parent, attr, attr->mode, uid,
+					       gid, NULL);
+	else
+		error = sysfs_add_bin_file_mode_ns(parent, battr, battr->attr.mode,
+						   uid, gid, NULL);
 	kernfs_put(parent);
 
 	return error;
 }
+
+int sysfs_add_file_to_group(struct kobject *kobj, const struct attribute *attr,
+			    const char *group)
+{
+	return __sysfs_add_file_to_group(kobj, attr, NULL, group);
+}
 EXPORT_SYMBOL_GPL(sysfs_add_file_to_group);
 
+int sysfs_add_bin_file_to_group(struct kobject *kobj,
+				const struct bin_attribute *battr,
+				const char *group)
+{
+	return __sysfs_add_file_to_group(kobj, NULL, battr, group);
+}
+EXPORT_SYMBOL_GPL(sysfs_add_bin_file_to_group);
+
 /**
  * sysfs_chmod_file - update the modified mode value on an object attribute.
  * @kobj: object we're acting for.
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index e3f1e8ac1f85..9b4f9d405604 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -302,6 +302,9 @@ void sysfs_remove_groups(struct kobject *kobj,
 			 const struct attribute_group **groups);
 int sysfs_add_file_to_group(struct kobject *kobj,
 			const struct attribute *attr, const char *group);
+int sysfs_add_bin_file_to_group(struct kobject *kobj,
+				const struct bin_attribute *battr,
+				const char *group);
 void sysfs_remove_file_from_group(struct kobject *kobj,
 			const struct attribute *attr, const char *group);
 int sysfs_merge_group(struct kobject *kobj,
-- 
2.31.1

