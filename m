Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666FF49DCFF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 09:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238013AbiA0Ix1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 03:53:27 -0500
Received: from mail-ej1-f53.google.com ([209.85.218.53]:37452 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237938AbiA0IxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 03:53:19 -0500
Received: by mail-ej1-f53.google.com with SMTP id ah7so4256318ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 00:53:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3cffNYGj+Akz41OJV9J6tS+Lh80OSf1RghBDqxOpAp4=;
        b=OGINEwD/6ua8UD6gA6MViLWOTs+4S9Newhhgq25pKwlsQYfYqtSV8n0pBOIsPY9+Jh
         +7gx4ELnDv9+0yiOYv9p9kHgbK2unz4FxjJoP6beF/HjWP0zLbC5QQYfeKkMJKa+5DoX
         v+ZAhp03mMzw9Qk9puIhSWpFzpV6qIzvO+hSEY+t8d4YPFkApD5NvqKiaORKImAxGtNt
         Tn7G7kxkDPxD5QnIq0tcJMyAsy1etYBUGnAulTNBx9txa2VkAt36A29xCAgd9GUE2pHI
         eli8u0IBQCuB2H9HLecxIrYthVR78XX2NbV1Ez/DskHaRDw0tAcfL/lbblpLRlz72IIB
         CfJQ==
X-Gm-Message-State: AOAM530+D1CvwwQlSidTByNUjompZTz1vk8OLrt6/3kbe9GSn93FbmT4
        n1dmWTfNTz/agpuq/LRUyfs=
X-Google-Smtp-Source: ABdhPJxrVaAhLyFhkkAgJvzZzpNdN996I46c3cMfR4IVIdNKkjTkr/h5oXzh9WZRYAUcKqeCQtAmhg==
X-Received: by 2002:a17:906:8412:: with SMTP id n18mr2096772ejx.483.1643273597838;
        Thu, 27 Jan 2022 00:53:17 -0800 (PST)
Received: from localhost.localdomain (ip-85-160-47-31.eurotel.cz. [85.160.47.31])
        by smtp.gmail.com with ESMTPSA id n11sm11029757edv.52.2022.01.27.00.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 00:53:17 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Rafael Aquini <raquini@redhat.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH 3/6] mm, memory_hotplug: drop arch_free_nodedata
Date:   Thu, 27 Jan 2022 09:53:02 +0100
Message-Id: <20220127085305.20890-4-mhocko@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127085305.20890-1-mhocko@kernel.org>
References: <20220127085305.20890-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

Prior to "mm: handle uninitialized numa nodes gracefully" memory hotplug
used to allocate pgdat when memory has been added to a node
(hotadd_init_pgdat) arch_free_nodedata has been only used in the
failure path because once the pgdat is exported (to be visible
by NODA_DATA(nid)) it cannot really be freed because there is no
synchronization available for that.

pgdat is allocated for each possible nodes now so the memory hotplug
doesn't need to do the ever use arch_free_nodedata so drop it.

This patch doesn't introduce any functional change.

Acked-by: Rafael Aquini <raquini@redhat.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 arch/ia64/mm/discontig.c       |  5 -----
 include/linux/memory_hotplug.h |  3 ---
 mm/memory_hotplug.c            | 10 ----------
 3 files changed, 18 deletions(-)

diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
index dd0cf4834eaa..73d0db36edb6 100644
--- a/arch/ia64/mm/discontig.c
+++ b/arch/ia64/mm/discontig.c
@@ -615,11 +615,6 @@ pg_data_t * __init arch_alloc_nodedata(int nid)
 	return memblock_alloc(size, SMP_CACHE_BYTES);
 }
 
-void arch_free_nodedata(pg_data_t *pgdat)
-{
-	kfree(pgdat);
-}
-
 void arch_refresh_nodedata(int update_node, pg_data_t *update_pgdat)
 {
 	pgdat_list[update_node] = update_pgdat;
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index cdd66bfdf855..60f09d3ebb3d 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -24,17 +24,14 @@ struct vmem_altmap;
  * node_data[nid] = kzalloc() works well. But it depends on the architecture.
  *
  * In general, generic_alloc_nodedata() is used.
- * Now, arch_free_nodedata() is just defined for error path of node_hot_add.
  *
  */
 extern pg_data_t *arch_alloc_nodedata(int nid);
-extern void arch_free_nodedata(pg_data_t *pgdat);
 extern void arch_refresh_nodedata(int nid, pg_data_t *pgdat);
 
 #else /* CONFIG_HAVE_ARCH_NODEDATA_EXTENSION */
 
 #define arch_alloc_nodedata(nid)	generic_alloc_nodedata(nid)
-#define arch_free_nodedata(pgdat)	generic_free_nodedata(pgdat)
 
 #ifdef CONFIG_NUMA
 /*
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index fc991831d296..875cdc7ffa58 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1217,16 +1217,6 @@ static pg_data_t __ref *hotadd_init_pgdat(int nid)
 	return pgdat;
 }
 
-static void rollback_node_hotadd(int nid)
-{
-	pg_data_t *pgdat = NODE_DATA(nid);
-
-	arch_refresh_nodedata(nid, NULL);
-	free_percpu(pgdat->per_cpu_nodestats);
-	arch_free_nodedata(pgdat);
-}
-
-
 /*
  * __try_online_node - online a node if offlined
  * @nid: the node ID
-- 
2.30.2

