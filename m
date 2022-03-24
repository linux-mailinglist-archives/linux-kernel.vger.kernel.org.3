Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7CD4E637A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350230AbiCXMl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344638AbiCXMlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:41:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B0F31506;
        Thu, 24 Mar 2022 05:40:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4790F1F745;
        Thu, 24 Mar 2022 12:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648125622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qDsOr8gX6EHN1Nd1eU2WHHdDrdoOYMkulYetFKIueLs=;
        b=pxsvihb9de9b5sHIHKI7fPyyRStLC9RYdvp2UQ/QFN2ProYk7+TPEzQWwCl0ahisn3Su4v
        x0xLNT3elQ42FKA0H7RMjrWGWe98QGuq4bVEkt+418yQAdvOLp8wo4jjLM2asr1fXh7FlA
        0rvi+Mf5M/4efAPR4nQV5DdGFcYKKfw=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EAC5CA3B93;
        Thu, 24 Mar 2022 12:40:21 +0000 (UTC)
Date:   Thu, 24 Mar 2022 13:40:13 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-mips@vger.kernel.org
Subject: Re: undefined reference to `node_data'
Message-ID: <YjxmrTKxRpTFeHnE@dhcp22.suse.cz>
References: <202203232042.AS9SV1zv-lkp@intel.com>
 <Yjs0ausRy6/mLUFD@dhcp22.suse.cz>
 <YjtPAwl/lhh+n3c2@dhcp22.suse.cz>
 <20220324090443.GA5375@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324090443.GA5375@alpha.franken.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24-03-22 10:04:43, Thomas Bogendoerfer wrote:
> On Wed, Mar 23, 2022 at 05:46:59PM +0100, Michal Hocko wrote:
> > > > If you fix the issue, kindly add following tag as appropriate
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > 
> > > > All errors (new ones prefixed by >>):
> > > > 
> > > >    mips64-linux-ld: mm/page_alloc.o: in function `free_area_init':
> > > > >> (.init.text+0x1680): undefined reference to `node_data'
> > > >    mips64-linux-ld: (.init.text+0x1690): undefined reference to `node_data'
> > > 
> > > OK, I can see what is going here. The page allocator normally
> > > uses NODE_DATA but arch_refresh_nodedata refers to node_data directly.
> > > This is a problem with
> > > arch/mips/include/asm/mach-loongson64/mmzone.h:
> > > extern struct pglist_data *__node_data[];
> > > 
> > > #define NODE_DATA(n)            (__node_data[n])
> > > 
> > > Unfortunately we cannot use NODE_DATA there because of header inclusion
> > > ordering. I will think about a solution.
> > 
> > Is there any reason why (some?) MIPS arches use __node_data rather than
> > node_data as most other architectures? Would it be acceptable to do the
> > renaming? It would help to cover the above compilation problem because
> > arch_refresh_nodedata could keep using node_data directly.
> 
> I've just checked history and I don't see a reason for __node_data.
> So I'm fine with changing it to node_data.

Thanks a lot for double checking Thomas! This is a dump&simple sed over
mips file. 0-day guys, could you give it a try please?
--- 
diff --git a/arch/mips/include/asm/mach-ip27/mmzone.h b/arch/mips/include/asm/mach-ip27/mmzone.h
index 08c36e50a860..a798ad379da1 100644
--- a/arch/mips/include/asm/mach-ip27/mmzone.h
+++ b/arch/mips/include/asm/mach-ip27/mmzone.h
@@ -20,9 +20,9 @@ struct node_data {
 	struct hub_data hub;
 };
 
-extern struct node_data *__node_data[];
+extern struct node_data *node_data[];
 
-#define NODE_DATA(n)		(&__node_data[(n)]->pglist)
-#define hub_data(n)		(&__node_data[(n)]->hub)
+#define NODE_DATA(n)		(&node_data[(n)]->pglist)
+#define hub_data(n)		(&node_data[(n)]->hub)
 
 #endif /* _ASM_MACH_MMZONE_H */
