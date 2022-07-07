Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F44569F18
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbiGGKDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbiGGKDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:03:45 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4E031373
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 03:03:44 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id ay25so663586wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 03:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ObHspT7PR13k/kGtFBiKTXV8HqbeVaIVVpnAi8PJftA=;
        b=GWZdkkrngxKv3835VFOOsLNeXYo8jmqMtWNAQnzvrZCrwFx5yifVdE+11NrZqzhcaD
         sipKBjoB2en+6upT6pL826qJX1xhCBSOoGusgSjlNcEvhNnMCrouEqECTyXEsDLmi5/s
         Z2nPfc6qNoUecPf2APngELGEFsIMd/gU1XdsjnFgmgZuFLQw1BaqogvfbhNaUBs79IlG
         sixx1kepX4WCDuccLT15Gr2rzyliVLLy3o/aELBHVXpNYdMkGwboTxUBoh/LRHpRlDjP
         7yuo4QfeBWahN3ptBWyMZONEbjxkbq/44bNxeTnZA7FDzDthzINWV258dKIbgoy6swgo
         Vx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ObHspT7PR13k/kGtFBiKTXV8HqbeVaIVVpnAi8PJftA=;
        b=Npj0i5N1CNuSk9LwKyi792qcIdeTQflwIRQXHUuFLZWGcdYSNieOIqtMFU0WXzM/M6
         0DCMP0tm+/aoTmr4Q3fDl2+PJ61eE+qIXFGJYloZu3YzgiqTpn360iWBPNVHBUGeHBhM
         4Fhb+BEWA4GfyhsXJrtp5on1Rpesc4HOQ8cni3DzojaSl/yenHzusn+Ov4gBjI0Id4Px
         NPYazQtCGc+qsQSC/WjUT21gGUTDIshAzRvnNruyFXtr/QfyF+rdQM1BwqyXCxPSNIcB
         fmVAPBTh35FWj63+nLvYKY3A1q8fWhE+nWVa3bWS7aZ2k3HdoHgRzunlubphHGhD8/1K
         bGow==
X-Gm-Message-State: AJIora/vpi3C90apaRAxUALFXIc7Qq1YO8tL5bY7U+9Ojf2hi7PTZuro
        l9isGN0quCNrgSrOxv+mRaKl2w==
X-Google-Smtp-Source: AGRyM1uGAAsPYsQWd2DaNk7kz2NhOZm9UNH91D25W0wEU2lB8IRcrOL+RJDUgzo05SB2rwlxtgrmgw==
X-Received: by 2002:a05:600c:4e51:b0:3a0:4e8d:1e44 with SMTP id e17-20020a05600c4e5100b003a04e8d1e44mr3581402wmq.105.1657188222631;
        Thu, 07 Jul 2022 03:03:42 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d548e000000b0021d7ad6b9fdsm4612034wrv.57.2022.07.07.03.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 03:03:42 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
Subject: [RFC PATCH 3/4] clk: Add consumers count information to debugfs
Date:   Thu,  7 Jul 2022 13:03:08 +0300
Message-Id: <20220707100309.1357663-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220707100309.1357663-1-abel.vesa@linaro.org>
References: <20220707100309.1357663-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lets add consumers count information to debugfs. It could be useful for
identifying which clocks do not have a consumer but are enabled at boot
and should be disabled since they are unused. Also you could tell which
clocks are marked as critical since they do not have consumers, but
their enable_count is non-zero.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/clk.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 9b54afd2fee8..e412e83a6e28 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2955,9 +2955,9 @@ static void clk_summary_show_one(struct seq_file *s, struct clk_core *c,
 {
 	int phase;
 
-	seq_printf(s, "%*s%-*s %7d %8d %8d %11lu %10lu ",
+	seq_printf(s, "%*s%-*s %7d %7d %8d %8d %11lu %10lu ",
 		   level * 3 + 1, "",
-		   30 - level * 3, c->name,
+		   30 - level * 3, c->name, c->consumers_count,
 		   c->enable_count, c->prepare_count, c->protect_count,
 		   clk_core_get_rate_recalc(c),
 		   clk_core_get_accuracy_recalc(c));
@@ -2996,9 +2996,9 @@ static int clk_summary_show(struct seq_file *s, void *data)
 	struct clk_core *c;
 	struct hlist_head **lists = (struct hlist_head **)s->private;
 
-	seq_puts(s, "                                 enable  prepare  protect                                duty  hardware\n");
-	seq_puts(s, "   clock                          count    count    count        rate   accuracy phase  cycle    enable\n");
-	seq_puts(s, "-------------------------------------------------------------------------------------------------------\n");
+	seq_puts(s, "                                 counsumers  enable  prepare  protect                                duty  hardware\n");
+	seq_puts(s, "   clock                              count   count    count    count        rate   accuracy phase  cycle    enable\n");
+	seq_puts(s, "-------------------------------------------------------------------------------------------------------------------\n");
 
 	clk_prepare_lock();
 
@@ -3021,6 +3021,7 @@ static void clk_dump_one(struct seq_file *s, struct clk_core *c, int level)
 
 	/* This should be JSON format, i.e. elements separated with a comma */
 	seq_printf(s, "\"%s\": { ", c->name);
+	seq_printf(s, "\"consumers_count\": %d,", c->consumers_count);
 	seq_printf(s, "\"enable_count\": %d,", c->enable_count);
 	seq_printf(s, "\"prepare_count\": %d,", c->prepare_count);
 	seq_printf(s, "\"protect_count\": %d,", c->protect_count);
@@ -3330,6 +3331,7 @@ static void clk_debug_create_one(struct clk_core *core, struct dentry *pdentry)
 	debugfs_create_u32("clk_phase", 0444, root, &core->phase);
 	debugfs_create_file("clk_flags", 0444, root, core, &clk_flags_fops);
 	debugfs_create_u32("clk_prepare_count", 0444, root, &core->prepare_count);
+	debugfs_create_u32("clk_consumers_count", 0444, root, &core->consumers_count);
 	debugfs_create_u32("clk_enable_count", 0444, root, &core->enable_count);
 	debugfs_create_u32("clk_protect_count", 0444, root, &core->protect_count);
 	debugfs_create_u32("clk_notifier_count", 0444, root, &core->notifier_count);
-- 
2.34.3

