Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D53C4F1E15
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381554AbiDDWId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379202AbiDDQnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:43:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C0535256
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:41:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B766F21100;
        Mon,  4 Apr 2022 16:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649090480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FcNvCr26VJpdX7oyGqii89Cwpfix4yCPyYMQI1flsJw=;
        b=x9FaROwQP77uLqIKZOoSlI3OTwBphZaHdP0q2puFfZdaqsGYbCiQdR7rIijJrNVkueGJoA
        bgjmv+bFQuNclKeIBDN8sc1LfF3Sk03dM5UJU0HVfDwKK9RZU0zd9YujqzIGCOqEdkfyaa
        T6kXGFzBiFPuq7f0/BXIlmjeu13ELiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649090480;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FcNvCr26VJpdX7oyGqii89Cwpfix4yCPyYMQI1flsJw=;
        b=d49e9uB+Jyc2beWWaOwHjc46S4kPYXvSYW9aLKpvhxbDVqZox1KFT/E3SB/JoclUd7Qo+E
        whqFaXTb9ppELdBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 88E7D12FC5;
        Mon,  4 Apr 2022 16:41:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gG3EILAfS2LjfAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 04 Apr 2022 16:41:20 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Marco Elver <elver@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v3 4/6] mm/slub: distinguish and print stack traces in debugfs files
Date:   Mon,  4 Apr 2022 18:41:10 +0200
Message-Id: <20220404164112.18372-5-vbabka@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220404164112.18372-1-vbabka@suse.cz>
References: <20220404164112.18372-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2691; i=vbabka@suse.cz; h=from:subject; bh=TYBaV9Bpt1W9CRWxPFEGgUeXoCCN9uIpTjzA+mehKao=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBiSx+l4rujDPLMqAaci99S+uU3nVbrVpdi1Mha9UXq y+iVjpGJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYksfpQAKCRDgIcpz8YmpEOHICA C1HKyC20o4z3ebpWfjUW2hruI+y8Bq8UBSziz87nv9/7++lyUuk63UBiQGd8O3XB/7ODR83ord0qQ+ ksExeB3w9cLOl0iV1K2DFclkVMgjCoFnKSvatK4bAwW4hnaX62t2LJZL+sm6XEA4KtuQ6BUcgoIAzM 3vquw0pYZ2lBPHTHoU6geu+EI53qoSEcKl6U+ShepJ3tX6iK8Kr9RHl9IF2ihs4r9Sl3p8FH0nIaWM pDZieOmyJ7sT4tG0psuJ6TlppyoP69c57vH/z4WTbX8HLbBFOijhcZTAYlOf3fXETVPKR5P0X5PBvd LHMZK37e2KomEkgwq26UnDtHMqDfS8
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Glitta <glittao@gmail.com>

Aggregate objects in slub cache by unique stack trace in addition to
caller address when producing contents of debugfs files alloc_traces and
free_traces in debugfs. Also add the stack traces to the debugfs output.
This makes it much more useful to e.g. debug memory leaks.

Signed-off-by: Oliver Glitta <glittao@gmail.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-and-tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slub.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 98c1450c23f0..f2e550e1adf0 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5064,6 +5064,7 @@ EXPORT_SYMBOL(validate_slab_cache);
  */
 
 struct location {
+	depot_stack_handle_t handle;
 	unsigned long count;
 	unsigned long addr;
 	long long sum_time;
@@ -5116,9 +5117,13 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
 {
 	long start, end, pos;
 	struct location *l;
-	unsigned long caddr;
+	unsigned long caddr, chandle;
 	unsigned long age = jiffies - track->when;
+	depot_stack_handle_t handle = 0;
 
+#ifdef CONFIG_STACKDEPOT
+	handle = READ_ONCE(track->handle);
+#endif
 	start = -1;
 	end = t->count;
 
@@ -5133,7 +5138,8 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
 			break;
 
 		caddr = t->loc[pos].addr;
-		if (track->addr == caddr) {
+		chandle = t->loc[pos].handle;
+		if ((track->addr == caddr) && (handle == chandle)) {
 
 			l = &t->loc[pos];
 			l->count++;
@@ -5158,6 +5164,8 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
 
 		if (track->addr < caddr)
 			end = pos;
+		else if (track->addr == caddr && handle < chandle)
+			end = pos;
 		else
 			start = pos;
 	}
@@ -5180,6 +5188,7 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
 	l->max_time = age;
 	l->min_pid = track->pid;
 	l->max_pid = track->pid;
+	l->handle = handle;
 	cpumask_clear(to_cpumask(l->cpus));
 	cpumask_set_cpu(track->cpu, to_cpumask(l->cpus));
 	nodes_clear(l->nodes);
@@ -6089,6 +6098,21 @@ static int slab_debugfs_show(struct seq_file *seq, void *v)
 			seq_printf(seq, " nodes=%*pbl",
 				 nodemask_pr_args(&l->nodes));
 
+#ifdef CONFIG_STACKDEPOT
+		{
+			depot_stack_handle_t handle;
+			unsigned long *entries;
+			unsigned int nr_entries, j;
+
+			handle = READ_ONCE(l->handle);
+			if (handle) {
+				nr_entries = stack_depot_fetch(handle, &entries);
+				seq_puts(seq, "\n");
+				for (j = 0; j < nr_entries; j++)
+					seq_printf(seq, "        %pS\n", (void *)entries[j]);
+			}
+		}
+#endif
 		seq_puts(seq, "\n");
 	}
 
-- 
2.35.1

