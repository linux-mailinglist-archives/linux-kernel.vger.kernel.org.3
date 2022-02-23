Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF584C18B2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242858AbiBWQft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241768AbiBWQfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:35:46 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D386B53B4B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:35:18 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id ev16-20020a17090aead000b001bc3835fea8so3334115pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PvSxjAkCTzHrnUJ0VH9JVo6LzgFiDVwgoKiwOiM2FoE=;
        b=lIs9bWeQZCbVcF0ZizI997m5HtjcGLwofO/q2rO50UhL2K3rqPXTmaaK8+hPGnStlK
         q0uM9I0AHFvbcVjS9NV0PVxbJ2oX2Dy9tIg/WyZAfQWBlPrACWk9PxTR5y2yk4VmL8IB
         cqLE3fvXs01qOtV9upS+bV7gb2+cx4ePjwXpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PvSxjAkCTzHrnUJ0VH9JVo6LzgFiDVwgoKiwOiM2FoE=;
        b=BVXvkCrcZxFqERyPs9+i0iQJl7MtDwgqXt9x7dMKGZxkXBI4XLMrddX0G4ZLGD1nki
         E0Y2PoJqjG7ao6TJ+WE3tVhpFC91s4YX8vkMBPyQt8QEIYki6KS/NpI/sbZG3UfogKcz
         V7jUVKqZ8DOQMogNa2AHiYOAkciSZMFlZVSXaxaLkwXuHRbDQxn+DRw9AyrXEkNtwhPp
         ausXvOPgVaoxCYY3ZEBoFE7GeNodOauRoDlCBfTPyxeZcup/R3Xs3ejFlyFjxYL0VPC5
         3KM+I4Z9XXH0shVHNRdLR9RYcmMDrgtHDbsSvlgPRL3u8rsW9lvKldVXx9LtJsqiTHrA
         sJbA==
X-Gm-Message-State: AOAM533uDGw6VeBpTUERluXCxG8k15J5JAAB81ts6TP20Yd2dgIp0hZi
        tcNin9ed/3KHqIcoTnTW/4jBVA==
X-Google-Smtp-Source: ABdhPJw5Jtbh9mv51qXwl2WJLO7oZUgpK7z+r3Jzsv2rFjApW+UyaQUhwslZQu6FcU65TL6jQei4TQ==
X-Received: by 2002:a17:902:a406:b0:14d:61ba:8bcc with SMTP id p6-20020a170902a40600b0014d61ba8bccmr575575plq.36.1645634118294;
        Wed, 23 Feb 2022 08:35:18 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:fbbe:971a:f60f:11e1])
        by smtp.gmail.com with ESMTPSA id g20sm4219pfj.64.2022.02.23.08.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 08:35:18 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH] PM: runtime: Have devm_pm_runtime_enable() handle pm_runtime_dont_use_autosuspend()
Date:   Wed, 23 Feb 2022 08:34:48 -0800
Message-Id: <20220223083441.1.I925ce9fa12992a58caed6b297e0171d214866fe7@changeid>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PM Runtime docs say:
  Drivers in ->remove() callback should undo the runtime PM changes done
  in ->probe(). Usually this means calling pm_runtime_disable(),
  pm_runtime_dont_use_autosuspend() etc.

From grepping code, it's clear that many people aren't aware of the
need to call pm_runtime_dont_use_autosuspend().

When brainstorming solutions, one idea that came up was to leverage
the new-ish devm_pm_runtime_enable() function. The idea here is that:
* When the devm action is called we know that the driver is being
  removed. It's the perfect time to undo the use_autosuspend.
* The code of pm_runtime_dont_use_autosuspend() already handles the
  case of being called when autosuspend wasn't enabled.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/base/power/runtime.c | 5 +++++
 include/linux/pm_runtime.h   | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 2f3cce17219b..d4059e6ffeae 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1476,11 +1476,16 @@ EXPORT_SYMBOL_GPL(pm_runtime_enable);
 
 static void pm_runtime_disable_action(void *data)
 {
+	pm_runtime_dont_use_autosuspend(data);
 	pm_runtime_disable(data);
 }
 
 /**
  * devm_pm_runtime_enable - devres-enabled version of pm_runtime_enable.
+ *
+ * NOTE: this will also handle calling pm_runtime_dont_use_autosuspend() for
+ * you at driver exit time if needed.
+ *
  * @dev: Device to handle.
  */
 int devm_pm_runtime_enable(struct device *dev)
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 9f09601c465a..2bff6a10095d 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -567,6 +567,10 @@ static inline void pm_runtime_disable(struct device *dev)
  * Allow the runtime PM autosuspend mechanism to be used for @dev whenever
  * requested (or "autosuspend" will be handled as direct runtime-suspend for
  * it).
+ *
+ * NOTE: It's important to undo this with pm_runtime_dont_use_autosuspend()
+ * at driver exit time unless your driver initially enabled pm_runtime
+ * with devm_pm_runtime_enable() (which handles it for you).
  */
 static inline void pm_runtime_use_autosuspend(struct device *dev)
 {
-- 
2.35.1.473.g83b2b277ed-goog

