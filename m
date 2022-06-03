Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A025953CBA3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 16:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242333AbiFCOg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 10:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbiFCOgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 10:36:54 -0400
Received: from pv50p00im-ztdg10021801.me.com (pv50p00im-ztdg10021801.me.com [17.58.6.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B53A283
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 07:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1654267011; bh=Ucku8Js4PlaZ5zvvbiyRmooKUGTiNzqZWqTg6PWHaUw=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=doncoDJ9Dt9FBjBh8fbkK/v4fsILBZQDp5iNFxevPTgjmoAifxkoSU/bfffzGJimR
         26tAQ4O3HN0A1TbauRcfHdPnjC6i+Xlm3Da4b3ZlloxQ7q4I1TRjxANvsJtkK1Z6Uw
         /fmMjb1uUvrQNSBi8nAYcYpC2MNdWJNBAV+R1BC6glMJ44LqyvUlHrM2V/XVw5FEvI
         +BOK3GZ4f9Ol6r/kA7KEt/G7y6K8GKul9yRbSTo7G6wvFyWghVq6XTKzbt/RBDNPWS
         TSro1XZIkSjp8C49rAmVisEiF1FTc4FuL91mc8nizIAaqN2GNncersJV5paOa6lzJz
         EU/NMCCv/1bkA==
Received: from xiongwei.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-ztdg10021801.me.com (Postfix) with ESMTPSA id 33B3A160308;
        Fri,  3 Jun 2022 14:36:25 +0000 (UTC)
From:   sxwjean@me.com
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        songmuchun@bytedance.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Xiongwei Song <xiongwei.song@windriver.com>
Subject: [PATCH v2] mm/slub: Simplify __kmem_cache_alias()
Date:   Fri,  3 Jun 2022 22:35:55 +0800
Message-Id: <20220603143555.41914-1-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-03_05:2022-06-02,2022-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=697 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2206030064
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <xiongwei.song@windriver.com>

There is no need to do anything if sysfs_slab_alias() return nonzero
value after getting a mergeable cache.

Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
v2: Collect Reviewed-by tag from Muchun.
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
2.30.2

