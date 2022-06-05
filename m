Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0793A53DC95
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 17:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351070AbiFEP0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 11:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345537AbiFEPZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 11:25:49 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EB337A3D
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 08:25:48 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b8so15758918edf.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 08:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AijNSNENsndq1lruXgHmAupjtkvf2lBpkHUQA6jew9s=;
        b=H0zgmtQMVi6D7id759wg8VhqByApWuQ2eAmgXrVLdr0Q1LBDhY7Kz4vpBWUEF4NhOf
         XiNPQ4GjBN04uYIBj9rn/FJOfwHB5hceglNc0WlSZbm1ugfm6i9LqALZfCEzOoYvi6yF
         92djWVCArm7K7WenfzY12vjC0Kkr0MxID7g4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AijNSNENsndq1lruXgHmAupjtkvf2lBpkHUQA6jew9s=;
        b=JB7uOLn3FSWZBeAR8eR678i+gFvStqAv4aHej/PkTKhx/a3/St1qxZVRQ2yybXmIqw
         bCFAnD+1v2dmx9F9xOF/fZV6/gSKGzymmzkE2au5LXHFHkp3GlJCyNE8AFpfegyswGl7
         Cq9diayO8cwZabj0638BtiJHkNh3N6l8oFF57yqJOoCJQRs8Lu1OUV7qIvN6NGWA+r+i
         PFNI+8LGFFHcBDGUblqdBjio2qQRPPmTksYz2hTlr8bXOlBmP1RRvjw1W2fRmjGvLiio
         kYJabWC2TqmPJ5E2TfBxsj0QXCGDUAiCi4q25jmpxU6OOx855XIb5QorzbOMIkq6U+hP
         X8cQ==
X-Gm-Message-State: AOAM5300C4hxBlrR3C/L2eRp+/KijzuOv7W6YL+OUEl8ODsku1bCkIsu
        68qJ87TE/8JJ8CeSGdDlzWdgWEkfkjA3lA==
X-Google-Smtp-Source: ABdhPJz8dAE/Co15RJ/4mJpqVwCjyClqDvdCuxcacvEE1TV8+moyX503AYyBnHuJfqgA1ohjLbwB0w==
X-Received: by 2002:a05:6402:3484:b0:42e:1f3b:4a4c with SMTP id v4-20020a056402348400b0042e1f3b4a4cmr17457804edc.326.1654442747113;
        Sun, 05 Jun 2022 08:25:47 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id l21-20020a056402125500b0042dddaa8af3sm7051499edw.37.2022.06.05.08.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 08:25:46 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [PATCH 3/3] mm/mempool: use might_alloc()
Date:   Sun,  5 Jun 2022 17:25:39 +0200
Message-Id: <20220605152539.3196045-3-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220605152539.3196045-1-daniel.vetter@ffwll.ch>
References: <20220605152539.3196045-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mempool are generally used for GFP_NOIO, so this wont benefit all that
much because might_alloc currently only checks GFP_NOFS. But it does
validate against mmu notifier pte zapping, some might catch some
drivers doing really silly things, plus it's a bit more meaningful in
what we're checking for here.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 mm/mempool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempool.c b/mm/mempool.c
index b933d0fc21b8..96488b13a1ef 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -379,7 +379,7 @@ void *mempool_alloc(mempool_t *pool, gfp_t gfp_mask)
 	gfp_t gfp_temp;
 
 	VM_WARN_ON_ONCE(gfp_mask & __GFP_ZERO);
-	might_sleep_if(gfp_mask & __GFP_DIRECT_RECLAIM);
+	might_alloc(gfp_mask);
 
 	gfp_mask |= __GFP_NOMEMALLOC;	/* don't allocate emergency reserves */
 	gfp_mask |= __GFP_NORETRY;	/* don't loop in __alloc_pages */
-- 
2.36.0

