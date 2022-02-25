Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1254C4D2D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiBYSEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbiBYSE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:04:26 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58192276D5A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:03:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BDDE72170C;
        Fri, 25 Feb 2022 18:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645812231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tBu/1WYoU7cCryCBr/Wwsy2RZmkfbDk2ui5A6RtTEco=;
        b=Jn6Z2Hk6YSl9rquKmP/kmjyovS3A1Ye0ylo2O3gsy1Bkah11ir4Llca6YzchFiL0T7Zr70
        3Ml07bcboGjKRv9CzBDKdAmKao/FuaM0ZZLF4xOjmNxf5WauI547ase3+RxOgYLeznGPPt
        32/oi5kZOlKvLYkNOs3l5wpvvvTQh2I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645812231;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tBu/1WYoU7cCryCBr/Wwsy2RZmkfbDk2ui5A6RtTEco=;
        b=nTBpUGl1wL5gy8S2j8xBzEoen3eXuzL6Cfhva5VU4qjmb7IDWgw3pppL29Sdct4CM+xA9E
        H5xGazOG8VOAC8AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 945B313EA7;
        Fri, 25 Feb 2022 18:03:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KPSXIwcaGWKSRQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 25 Feb 2022 18:03:51 +0000
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
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 3/5] mm/slub: aggregate and print stack traces in debugfs files
Date:   Fri, 25 Feb 2022 19:03:16 +0100
Message-Id: <20220225180318.20594-4-vbabka@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225180318.20594-1-vbabka@suse.cz>
References: <20220225180318.20594-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2623; i=vbabka@suse.cz; h=from:subject; bh=d/M0A17T6NVY/63xRjHahLXVuqzL7p0DQ1xf3e/krws=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBiGRnjHrUvTO68/pSZox7nb/OtUKsIoZpHL+wB17v2 pbEhdFuJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYhkZ4wAKCRDgIcpz8YmpEPhqB/ 4yB1v3Ok3qG0Z3hJymSKSn+NNc+Ax2oS3LyVypyj91uSQ9b76twtFUbr3/riY0ZS1aR0iMbqsp+Uhv 4WHk6FHCNr6PdRaJhGcyegNTKlBm2Z1VpK9PJqKHJuESARGavs2ngutFi5gnh2VQtryqXm7ki/9Pj2 5E0TYDM5k+SGIJljQAnkkSCAT0WMtkj2C0uQxsoo3fGCyAo/kTT0yPKHAaYiJZUOXDYTCgVOqAA5CO ea4xGfybJSYv/kISQbXnbwzK6+2sFLFyXY+rrCSVmEcs5/VW5wrZNDFr1n9y2lfxS/rAkcE9aGFs/e NLLZsBI10+fI+NuzWgkk0z4yiFDrp5
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

Aggregate objects in slub cache by stack trace in addition to caller
address when producing contents of debugfs files alloc_traces and
free_traces in debugfs. Also add the stack traces to the debugfs
output. This makes it much more useful to e.g. debug memory leaks.

Signed-off-by: Oliver Glitta <glittao@gmail.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 3140f763e819..06599db4faa3 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5075,6 +5075,7 @@ EXPORT_SYMBOL(validate_slab_cache);
  */
 
 struct location {
+	depot_stack_handle_t handle;
 	unsigned long count;
 	unsigned long addr;
 	long long sum_time;
@@ -5127,9 +5128,13 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
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
 
@@ -5144,7 +5149,8 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
 			break;
 
 		caddr = t->loc[pos].addr;
-		if (track->addr == caddr) {
+		chandle = t->loc[pos].handle;
+		if ((track->addr == caddr) && (handle == chandle)) {
 
 			l = &t->loc[pos];
 			l->count++;
@@ -5169,6 +5175,8 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
 
 		if (track->addr < caddr)
 			end = pos;
+		else if (track->addr == caddr && handle < chandle)
+			end = pos;
 		else
 			start = pos;
 	}
@@ -5191,6 +5199,7 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
 	l->max_time = age;
 	l->min_pid = track->pid;
 	l->max_pid = track->pid;
+	l->handle = handle;
 	cpumask_clear(to_cpumask(l->cpus));
 	cpumask_set_cpu(track->cpu, to_cpumask(l->cpus));
 	nodes_clear(l->nodes);
@@ -6102,6 +6111,21 @@ static int slab_debugfs_show(struct seq_file *seq, void *v)
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

