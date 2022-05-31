Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B16538965
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 03:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242913AbiEaBCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 21:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238350AbiEaBCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 21:02:52 -0400
X-Greylist: delayed 405 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 May 2022 18:02:51 PDT
Received: from pv50p00im-tydg10021701.me.com (pv50p00im-tydg10021701.me.com [17.58.6.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E089347B
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 18:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1653958566; bh=wgvlbiHXPS4b0FVNndNCUtFwoK4klCA5shEF51SF30M=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=XL3lu02CUzmSCCbYKmJ8aoNxXziM1fazmIgSygrky9eVur94TUkxOtF+RP/o862ac
         +2us3/rGVsGqaOBxnhiLnIsHychJ0IaU0V158GSvWEbYvGmz0SBIGZtTLcePfz3DW0
         +dmu5hjpBg02BzepgK27/JaAyZG+XqPtItBvUtnS209pYccGS2Q4PG7CrchZSi6igI
         4RW69mlHIQ+HtO8r3dht9GZHfV9G1ZFNqg3nhmxFQGlHuWLNzjle7Yt+ZmquHRwbc4
         Db714Qs2Mw5eAcj/pz7lVnwy0ifabMtzIm50hmgYGteWg5CIfJkS2PCPNiewow99jh
         h7RchOnzrcrlw==
Received: from xiongwei.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id 864D33A0B00;
        Tue, 31 May 2022 00:56:01 +0000 (UTC)
From:   sxwjean@me.com
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Xiongwei Song <xiongwei.song@windriver.com>
Subject: [PATCH] mm/slub: Simplify __kmem_cache_alias()
Date:   Tue, 31 May 2022 08:55:50 +0800
Message-Id: <20220531005550.10613-1-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-05-30_10:2022-05-30,2022-05-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=668 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2205310003
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

