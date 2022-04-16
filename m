Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604D55032FE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiDPFl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 01:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiDPFln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 01:41:43 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AD3FCBC6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 22:39:12 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id ADBC98E0819;
        Sat, 16 Apr 2022 05:39:11 +0000 (UTC)
Received: from pdx1-sub0-mail-a254.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id F3BE78E06B6;
        Sat, 16 Apr 2022 05:39:10 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1650087551; a=rsa-sha256;
        cv=none;
        b=7ELyfl2/zsWIsKl8MdBfcyCbEYf4HNqnvfgIVRy+9TgA9J7diXiVf/TjMLe6fJKlnfzu1D
        eCLKLZHgo3v1J0H/NGPajmXRDvPS3dfcy9UTLzDHqewMi8LGh3GW+7+M74jYckdqnoCNCT
        L/fcZ/zBRVgRO1ya+4OkGlCZPSGr8kWwKuO1hf17c6JaRiZeF5Ux1evJFezRpddA4vCmai
        tPRY9CffGFWfiFl/ePHu7ecoGDVeZg/y2WxgnNpIu/eY4KfFL2K+7b2KmWcfGNHTsZ4rTR
        CxeSUKmDfjOtQwK11+8JSDgutG3K/OOjHT+iJE1dssMn4SMpAACsOYAO1IKTsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1650087551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=1GcA1EQLKr6cDmztZQrBKDqx1z4dpZsZKzsdXEMRVzY=;
        b=YBmqxd4qGkYBUlYDZck0Aj6Bmr2e+O3nepNecQR9p+2EDE5JvllEthms9t1MHJWalgBD3c
        hwPjqPKVmJO7QiJNvdFahzAkIeOtUvUcmLs67t2xb9LsLV5mV3kUyczC49GY3lcwlQOiTQ
        vvlfli9cXPnvsg0ID4RheL0jWCcc+xNu+COAQn8IOrrAX0VMiTyzEQaBH7ZSssF2aHZdGt
        eRdK844Kd2qxuCmxvh/YBfQnmayWsTJCtM8wEmFbEbzAYGJdK+pCaMpHPemuQX6XNjUHEA
        +Fwx1VCnQmVk7m77cCl6+uB8OBL/IBUdmvYBF+KYszOdnzb16YhlPWLSowlijQ==
ARC-Authentication-Results: i=1;
        rspamd-b69d6888c-bbjgq;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a254.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.106.98 (trex/6.7.1);
        Sat, 16 Apr 2022 05:39:11 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Squirrel-Reign: 2b63278d331c9d71_1650087551437_1108755106
X-MC-Loop-Signature: 1650087551437:2424071474
X-MC-Ingress-Time: 1650087551437
Received: from localhost.localdomain (unknown [104.36.29.107])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a254.dreamhost.com (Postfix) with ESMTPSA id 4KgMSs4Rm1z2x;
        Fri, 15 Apr 2022 22:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1650087550;
        bh=1GcA1EQLKr6cDmztZQrBKDqx1z4dpZsZKzsdXEMRVzY=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=O6EVUGnYZCCOAL10auVg4KYPQEL5CcCMIqG67RDrj2Yfq0ehUw5IHLfaf/xeFrV6C
         Aazy55ckqril50OFjab3d0r5RpDPw6Dm3BY8FKdU0zeo22iZpxM0sivWmkLQkHtXiS
         y3Lmo1ZKB+9X0CUDCeDo0+b8dlqikjoQkpTVPWmtiKp5dMzvWAJJ+2tYNa1FaSK7DT
         U7gQZ4715IYXfWw9epgv0ydXQg1EI5qLHC9qVMXbK22aQ7yK8BomZDb2lxAWPLcQLN
         /XN8vu+DoWAadOkW+YDEjWPTLFRCy1meDR70ryGIaGDZB7Dei9Yyyza3hBsFU2/7ac
         bIofukKT3MClw==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org, rientjes@google.com,
        yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com,
        dave.hansen@linux.intel.com, tim.c.chen@linux.intel.com,
        roman.gushchin@linux.dev, gthelen@google.com,
        a.manzanares@samsung.com, heekwon.p@samsung.com,
        gim.jongmin@samsung.com, dave@stgolabs.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] mm: introduce per-node proactive reclaim interface
Date:   Fri, 15 Apr 2022 22:39:00 -0700
Message-Id: <20220416053902.68517-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220416053902.68517-1-dave@stgolabs.net>
References: <20220416053902.68517-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a mechanism to trigger memory reclaim
as a per-node sysfs interface, inspired by compaction's
equivalent; ie:

	 echo 1G > /sys/devices/system/node/nodeX/reclaim

It is based on the discussions from David's thread[1] as
well as the current upstreaming of the memcg[2] interface
(which has nice explanations for the benefits of userspace
reclaim overall). In both cases conclusions were that either
way of inducing proactive reclaim should be KISS, and can be
later extended. So this patch does not allow the user much
fine tuning beyond the size of the reclaim, such as anon/file
or whether or semantics of demotion.

