Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA5D4EFFB2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 10:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239213AbiDBIgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 04:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiDBIgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 04:36:37 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072B8158558;
        Sat,  2 Apr 2022 01:34:46 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id bp39so3984003qtb.6;
        Sat, 02 Apr 2022 01:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tfha1nXEQp5tnH0OT7lYvNtXkp0/rCs/1BLKkrtZnbc=;
        b=Okfx0/e4xNIm4mKw8WX9qJApxey2071CaaKEMbniVf5ghLGtCCW+JTr3NaZVhnghOe
         96iwVtE/kpNO0QyNa62PqceYRwvr4amAsOqmAFMzO92vcC5PI4eTjGV9xi+ILjZxwU6K
         iQETuQmcDrGV1EQNq+uBZNHHAMqCXTkSLieoJpqzZtq6Eu5ecUzppmdiHl6W/u184Mxp
         Cgx4Tq83A39LIC9xcfl3uFRthf4hCIxRXnMt/ZWh9R4unIYPzRh2pVkzfbX0jpgkXS49
         RSUV+808bVOA8RJOlrE9cIDF4WG2eyrMuZURXdoIfuYIS1C8RwL+vsUzn/DkmWG5FtqU
         x66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tfha1nXEQp5tnH0OT7lYvNtXkp0/rCs/1BLKkrtZnbc=;
        b=fMMbu/P1xwjBlkBWs74uqVXAO0lbHh6hesk3Nkx5yIVHN6MoQdII91aWv7uw+RJ4bY
         dRZ5PCGChMGoJQHVPbglPbgATWivArjX0dlwwZdRxXksoAk+2+HivVM5F7hs657jR4U0
         WLwoGZzii9PRza3e1NATL51FvP3ryYXvNcf1YUNs0vv+creRvv20oT5Zxyler7mnBTEk
         BsIEIGYwAGypxHLM0uVGpdfguHoeYufvunVsBzSNJKIiizn4E7aZ9glRLsJoD583OokJ
         WhNNDJC5JsDShDNtk9Uk0yoUs264QP6OzcQZti61UmPBwfZ3HEgPkZ8o0M5cvrwcoiuQ
         /6bA==
X-Gm-Message-State: AOAM532sPyWb+h1vffWfJmSdBRZ8UwCk8y39voBEqgGDJf0l/ytvro9W
        m0vvuNCNybhu+uJHGeVKcho=
X-Google-Smtp-Source: ABdhPJwfq+enwXW1WKkocNgin+7CGJQUN/e2R5dCD7uiQb4eIWzcOf+5brTtSbj2SynoMohIY6RE3Q==
X-Received: by 2002:a05:622a:1315:b0:2e2:2952:11b8 with SMTP id v21-20020a05622a131500b002e2295211b8mr11269954qtk.244.1648888485207;
        Sat, 02 Apr 2022 01:34:45 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id de8-20020a05620a370800b0067ec34c9f27sm2569212qkb.129.2022.04.02.01.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 01:34:44 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     rth@twiddle.net
Cc:     ink@jurassic.park.msu.ru, mattst88@gmail.com, lv.ruyi@zte.com.cn,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] alpha: add null pointer check
Date:   Sat,  2 Apr 2022 08:34:36 +0000
Message-Id: <20220402083436.2413189-1-lv.ruyi@zte.com.cn>
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

kmalloc is a memory allocation function which can return NULL when some
internal memory errors happen. Add null pointer check to avoid
dereferencing null pointer.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 arch/alpha/kernel/module.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/alpha/kernel/module.c b/arch/alpha/kernel/module.c
index 5b60c248de9e..5442b75a98c2 100644
--- a/arch/alpha/kernel/module.c
+++ b/arch/alpha/kernel/module.c
@@ -47,6 +47,8 @@ process_reloc_for_got(Elf64_Rela *rela,
 		}
 
 	g = kmalloc (sizeof (*g), GFP_KERNEL);
+	if (!g)
+		return;
 	g->next = chains[r_sym].next;
 	g->r_addend = r_addend;
 	g->got_offset = *poffset;
-- 
2.25.1


