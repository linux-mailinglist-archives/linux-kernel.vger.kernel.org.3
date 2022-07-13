Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FE7573C9B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 20:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbiGMSjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 14:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiGMSjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 14:39:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05F661AF35
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 11:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657737543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=w9ISA9tgFxM9CIk2iQzh4LVvlpFF6ft7yZ2ywOZt+mg=;
        b=HDMRoYa88OFmOX8FkcYkG5tt1bszCdrSSxvMUJzW+JHN1hc25DIX1Q0bLhcJXDMthrI3hE
        Xino+YZMjQP+lbXA5Y99CYIP1fgEZ+rSklWf75+UYLvtRLTNR3LuOI7uleSjrpGe9RPrgc
        /2yzV3WCS+1gJqYbYmqsVoi3GwelC1o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-Nq5ZVIjBM5KxOSlR5OFdhg-1; Wed, 13 Jul 2022 14:38:57 -0400
X-MC-Unique: Nq5ZVIjBM5KxOSlR5OFdhg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A6B9185A794;
        Wed, 13 Jul 2022 18:38:57 +0000 (UTC)
Received: from pauld.bos.com (dhcp-17-237.bos.redhat.com [10.18.17.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0485318EBB;
        Wed, 13 Jul 2022 18:38:56 +0000 (UTC)
From:   Phil Auld <pauld@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Barry Song <21cnbao@gmail.com>,
        Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH v3] drivers/base/node.c: fix userspace break from using bin_attributes for cpumap and cpulist
Date:   Wed, 13 Jul 2022 14:38:55 -0400
Message-Id: <20220713183855.2188201-1-pauld@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
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
node or something similar. e.g. (0,2,4,... 1024,1026...). To simplify the math and
support larger NR_CPUS we are using NR_CPUS * 7 to support a future with much larger NR_CPUS.
We also set it to a min of PAGE_SIZE to retain the older behavior for smaller NR_CPUS.
The cpumap file wants to be something like NR_CPUS/4 + NR_CPUS/32, for the ","s so for
simplicity we are using NR_CPUS/2.

On an 80 cpu 4-node sytem (NR_CPUS == 8192)

before:

-r--r--r--. 1 root root 0 Jul 12 14:08 /sys/devices/system/node/node0/cpulist
-r--r--r--. 1 root root 0 Jul 11 17:25 /sys/devices/system/node/node0/cpumap

after:

-r--r--r--. 1 root root 57344 Jul 13 11:32 /sys/devices/system/node/node0/cpulist
-r--r--r--. 1 root root  4096 Jul 13 11:31 /sys/devices/system/node/node0/cpumap

NR_CPUS = 16384
-r--r--r--. 1 root root 114688 Jul 13 14:03 /sys/devices/system/node/node0/cpulist
-r--r--r--. 1 root root   8192 Jul 13 14:02 /sys/devices/system/node/node0/cpumap

Fixes: 75bd50fa841 ("drivers/base/node.c: use bin_attribute to break the size limitation of cpumap ABI")
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Phil Auld <pauld@redhat.com>
---
 drivers/base/node.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 0ac6376ef7a1..89c932a1d8ca 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -45,7 +45,11 @@ static inline ssize_t cpumap_read(struct file *file, struct kobject *kobj,
 	return n;
 }
 
-static BIN_ATTR_RO(cpumap, 0);
+/* Report a valid max size for this file to avoid breaking userspace. We use NR_CPUS/2 as 
+ * a simplification of NR_CPUS/8 + NR_CPUS/32.  Use PAGE_SIZE as a minimum for smaller 
+ * configurations. 
+ */ 
+static BIN_ATTR_RO(cpumap, (((NR_CPUS >> 1) > PAGE_SIZE) ? NR_CPUS >> 1 : PAGE_SIZE));
 
 static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
 				   struct bin_attribute *attr, char *buf,
@@ -66,7 +70,15 @@ static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
 	return n;
 }
 
-static BIN_ATTR_RO(cpulist, 0);
+/* Report a valid maximum size for this file since 0 breaks userspace, which
+ * may use the size from fstat to allocate a read buffer. 
+ * The value 7 is a hardcoded version of ceil(log10(NR_CPUS)) + 1 for future values
+ * of NR_CPUS that may be upto 2 orders of magnitude larger than 8192.
+ * In a worst case system every other cpu is on one of two nodes. This leads to 
+ * a file like "0,2,4,6,8...1024,...8190,...". Use PAGE_SIZE as a minimum for smaller
+ * NR_CPUS.  
+*/
+static BIN_ATTR_RO(cpulist, (((NR_CPUS * 7) > PAGE_SIZE) ? NR_CPUS * 7 : PAGE_SIZE));
 
 /**
  * struct node_access_nodes - Access class device to hold user visible
-- 
2.31.1

