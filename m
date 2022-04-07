Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B3C4F859D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345970AbiDGRM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346001AbiDGRMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:12:31 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCA41E9637
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:10:29 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649351427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RKada/syRdNLHr4WO/ASA7jzsH+BuRSFKa7ozmTSlP8=;
        b=Z4SrfJi1IGw71HQV0HTQYn56ug6Z0kofWnjvTZo2iPvxqU64LoNhJVplJ5jFu+qEAbkYmk
        N3DtZ2QlQGuJZ2Suddbcc68RzATXbn5Kvs9psFJWBnnTmlr0P5HMnFK7ffrD0YvmCS7AqZ
        6RgTwrxuq3IFOaz3KM8s/pAoHSHFs6M=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] kasan: mark KASAN_VMALLOC flags as kasan_vmalloc_flags_t
Date:   Thu,  7 Apr 2022 19:08:37 +0200
Message-Id: <52d8fccdd3a48d4bdfd0ff522553bac2a13f1579.1649351254.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Fix sparse warning:

mm/kasan/shadow.c:496:15: warning: restricted kasan_vmalloc_flags_t degrades to integer

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index ceebcb9de7bf..b092277bf48d 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -23,10 +23,10 @@ struct task_struct;
 
 typedef unsigned int __bitwise kasan_vmalloc_flags_t;
 
-#define KASAN_VMALLOC_NONE		0x00u
-#define KASAN_VMALLOC_INIT		0x01u
-#define KASAN_VMALLOC_VM_ALLOC		0x02u
-#define KASAN_VMALLOC_PROT_NORMAL	0x04u
+#define KASAN_VMALLOC_NONE		((__force kasan_vmalloc_flags_t)0x00u)
+#define KASAN_VMALLOC_INIT		((__force kasan_vmalloc_flags_t)0x01u)
+#define KASAN_VMALLOC_VM_ALLOC		((__force kasan_vmalloc_flags_t)0x02u)
+#define KASAN_VMALLOC_PROT_NORMAL	((__force kasan_vmalloc_flags_t)0x04u)
 
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 
-- 
2.25.1

