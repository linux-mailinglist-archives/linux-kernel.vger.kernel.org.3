Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E236F4D633B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348423AbiCKOOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349871AbiCKONi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:13:38 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826C21C65CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 06:12:22 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 929C7C01B; Fri, 11 Mar 2022 15:12:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1647007940; bh=F9oTQJj/bOWo+DnmjeL79H/5Dvz3gPQThlOlCq8LXyg=;
        h=From:To:Cc:Subject:Date:From;
        b=BtQJETfV7ckRZaHu3+Pz0LoOZinNNMnVWZNnSWyvGsJOPkmUGMMfpxr2YRym04l9E
         zQS5scHlHFAHZhhdNA9K54ROQbUv6U3vI+Cdw8YMFACYaqY3Ijg9epNzip/8v2xASv
         smMWT4STe0H6bEhP/xAlTIb7XHv4H54IZosVXfhUBYL4nQkSeUOAbxj7Rt0n9tAg1T
         iRLKSjvoo8ItbWshS2vrqO90w1qBDZSRgTxXqJQ3/lp/lGGA17dB8Xk1SwHSCSt7cc
         Ft5Ij6xqk+OuMfxemEIFQWYnFgXYAHksYwPQ0HLi/uctAYuKKicksNUK0oxlXrEjI9
         lIH+9PzldQPQw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 046C5C009;
        Fri, 11 Mar 2022 15:12:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1647007940; bh=F9oTQJj/bOWo+DnmjeL79H/5Dvz3gPQThlOlCq8LXyg=;
        h=From:To:Cc:Subject:Date:From;
        b=BtQJETfV7ckRZaHu3+Pz0LoOZinNNMnVWZNnSWyvGsJOPkmUGMMfpxr2YRym04l9E
         zQS5scHlHFAHZhhdNA9K54ROQbUv6U3vI+Cdw8YMFACYaqY3Ijg9epNzip/8v2xASv
         smMWT4STe0H6bEhP/xAlTIb7XHv4H54IZosVXfhUBYL4nQkSeUOAbxj7Rt0n9tAg1T
         iRLKSjvoo8ItbWshS2vrqO90w1qBDZSRgTxXqJQ3/lp/lGGA17dB8Xk1SwHSCSt7cc
         Ft5Ij6xqk+OuMfxemEIFQWYnFgXYAHksYwPQ0HLi/uctAYuKKicksNUK0oxlXrEjI9
         lIH+9PzldQPQw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 4c2ced64;
        Fri, 11 Mar 2022 14:12:15 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH] fscache_aquire_cache: error instead of asserting name is set
Date:   Fri, 11 Mar 2022 23:12:08 +0900
Message-Id: <20220311141208.847320-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

name comes straight from the cachefilesd config file, so return an error that
the daemon handles and reports instead of printing a kernel stack in dmesg

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 fs/fscache/cache.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/fscache/cache.c b/fs/fscache/cache.c
index 2749933852a9..6115b974585d 100644
--- a/fs/fscache/cache.c
+++ b/fs/fscache/cache.c
@@ -150,7 +150,9 @@ struct fscache_cache *fscache_acquire_cache(const char *name)
 {
 	struct fscache_cache *cache;
 
-	ASSERT(name);
+	if (!name)
+		return ERR_PTR(-EINVAL);
+
 	cache = fscache_lookup_cache(name, true);
 	if (IS_ERR(cache))
 		return cache;
-- 
2.35.1

