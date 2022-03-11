Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9DC4D633E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349052AbiCKOQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiCKOQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:16:33 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAE11C74C7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 06:15:30 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id gj15-20020a17090b108f00b001bef86c67c1so8262745pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 06:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XZJctosDLei9tHFcPaHwOIETymJfkLOU84IX8rfwoMA=;
        b=mlneQKeHJ/qSdm+TB7TDo/UG6ZhvlDTwVeHAuWr/hFTgu67cXJeHmVwQbJvWeP9VmV
         79UrIYA6aZCl1jvyMjTLoeztHo/3zJkp8vvtLoZ2UZzLj17yVb6549Zf/dj2eJ/67ZZr
         AEXyLwphI7tv0irobgWo1chw3ftIJrrayx24R3abyLF0EA7ryyorHfshGCGs3kfKNfD+
         TkIFN4iHUcE7uiSXTS/dlTG5asehAtA9t/Z8iNckuS8yzESRghBxZxHrIs/fnRkMDi/b
         TO3tBvagmQh+Rs/vsX9MDYm/Rx/KSVEMNV3bIBxKr9tYzJ9pJsVOPOoFP4JQnzSrxp9r
         +ilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XZJctosDLei9tHFcPaHwOIETymJfkLOU84IX8rfwoMA=;
        b=XToLheCI27N3m+VRsoT2em9zlgndCfVm2v9dfEdioAyCBB0dfk/+nZPvhgIm2Nil7V
         6/UQWnOog2b0eRjLyXX1ch9Wqh0eSmitk/F9YDYFgZ2096i1sP1b6RwCsTIY483cq2BC
         P55BUN1APXpFN/0UipLjiJm9Kh8F7wsGuUIGoKPsLoSm24vie5J/3jvbxol2OqS4adiZ
         U8bX5l0DpPyjQZfNxR4sBBNVVx5NAyNyAeoCzCXvcSg0izrvnwj9FJhGbeBM/BVuZnv9
         OHvtWGGNbMsdwzsptPMHy4yF+4A9Apaz3qiSB7SpfnJCUwdQx62cSFwL7CJDesSFEM7+
         xTEA==
X-Gm-Message-State: AOAM530TuR7ywK29WlMBtCBExcd4zhoun3oXvZtVTPsSwTjpejGDyOE1
        TDeMTV9mJ40JcgQLoE5DY6s=
X-Google-Smtp-Source: ABdhPJzNXz6mffH6Eejx1Ocj6S+aaeYG+sSnd2LWtIQTiBQPjNe628xzHMHFb44//EEEGkMb7KdY/A==
X-Received: by 2002:a17:902:bd95:b0:14f:40ab:270e with SMTP id q21-20020a170902bd9500b0014f40ab270emr10677648pls.101.1647008129627;
        Fri, 11 Mar 2022 06:15:29 -0800 (PST)
Received: from localhost.localdomain ([119.3.102.56])
        by smtp.gmail.com with ESMTPSA id o3-20020a639203000000b003810e49ff4fsm2224810pgd.1.2022.03.11.06.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 06:15:29 -0800 (PST)
From:   Bang Li <libang.linuxer@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Bang Li <libang.linuxer@gmail.com>
Subject: [PATCH] mm/swap: fix confusing comment in folio_mark_accessed
Date:   Fri, 11 Mar 2022 22:15:19 +0800
Message-Id: <20220311141519.59948-1-libang.linuxer@gmail.com>
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

For unevictable pages, we don't need mark them.

Signed-off-by: Bang Li <libang.linuxer@gmail.com>
---
 mm/swap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swap.c b/mm/swap.c
index 00804ea244e1..9d91ce23ea18 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -423,7 +423,7 @@ void folio_mark_accessed(struct folio *folio)
 		/*
 		 * Unevictable pages are on the "LRU_UNEVICTABLE" list. But,
 		 * this list is never rotated or maintained, so marking an
-		 * evictable page accessed has no effect.
+		 * unevictable page accessed has no effect.
 		 */
 	} else if (!folio_test_active(folio)) {
 		/*
-- 
2.25.1

