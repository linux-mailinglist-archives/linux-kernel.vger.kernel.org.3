Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85BB527792
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 14:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236810AbiEOMny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 08:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbiEOMnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 08:43:00 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07622E9DA
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 05:42:43 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id a191so11713032pge.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 05:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JuZm0iyeNXKvBw7CRNXXxjER+lmIsZfs9nGcE1KNIMA=;
        b=HnBtgyglcpAF47QDC7sGEQOlZ8dA2kdM7Qk0V0OskPV+UUv2/Fg0VNfgf/3BP67ae+
         EWEvu4jP9ZYPFJU1Jl+KsBypKmSHGBT2LbO3zFpUG3sUQMl8Pen4x3klqlH0lkpX7CIZ
         2QZhW569rFu2lUyA/d6tuBXR7dc3pNrTuLXxqpq+bh2xDns6v0/abZpuEnLnxw5ztYy2
         oOByW3u1YuNsxat9rJzzWc0WJwNW2mWI1UcpkqpR2sAZVCUjFYfXoTZLMY06brZlH7yO
         WpSultNnn/SOkiYM04ODjT6uK9n+oQJpB+TuedLmW3/ohjD8K4r8y0MZnQhm9l1WPvZW
         34MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JuZm0iyeNXKvBw7CRNXXxjER+lmIsZfs9nGcE1KNIMA=;
        b=6SG+WtyoeADEj15HFlJQZrG60+u9xi7PZ73vZClwa+5NLdb+Jm1tk+n5xJQqjg/CAI
         Zi9hB6TF644rZ4ikN63fqRowMHSPtNrOD86/k0GJBKBpkhQxYETb7gtlr2Z0AtC1+smR
         IdiN828P1+oWUQUKnbvPa0SGNOOLkHfOilWkcJwJFyAb1xgNjKO9YaRPjlU5/b9fZnhP
         XyAB0wCCz1/J5FrGmovMyclBjLdw4bjRAfEXEeGrmghC1GdcYCIPnWK3MhnAScttvjdF
         TgNUvggKEVvqLH8+r8POb6l6/Rk0rGF1FoD3M/Zwj32OpAGpra17vYZ1NEADi/xU2igV
         Aw9g==
X-Gm-Message-State: AOAM533ZLm8oFnpCBqDh6J5Q0qxI1D/1tam8Ho1+DJkAmeAnpWhtSpQG
        2I9dyyvnfFZWqAgBjq/MumOAQHndRmijIw==
X-Google-Smtp-Source: ABdhPJzqvncFRUIuRAfj62LKQruwUlpe0XsMKkrLRlM+M8DkM4ubr+ddMYmcks46kDiHJU3mIwGNFQ==
X-Received: by 2002:a63:491f:0:b0:3f2:6b20:fa10 with SMTP id w31-20020a63491f000000b003f26b20fa10mr1000385pga.531.1652618561911;
        Sun, 15 May 2022 05:42:41 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id k1-20020a637b41000000b003dafe6e72ffsm4844337pgn.88.2022.05.15.05.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 05:42:41 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 10/13] openrisc/time: Fix symbol scope warnings
Date:   Sun, 15 May 2022 21:41:55 +0900
Message-Id: <20220515124158.3167452-11-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220515124158.3167452-1-shorne@gmail.com>
References: <20220515124158.3167452-1-shorne@gmail.com>
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

