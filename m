Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857474F1EA4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379973AbiDDV7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379203AbiDDQnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:43:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A053A35855
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:41:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E843121110;
        Mon,  4 Apr 2022 16:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649090480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8KmIpmO8YqXFupMJe70SE4ST4S5v6JXlyjUwSJMcLP8=;
        b=TVTTVGBGcLRn7CeaaMh2C17Xjn0XKxhFq614E6Xpexe+8p9ZeTX0735WHz7q4R2JFLpE8G
        mJBXgopXf/XUbIdCE/nCMEfHl0PjzmeTEKz21nE4L2f82bNuUz7rVa/nKJj6NefkB6K0QZ
        9WuQc9MeADaearI10OPax4gwG//IRq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649090480;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8KmIpmO8YqXFupMJe70SE4ST4S5v6JXlyjUwSJMcLP8=;
        b=ATZhY4H6/PBegfP9r6vtIlKmb29/JpHLT/dEFJTF/Wa0cHS4scHRvlIq7ObkFlJXwLcX45
        7i4sjjq+qiHdJvDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B8C1713A89;
        Mon,  4 Apr 2022 16:41:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gPx5LLAfS2LjfAAAMHmgww
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
Subject: [PATCH v3 5/6] mm/slub: sort debugfs output by frequency of stack traces
Date:   Mon,  4 Apr 2022 18:41:11 +0200
Message-Id: <20220404164112.18372-6-vbabka@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220404164112.18372-1-vbabka@suse.cz>
References: <20220404164112.18372-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1585; i=vbabka@suse.cz; h=from:subject; bh=VWFnnyqmJ3+H/KNgJI+ywlf8rteatjMmjGdFv2ZRZAw=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBiSx+mYi5UGPiEavlh5JxH0UiWzCBiobPIgKlRfrvu b+85Wi2JATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYksfpgAKCRDgIcpz8YmpEEOdB/ 9jpr5TWCnpmgEh6Z2MrAz9Xj9T/goJ6+Zgnoln8bhAP12iksWj7XdGTFTK8rwf05YRYaIfHeI1+Vvl LD1DPs0SJFixbeWW0DB2A0EniuqfNgsJ7liONNz1xxioOnkZ8AJFXS8kDyJ2wCjgGLmbMc7I9RSg9/ CuzAJ4CD2x1YoP1GV9e9Gfk0UnaxONR5i0UQZDUU9LXbOx3lOpDUUU129+9gplokFWIFz9PoHtbIXu E95Md+iEzYsS3tUN9gecEJLHPESQsDYrZculV45wdlwyFYLK8VycXMun1fd5I4bPo9pIcEBFNN+g17 juUwhdYTPOxnJHR3nf8kpPtCI7HZMB
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
Reviewed-and-tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slub.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index f2e550e1adf0..2963dc123336 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -38,6 +38,7 @@
 #include <linux/memcontrol.h>
 #include <linux/random.h>
 #include <kunit/test.h>
+#include <linux/sort.h>
 
 #include <linux/debugfs.h>
 #include <trace/events/kmem.h>
@@ -6137,6 +6138,17 @@ static void *slab_debugfs_next(struct seq_file *seq, void *v, loff_t *ppos)
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
@@ -6198,6 +6210,10 @@ static int slab_debug_trace_open(struct inode *inode, struct file *filep)
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

