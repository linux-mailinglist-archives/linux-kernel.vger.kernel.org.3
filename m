Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60690575454
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238459AbiGNSBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGNSB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:01:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F02B675B6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657821687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=37HKrprCDKwP7gxMMJnbcQGOEfOyfPYj4JsW1/f3jFE=;
        b=MDwEa7IYzFVZ053EqNdSELxPeru9rXJnPrezxNHP9J6MbxHTb0iCNxxPj5si93TC8qqI8I
        EfBxpQ3fUf+SUZeAgrqbX6TalCiWwhIQErte/+uyqyxIb+4guqYAEENzC8bDepn8UfI81v
        ShaYZCKifbJFUxH5iuIjDrBPUoX4t/w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-97Dq48OPOkuKNX2QL_jvng-1; Thu, 14 Jul 2022 14:01:23 -0400
X-MC-Unique: 97Dq48OPOkuKNX2QL_jvng-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4FD4802E5C;
        Thu, 14 Jul 2022 18:01:22 +0000 (UTC)
Received: from pauld.bos.com (dhcp-17-237.bos.redhat.com [10.18.17.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FE972026D64;
        Thu, 14 Jul 2022 18:01:22 +0000 (UTC)
From:   Phil Auld <pauld@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Barry Song <21cnbao@gmail.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v4] drivers/base: fix userspace break from using bin_attributes for cpumap and cpulist
Date:   Thu, 14 Jul 2022 14:01:21 -0400
Message-Id: <20220714180121.2917662-1-pauld@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using bin_attributes with a 0 size causes fstat and friends to return that 0 size.
This breaks userspace code that retrieves the size before reading the file. Rather
than reverting 75bd50fa841 ("drivers/base/node.c: use bin_attribute to break the size
limitation of cpumap ABI") let's put in a size value at compile time. Use direct
comparison and a worst-case maximum to ensure compile time constants. For cpulist the
max is on the order of NR_CPUS * (ceil(log10(NR_CPUS)) + 1) which for 8192 is 40960
(8192 * 5). In order to get near that you'd need a system with every other CPU on one
node or something similar. e.g. (0,2,4,8, ... ). To simplify the math and support
larger NR_CPUS in the future we are using NR_CPUS * 7. We also set it to a min of
PAGE_SIZE to retain the older behavior for smaller NR_CPUS. The cpumap file wants to
be something like NR_CPUS/4 + NR_CPUS/32, for the ","s so for simplicity we are using
NR_CPUS/2.

Add a set of macros for these values to cpumask.h so they can be used in multiple places.
Apply these to the handful of such files in drivers/base/topology.c as well as node.c.

On an 80 cpu 4-node sytem (NR_CPUS == 8192)

before:

-r--r--r--. 1 root root 0 Jul 12 14:08 /sys/devices/system/node/node0/cpulist
-r--r--r--. 1 root root 0 Jul 11 17:25 /sys/devices/system/node/node0/cpumap

after:

-r--r--r--. 1 root root 57344 Jul 13 11:32 /sys/devices/system/node/node0/cpulist
-r--r--r--. 1 root root  4096 Jul 13 11:31 /sys/devices/system/node/node0/cpumap

CONFIG_NR_CPUS = 16384
-r--r--r--. 1 root root 114688 Jul 13 14:03 /sys/devices/system/node/node0/cpulist
-r--r--r--. 1 root root   8192 Jul 13 14:02 /sys/devices/system/node/node0/cpumap

Fixes: 75bd50fa841 ("drivers/base/node.c: use bin_attribute to break the size limitation of cpumap ABI")
Fixes: bb9ec13d156 ("topology: use bin_attribute to break the size limitation of cpumap ABI")
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Phil Auld <pauld@redhat.com>
---
 drivers/base/node.c     |  4 ++--
 drivers/base/topology.c | 32 ++++++++++++++++----------------
 include/linux/cpumask.h | 16 ++++++++++++++++
 3 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 0ac6376ef7a1..eb0f43784c2b 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -45,7 +45,7 @@ static inline ssize_t cpumap_read(struct file *file, struct kobject *kobj,
 	return n;
 }
 
-static BIN_ATTR_RO(cpumap, 0);
+static BIN_ATTR_RO(cpumap, CPUMAP_FILE_MAX_BYTES);
 
 static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
 				   struct bin_attribute *attr, char *buf,
@@ -66,7 +66,7 @@ static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
 	return n;
 }
 
-static BIN_ATTR_RO(cpulist, 0);
+static BIN_ATTR_RO(cpulist, CPULIST_FILE_MAX_BYTES);
 
 /**
  * struct node_access_nodes - Access class device to hold user visible
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index ac6ad9ab67f9..89f98be5c5b9 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -62,47 +62,47 @@ define_id_show_func(ppin, "0x%llx");
 static DEVICE_ATTR_ADMIN_RO(ppin);
 
 define_siblings_read_func(thread_siblings, sibling_cpumask);
-static BIN_ATTR_RO(thread_siblings, 0);
-static BIN_ATTR_RO(thread_siblings_list, 0);
+static BIN_ATTR_RO(thread_siblings, CPUMAP_FILE_MAX_BYTES);
+static BIN_ATTR_RO(thread_siblings_list, CPULIST_FILE_MAX_BYTES);
 
 define_siblings_read_func(core_cpus, sibling_cpumask);
-static BIN_ATTR_RO(core_cpus, 0);
-static BIN_ATTR_RO(core_cpus_list, 0);
+static BIN_ATTR_RO(core_cpus, CPUMAP_FILE_MAX_BYTES);
+static BIN_ATTR_RO(core_cpus_list, CPULIST_FILE_MAX_BYTES);
 
 define_siblings_read_func(core_siblings, core_cpumask);
-static BIN_ATTR_RO(core_siblings, 0);
-static BIN_ATTR_RO(core_siblings_list, 0);
+static BIN_ATTR_RO(core_siblings, CPUMAP_FILE_MAX_BYTES);
+static BIN_ATTR_RO(core_siblings_list, CPULIST_FILE_MAX_BYTES);
 
 #ifdef TOPOLOGY_CLUSTER_SYSFS
 define_siblings_read_func(cluster_cpus, cluster_cpumask);
-static BIN_ATTR_RO(cluster_cpus, 0);
-static BIN_ATTR_RO(cluster_cpus_list, 0);
+static BIN_ATTR_RO(cluster_cpus, CPUMAP_FILE_MAX_BYTES);
+static BIN_ATTR_RO(cluster_cpus_list, CPULIST_FILE_MAX_BYTES);
 #endif
 
 #ifdef TOPOLOGY_DIE_SYSFS
 define_siblings_read_func(die_cpus, die_cpumask);
-static BIN_ATTR_RO(die_cpus, 0);
-static BIN_ATTR_RO(die_cpus_list, 0);
+static BIN_ATTR_RO(die_cpus, CPUMAP_FILE_MAX_BYTES);
+static BIN_ATTR_RO(die_cpus_list, CPULIST_FILE_MAX_BYTES);
 #endif
 
 define_siblings_read_func(package_cpus, core_cpumask);
-static BIN_ATTR_RO(package_cpus, 0);
-static BIN_ATTR_RO(package_cpus_list, 0);
+static BIN_ATTR_RO(package_cpus, CPUMAP_FILE_MAX_BYTES);
+static BIN_ATTR_RO(package_cpus_list, CPULIST_FILE_MAX_BYTES);
 
 #ifdef TOPOLOGY_BOOK_SYSFS
 define_id_show_func(book_id, "%d");
 static DEVICE_ATTR_RO(book_id);
 define_siblings_read_func(book_siblings, book_cpumask);
-static BIN_ATTR_RO(book_siblings, 0);
-static BIN_ATTR_RO(book_siblings_list, 0);
+static BIN_ATTR_RO(book_siblings, CPUMAP_FILE_MAX_BYTES);
+static BIN_ATTR_RO(book_siblings_list, CPULIST_FILE_MAX_BYTES);
 #endif
 
 #ifdef TOPOLOGY_DRAWER_SYSFS
 define_id_show_func(drawer_id, "%d");
 static DEVICE_ATTR_RO(drawer_id);
 define_siblings_read_func(drawer_siblings, drawer_cpumask);
-static BIN_ATTR_RO(drawer_siblings, 0);
-static BIN_ATTR_RO(drawer_siblings_list, 0);
+static BIN_ATTR_RO(drawer_siblings, CPUMAP_FILE_MAX_BYTES);
+static BIN_ATTR_RO(drawer_siblings_list, CPULIST_FILE_MAX_BYTES);
 #endif
 
 static struct bin_attribute *bin_attrs[] = {
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index fe29ac7cc469..007acdb462bd 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -1071,4 +1071,20 @@ cpumap_print_list_to_buf(char *buf, const struct cpumask *mask,
 	[0] =  1UL							\
 } }
 
+/* 
+ * Provide a valid theoretical max size for cpumap ands cpulist sysfs files to 
+ * avoid breaking userspace which may allocate a buffer based on the size 
+ * reported by e.g. fstat.
+ *
+ * For cpumap NR_CPUS/2 is a simplification of NR_CPUS/4 + NR_CPUS/32. 
+ *
+ * For cpulist 7 is (ceil(log10(NR_CPUS)) + 1) allowing for NR_CPUS to be up to 
+ * 2 orders of magnitude larger than 8192. This covers a worst-case of every 
+ * other cpu being on one of two nodes for a very large NR_CPUS.
+ *
+ *  Use PAGE_SIZE as a minimum for smaller configurations. 
+ */
+#define CPUMAP_FILE_MAX_BYTES  (((NR_CPUS >> 1) > PAGE_SIZE) ? NR_CPUS >> 1 : PAGE_SIZE)
+#define CPULIST_FILE_MAX_BYTES  (((NR_CPUS * 7) > PAGE_SIZE) ? NR_CPUS * 7 : PAGE_SIZE)
+
 #endif /* __LINUX_CPUMASK_H */
-- 
2.31.1