diff --git a/arch/mips/include/asm/mach-loongson64/mmzone.h b/arch/mips/include/asm/mach-loongson64/mmzone.h
index ebb1deaa77b9..14e2b860ad65 100644
--- a/arch/mips/include/asm/mach-loongson64/mmzone.h
+++ b/arch/mips/include/asm/mach-loongson64/mmzone.h
@@ -14,9 +14,9 @@
 #define pa_to_nid(addr)  (((addr) & 0xf00000000000) >> NODE_ADDRSPACE_SHIFT)
 #define nid_to_addrbase(nid) ((unsigned long)(nid) << NODE_ADDRSPACE_SHIFT)
 
-extern struct pglist_data *__node_data[];
+extern struct pglist_data *node_data[];
 
-#define NODE_DATA(n)		(__node_data[n])
+#define NODE_DATA(n)		(node_data[n])
 
 extern void setup_zero_pages(void);
 extern void __init prom_init_numa_memory(void);
diff --git a/arch/mips/loongson64/numa.c b/arch/mips/loongson64/numa.c
index e8e3e48c5333..abbbc70ce980 100644
--- a/arch/mips/loongson64/numa.c
+++ b/arch/mips/loongson64/numa.c
@@ -29,8 +29,8 @@
 
 unsigned char __node_distances[MAX_NUMNODES][MAX_NUMNODES];
 EXPORT_SYMBOL(__node_distances);
-struct pglist_data *__node_data[MAX_NUMNODES];
-EXPORT_SYMBOL(__node_data);
+struct pglist_data *node_data[MAX_NUMNODES];
+EXPORT_SYMBOL(node_data);
 
 cpumask_t __node_cpumask[MAX_NUMNODES];
 EXPORT_SYMBOL(__node_cpumask);
@@ -107,7 +107,7 @@ static void __init node_mem_init(unsigned int node)
 	tnid = early_pfn_to_nid(nd_pa >> PAGE_SHIFT);
 	if (tnid != node)
 		pr_info("NODE_DATA(%d) on node %d\n", node, tnid);
-	__node_data[node] = nd;
+	node_data[node] = nd;
 	NODE_DATA(node)->node_start_pfn = start_pfn;
 	NODE_DATA(node)->node_spanned_pages = end_pfn - start_pfn;
 
diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index adc2faeecf7c..1c3a0b92d134 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -33,9 +33,9 @@
 #define SLOT_PFNSHIFT		(SLOT_SHIFT - PAGE_SHIFT)
 #define PFN_NASIDSHFT		(NASID_SHFT - PAGE_SHIFT)
 
-struct node_data *__node_data[MAX_NUMNODES];
+struct node_data *node_data[MAX_NUMNODES];
 
-EXPORT_SYMBOL(__node_data);
+EXPORT_SYMBOL(node_data);
 
 static u64 gen_region_mask(void)
 {
@@ -358,8 +358,8 @@ static void __init node_mem_init(nasid_t node)
 	/*
 	 * Allocate the node data structures on the node first.
 	 */
-	__node_data[node] = __va(slot_freepfn << PAGE_SHIFT);
-	memset(__node_data[node], 0, PAGE_SIZE);
+	node_data[node] = __va(slot_freepfn << PAGE_SHIFT);
+	memset(node_data[node], 0, PAGE_SIZE);
 
 	NODE_DATA(node)->node_start_pfn = start_pfn;
 	NODE_DATA(node)->node_spanned_pages = end_pfn - start_pfn;
@@ -401,7 +401,7 @@ void __init prom_meminit(void)
 			node_mem_init(node);
 			continue;
 		}
-		__node_data[node] = &null_node;
+		node_data[node] = &null_node;
 	}
 }
-- 
Michal Hocko
SUSE Labs
