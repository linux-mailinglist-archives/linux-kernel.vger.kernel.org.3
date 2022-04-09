Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333E24FA914
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 16:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242345AbiDIOpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 10:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbiDIOpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 10:45:03 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8573BDE8F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 07:42:55 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id h23-20020a17090a051700b001c9c1dd3acbso12314510pjh.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 07:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vl38/Gn1Ja/tfx1OE95rZjNeXGNT1OOD4zzjhjOONik=;
        b=K1WsvwuoCpAIHJWhA/t7k/ll20oJIFxUcaj9+xFS8rndq8lbEQnGLMXJKZM92HJ5AG
         iYR9vg9r170/BRZdFbYm/E9/61C8iwLGhVZYfL7acFA+08b7E3iHtHQFDIYuwunVOt9H
         D5St9/4uIf3Fjdura6SkBzwY3HJ9jNvDI70sKSbT7ICPZdJoL2SIBSGDMbqzhlDMato+
         gE0osfNBgJ7tDoSm7Yt3hETKG4VlH4CRVtImaL+hqCBFxESMw2oGY6U4bI/cJbWAjlPK
         blbZE2zVGlRNrllye2MBu16e8vHPCTOxXxY4+/c4VcMeif9zdMBEm8cBhWYG8rEEfiz6
         AJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vl38/Gn1Ja/tfx1OE95rZjNeXGNT1OOD4zzjhjOONik=;
        b=WDqJalPKAJ3izf+nOYmPD7zt/wBRATPAlw1SxrQqOPhNLnZGIro4k+5wK9FZfa1svX
         DP1LOddS7aZeH3hAHLX8haBOHDYyjFyxdC5tybBzFoX6IZLZvEiwuc5WVYLedodLmJK9
         stoc9yXrspcqQBZtSyiLZR8t2jYsT1L3XX7DYtihk7AYxGklecnpdYus9c8hH2qfgl0n
         8IB+z4lLUirZn3Gk1sE8UKSfB/sVkZvpBm28GPznQ7Jpg3bTc6tTGQDi4DQZv004ZCvd
         fDscs9suibJXH3TXV7xtRO+aZingtom6+YqVPj7GZ1EIBsHabAwA3mcPAFA9eRz6SbUp
         wSdA==
X-Gm-Message-State: AOAM531Wo3ELU3+5FjHqeY95Dkl1yRNSV29ZOUSMdUSdcp9Qbh2pf3aM
        iAdAvYKBeJbAtj5Cf47lAA==
X-Google-Smtp-Source: ABdhPJzxdWFiiA50vM0YwFC3qcQrpLR0x4AQV9NPemYyBGaoQaD8ChdalwfSOXfyP27GkjMl8dt8Uw==
X-Received: by 2002:a17:90b:1bc8:b0:1c7:443:3ffb with SMTP id oa8-20020a17090b1bc800b001c704433ffbmr26976623pjb.84.1649515374917;
        Sat, 09 Apr 2022 07:42:54 -0700 (PDT)
Received: from localhost.localdomain ([121.165.123.189])
        by smtp.gmail.com with ESMTPSA id q5-20020a17090a68c500b001cb651fffdbsm2218373pjj.8.2022.04.09.07.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 07:42:54 -0700 (PDT)
From:   JaeSang Yoo <js.yoo.5b@gmail.com>
X-Google-Original-From: JaeSang Yoo <jsyoo5b@gmail.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Ohhoon Kwon <ohkwon1043@gmail.com>,
        Wonhyuk Yang <vvghjk1234@gmail.com>,
        Jiyoup Kim <lakroforce@gmail.com>,
        Donghyeok Kim <dthex5d@gmail.com>,
        JaeSang Yoo <jsyoo5b@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/slub: remove meaningless node check in ___slab_alloc()
Date:   Sat,  9 Apr 2022 23:42:39 +0900
Message-Id: <20220409144239.2649257-1-jsyoo5b@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

node_match() with node=NUMA_NO_NODE always returns 1.
Duplicate check by goto statement is meaningless. Remove it.

Signed-off-by: JaeSang Yoo <jsyoo5b@gmail.com>
---
 mm/slub.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 9fe000fd19ca..a65e282b8238 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2913,7 +2913,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		 */
 		if (!node_isset(node, slab_nodes)) {
 			node = NUMA_NO_NODE;
-			goto redo;
 		} else {
 			stat(s, ALLOC_NODE_MISMATCH);
 			goto deactivate_slab;
-- 
2.25.1

