Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AA453F9EA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239749AbiFGJgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239683AbiFGJfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:35:08 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F6166C88
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:35:04 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id u26so26655425lfd.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 02:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KoD0FJtvAYiro/wAlRb5zLOAm2ljSVphawX93yu7smo=;
        b=lTqaQnN6yqJuFg22PrQ1ychCB7duFlShGXgJcYA3YXTZ23/6rCXn89SZzsVCCuXNwk
         fAyAPiksl8n+YyODYbm60Hd4oRw3NqyoehccHyocO3M5pUWDoZJ+uOfLV7auvKjwedeG
         pgJO752qd9Vvj9NdJGo0Iv9fCCIZg1NEkfTBLDMCry64TNpUFu0GvHHRUEcQpj4q2hIu
         772fHfD/oM1dD0AFUusJoVNawrxrMrKudVN4B2argH2tKTHdVFCUco6bLGjusSs5xmfq
         ZuVO0jNoebGgeiyb26jyQCnjn8c9ciStTmHRcqYLEfe/i01YDdaInFg+xEK4FUA09ZPU
         Ad7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KoD0FJtvAYiro/wAlRb5zLOAm2ljSVphawX93yu7smo=;
        b=Lm8p4Q310onLTnE0hs+Gj3rKlNMeSZKV4JzN2i1xI3UJX9kMVCwrXQ5r3IGB55i21l
         LjpQXPUPu/qg/gfQMJ9QXBNWGw3STO314ZeMB+yOCj6sCemvj9wyiGrW3Tsvpt2MWlkD
         JtpYIPcF4PhnoeSAuCuD0nVUBGemwQZ7yKbA7yS41jG6Hz7f/VJAtjoPG1dfhlfQPwNt
         nggUzwnp3bxcHf7aV75JkbLJcv1XqAYVH7IGLwK1RpxlwTFDyD/QYIWiddHmR7xAqGc8
         WwLmxFE3icqRfrt7toHXWFhfQzlMPjelW8lQGcnVGTdotY25uejw+NGHyBpdKbEaYQ6w
         EB2Q==
X-Gm-Message-State: AOAM532OKPMaKOz/daYA3VgtMc0OAhtrs6kxCTyLbTQd77ehyauL+pX7
        KbpqnAMx7ZzsrJ/Nq73Qql4=
X-Google-Smtp-Source: ABdhPJz+nEYe43ymsAQpZtJHQ1/MvaMOMA/s21VY0MJGYYJhjcHNnEvXn54O9Datx6yzWQULld4+1g==
X-Received: by 2002:a05:6512:3502:b0:476:c68d:8b0d with SMTP id h2-20020a056512350200b00476c68d8b0dmr18657838lfs.113.1654594502769;
        Tue, 07 Jun 2022 02:35:02 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id r27-20020a2e575b000000b002554a4ebf5fsm2748043ljd.74.2022.06.07.02.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 02:35:02 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 3/5] mm/vmalloc: Initialize VA's list node after unlink
Date:   Tue,  7 Jun 2022 11:34:47 +0200
Message-Id: <20220607093449.3100-4-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220607093449.3100-1-urezki@gmail.com>
References: <20220607093449.3100-1-urezki@gmail.com>
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

A vmap_area can travel between different places. For example
attached/detached to/from different rb-trees. In order to
prevent fancy bugs, initialize a VA's list node after it is
removed from the list, so it pairs with VA's rb_node which
is also initialized.

There is no functional change as a result of this patch.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 745e89eb6ca1..82771e555273 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -978,7 +978,7 @@ __unlink_va(struct vmap_area *va, struct rb_root *root, bool augment)
 	else
 		rb_erase(&va->rb_node, root);
 
-	list_del(&va->list);
+	list_del_init(&va->list);
 	RB_CLEAR_NODE(&va->rb_node);
 }
 
-- 
2.30.2

