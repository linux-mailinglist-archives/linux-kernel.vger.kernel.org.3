Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48864BDF59
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379502AbiBUPqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:46:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379586AbiBUPqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:46:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 226BF22B0E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645458339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5p6SVD+iSqqkjQ95jNA8dJL55xZ3wL1UzWwbq1ZkZlU=;
        b=ieUeonr/JUc9Dk2nItDbDnSTLjH21qFTFpZqVFMh5TU0s2OaOb5acHgCbp/VY2nozp9Pk5
        MBK8IQapYIZOe6wONP9dmCKzL9W53NB6dfuN77HzgP5CSvptirSwhgVDS5v6YfySm+WpJ+
        6gtvf480Q0piCyU15SV8PBqq4PIUsQo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-422-5YxYP_JDPTOfWzl8jPuItQ-1; Mon, 21 Feb 2022 10:45:36 -0500
X-MC-Unique: 5YxYP_JDPTOfWzl8jPuItQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BE49801B0C;
        Mon, 21 Feb 2022 15:45:34 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.195.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A92A2BE74;
        Mon, 21 Feb 2022 15:45:32 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v1] drivers/base/memory: clarify adding and removing of memory blocks
Date:   Mon, 21 Feb 2022 16:45:31 +0100
Message-Id: <20220221154531.11382-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's make it clearer at which places we actually add and remove memory
blocks -- streamlining the terminology -- and highlight which memory
block start out online and which start out as offline.

* rename add_memory_block -> add_boot_memory_block
* rename init_memory_block -> add_memory_block
* rename unregister_memory -> remove_memory_block
* rename register_memory -> __add_memory_block
* add add_hotplug_memory_block
* mark add_boot_memory_block with __init (suggested by Oscar)

__add_memory_block() is  a pure helper for add_memory_block(), remove
the somewhat obvious comment.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

Based on v5.17-rc5 and:
	[PATCH v2 0/2] drivers/base/memory: determine and store zone for
	single-zone memory blocks [1]

[1] https://lkml.kernel.org/r/20220210184359.235565-1-david@redhat.com

---
 drivers/base/memory.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 5297c8a84428..c7dfd86e960f 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -617,11 +617,7 @@ static const struct attribute_group *memory_memblk_attr_groups[] = {
 	NULL,
 };
 
-/*
- * register_memory - Setup a sysfs device for a memory block
- */
-static
-int register_memory(struct memory_block *memory)
+static int __add_memory_block(struct memory_block *memory)
 {
 	int ret;
 
@@ -721,9 +717,9 @@ void memory_block_add_nid(struct memory_block *mem, int nid,
 }
 #endif
 
-static int init_memory_block(unsigned long block_id, unsigned long state,
-			     unsigned long nr_vmemmap_pages,
-			     struct memory_group *group)
+static int add_memory_block(unsigned long block_id, unsigned long state,
+			    unsigned long nr_vmemmap_pages,
+			    struct memory_group *group)
 {
 	struct memory_block *mem;
 	int ret = 0;
@@ -754,7 +750,7 @@ static int init_memory_block(unsigned long block_id, unsigned long state,
 		mem->zone = early_node_zone_for_memory_block(mem, NUMA_NO_NODE);
 #endif /* CONFIG_NUMA */
 
-	ret = register_memory(mem);
+	ret = __add_memory_block(mem);
 	if (ret)
 		return ret;
 
@@ -766,7 +762,7 @@ static int init_memory_block(unsigned long block_id, unsigned long state,
 	return 0;
 }
 
-static int add_memory_block(unsigned long base_section_nr)
+static int __init add_boot_memory_block(unsigned long base_section_nr)
 {
 	int section_count = 0;
 	unsigned long nr;
@@ -778,11 +774,18 @@ static int add_memory_block(unsigned long base_section_nr)
 
 	if (section_count == 0)
 		return 0;
-	return init_memory_block(memory_block_id(base_section_nr),
-				 MEM_ONLINE, 0,  NULL);
+	return add_memory_block(memory_block_id(base_section_nr),
+				MEM_ONLINE, 0,  NULL);
+}
+
+static int add_hotplug_memory_block(unsigned long block_id,
+				    unsigned long nr_vmemmap_pages,
+				    struct memory_group *group)
+{
+	return add_memory_block(block_id, MEM_OFFLINE, nr_vmemmap_pages, group);
 }
 
-static void unregister_memory(struct memory_block *memory)
+static void remove_memory_block(struct memory_block *memory)
 {
 	if (WARN_ON_ONCE(memory->dev.bus != &memory_subsys))
 		return;
@@ -821,8 +824,7 @@ int create_memory_block_devices(unsigned long start, unsigned long size,
 		return -EINVAL;
 
 	for (block_id = start_block_id; block_id != end_block_id; block_id++) {
-		ret = init_memory_block(block_id, MEM_OFFLINE, vmemmap_pages,
-					group);
+		ret = add_hotplug_memory_block(block_id, vmemmap_pages, group);
 		if (ret)
 			break;
 	}
@@ -833,7 +835,7 @@ int create_memory_block_devices(unsigned long start, unsigned long size,
 			mem = find_memory_block_by_id(block_id);
 			if (WARN_ON_ONCE(!mem))
 				continue;
-			unregister_memory(mem);
+			remove_memory_block(mem);
 		}
 	}
 	return ret;
@@ -862,7 +864,7 @@ void remove_memory_block_devices(unsigned long start, unsigned long size)
 		if (WARN_ON_ONCE(!mem))
 			continue;
 		unregister_memory_block_under_nodes(mem);
-		unregister_memory(mem);
+		remove_memory_block(mem);
 	}
 }
 
@@ -922,7 +924,7 @@ void __init memory_dev_init(void)
 	 */
 	for (nr = 0; nr <= __highest_present_section_nr;
 	     nr += sections_per_block) {
-		ret = add_memory_block(nr);
+		ret = add_boot_memory_block(nr);
 		if (ret)
 			panic("%s() failed to add memory block: %d\n", __func__,
 			      ret);
-- 
2.35.1

