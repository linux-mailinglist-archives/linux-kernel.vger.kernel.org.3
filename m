Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F25474017
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 11:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbhLNKH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 05:07:58 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:45848 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbhLNKHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 05:07:51 -0500
Received: by mail-ed1-f44.google.com with SMTP id y12so60305445eda.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 02:07:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6RQC4y14E0OTFBkSonwzXcuSKTL9ur9en/M+IDiQQWY=;
        b=CaL/VEX+AQDCGdlPd25theF4JHuh3pIJ4wWEqEtNZsoKRzLeeaqrEXnj0ctkgBBMTP
         sOO1PfD+UcxXniqQ+j2N4/iTqbpgE4IW+tVU6XCHytY7aCp8Zl1k7ZJOpcapuMabwY8A
         M6gldymeK9yINtbID7foOZRDSrj7k92zHHi6foB5g8jC+ntlGBE9r51bgHRPFRfmQlBG
         WyVgs+bt4UOoZdPhdZA8YrToif4w5FiP13fLKKNiOi+lQG+zvzmaTxJlJEATK7cGpVZv
         fOjtBhU/jjjci+EwxEIP9ncoRFx5d/cnYcClkcLfv8It4lC3C8jIr1NSIPg4AXfPCshK
         tzUA==
X-Gm-Message-State: AOAM5328w8deyqH2gou+8m8IV9QET89bCiWVrI9EqUkQzt1rmxreMKLT
        wTB5Bz+7DbPZFNAOCs5Ir+g=
X-Google-Smtp-Source: ABdhPJww9R8NaedTc3jhAf29s6pfgcXgbWbAmrm9GgaxrXWKuBTNWefpXJ+feRi+sj2zw5EjPeWFyQ==
X-Received: by 2002:a17:907:62a2:: with SMTP id nd34mr4672505ejc.114.1639476470482;
        Tue, 14 Dec 2021 02:07:50 -0800 (PST)
Received: from localhost.localdomain (ip-85-160-4-65.eurotel.cz. [85.160.4.65])
        by smtp.gmail.com with ESMTPSA id f5sm839766ejl.219.2021.12.14.02.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 02:07:50 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Alexey Makhalov <amakhalov@vmware.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>, Michal Hocko <mhocko@suse.com>
Subject: [PATCH v2 3/4] mm, memory_hotplug: drop arch_free_nodedata
Date:   Tue, 14 Dec 2021 11:07:31 +0100
Message-Id: <20211214100732.26335-4-mhocko@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211214100732.26335-1-mhocko@kernel.org>
References: <YbHfBgPQMkjtuHYF@dhcp22.suse.cz>
 <20211214100732.26335-1-mhocko@kernel.org>
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

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 arch/ia64/mm/discontig.c       |  5 -----
 include/linux/memory_hotplug.h |  3 ---
 mm/memory_hotplug.c            | 10 ----------
 3 files changed, 18 deletions(-)

diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
index b4c46925792f..f177390fdee1 100644
--- a/arch/ia64/mm/discontig.c
+++ b/arch/ia64/mm/discontig.c
@@ -615,11 +615,6 @@ pg_data_t *arch_alloc_nodedata(int nid)
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
index 9009a7b2a170..2daa88ce8c80 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1216,16 +1216,6 @@ static pg_data_t __ref *hotadd_init_pgdat(int nid)
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

