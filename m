Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE0C52FCB0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 15:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353316AbiEUNPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 09:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354859AbiEUNO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 09:14:27 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27575644DF
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:14:12 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id z11so357589pjc.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JuZm0iyeNXKvBw7CRNXXxjER+lmIsZfs9nGcE1KNIMA=;
        b=Sc6A9rrs2CNpuzMYl9NDxDJMyzMrUdwkEL59QOtbB4CGMTiqKNH5Eg7kFRFTYWvOCi
         KvMrO/BhJz/8I7CnQdHfCLQgstx5qL4qj7Y7M19/MggfMwPalkmrzQC42OPUc1pRxZDA
         RkbI9VeBT3mvPmUnph6SIduSb9zMORPBz4/duPZy+nTp70iBYDIcLVZt2thsIE8+AlOW
         7EGtjoXIcFgOjCQTVo3gXAxD65fsE2+00LDr/l2QZ1Rw2YLz1G4OpUhP00RoFstbDbhp
         qBRYtHKJnMZprRtRK9CEX8TxxQabMo4eFO2kDaT6+YaE++952T73XbPODjIMZW7beYu/
         jlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JuZm0iyeNXKvBw7CRNXXxjER+lmIsZfs9nGcE1KNIMA=;
        b=UY/X9UAT+LlRxkgBub6/+zOzmXiXgYFsQlLy58RkSBJN+3uQP1Qa6arWyescOzSTds
         Gyhf3PcZENko3xQAUYk3XiLXV4pOab53MqbItI3vJqfkiFs07HStN4IiFVY2IbRTgv40
         iunYc4YTi+5ld2LYKQuj4V6yJdnPGIm7gGNbt+8UpjHSjxncYlnddVUEwG9KeDP4fF2M
         xuRYtLJPn9KaSlAcSmvdWLYdCdKmx/TWh2AcVD+CLeC7W7nsvoomv0XbpZK9MlBFy1xH
         OHMpGDQivlTBSkLouWtrzWJuYLilOYgrUaaIWwdpenIJ9ny8z3Gks+OgReE7otweJGxK
         D2Ow==
X-Gm-Message-State: AOAM530lDfJ/tgnjdUPWAb7n/x8Vc17QTa1PYHv34a3xoPLFZPc66g0S
        9BC+eLg8S3V04R/rzNahgV9UGH6p1JjaDg==
X-Google-Smtp-Source: ABdhPJzskd466pWvMA9IpEpSRlwXzHnjwv1BqbS+UhQIKkByXjc1R/mTGqRMDsXeqdEZ64pVE3orRA==
X-Received: by 2002:a17:90b:180b:b0:1df:b2ac:fafc with SMTP id lw11-20020a17090b180b00b001dfb2acfafcmr17065256pjb.101.1653138851293;
        Sat, 21 May 2022 06:14:11 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090301c400b0015e8d4eb2d6sm1187912plh.288.2022.05.21.06.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 06:14:10 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3 10/13] openrisc/time: Fix symbol scope warnings
Date:   Sat, 21 May 2022 22:13:20 +0900
Message-Id: <20220521131323.631209-11-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220521131323.631209-1-shorne@gmail.com>
References: <20220521131323.631209-1-shorne@gmail.com>
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

