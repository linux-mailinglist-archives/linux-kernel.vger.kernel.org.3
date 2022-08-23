Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A471259D2A6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241348AbiHWHwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241260AbiHWHws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:52:48 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A5665544
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:52:46 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 202so11576390pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=MgN+KREEFxa4xm6tdK3/YoM4YbnrbMSDZ+9EuL3RHVM=;
        b=dEqbckJOMJZcX6/v3PLFyyPYN2v2QaTFyFRXKUoMvhiNvJRYqWL/OUvflzM+bwV7ZW
         aU8/3/w2QO70sc2k+D89CQScTDJ8TcqH0xrxT6bGN/zI6TloQZsOWPwIgPA2MsXWg4q2
         ELZOXOlB+5fE8kBSgbF1+c6ocYcf18YzVj0pjG/y2Xbyw5nUHfET9TQysbdYFnrqbDBB
         dlX05q1p9zkwTQlcw9PLEhTV3qlhDowyM7ZdlKHLzSOVDADUpzmyQjOQ3+FkcMdYL//x
         bh/mdZfSIISUTADk6wwlImvTZVQF/zU+5Wow5c0zklytq/mUKHRtauza2wPk/ps2mBmm
         rixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=MgN+KREEFxa4xm6tdK3/YoM4YbnrbMSDZ+9EuL3RHVM=;
        b=cYK6A14OaMLBUQ8rXRLHlVAEFy4iV6bvpfm0MzgmRl/uWLxY69KPlY2SX+rr1WAgaS
         xky37wJW7TZcbj3smO3LqXK7U24LWQNrbUnkBsqPimhWhUJFlGnLQrKVXFa97AKMdaZB
         yZaIkGJHTCMHzXBVsJOpqtrUtdlpJkdD+Od59mtIwA2fKPCmMGVgOa1S2pbReuzrIpbY
         kxe3A1/lEmD+rmeIf18olzrcKHlUDy/VgbCEGEwJANhMxOyitXojlYiBeyWBO/aN8Jq2
         PxbjeyK6nTGqitOuXdIoK1rvJ5GwlcEyROuZ/54lHnXLJARQW+7MXUIwRsADyA2vLQEI
         rqzQ==
X-Gm-Message-State: ACgBeo1wig80d71q/sA1eXGMUjcyRTTrloOrk/dR2bPqHsJCZoFOkP7K
        WH+4hxmVvlXjq+tF6qn6RS4=
X-Google-Smtp-Source: AA6agR6tK9o+kL139TUNt9pXwhRG3QQMgJm5L6Ql0waoJDaieYwaBti0inwQ3JasWVBnO6YijcZErQ==
X-Received: by 2002:a05:6a00:2185:b0:520:7276:6570 with SMTP id h5-20020a056a00218500b0052072766570mr24305446pfi.84.1661241166130;
        Tue, 23 Aug 2022 00:52:46 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id bn20-20020a056a02031400b00419ab8f8d2csm8604216pgb.20.2022.08.23.00.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 00:52:45 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     42.hyeyoo@gmail.com
Cc:     cl@linux.com, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] mm/slab_common: Remove the unneeded result variable
Date:   Tue, 23 Aug 2022 07:52:41 +0000
Message-Id: <20220823075241.209009-1-ye.xingchen@zte.com.cn>
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value from __kmem_cache_shrink() directly instead of storing it
 in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 mm/slab_common.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 17996649cfe3..0dfa3cfb6be5 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -495,13 +495,9 @@ EXPORT_SYMBOL(kmem_cache_destroy);
  */
 int kmem_cache_shrink(struct kmem_cache *cachep)
 {
-	int ret;
-
-
 	kasan_cache_shrink(cachep);
-	ret = __kmem_cache_shrink(cachep);
 
-	return ret;
+	return __kmem_cache_shrink(cachep);
 }
 EXPORT_SYMBOL(kmem_cache_shrink);
 
-- 
2.25.1
