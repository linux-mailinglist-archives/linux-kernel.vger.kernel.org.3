Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776364C814A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 03:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiCACxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 21:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiCACxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 21:53:13 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA7C48E67
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 18:52:34 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id z11so3951702pla.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 18:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=IN1VYmp44x+rwI/ogRY6xwm4hMfgB6hDpJsyZy4ABUc=;
        b=oveJUp9NBB0QCEzYV1EUcq27GIoMI7Iaxme9xLjbqi/1YNZLPYZG//JmNw37Eqi4Sx
         4+vO4pkKKZELajiL0xDksZhRPSdVp8JSKrrZitUTZ9syXBuvJQ+Jdj0q1pCLlVc8nlIQ
         0qbvcjoR1n1Xg4Y4JNqkWeAhvP62m6P68OuwvKwY/hO43hSRR03yIPueHVEP/jbR8CRG
         ypPW0ymK53Ep7XdcIa9z9IqN6irhW5ovflyTZ7FDQ2fwpkihOvMxUPIkLEAxrXpwVu/K
         6HgGmX4sEqIj4y2pSkg48vog9s4k2EYYKop+qA2HU2VkgUfBjAhGaJJHL60eMYR9S06M
         unGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IN1VYmp44x+rwI/ogRY6xwm4hMfgB6hDpJsyZy4ABUc=;
        b=mv59oMGuc/ruXQIzutyJZ0FNm3hdJqvBKojdg0XSVjeH93uB4s4TmbCLGJOlXooU7E
         lZvpl1rgj0UKahZQmAV1jJP6jBi/v1Kd6tUbCg7nHfd4Q7zUnrMo2QPU3z3hSx/gZlcA
         AcSbex8kNzPKkKMP0QnrZbKhB1XZzXB7gMdFgcIB/YQpt3hGwg9py4AjXoHiAPrdTEnz
         Lc42b499MqGtejF71a4B+oA5N7RJACGFKvrdJ13wBk8smJImzSf01JTEc6B1NZBo5RRe
         XT7zIVBF+2TCV++dTDyOGztyeCWDRU6MmDkmAW9FT6Th/93Ttes/8hAn6xZWOvc4aE9/
         odSg==
X-Gm-Message-State: AOAM530Qce3IpGA/0WVg2O9bi5Mqz3HjN7hiXTpS0iwyZAMLasIN1T8k
        TQXC3rW6Qhq+wAahkOEwMqTmA1+Zxl4XN/q/qJ4=
X-Google-Smtp-Source: ABdhPJzTmf8K3iQdP5ygZW0I6HLdCMqpmjofcOzuSt0kmKT1TsKFBexwJFF1CqNa/s0L9S3tUj+nTw==
X-Received: by 2002:a17:90a:f0cb:b0:1bd:2372:c992 with SMTP id fa11-20020a17090af0cb00b001bd2372c992mr12875610pjb.71.1646103153570;
        Mon, 28 Feb 2022 18:52:33 -0800 (PST)
Received: from meizu.meizu.com ([137.59.103.163])
        by smtp.gmail.com with ESMTPSA id i128-20020a626d86000000b004f3f2929d7asm8778950pfc.217.2022.02.28.18.52.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Feb 2022 18:52:33 -0800 (PST)
From:   Haowen Bai <baihaowen88@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org
Cc:     longman@redhat.com, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, Haowen Bai <baihaowen88@gmail.com>
Subject: [PATCH] locking/rtmutex: Return true/false (not 1/0) from bool functions
Date:   Tue,  1 Mar 2022 10:52:28 +0800
Message-Id: <1646103148-21514-1-git-send-email-baihaowen88@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return boolean values ("true" or "false") instead of 1 or 0 from bool
functions.  This fixes the following warnings from coccicheck:

kernel/locking/rtmutex.c:375:9-10: WARNING: return of 0/1 in function '__waiter_less' with return type bool

Signed-off-by: Haowen Bai <baihaowen88@gmail.com>
---
 kernel/locking/rtmutex.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 8555c4e..29db06a 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -372,24 +372,24 @@ static __always_inline bool __waiter_less(struct rb_node *a, const struct rb_nod
 	struct rt_mutex_waiter *bw = __node_2_waiter(b);
 
 	if (rt_mutex_waiter_less(aw, bw))
-		return 1;
+		return true;
 
 	if (!build_ww_mutex())
-		return 0;
+		return false;
 
 	if (rt_mutex_waiter_less(bw, aw))
-		return 0;
+		return false;
 
 	/* NOTE: relies on waiter->ww_ctx being set before insertion */
 	if (aw->ww_ctx) {
 		if (!bw->ww_ctx)
-			return 1;
+			return true;
 
 		return (signed long)(aw->ww_ctx->stamp -
 				     bw->ww_ctx->stamp) < 0;
 	}
 
-	return 0;
+	return false;
 }
 
 static __always_inline void
-- 
2.7.4

