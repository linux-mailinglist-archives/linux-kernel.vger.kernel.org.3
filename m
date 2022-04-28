Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC12751394B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349744AbiD1QDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349434AbiD1QC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:02:59 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99046ADD73
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:59:44 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651161583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+aMYyx9JbjctX7IKCAz71I7UvEWhb1H0O2/pEdg011c=;
        b=Jrko63r6s51mjDxZWE6hvaqb98Yrb2UoUcte3KUc/vRV6Md+Z/9eBqzdF/KYUvA5PaZCLb
        0Td+pe5Ctd5RZKsYeFZtwSIfDiKv1HPtf+7irvWx1hK/ug3JaKyA1hDI3AEKdDirT4jGlQ
        8KOM/oj8IRb5BjH2u2re/seuCQR/KWY=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 1/2] mm: slab: fix comment for ARCH_KMALLOC_MINALIGN
Date:   Thu, 28 Apr 2022 17:59:39 +0200
Message-Id: <fe1ca7a25a054b61d1038686d07569416e287e7b.1651161548.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

The comment next to the ARCH_KMALLOC_MINALIGN definition says that
ARCH_KMALLOC_MINALIGN can be defined in arch headers. This is incorrect:
it's actually ARCH_DMA_MINALIGN that can be defined there.

Fix the comment.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/slab.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 373b3ef99f4e..8cc1d54e56ad 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -190,7 +190,7 @@ void kmem_dump_obj(void *object);
 /*
  * Some archs want to perform DMA into kmalloc caches and need a guaranteed
  * alignment larger than the alignment of a 64-bit integer.
- * Setting ARCH_KMALLOC_MINALIGN in arch headers allows that.
+ * Setting ARCH_DMA_MINALIGN in arch headers allows that.
  */
 #if defined(ARCH_DMA_MINALIGN) && ARCH_DMA_MINALIGN > 8
 #define ARCH_KMALLOC_MINALIGN ARCH_DMA_MINALIGN
-- 
2.25.1

