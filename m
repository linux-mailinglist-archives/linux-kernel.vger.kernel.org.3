Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1575964A9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 23:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237649AbiHPVcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 17:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237159AbiHPVcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 17:32:52 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D13B8A6F8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:32:49 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 6431012135A;
        Tue, 16 Aug 2022 21:32:49 +0000 (UTC)
Received: from pdx1-sub0-mail-a292.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id ED9651220C6;
        Tue, 16 Aug 2022 21:32:48 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1660685569; a=rsa-sha256;
        cv=none;
        b=eqOFaHFfJOC0fw24TsJq0i/M3NP+k1KDT72qAtx9cddcbWWGmoXYNNDANAG7ULhtn6uZB5
        Hef+Du3PodqHX4vWglAX9g5k8f8qjbHqMGZQqaRKSn8wn2lq0KVAzOOxMcS08h8p30ugUD
        IcOKJVpzlNpN5N1VJqp1bapF5lAXYfsJtETUMiXwCIu4NWJNoRporNipNPn0rsCSx8jDVk
        JLRQa3CXz2ojV5uuMYxLOJ03Vn87N72B8xejdqqIi5CG+aZA1g4fq6PgDXhriRqCxn70fO
        k6ua9t6zRWbKhCOyFEtQA95W0UrjFmHNxRz2tuxIwD0pGeivkOd+wzEt/7e7vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1660685569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=PDKuvb/ex6Zle6Fc5j0wp3zzKS/PZoppMV+iGRqF/tE=;
        b=64gId466mTRa/AK0bQmQ6YpxlUMWcNiDv+MDi4zsdWhInMW8E5E/6Et3ZdzecRv5Cu/Gt9
        v1bHWvs3sotCi1+jSQWL+NmZGvJt3faThV4a4+I5jUobEfDsCP3lU+aCFwevIhNHijy3Ca
        Xs+VWgeE51imyL0qsgngNSKL8oY5OkBqrd+e5U4Bcx7NwQ7iLoQGx7pP2wtWyJN+PuLkN1
        0OxzvQVeiki/A21Ee+Gs4ReH6DcbDEuOdAHCu8gREKa2cKy6g0HGF3zEvBzWPKWVS9PgPB
        u3ksCu5piZpjL51cMRI/g2r57vtjX1cD2qOqhLLpJyH9VGTST7Wf1ov0MyVHjQ==
ARC-Authentication-Results: i=1;
        rspamd-7697cc766f-r4c9z;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tart-Drop: 40a0aca735329580_1660685569233_3771307976
X-MC-Loop-Signature: 1660685569233:2160473036
X-MC-Ingress-Time: 1660685569233
Received: from pdx1-sub0-mail-a292.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.110.28.254 (trex/6.7.1);
        Tue, 16 Aug 2022 21:32:49 +0000
Received: from offworld.. (unknown [104.36.25.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a292.dreamhost.com (Postfix) with ESMTPSA id 4M6krw0xQHz5j;
        Tue, 16 Aug 2022 14:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1660685568;
        bh=PDKuvb/ex6Zle6Fc5j0wp3zzKS/PZoppMV+iGRqF/tE=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=Uhq2Y47Bxg8UjxquVs7w/MLc17W4yQBKdZ0OivqVwybWaaOv6WotcrffsSH3AXkvL
         CM72k70du2NfWPxYO6WRfwXIThn1M06aon0c3kKMaWiN9EnEoRend2W5dXhyYjpkug
         uThx4od/4Q5urYN+v1qWQv3swdMg8+CZDk9zOaRjk2mw3x7KgUMkVjtl7x954EE79X
         4WWzKEGVy/nzDlUId8ntn5fwQ7p4vvnSsJXi2VzR0j/A4TCzB4QzqHimlHCNxhW6tQ
         K4Y3+LRGCURYFDwAh6oapRnk+Vo7gOx1kq5gc4GozQ/v1sgyjkjOG4Mt6AtqSSCKCQ
         1GM/u/7s6PCdw==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     chris@zankel.net, jcmvbkbc@gmail.com
Cc:     linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net
Subject: [PATCH] xtensa: use asm-generic/cacheflush.h
Date:   Tue, 16 Aug 2022 14:32:37 -0700
Message-Id: <20220816213237.924454-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rely on asm-generic/cacheflush.h for the defaults
for the non-aliasing cases.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 arch/xtensa/include/asm/cacheflush.h | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/arch/xtensa/include/asm/cacheflush.h b/arch/xtensa/include/asm/cacheflush.h
index 7b4359312c25..b86f3fb0bf8d 100644
--- a/arch/xtensa/include/asm/cacheflush.h
+++ b/arch/xtensa/include/asm/cacheflush.h
@@ -129,19 +129,7 @@ void local_flush_cache_page(struct vm_area_struct *vma,
 
 #else
 
-#define flush_cache_all()				do { } while (0)
-#define flush_cache_mm(mm)				do { } while (0)
-#define flush_cache_dup_mm(mm)				do { } while (0)
-
-#define flush_cache_vmap(start,end)			do { } while (0)
-#define flush_cache_vunmap(start,end)			do { } while (0)
-
-#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
-#define flush_dcache_page(page)				do { } while (0)
-
 #define flush_icache_range local_flush_icache_range
-#define flush_cache_page(vma, addr, pfn)		do { } while (0)
-#define flush_cache_range(vma, start, end)		do { } while (0)
 
 #endif
 
@@ -154,12 +142,6 @@ void local_flush_cache_page(struct vm_area_struct *vma,
 		__invalidate_icache_range(start,(end) - (start));	\
 	} while (0)
 
-/* This is not required, see Documentation/core-api/cachetlb.rst */
-#define	flush_icache_page(vma,page)			do { } while (0)
-
-#define flush_dcache_mmap_lock(mapping)			do { } while (0)
-#define flush_dcache_mmap_unlock(mapping)		do { } while (0)
-
 #if defined(CONFIG_MMU) && (DCACHE_WAY_SIZE > PAGE_SIZE)
 
 extern void copy_to_user_page(struct vm_area_struct*, struct page*,
@@ -181,4 +163,6 @@ extern void copy_from_user_page(struct vm_area_struct*, struct page*,
 
 #endif
 
+#include <asm-generic/cacheflush.h>
+
 #endif /* _XTENSA_CACHEFLUSH_H */
-- 
2.37.2

