Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B3959C52A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237292AbiHVRkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237048AbiHVRkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:40:07 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9BC40E39
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:40:06 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id s11so14858700edd.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=1TtMemYiIvk93tn5UUsKoJV+JTgMPZ1xOAogcg0oHaQ=;
        b=lUnQA4irDvwEdvW3fHYFBOukijc3L7NlrziQcZBDY+p3hG/YmJmwb4INlZlxIiTT4B
         gY6a2o5xMrIcoS5uBFRRmkK7kjhLt1V5IU7/hHkIW/Ln+mc7/tiHCMUspIkYBsP8CclM
         HV24/4aiE2AZhIgke8PQbn+BVQ7zVEf4i0zffHIGxzO6n8OcMTj1HDR/yVFbZFZNKoKo
         SdhUZmhNXv1q9JkStYNggWAKLRGZpMHDIRcSgtK8JwC6d2V8gUK5gLvBASgF6EW/2gs6
         NaG16c0kCTjk8AWL4tHJRk4gOrK/5Evz40CCjLf1WC6tj3lGTZOYKTPVXyMUXLF0S019
         tsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=1TtMemYiIvk93tn5UUsKoJV+JTgMPZ1xOAogcg0oHaQ=;
        b=esaPsWbGrO/kUBC856Yjjub/gx3O1WuFJz8c8r9Sud0dTwltrz/EaLr7Jx2j6BHT0x
         4Q/WQ+azbTUoiX6aeAG0gr3pyi9+hxpgkZnDGocw1RTJDF1fOkVV1evKzaBg6fIpl5Lj
         xCVkaDMEpkqV1iumDhHM61/u9QvxmaXn517/9dYEEdQ9rcEOn5W8EJ6/IDbKlqB5d9ZJ
         xX4wS/Pexan4Sxw7LZxLrfvFCUo0tSxJijQ8tXNhQVMLnkC3P6ZwmM9m8H1QBLcLhKdr
         H8EqKOfGqFjMUz4lwhTYLXXRRBinelYYBdg8RqRQnK+oOXFXJxZm9o9z9bU6O4HTv8gY
         OePg==
X-Gm-Message-State: ACgBeo28Ko2glK4hQ5fRCd0EZypFUnNSaDK2P8M5DIy9fEPRhwSqjcWq
        fhAVshdhvmfI8MsxODzJJ1hK4Pl4iNq+XA==
X-Google-Smtp-Source: AA6agR7QWYAsWwT1bh3H0XVoCzQKIP9Ppv/w6DhnvXuDEHkoJxIU2zovfk+WKPYQVP0sh9Ar7Og2ow==
X-Received: by 2002:a05:6402:3552:b0:446:b318:d7e0 with SMTP id f18-20020a056402355200b00446b318d7e0mr228483edd.61.1661190004528;
        Mon, 22 Aug 2022 10:40:04 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id w5-20020aa7cb45000000b00445b822005dsm72319edt.6.2022.08.22.10.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 10:40:04 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: Use try_cmpxchg in task_numa_work
Date:   Mon, 22 Aug 2022 19:39:56 +0200
Message-Id: <20220822173956.82525-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.37.1
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

Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old
in task_numa_work. x86 CMPXCHG instruction returns success in ZF flag,
so this change saves a compare after cmpxchg (and related move
instruction in front of cmpxchg).

No functional change intended.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 914096c5b1ae..efe73ee89989 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2802,7 +2802,7 @@ static void task_numa_work(struct callback_head *work)
 	}
 
 	next_scan = now + msecs_to_jiffies(p->numa_scan_period);
-	if (cmpxchg(&mm->numa_next_scan, migrate, next_scan) != migrate)
+	if (!try_cmpxchg(&mm->numa_next_scan, &migrate, next_scan))
 		return;
 
 	/*
-- 
2.37.1

