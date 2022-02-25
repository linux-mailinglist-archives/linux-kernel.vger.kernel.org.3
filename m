Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFCC4C4D2F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbiBYSE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbiBYSEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:04:25 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAC12510FD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:03:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 633A3212C3;
        Fri, 25 Feb 2022 18:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645812231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wbzb6rwe8BeYvrev9nqwEXLhWRFFA+vAEVQGD0RO8YQ=;
        b=yZIpqxaoqBAAGu78WfynY6RE/QeIasdv8y41xCLA172w16Hrmg2D1Ok5L9f3PYpp6EsEqn
        bh/Z5Co+xzyt9p30RxcgKkTUV/IjoPvsITEiEpZ6w98ufyVFwDxpPi9R3zs1+rmTosDRfo
        RtxgHdevfR4JidJiOdixd3i1oivM5Y4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645812231;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wbzb6rwe8BeYvrev9nqwEXLhWRFFA+vAEVQGD0RO8YQ=;
        b=zOu/LTYva8llbVLt23byI4J6oSyX/461yzWGb3GEY3aaNptsxCtR43jeJ9ihZBVH3uXgpa
        XkQiQrL9PvhMqqAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3766113EA7;
        Fri, 25 Feb 2022 18:03:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CMbyDAcaGWKSRQAAMHmgww
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
Subject: [PATCH 1/5] mm/slub: move struct track init out of set_track()
Date:   Fri, 25 Feb 2022 19:03:14 +0100
Message-Id: <20220225180318.20594-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225180318.20594-1-vbabka@suse.cz>
References: <20220225180318.20594-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1979; h=from:subject; bh=+MXYxk+IxU7wPrbf4fe94giU090LakTiC0p9f3LDPs0=; b=owGbwMvMwMH4QPFU8cfOlQKMp9WSGJIkJR/yBC2Ve3i3Y8P/WY8P1spXt4Vk5mm7MpUnZBuUaPQm b/DrZDRmYWDkYJAVU2Tp9Z7MuNL0scQ+j7gzMINYmUCmMHBxCsCN1uBgmPpMuFjBj4VN/5dLzY7aZp PwY8kdBS587DH6ttX/ZNJ2Vmt8b//sb+TBqbv8xAWf/pfZ79kPOm7+/tj6/tH1cX9V+Sfej2adIn5x U4LPN5XStOvBcttLmHpqPu19YKShum+LkNYTLoeVbw88XO79NvXH1VNBirp7hBJWr+PL8Q2yFZy6VO Z2qu6VvC+XVu+S67ox4+CjheHuH1p9/h85POPipoPTw3k2PL3u3xc5Z//M3vL0nUzBkSfiS+ZJvfzm 086gbbTiROeSg5yWG4xO37z9uUBzh0vkSV6pH10BjNmhUdH3Hr715bhZuNWjZ7IdM1u97nabk0s2al tvMd6ssYo3rdnEv8z5XYf7tYaJAA==
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

set_track() either zeroes out the struct track or fills it, depending on
the addr parameter. This is unnecessary as there's only one place that
calls it for the initialization - init_tracking(). We can simply do the
zeroing there, with a single memset() that covers both TRACK_ALLOC and
TRACK_FREE as they are adjacent.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 261474092e43..1fc451f4fe62 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -729,34 +729,32 @@ static void set_track(struct kmem_cache *s, void *object,
 {
 	struct track *p = get_track(s, object, alloc);
 
-	if (addr) {
 #ifdef CONFIG_STACKTRACE
-		unsigned int nr_entries;
+	unsigned int nr_entries;
 
-		metadata_access_enable();
-		nr_entries = stack_trace_save(kasan_reset_tag(p->addrs),
-					      TRACK_ADDRS_COUNT, 3);
-		metadata_access_disable();
+	metadata_access_enable();
+	nr_entries = stack_trace_save(kasan_reset_tag(p->addrs),
+				      TRACK_ADDRS_COUNT, 3);
+	metadata_access_disable();
 
-		if (nr_entries < TRACK_ADDRS_COUNT)
-			p->addrs[nr_entries] = 0;
+	if (nr_entries < TRACK_ADDRS_COUNT)
+		p->addrs[nr_entries] = 0;
 #endif
-		p->addr = addr;
-		p->cpu = smp_processor_id();
-		p->pid = current->pid;
-		p->when = jiffies;
-	} else {
-		memset(p, 0, sizeof(struct track));
-	}
+	p->addr = addr;
+	p->cpu = smp_processor_id();
+	p->pid = current->pid;
+	p->when = jiffies;
 }
 
 static void init_tracking(struct kmem_cache *s, void *object)
 {
+	struct track *p;
+
 	if (!(s->flags & SLAB_STORE_USER))
 		return;
 
-	set_track(s, object, TRACK_FREE, 0UL);
-	set_track(s, object, TRACK_ALLOC, 0UL);
+	p = get_track(s, object, TRACK_ALLOC);
+	memset(p, 0, 2*sizeof(struct track));
 }
 
 static void print_track(const char *s, struct track *t, unsigned long pr_time)
-- 
2.35.1

