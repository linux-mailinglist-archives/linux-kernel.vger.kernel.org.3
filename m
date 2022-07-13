Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9182F573A9F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbiGMPy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236837AbiGMPyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:54:22 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4C62A717
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:54:21 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id j22so20636960ejs.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ijboKzjTSzsd+bJY8ZcuFW/Xbsztbht17nmFPJI6drg=;
        b=BAIUjy11tSgwstQ6yLGA9n142er4g913SnNJP7srr8eNQuI5Syjw4vBaYQ3DPcV0S9
         ZMFoSB9cQeO+Q8HUEUWWxOMpDv2x4HKLnc1U2DhzE+S7AGsI86d3PJRfM6fU2Imm2O3h
         azTlWaUG47LcDLgRILUq0aSU1jcIjCwpwJGTJ3f43luwnKc1ndMHdDhhjp/O5zr0+Z3+
         9QVKufP4jfnR9gsXnaE79hesIub45kOKPoofUhpfoKCesv1T9NFAMqgu0dGxD43wyohR
         vJRBth3JGyq8TWcpIEkKeMjLxRmO4aaTMA+2pm7DP1YbphJSLYuzHdIBPfC9lR/4wozk
         AI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ijboKzjTSzsd+bJY8ZcuFW/Xbsztbht17nmFPJI6drg=;
        b=ZwO0IbYA0+bP28sdJxiHM0t99JlkeEdvnUkvm0EfAZlnSvgHBCfm4TKDD/Q+XfF6ev
         1FjtSULLZvVFH87Y/SD12zUqvH5k0N15Xq+M0oePIFOwWTwm8WBqajjkzbFLBrZLnrP+
         L+dX4YnNwFspK+WYfIGCDQrZZgMcBdiDxriAac+MhLewBXt0FoDwobIi+yD9uEuCawqN
         NdEk0VTUk2dDBHKCzKPgyAI108h+XMqAVoVduvKLawEv3bAfgv4i5rzM6G8xaQYY2K2L
         pgG43wxPcxwOulxMOCCBNvue9ItXNNYsN9gFR7aeiN/q5iFI6qOjLlbofsNtMx5u0VAw
         IV6A==
X-Gm-Message-State: AJIora/Of8xhOcgg2ZjGQqmMqnr8Sy/K+6oeBvjAUXCYdjprK5p8zDoS
        m1CUOahuO0ZMkVqZAzv8crW7Z+AS+P0=
X-Google-Smtp-Source: AGRyM1v+EgyXmm+WIrwhqUTLys0FStOlDDH9tqmrDCD2QlygO0YDrLJOW0xQwcLtW4iugGwmqF1VrA==
X-Received: by 2002:a17:906:8459:b0:72b:60c8:107d with SMTP id e25-20020a170906845900b0072b60c8107dmr4300159ejy.142.1657727660065;
        Wed, 13 Jul 2022 08:54:20 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id n2-20020a17090695c200b0072b21cab5a5sm5073688ejy.133.2022.07.13.08.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 08:54:19 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 2/2] ucount: Use atomic_long_try_cmpxchg in atomic_long_inc_below
Date:   Wed, 13 Jul 2022 17:54:05 +0200
Message-Id: <20220713155405.80663-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220713155405.80663-1-ubizjak@gmail.com>
References: <20220713155405.80663-1-ubizjak@gmail.com>
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

Use atomic_long_try_cmpxchg instead of
atomic_long_cmpxchg (*ptr, old, new) == old in atomic_long_inc_below.
x86 CMPXCHG instruction returns success in ZF flag, so this change saves
a compare after cmpxchg (and related move instruction in front of cmpxchg).

Also, atomic_long_try_cmpxchg implicitly assigns old *ptr value to "old"
when cmpxchg fails, enabling further code simplifications.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/ucount.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index 974ac1585009..5d980460104e 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -218,16 +218,14 @@ void put_ucounts(struct ucounts *ucounts)
 
 static inline bool atomic_long_inc_below(atomic_long_t *v, long u)
 {
-	long c, old;
-	c = atomic_long_read(v);
-	for (;;) {
+	long c = atomic_long_read(v);
+
+	do {
 		if (unlikely(c >= u))
 			return false;
-		old = atomic_long_cmpxchg(v, c, c+1);
-		if (likely(old == c))
-			return true;
-		c = old;
-	}
+	} while (!atomic_long_try_cmpxchg(v, &c, c+1));
+
+	return true;
 }
 
 struct ucounts *inc_ucount(struct user_namespace *ns, kuid_t uid,
-- 
2.35.3

