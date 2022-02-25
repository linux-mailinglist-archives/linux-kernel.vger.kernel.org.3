Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2DE4C4D2C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbiBYSEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbiBYSE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:04:26 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999DE2782B2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:03:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2C0682170E;
        Fri, 25 Feb 2022 18:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645812232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JD9hqNkoA5J42agtjJGEVLrQTac6+7vbg/b1GAr+BEA=;
        b=YGjh6vBj2Ti9mp6ef4y1E4kNoGSitUTTqmSgcdiMzYS2NpOjuV6CQ+3zktn+383Gx7dtGZ
        hjCQub9XAeHxD5coz/ymq3VtM6VhQhTJ3TrN+CdCIa4cwDbhQeOEwnnBjaoUSSid7dsvUk
        9ablYY2/K0CpXb1fp7knvPHt6MORxv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645812232;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JD9hqNkoA5J42agtjJGEVLrQTac6+7vbg/b1GAr+BEA=;
        b=l6p/u75O17s5invG2b8ryOwS/RnwgniwqiB1avm9l3/Pnafe1VtUc1NreH3dSOi8uSq9fM
        5LfezO/U5bCC6MDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C243913C17;
        Fri, 25 Feb 2022 18:03:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0G3PLgcaGWKSRQAAMHmgww
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
Subject: [PATCH 4/5] mm/slub: sort debugfs output by frequency of stack traces
Date:   Fri, 25 Feb 2022 19:03:17 +0100
Message-Id: <20220225180318.20594-5-vbabka@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225180318.20594-1-vbabka@suse.cz>
References: <20220225180318.20594-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1524; i=vbabka@suse.cz; h=from:subject; bh=xon+abvw43ttzY/JL7dHk0VJGFJj42xBf676Lz8+8ko=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBiGRnkU4GtGDN+xfeUVAn46PwUBpP9RxYL6YJ8EmhE gxqahSmJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYhkZ5AAKCRDgIcpz8YmpEPY8B/ 98BKdLhZDN6HhOVm0tL7NIdHDDDgyiOrkS6i3h+AjEpuQDeg3BCKLN9NiVU5UgDFE1CJk+1FbKNVLL aVYGQQQ0EELV2AclZOqeFxeCDEiRLqEP0miGwAhwYy4wiWvVveayeLFNdmmWSNVmwPo10g5PWSaT7b 8N2S/whmykcaLi9znc3uHNzPEHxN2ZCgPiKUa6g7ekYCz5rYPXOchAFB58HrbLbkB11dAykIq4uNFj L95uNYrhhWiu67zzKPR3qRWHazTSh/iDIySvg0iaAhFXvsD17ZQAiW6UxI0NM6qhGl/OUoivTiF4Hy sD/E+PWVRJzM+9k8nvTo0d+pnRJTXc
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

Sort the output of debugfs alloc_traces and free_traces by the frequency
of allocation/freeing stack traces. Most frequently used stack traces
will be printed first, e.g. for easier memory leak debugging.

Signed-off-by: Oliver Glitta <glittao@gmail.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index 06599db4faa3..a74afe59a403 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -38,6 +38,7 @@
 #include <linux/memcontrol.h>
 #include <linux/random.h>
 #include <kunit/test.h>
+#include <linux/sort.h>
 
 #include <linux/debugfs.h>
 #include <trace/events/kmem.h>
@@ -6150,6 +6151,17 @@ static void *slab_debugfs_next(struct seq_file *seq, void *v, loff_t *ppos)
 	return NULL;
 }
 
+static int cmp_loc_by_count(const void *a, const void *b, const void *data)
+{
+	struct location *loc1 = (struct location *)a;
+	struct location *loc2 = (struct location *)b;
+
+	if (loc1->count > loc2->count)
+		return -1;
+	else
+		return 1;
+}
+
 static void *slab_debugfs_start(struct seq_file *seq, loff_t *ppos)
 {
 	struct loc_track *t = seq->private;
@@ -6211,6 +6223,10 @@ static int slab_debug_trace_open(struct inode *inode, struct file *filep)
 		spin_unlock_irqrestore(&n->list_lock, flags);
 	}
 
+	/* Sort locations by count */
+	sort_r(t->loc, t->count, sizeof(struct location),
+		cmp_loc_by_count, NULL, NULL);
+
 	bitmap_free(obj_map);
 	return 0;
 }
-- 
2.35.1

