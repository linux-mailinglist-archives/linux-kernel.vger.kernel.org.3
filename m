Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0BA59747E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241165AbiHQQvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241141AbiHQQvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:51:40 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564BB85F87
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:51:37 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D294D824FD;
        Wed, 17 Aug 2022 16:51:34 +0000 (UTC)
Received: from pdx1-sub0-mail-a274.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 5836A8257C;
        Wed, 17 Aug 2022 16:51:34 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1660755094; a=rsa-sha256;
        cv=none;
        b=cDPm5aDRagmiXd1f30W2DXF3k+ZgbdxkYfQOMOb5Wh4bRNrcA1TEVV1efYaMurZ1SPPvCe
        68fn/Qxm+tG6MR7CJBFBGApt4HvwMNTffizWYHUYGaulPOu9Qeq6HBc/EauqU+RcTpTzpt
        +r49IcBNpfuVRZPCN2fZ5lM8NPxCe9TN8SCb4/cJF1VHMRGhLJn5wBPXBaKE52UALItTIM
        gfOJ4CdnNf/ufQQYyJgQ9qmwWTaaJmKvvGPy7l/ZrmIOuTRNYcmaDMEuOPJz1gH4rddTYz
        /OzeaUCHGmUqlMCq6Qd6hl17E709VpePkv+xpXC00+uSq+0BZbTgoC/E330+sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1660755094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=xaPo4zsK8C4sYthWV3qxpUqrKQh7yxdRf5TciH/0x3Y=;
        b=hNqak+0kM2uRwYMyVIg8kbOIgfQgbCkhSpmqpAZlGCoF4U5ebEYpaocsvLlWEarNmihcL4
        sT14IbkmntSbCAw2Cd10OozY0SS2km6R9umGE5FP1KPcBRP+sq5yyKOLHhLjV+5XGX2wN1
        zFA9U18APzp/TEeBe53OdjF56KnJctE2EQIwnP87n8g8XVqtbK1ynmCPCY2GGLkeHdSJQY
        KCCm9K4czVK5gs7X5pAjW2NORY3quWi872tLCf5SQq1t0NGiSTx2JOJgT8eBsXi922MabZ
        3KDBcUD3VL4A0M3iduB8KWk8gfswUBb7wss4hNO9VDffmp2CGHRXAlNeJ/g6Og==
ARC-Authentication-Results: i=1;
        rspamd-79b898d947-vd42s;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Robust-Cooperative: 5b94f0a65345267a_1660755094614_1038977106
X-MC-Loop-Signature: 1660755094614:791189713
X-MC-Ingress-Time: 1660755094614
Received: from pdx1-sub0-mail-a274.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.113.181.85 (trex/6.7.1);
        Wed, 17 Aug 2022 16:51:34 +0000
Received: from offworld.. (unknown [104.36.25.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a274.dreamhost.com (Postfix) with ESMTPSA id 4M7DYx67Dnz2B;
        Wed, 17 Aug 2022 09:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1660755094;
        bh=gljdSyd+HSBJ7IXp4awLk86AL/cmb8X8tMplUibsLjM=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=FKmDeWwXmfIU3BjJ3iyDK3P3qCu4efTBu0uecApwjD69YX4PTXFZ50BTPUBDAot9L
         9q46JUIZ8u1x5PJy7AQBU2kQslCdc3O0rjrPbD3BQc24WCNJnRAt5sKQ5qWxw6zy2U
         Z44Uk9AmSLd+YZmeBoCPsh+45f2ph9j8HFHn96go8sZYiL24Q6BHsnFam6dQDgdLMq
         PPsNdNLRXfQRi1BQ8VjzR6hFQRDcpM+IFNmr6HBqCG3RAQfM8xVUdPpuzhsVXzTmuq
         YhPgjS3YJs+gYCB7lXnUWj1HOETkrF1eafYDNY7PdIbKev7Xef/gA3SsEfeiQWGpln
         dML7pYiIpq7Dw==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     chenhuacai@kernel.org
Cc:     kernel@xen0n.name, linux-kernel@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH] loongarch: use asm-generic/cacheflush.h
Date:   Wed, 17 Aug 2022 09:51:26 -0700
Message-Id: <20220817165126.990420-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... instead of redefining the nops.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 arch/loongarch/include/asm/cacheflush.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/loongarch/include/asm/cacheflush.h b/arch/loongarch/include/asm/cacheflush.h
index 670900141b7c..7e38243b79bf 100644
--- a/arch/loongarch/include/asm/cacheflush.h
+++ b/arch/loongarch/include/asm/cacheflush.h
@@ -14,21 +14,6 @@ extern void local_flush_icache_range(unsigned long start, unsigned long end);
 #define flush_icache_range	local_flush_icache_range
 #define flush_icache_user_range	local_flush_icache_range
 
-#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
-
-#define flush_cache_all()				do { } while (0)
-#define flush_cache_mm(mm)				do { } while (0)
-#define flush_cache_dup_mm(mm)				do { } while (0)
-#define flush_cache_range(vma, start, end)		do { } while (0)
-#define flush_cache_page(vma, vmaddr, pfn)		do { } while (0)
-#define flush_cache_vmap(start, end)			do { } while (0)
-#define flush_cache_vunmap(start, end)			do { } while (0)
-#define flush_icache_page(vma, page)			do { } while (0)
-#define flush_icache_user_page(vma, page, addr, len)	do { } while (0)
-#define flush_dcache_page(page)				do { } while (0)
-#define flush_dcache_mmap_lock(mapping)			do { } while (0)
-#define flush_dcache_mmap_unlock(mapping)		do { } while (0)
-
 #define cache_op(op, addr)						\
 	__asm__ __volatile__(						\
 	"	cacop	%0, %1					\n"	\
-- 
2.37.2

