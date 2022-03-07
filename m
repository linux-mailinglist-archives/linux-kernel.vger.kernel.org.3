Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0571A4D0277
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 16:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243650AbiCGPIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 10:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242498AbiCGPIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:08:32 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934C41260E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 07:07:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 451591F396;
        Mon,  7 Mar 2022 15:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646665657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3P7bIRLrBlFDijrCRgEyPsvaDPLZQ9uN0q/x7eaR+p0=;
        b=Ey7TZ3RtHRDRJfjlRvqYGfgCeXP6f2e/zRCCnY0fgKG+lWYsIszX1S0JeOD0iI27d9FANs
        tuAtcOnnQkyna/xA02xRXWVx8vqENll2LjOAKLAhL+6nmVki01Um8UZ6XeCpBYpoOs4YJy
        MpxRC9LshIBY1+5Sm80cxTgxfftE1Uw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646665657;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3P7bIRLrBlFDijrCRgEyPsvaDPLZQ9uN0q/x7eaR+p0=;
        b=bk0rwY2cBrRtaQPiDVmNf/T1xTP4vhye4JE996PHCMKFUBCfYkvXZ+ODoldNb+f4Gr+V34
        YBZ0mSifN2993CBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C38FB132BC;
        Mon,  7 Mar 2022 15:07:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gIoJLbgfJmLrHgAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 07 Mar 2022 15:07:36 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 3/3] mm/memory_hotplug: Refactor hotadd_init_pgdat and try_online_node
Date:   Mon,  7 Mar 2022 16:07:25 +0100
Message-Id: <20220307150725.6810-4-osalvador@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220307150725.6810-1-osalvador@suse.de>
References: <20220307150725.6810-1-osalvador@suse.de>
MIME-Version: 1.0
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

Since we pre-allocate all nodes now, hotadd_init_pgdat() does
not need to return a pgdat struct, as that was meant for
__try_online_node() to check whether the node was succesfully
allocated.

Also get rid of the __ref as all functions hotadd_init_pgdat()
calls fall within the same section.

Also try to make more clear the return codes from __try_online_node().
__try_online_node() can return either 0, 1 or -errno (the latter not really
as the BUG_ON() would catch it before we return) but depending on the caller
that has different meanings.
For add_memory_resource(), when __try_online_node() returns non-zero,
it means that the node was already allocated and it does not need to bring
it up. It is fine not to check for -errno values because we do not
get to call register_one_node() when !set_node_online.
For those who call try_online_node(), so set_node_online is true, a value
other than zero means a failure (e.g: cpu_up() or find_and_online_cpu_nid()).

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/memory_hotplug.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 07cece9e22e4..5c92ac81a399 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1161,8 +1161,7 @@ static void reset_node_present_pages(pg_data_t *pgdat)
 	pgdat->node_present_pages = 0;
 }
 
-/* we are OK calling __meminit stuff here - we have CONFIG_MEMORY_HOTPLUG */
-static pg_data_t __ref *hotadd_init_pgdat(int nid)
+static void hotadd_init_pgdat(int nid)
 {
 	struct pglist_data *pgdat = NODE_DATA(nid);
 
@@ -1182,8 +1181,6 @@ static pg_data_t __ref *hotadd_init_pgdat(int nid)
 	 * to access not-initialized zonelist, build here.
 	 */
 	build_all_zonelists(pgdat);
-
-	return pgdat;
 }
 
 /*
@@ -1193,31 +1190,27 @@ static pg_data_t __ref *hotadd_init_pgdat(int nid)
  * called by cpu_up() to online a node without onlined memory.
  *
  * Returns:
- * 1 -> a new node has been allocated
- * 0 -> the node is already online
- * -ENOMEM -> the node could not be allocated
+ * 1 -> The node has been initialized.
+ * 0 -> Either the node was already online, or we succesfully registered a new
+ *      one.
+ * -errno -> register_one_node() failed.
  */
 static int __try_online_node(int nid, bool set_node_online)
 {
-	pg_data_t *pgdat;
-	int ret = 1;
+	int ret;
 
 	if (node_online(nid))
 		return 0;
 
-	pgdat = hotadd_init_pgdat(nid);
-	if (!pgdat) {
-		pr_err("Cannot online node %d due to NULL pgdat\n", nid);
-		ret = -ENOMEM;
-		goto out;
-	}
+	hotadd_init_pgdat(nid);
+
+	if (!set_node_online)
+		return 1;
+
+	node_set_online(nid);
+	ret = register_one_node(nid);
+	BUG_ON(ret);
 
-	if (set_node_online) {
-		node_set_online(nid);
-		ret = register_one_node(nid);
-		BUG_ON(ret);
-	}
-out:
 	return ret;
 }
 
-- 
2.34.1

