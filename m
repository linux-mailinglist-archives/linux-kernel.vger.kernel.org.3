Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5543653894C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 02:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240697AbiEaAlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 20:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbiEaAl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 20:41:29 -0400
X-Greylist: delayed 161 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 May 2022 17:41:22 PDT
Received: from mail1.wrs.com (unknown-3-146.windriver.com [147.11.3.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469BA8E18D
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 17:41:22 -0700 (PDT)
Received: from mail.windriver.com (mail.wrs.com [147.11.1.11])
        by mail1.wrs.com (8.15.2/8.15.2) with ESMTPS id 24V0brtZ024435
        (version=TLSv1.1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Mon, 30 May 2022 17:37:53 -0700
Received: from pek-lpd-ccm5.wrs.com (pek-lpd-ccm5.wrs.com [128.224.153.195])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 24V0blxO017066
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 30 May 2022 17:37:49 -0700 (PDT)
From:   Xiongwei Song <xiongwei.song@windriver.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/slub: Simplify __kmem_cache_alias()
Date:   Tue, 31 May 2022 08:37:47 +0800
Message-Id: <20220531003747.4044102-1-xiongwei.song@windriver.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to do anything if sysfs_slab_alias() return nonzero
value after getting a mergeable cache.

Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
---
 mm/slub.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index d8d5abf49f5f..9444277d669a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4861,6 +4861,9 @@ __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
 
 	s = find_mergeable(size, align, flags, name, ctor);
 	if (s) {
+		if (sysfs_slab_alias(s, name))
+			return NULL;
+
 		s->refcount++;
 
 		/*
@@ -4869,11 +4872,6 @@ __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
 		 */
 		s->object_size = max(s->object_size, size);
 		s->inuse = max(s->inuse, ALIGN(size, sizeof(void *)));
-
-		if (sysfs_slab_alias(s, name)) {
-			s->refcount--;
-			s = NULL;
-		}
 	}
 
 	return s;
-- 
2.27.0

