Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6DA4670F0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 04:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378429AbhLCD4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 22:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378424AbhLCD4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 22:56:44 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A1BC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 19:53:20 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id m37-20020a4a9528000000b002b83955f771so690193ooi.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 19:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h+XQeWG+kiuxd01qltERiKBl9nbzu6qBH83LxBkxkHk=;
        b=SH7lH+iKcZKVJjD1yWjnnZtlJHBxbx2iQTjJs5I7ztG1yEbJSvXkDvDLGcZaDnnpmw
         /jDjiUky3dwu+eU7W7Pi/VnouqhI8x/CH9OPdYgHZhHVOJIV+GMZAb5qQjGWhwx5a29J
         aWF4imSdzjjzyyp+LMl3ciI0+DkUD08sv455Nn9A2V97GBBZgWYOD3VzekeOlLVfi9lx
         U5/ZIwDbfU4rowiVNp3cwq5JCMs1C7S8Q+IbEukxkOp7icBpjvFnfM4lfPio1NGL7AcO
         JbZJxd4Slnv+4rJPn6Syz4dsv9IZXc6rKoNsjAYgPmijAUKaIBVoUWtx3r+IY0f035gH
         GB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h+XQeWG+kiuxd01qltERiKBl9nbzu6qBH83LxBkxkHk=;
        b=y2pdKxXO+QXCzn0JPE9pSCoSqNexC4pMNQ6K2BXRewNcCEJO6xTWxRUboqVtyqKoSA
         2f1OZMJlIBthrfQ2ER7MVhw0sp8Ez7dyN2i9nGgmpLhespERQKobVAiL9Hymui5xPkhq
         4HEulgez+owWEcPalSFUNprBNqm22vfoJWs/DwIEpEUAhDL9Mc9MW3ucTb5JHy24Lv8n
         JFOKvWxpS4maITAjdidhBbB+cbbXEDAShVlLBNyhezsDck+XtYbkvhrAc7PbdKij2DYE
         Q9f7TTzgbk0xbWxZ0Yi+k3D/9FQ5ygVS4FIgqhiDUy7uWyQtSqOyX1prDM78WcR2wb4u
         8ogA==
X-Gm-Message-State: AOAM5331K4MkDdqhZ6lDVYVyYLN+QZtgFasnZClLRE6uCmxx7r9EQ3dm
        jdK3FJPP2Sm2o25dYKT8xpzxGogdSzrSTQ==
X-Google-Smtp-Source: ABdhPJwLV2ozK4tglP6qFcjCexCRKm8m6RTaobpaw2u2RMk65X1JO5tDXbWsS8cYLeUBrjte23ts2g==
X-Received: by 2002:a05:6830:3113:: with SMTP id b19mr14440120ots.9.1638503585272;
        Thu, 02 Dec 2021 19:53:05 -0800 (PST)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t14sm418006otr.23.2021.12.02.19.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 19:53:04 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        dmitry.baryshkov@linaro.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/2] clk: Introduce CLK_ASSUME_ENABLED_WHEN_UNUSED
Date:   Thu,  2 Dec 2021 19:54:35 -0800
Message-Id: <20211203035436.3505743-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some clock implementations doesn't provide means of implementing
is_enabled(), but still requires to be explicitly disabled when found
unused as part of clk_disable_unused().

One such set of clocks are Qualcomm's display RCGs. These can be enabled
and disabled automatically by the hardware, so it's not possible to
reliably query their configuration. Further more, these clocks need to
be disabled when unused, to allow them to be "parked" onto a safe
parent. Failure to disable the RCG results in the hardware locking up as
clk_disable_unused() traverses up the tree and turns off its source
clocks.

Add a new flag, CLK_ASSUME_ENABLED_BOOT, which clock drivers can use to
signal that these clocks should be disabled even if they don't implement
the is_enabled() ops.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/clk/clk.c            | 2 +-
 include/linux/clk-provider.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index f467d63bbf1e..e0bb53cbd4c8 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1265,7 +1265,7 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
 	 * sequence.  call .disable_unused if available, otherwise fall
 	 * back to .disable
 	 */
-	if (clk_core_is_enabled(core)) {
+	if (clk_core_is_enabled(core) || core->flags & CLK_ASSUME_ENABLED_WHEN_UNUSED) {
 		trace_clk_disable(core);
 		if (core->ops->disable_unused)
 			core->ops->disable_unused(core->hw);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index f59c875271a0..7661cce31fa1 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -32,6 +32,8 @@
 #define CLK_OPS_PARENT_ENABLE	BIT(12)
 /* duty cycle call may be forwarded to the parent clock */
 #define CLK_DUTY_CYCLE_PARENT	BIT(13)
+/* assume clock is enabled if found unused in late init */
+#define CLK_ASSUME_ENABLED_WHEN_UNUSED	BIT(14)
 
 struct clk;
 struct clk_hw;
-- 
2.33.1

