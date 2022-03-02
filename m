Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CD54CAC04
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243941AbiCBRdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244190AbiCBRcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:32:52 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67B8D0062
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:31:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EE40C1F8A8;
        Wed,  2 Mar 2022 17:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646242296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LQnHXhrO7on2owbSpKE5n1md35S3c5ELU5Z9yrYqevE=;
        b=pGtPuEgrk5zRWMLCylIQqL/l5kwpBUKLLwQw+/Nv36eFxoT56EUcD44bCY77kbRWNRxjO7
        0MviCuveY2snGyyOS6++DZvGY3GDWxRBA8bSTYyJpj9twCLQrpbwZBdjSQiVwVDAY27ZBr
        doHMwNTSu1zvA9yQ79eVAO4O8N8V/o0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646242296;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LQnHXhrO7on2owbSpKE5n1md35S3c5ELU5Z9yrYqevE=;
        b=EtbnYSUXQ8iCWjGO9SRXOrH2uy/pJIQHgf7+YT2dM+RIqmxlnlP+aUZ4wnGbXsPaIOw8WC
        3JKikr+weZdjYNAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA77413A89;
        Wed,  2 Mar 2022 17:31:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8EnuLPipH2LPTAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 02 Mar 2022 17:31:36 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Marco Elver <elver@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 4/6] mm/slub: distinguish and print stack traces in debugfs files
Date:   Wed,  2 Mar 2022 18:31:20 +0100
Message-Id: <20220302173122.11939-5-vbabka@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220302173122.11939-1-vbabka@suse.cz>
References: <20220302173122.11939-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2691; i=vbabka@suse.cz; h=from:subject; bh=i+vTj/bLGNkS06QEkNuKLLTXKRcpqAmsd8AhSKRmP/4=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBiH6noW6mVlFyLbj1aJzDiTKdnm9vD+CY6DbeO2YmL hzn1zXKJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYh+p6AAKCRDgIcpz8YmpEPTTB/ 9Nm9Dxg3WSur7zB1Abt51hsqTZJ6TRd/u/Jx+tqEfmRCycJ89uyjl30SrhfjtLpAnUI2jha9AS6e+e +Zp5ZgM/67CLBHvLOQ9xD04qmnsl9+6aIM9LFj409LI5UQwJnttguLW1zdpea4kOQOF/1Zq8dK91eT rKBG8LGz+V+9fXO9x6vbN6TBzxvRLRzZqFWk4khMGMH7WY0PyktwnuIRbaU4s5n+rmvXroeLUNJ2ZY CgRpRTS3ykCDnUHj5fROFNHpJMWOSxjaln/3LAlX3svyq/tkZX1hflr8g/0Nxz6DimghkUEg0ILehb /cYy/J8v+gjNitirJ9GpHv/ObwEE/s
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
index 42cb79af70a0..25138cd7a4ef 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5074,6 +5074,7 @@ EXPORT_SYMBOL(validate_slab_cache);
  */
 
 struct location {
+	depot_stack_handle_t handle;
 	unsigned long count;
 	unsigned long addr;
 	long long sum_time;
@@ -5126,9 +5127,13 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
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
 
@@ -5143,7 +5148,8 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
 			break;
 
 		caddr = t->loc[pos].addr;
-		if (track->addr == caddr) {
+		chandle = t->loc[pos].handle;
+		if ((track->addr == caddr) && (handle == chandle)) {
 
 			l = &t->loc[pos];
 			l->count++;
@@ -5168,6 +5174,8 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
 
 		if (track->addr < caddr)
 			end = pos;
+		else if (track->addr == caddr && handle < chandle)
+			end = pos;
 		else
 			start = pos;
 	}
@@ -5190,6 +5198,7 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
 	l->max_time = age;
 	l->min_pid = track->pid;
 	l->max_pid = track->pid;
+	l->handle = handle;
 	cpumask_clear(to_cpumask(l->cpus));
 	cpumask_set_cpu(track->cpu, to_cpumask(l->cpus));
 	nodes_clear(l->nodes);
@@ -6101,6 +6110,21 @@ static int slab_debugfs_show(struct seq_file *seq, void *v)
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