[1] https://lore.kernel.org/all/5df21376-7dd1-bf81-8414-32a73cea45dd@google.com/
[2] https://lore.kernel.org/all/20220408045743.1432968-1-yosryahmed@google.com/

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/ABI/stable/sysfs-devices-node | 10 ++++
 drivers/base/node.c                         |  2 +
 include/linux/swap.h                        | 16 ++++++
 mm/vmscan.c                                 | 59 +++++++++++++++++++++
 4 files changed, 87 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
index 8db67aa472f1..3c935e1334f7 100644
--- a/Documentation/ABI/stable/sysfs-devices-node
+++ b/Documentation/ABI/stable/sysfs-devices-node
@@ -182,3 +182,13 @@ Date:		November 2021
 Contact:	Jarkko Sakkinen <jarkko@kernel.org>
 Description:
 		The total amount of SGX physical memory in bytes.
+
+What:		/sys/devices/system/node/nodeX/reclaim
+Date:		April 2022
+Contact:	Davidlohr Bueso <dave@stgolabs.net>
+Description:
+		Write the amount of bytes to induce memory reclaim in this node.
+		This file accepts a single key, the number of bytes to reclaim.
+		When it completes successfully, the specified amount or more memory
+		will have been reclaimed, and -EAGAIN if less bytes are reclaimed
+		than the specified amount.
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 6cdf25fd26c3..d80c478e2a6e 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -670,6 +670,7 @@ static int register_node(struct node *node, int num)
 
 	hugetlb_register_node(node);
 	compaction_register_node(node);
+	reclaim_register_node(node);
 	return 0;
 }
 
@@ -685,6 +686,7 @@ void unregister_node(struct node *node)
 	hugetlb_unregister_node(node);		/* no-op, if memoryless node */
 	node_remove_accesses(node);
 	node_remove_caches(node);
+	reclaim_unregister_node(node);
 	device_unregister(&node->dev);
 }
 
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 27093b477c5f..cca43ae6d770 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -398,6 +398,22 @@ extern unsigned long shrink_all_memory(unsigned long nr_pages);
 extern int vm_swappiness;
 long remove_mapping(struct address_space *mapping, struct folio *folio);
 
+#if defined(CONFIG_SYSFS) && defined(CONFIG_NUMA)
+extern int reclaim_register_node(struct node *node);
+extern void reclaim_unregister_node(struct node *node);
+
+#else
+
+static inline int reclaim_register_node(struct node *node)
+{
+	return 0;
+}
+
+static inline void reclaim_unregister_node(struct node *node)
+{
+}
+#endif /* CONFIG_SYSFS && CONFIG_NUMA */
+
 extern unsigned long reclaim_pages(struct list_head *page_list);
 #ifdef CONFIG_NUMA
 extern int node_reclaim_mode;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1735c302831c..3539f8a0f0ea 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4819,3 +4819,62 @@ void check_move_unevictable_pages(struct pagevec *pvec)
 	}
 }
 EXPORT_SYMBOL_GPL(check_move_unevictable_pages);
+
+#if defined(CONFIG_SYSFS) && defined(CONFIG_NUMA)
+static ssize_t reclaim_store(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	int err, nid = dev->id;
+	gfp_t gfp_mask = GFP_KERNEL;
+	struct pglist_data *pgdat = NODE_DATA(nid);
+	unsigned long nr_to_reclaim, nr_reclaimed = 0;
+	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
+	struct scan_control sc = {
+		.gfp_mask = current_gfp_context(gfp_mask),
+		.reclaim_idx = gfp_zone(gfp_mask),
+		.priority = NODE_RECLAIM_PRIORITY,
+		.may_writepage = !laptop_mode,
+		.may_unmap = 1,
+		.may_swap = 1,
+	};
+
+	buf = strstrip((char *)buf);
+	err = page_counter_memparse(buf, "", &nr_to_reclaim);
+	if (err)
+		return err;
+
+	sc.nr_to_reclaim = max(nr_to_reclaim, SWAP_CLUSTER_MAX);
+
+	while (nr_reclaimed < nr_to_reclaim) {
+		unsigned long reclaimed;
+
+		if (test_and_set_bit(PGDAT_RECLAIM_LOCKED, &pgdat->flags))
+			return -EAGAIN;
+
+		/* does cond_resched() */
+		reclaimed = __node_reclaim(pgdat, gfp_mask,
+					   nr_to_reclaim - nr_reclaimed, &sc);
+
+		clear_bit(PGDAT_RECLAIM_LOCKED, &pgdat->flags);
+
+		if (!reclaimed && !nr_retries--)
+			break;
+
+		nr_reclaimed += reclaimed;
+	}
+
+	return nr_reclaimed < nr_to_reclaim ? -EAGAIN : count;
+}
+
+static DEVICE_ATTR_WO(reclaim);
+int reclaim_register_node(struct node *node)
+{
+	return device_create_file(&node->dev, &dev_attr_reclaim);
+}
+
+void reclaim_unregister_node(struct node *node)
+{
+	return device_remove_file(&node->dev, &dev_attr_reclaim);
+}
+#endif
-- 
2.26.2

