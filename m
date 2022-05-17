Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3850252965C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 02:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239487AbiEQA6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 20:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239837AbiEQA4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 20:56:00 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86CE201A6
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:55:59 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id q4so15980683plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JuZm0iyeNXKvBw7CRNXXxjER+lmIsZfs9nGcE1KNIMA=;
        b=H5MdmlFKJmCnyxJIjM/qpwTxPaW0iw9pGgyPhqb86vIvFdIh9MsqnbGRdbo3jl3DD1
         NZN0aiW77lj3kr3NKdkj4BPOdHAU/UPyX/6yZIrzwOxS54MnqkBsCqlB9WP06jWpjRKH
         m72bcJwu6Ybfqm+nkmSy/X7omkA497/BL3qqkBDNks8sOGs5dx4iXkYFEcNLrjByTLJo
         QLuP6rY2ypxJZSFaiaqB4i7xxnDSVXrNwXFBd++H697yAHCrtvVNnax0Mo0KofZm06co
         4k7PzeBN94R4jk21clzsMW07xHsrjYvmkSSiFrwl5uSuGe6TzUsJPulniHg1JJ9LPoQ3
         YyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JuZm0iyeNXKvBw7CRNXXxjER+lmIsZfs9nGcE1KNIMA=;
        b=7CFPH51ru3SdQdKFeyZBlTmzyLMy6TOhQsOGVqQ89LF16hUhLfSouJXOQDIx17Nj+9
         4CCSvqALDUkCQp9siSQmQfgzLkz3yQotAI8/oY6Imk4ZyeUg3W4+8/IayDEHqh7HLbiL
         QomuBUl77zXX/f/GVmWI8uVJcH4aOrh36RffJCJ3fZ/471Tl/hQCImk5JkTmr7GXrZN9
         m+KImIvoEaAcRJmf72ppDFNryrfuRlKy0CFg+/2UmThriGTDfJiACLCiyg0l88XHPBk3
         Bg/iJfQ0KQjq7hAUbShIG6G/A1tR4M35D7V4V+QOU6ePrAjGohbmYeh7AtbhafPiVGBM
         59cQ==
X-Gm-Message-State: AOAM531aOkxl6p1Vgh4cokb0ZnRWFIZaVo+H2LDPGayQ6oOm5nklpnHx
        5RyJs5tW5z23OsPA6Rs1zEeaZeQGoRoZlQ==
X-Google-Smtp-Source: ABdhPJyuJHialPFzmk9jCitdBmrkLR09Y4G9IMW9rKIhLzuMTvlJo4x/V3N31o577AIjRUWU+WBkgg==
X-Received: by 2002:a17:902:db07:b0:15e:b669:42a2 with SMTP id m7-20020a170902db0700b0015eb66942a2mr19595241plx.80.1652748958849;
        Mon, 16 May 2022 17:55:58 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id r2-20020a170903020200b0015e8d4eb29asm7582806plh.228.2022.05.16.17.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 17:55:58 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 10/13] openrisc/time: Fix symbol scope warnings
Date:   Tue, 17 May 2022 09:55:07 +0900
Message-Id: <20220517005510.3500105-11-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220517005510.3500105-1-shorne@gmail.com>
References: <20220517005510.3500105-1-shorne@gmail.com>
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

Spare reported the following warnings:
    arch/openrisc/kernel/time.c:64:1: warning: symbol 'clockevent_openrisc_timer' was not declared. Should it be static?
    arch/openrisc/kernel/time.c:66:6: warning: symbol 'openrisc_clockevent_init' was not declared. Should it be static?

This patch fixes by:

 - Add static declaration to clockevent_openrisc_timer as it's used only in
   this file.
 - Add include for asm/time.h for openrisc_clockevent_init declaration.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/time.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/openrisc/kernel/time.c b/arch/openrisc/kernel/time.c
index 6d18989d63d0..8e26c1af5441 100644
--- a/arch/openrisc/kernel/time.c
+++ b/arch/openrisc/kernel/time.c
@@ -23,6 +23,7 @@
 #include <linux/of_clk.h>
 
 #include <asm/cpuinfo.h>
+#include <asm/time.h>
 
 /* Test the timer ticks to count, used in sync routine */
 inline void openrisc_timer_set(unsigned long count)
@@ -61,7 +62,7 @@ static int openrisc_timer_set_next_event(unsigned long delta,
  * timers) we cannot enable the PERIODIC feature.  The tick timer can run using
  * one-shot events, so no problem.
  */
-DEFINE_PER_CPU(struct clock_event_device, clockevent_openrisc_timer);
+static DEFINE_PER_CPU(struct clock_event_device, clockevent_openrisc_timer);
 
 void openrisc_clockevent_init(void)
 {
-- 
2.31.1

