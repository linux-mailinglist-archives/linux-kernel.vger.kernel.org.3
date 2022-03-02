Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8984CAC13
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244051AbiCBRdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243944AbiCBRdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:33:13 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6D255BFB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:32:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3C1501F8AA;
        Wed,  2 Mar 2022 17:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646242297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LwcP1iJrYs9CiAU77l19QAKomEttfa24uCohxTMqv9A=;
        b=YGwfIf+naYMjndyRe1xaiqBlc0LEwBeqFk2Rgqi7wvpAEeuDNTfz8hZlqi0AKOY0xneEG6
        mnhbvBk/rxNxxqG1sDJUbpBYWssViMCnuxgIR2aSSrq2Dval/FZf6Kt8+V0VwHiYGxXLxy
        WFJsq8E/AdY9bfOCMYeU/vfEMQcwzTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646242297;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LwcP1iJrYs9CiAU77l19QAKomEttfa24uCohxTMqv9A=;
        b=dmywO0lYe0j27g6NwDAGRsVMvyc04njnj0FW6VpDmK1nSudERrNP1/y5dyuyTArsS0/A6v
        MhRgzTJ99tJQDSDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F1F8013D38;
        Wed,  2 Mar 2022 17:31:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cBiDOvipH2LPTAAAMHmgww
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
Subject: [PATCH v2 5/6] mm/slub: sort debugfs output by frequency of stack traces
Date:   Wed,  2 Mar 2022 18:31:21 +0100
Message-Id: <20220302173122.11939-6-vbabka@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220302173122.11939-1-vbabka@suse.cz>
References: <20220302173122.11939-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1585; i=vbabka@suse.cz; h=from:subject; bh=tlKVMC4Mx/hSa/FZSyCKskcpV5VFc4MSXPAqJSKQmvo=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBiH6npw4Jqu7vak6nvRHvxTCzeJjHQMlEYpCh9kQiZ Kc2CKi6JATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYh+p6QAKCRDgIcpz8YmpECnaB/ 43KXlOKcXMrSiW0sg7KEoTPuicTHQe25b5a2/l8Nr1v/N2Ay7agOO3pWPD/Mah/V27RAjM5T1NhTnl I++Nw27NO3RD7qNmvmA0VAMvpSG3RAT7nne7V83BJmSFFng/8QHp1hgDXQ+ctDY1K1zKqYh3xoXTdc vxcsAS8uOKvH5/TCVM6Ihw/ZC11qGthce8a2RFEGpxdwKjnP0BfuvcsJO2CU50HYXLzspWPHnZie2i xprk+SPoEB01FhHfqdAj5ZprQ+GiAxILxnMTFRVFs4DAnk6PIbSOAIH5vAVIOGdaUuRO8YhlDWj2ub O18MaKRRTTv8heY4DqKzc2FzIZmQqb
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
index 25138cd7a4ef..39da762fbceb 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -38,6 +38,7 @@
 #include <linux/memcontrol.h>
 #include <linux/random.h>
 #include <kunit/test.h>
+#include <linux/sort.h>
 
 #include <linux/debugfs.h>
 #include <trace/events/kmem.h>
@@ -6149,6 +6150,17 @@ static void *slab_debugfs_next(struct seq_file *seq, void *v, loff_t *ppos)
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
@@ -6210,6 +6222,10 @@ static int slab_debug_trace_open(struct inode *inode, struct file *filep)
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

