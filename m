Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1857B4D8A38
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbiCNQ6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbiCNQ6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:58:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137223A73B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 09:57:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B45C41F380;
        Mon, 14 Mar 2022 16:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647277052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=EjQj53Mw0YNh700fK1Icsq6ho1Eko/PdYkCQNR6mqrE=;
        b=gugqY4B+djL/nhmH2nhDAdJV9P41rQYJ2g8SWA9aCiKiiKSdP2+uGZsC4sPdnLQ8fOgSCH
        qSm6oJPE6pYN89aep1Xr1FKgtz60j1MreAp0B6P5lM0t/5RqEp9n8OdcaLZGDVga6OGmeo
        UaWZx+zlPEUkeANI0uWQ9uIAZDXJ17E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647277052;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=EjQj53Mw0YNh700fK1Icsq6ho1Eko/PdYkCQNR6mqrE=;
        b=fnCZrvmEeOA7aH1I0CkzTH1mPfrTtZJOzoyH8BmBVce8WgahkZwgQgUp/95n0M8XfYcZLU
        0/4ZOUhnIT9ymwAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8994213B39;
        Mon, 14 Mar 2022 16:57:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RbYpIPxzL2I+PAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 14 Mar 2022 16:57:32 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 1/2] mm, fault-injection: declare should_fail_alloc_page()
Date:   Mon, 14 Mar 2022 17:57:23 +0100
Message-Id: <20220314165724.16071-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1119; h=from:subject; bh=QGoL6qUI09dpG/35dBQDgHemHz/FCAGmqGRnNq+rios=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBiL3Pyn7opOzfCBHWa660u1sfUHhTXqveiKMNIEZ6Q pT5b1QiJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYi9z8gAKCRDgIcpz8YmpEMjmCA C9dqVWnbqOG9kRwx4yBIUGJqbzVqSalN5zHjMGiyDG9PUa8Mnsw9v6WJnWG1gaXlTYM2UMkddxUri0 kEpkTc6qNrYCiVzwkr8MVCFU9JEDYmIkPz/EBljtAn0cjEZnHhcM5BVQeJ5J48dZzz25H4PgSc1bW5 FKbXmRop8pWwllwouudA5m0JJrLP+IeNyEC/GPxsTJGWqpiCFEmBpdJSJWDxoCf5jEax4yqzbwKUnj jAcBl7tnK4lVHEyhafgDiTGXts1HxQWuXkWqLza096bE/p3c0aJKNWEU43yOANIOKTZN/vJ9X4Kycb ZThdDMOsM+5NMxrU4PpYv+0bfjRDxj
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

The mm/ directory can almost fully be built with W=1, which would help
in local development. One remaining issue is missing prototype for
should_fail_alloc_page(). Thus add it next to the should_failslab()
prototype.

Note the previous attempt by commit f7173090033c ("mm/page_alloc: make
should_fail_alloc_page() static") had to be reverted by commit
54aa386661fe as it caused an unresolved symbol error with
CONFIG_DEBUG_INFO_BTF=y

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/fault-inject.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/fault-inject.h b/include/linux/fault-inject.h
index e525f6957c49..2d04f6448cde 100644
--- a/include/linux/fault-inject.h
+++ b/include/linux/fault-inject.h
@@ -64,6 +64,8 @@ static inline struct dentry *fault_create_debugfs_attr(const char *name,
 
 struct kmem_cache;
 
+bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order);
+
 int should_failslab(struct kmem_cache *s, gfp_t gfpflags);
 #ifdef CONFIG_FAILSLAB
 extern bool __should_failslab(struct kmem_cache *s, gfp_t gfpflags);
-- 
2.35.1

