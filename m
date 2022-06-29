Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331C655F2E4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 03:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiF2BlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 21:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiF2BlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 21:41:15 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EB325C7C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 18:41:13 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s206so4857101pgs.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 18:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VPrtKXtq4qyhWu5o6BvIQVhQZeTNkHbfrZBU4KflF1U=;
        b=hkx13qBdyfwvDRjLf7bPh5cXqfEkjL+9Mp5yt9EbaSpbCItGkXK69DXTcE+WxPlHth
         3E3xXl3Oaq3WF+FEox6KG/dTIL/YmVKSSw6qiZ2x/wBq5dbdv75rO6VYh+7oZKd7I8Pv
         lYX2roR43c+eBF8Wk5PvX3JJwwtB+ElKB7J/BVWLWXtZYc8N2124Poc20XLw08ebY+/q
         qrQ4wz5FD0HFQLfUGDzk/94yWX17bpcXeWWf4QF3qofkdLB1xmOM/BQwnsAHPB1ww41k
         TvcxsR42R6wJCii5UkUTuk4dCQU5NvCnzcpUfsq4lnqZ5uoaBpHkPZVrPbQc+1Uqyeew
         5wMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VPrtKXtq4qyhWu5o6BvIQVhQZeTNkHbfrZBU4KflF1U=;
        b=ku0qtPSmt/91td1HSh8BzZ7NTtmOUGhLHwAl9cgBnA+5bpxNyTKMDxc4HGlGxSybiY
         vSXv7ZlB8kENYCjEgBwFW0p/HxL+HCdFYdVsp9ZAh4ih2cbtEsNzPlzvwJW3EGT75322
         uqISifjRodF36Snx0mzttMK0cCSYVrSrxAs7OAaiiMbKZdjL/UpOrBNqIWRMpklnjCHo
         GFeBHIWu9LQOp6yEtvRf0m6PoK/PSnP6/3E3GX7ca/W5AvFkBMGpulpdEkBf0QDo71pg
         fnnsOMUOtCnrdxzopWDMv4ttnGC8hM76RpNOSzOTw/oTLTbuYJ4DBsWm5leI0UQe6REj
         iiKA==
X-Gm-Message-State: AJIora+DsiH1DWxwIckQbVur5cN50ywa86sEkY36yaj/FiMc4J2Yrr6H
        5qfifWOxkspbwvVvwWAIW4I=
X-Google-Smtp-Source: AGRyM1uG6BxKE8W+97XkRAiCdqoSnQSGJ5ap2Q3rJirhPCQLRDuMDEjwijqDdlb2irmBj2SOir0Aig==
X-Received: by 2002:a05:6a00:1a48:b0:522:9716:4e0a with SMTP id h8-20020a056a001a4800b0052297164e0amr6478757pfv.22.1656466872983;
        Tue, 28 Jun 2022 18:41:12 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:46a:3e21:914b:bb3e:3e56:4806])
        by smtp.gmail.com with ESMTPSA id u15-20020aa7838f000000b0052592a8ef62sm7182965pfm.110.2022.06.28.18.41.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jun 2022 18:41:12 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, matthias.bgg@gmail.com, chiaen_wu@richtek.com,
        alice_chen@richtek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        ChiYuan Huang <cy_huang@richtek.com>
Subject: [PATCH 2/2] regulator: mt6370: Use the correct header for platform_device_id
Date:   Wed, 29 Jun 2022 09:41:01 +0800
Message-Id: <1656466861-7737-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1656466861-7737-1-git-send-email-u0084500@gmail.com>
References: <1656466861-7737-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

'platform_device_id' struct is defined in 'mod_devicetable.h'.
Even 'of.h' also includes this header usage. The 'of.h' cannot be removed
due to 'of_match_ptr' function.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/regulator/mt6370-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/mt6370-regulator.c b/drivers/regulator/mt6370-regulator.c
index 949b2c7..e73f5a4 100644
--- a/drivers/regulator/mt6370-regulator.c
+++ b/drivers/regulator/mt6370-regulator.c
@@ -4,6 +4,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
-- 
2.7.4

