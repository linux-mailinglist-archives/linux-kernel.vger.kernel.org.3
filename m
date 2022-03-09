Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463CF4D2DA3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbiCILIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbiCILIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:08:22 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4055616F940
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 03:07:24 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id z3so1630760plg.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 03:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GKebUur/S+XRejLBhOyjy8XggC3dL/V1yGt1wm2dInU=;
        b=Qro99lBc7nlHUz1t/2SoAKOWBZUDy7llKexrls150vhS9ztw/EGj3v1Ty/GVOObgXx
         uX4fKKb6WTOsfvVw6tqE0f8uTx/cyIi97wunNiiZBQGRoREJR8reG278BVlLrtOz+tW0
         MxMsQf7xiOYlpyj9PuhuH1CEuv19U8D/Z1Lqpuy7tVc0C+wlqGR5wD+FZnAKMvfSvpDl
         TJ5OHOR3miwa4vJQKnNf7eZro2Nar/fHmwhoBRFbRIOUstNCh1f0u4iIB7F9iXMCiQKm
         ZAPoYxkQotY0rlMhbH+pAeqfcU7ijOXkqkOfuvoJdcJc2AWluXMAuE5Giu0KRYOrbR9A
         h22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GKebUur/S+XRejLBhOyjy8XggC3dL/V1yGt1wm2dInU=;
        b=d6HAtwY2fsWiXZzL1gfYTWV0jCDMEODuKbZbK6vqlkXxhuqrGZ0C2IOoW9EpDzrM+9
         vKNhxv6z2FTTY635Y+EwsM/1MZ219I6AI5mpmIB+Xw+5oeQYQC3TwLzOSMPJvGE3NDLz
         J7xSxQ8r0WO7XJtrkSwNaYRjGA7KecNNnWW/dwXu1Eqf46/RQFc8/cIFtpAAkOX4Xza7
         jc9xYXZUzR9ML8vqH2duKkJWhU+3JJd+ePvFSzH0R2x9cvIYdLdFUwU8lKfWFpIvvFYm
         FUhCCHzTlnVdXCZyVmxUCNCUoVhZ1RmmEViz3f0gacNnryD9/yXAxudti/8xLn/Z+3Gf
         mbNA==
X-Gm-Message-State: AOAM531Hz0R9WoEAxS1cX5kBwJR+fSgbGTJDLf54Sh6Brr8bIcTXocVa
        ppghvdnPqA6w0P4nzKle1GhNcrw1kFQCU+5s
X-Google-Smtp-Source: ABdhPJz9ZXrpmQbPKnEB7U/O9hUNwBgO8ACxtCv3tvpu+540PFnMHpFQxXdudNZWAs5ibUwy9iWImw==
X-Received: by 2002:a17:902:b087:b0:151:842a:d212 with SMTP id p7-20020a170902b08700b00151842ad212mr22171488plr.92.1646824043769;
        Wed, 09 Mar 2022 03:07:23 -0800 (PST)
Received: from n144-252-048.byted.org. ([111.225.144.244])
        by smtp.gmail.com with ESMTPSA id mw7-20020a17090b4d0700b001b8baf6b6f5sm2440632pjb.50.2022.03.09.03.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 03:07:23 -0800 (PST)
From:   huteng.ht@bytedance.com
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org, huteng.ht@bytedance.com
Subject: [PATCH] kernel/locking: Return proper value in __down_common()
Date:   Wed,  9 Mar 2022 19:07:05 +0800
Message-Id: <20220309110705.1616783-1-huteng.ht@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Teng Hu <huteng.ht@bytedance.com>

Return -ETIME when a process waiting on a semaphore woken up
due to timedout, while return -EINTR when woken up by a signal.

Signed-off-by: Teng Hu <huteng.ht@bytedance.com>
---
 kernel/locking/semaphore.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
index 9ee381e4d2a4..97ad6a747d2f 100644
--- a/kernel/locking/semaphore.c
+++ b/kernel/locking/semaphore.c
@@ -225,6 +225,8 @@ static inline int __sched __down_common(struct semaphore *sem, long state,
 		raw_spin_lock_irq(&sem->lock);
 		if (waiter.up)
 			return 0;
+		if (timeout)
+			goto interrupted;
 	}
 
  timed_out:
-- 
2.20.1

