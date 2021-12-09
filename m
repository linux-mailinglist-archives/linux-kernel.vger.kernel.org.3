Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2900546F505
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 21:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbhLIUjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhLIUjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:39:01 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9D1C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 12:35:27 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t9so11759733wrx.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 12:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FwcKS2UKLAvrcYdIiK6cdE3C3+gkf0RAZDU5sfPJejQ=;
        b=D3ys7W8YHQ8ff73vPJeuZIkwQHOATBjZjS1jgt20S6un0v0RaJsBnhWs1hO/9UQv0O
         UUAhH5QMMLcsM8a57z66QAL6nr/3gWcHOKsi/L30BOU96aWM/VR5o4BrjGRfA6hrN5yD
         SYiyvYTmvhtvPuzQaCZb5SdP+Hc+5gLOJKmMps7hIDw7tcjhIxsHrGY9lISD8F6Y1uGI
         lRxzDddbZLMfTmPxQ9Wwfctbdj4KYUMZ9rRSTD4ob9+/svat6HLwtNNtT8M8gmFPeYzq
         5x4mAmf6APvWBV9CYXBgv/SDDweMuZQLTumP1Xkpg4vWMXfclETJUZ7gnuxCWTa9vnm4
         eD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FwcKS2UKLAvrcYdIiK6cdE3C3+gkf0RAZDU5sfPJejQ=;
        b=DFS8rHM2hcpKvxqkL83Wrb3xgIlkNYwiDFnOgn/bInP4rgBQTa0a/ZYEkf5hk3ehoo
         u4Lt9Anl0MzxCz48/JYVrSaE0P3+FLfC+az3cf8scPbb5+sW8Y9We6d0kuPBlcRLrWv+
         N56jvfu8gwPZ1YryytAMlVU0a12BeTtknbxcAWzL7JGM9cJXKRDcqd3Iz5T7VQsZzhe3
         5Zvzm4bKRKij/w/GotznBWYGn8J9KQrxqU7HY1UEGnzkzk9IhN+buH12zQMQx4+TIcws
         BZvKOtIPn93lqGA4uAkgRmeztD7cAaJUhydlShGFseMggI72O1PNRtZIzuqNNHyQrpov
         FFrg==
X-Gm-Message-State: AOAM532298bUwEK6sOnmnS7UO0ZqpTaUwPu0yh1vcyY9UUSHvHiMIy9/
        LD2luu7jAwQjH1H3P8Ntyv8Hh6QLNfw3Gw==
X-Google-Smtp-Source: ABdhPJzwdRdl5coG2LAl5Ilrn9X/+X+ZSGHghqb/s3JcwDwqstfm7yigA3NadoQUcDugKHlowvf5Lw==
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr8744354wro.484.1639082125664;
        Thu, 09 Dec 2021 12:35:25 -0800 (PST)
Received: from giga1.localdomain ([195.245.21.30])
        by smtp.gmail.com with ESMTPSA id e12sm990684wrq.20.2021.12.09.12.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 12:35:25 -0800 (PST)
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Alexander Sverdlin <alexander.sverdlin@gmx.de>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] ep93xx: clock: Fix "plain integer as NULL pointer" warning
Date:   Thu,  9 Dec 2021 21:34:29 +0100
Message-Id: <20211209203429.140751-1-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@gmx.de>

Fix sparse warning (use "NULL" where appropriate).

Link: https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/WU46Y7J42IOXN3BCLEEA2U5SHD2E2M2M/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmx.de>
---
 arch/arm/mach-ep93xx/clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index cc75087134d3..3dfeef00ac5b 100644
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -207,7 +207,7 @@ static int ep93xx_mux_determine_rate(struct clk_hw *hw,
 				struct clk_rate_request *req)
 {
 	unsigned long rate = req->rate;
-	struct clk *best_parent = 0;
+	struct clk *best_parent = NULL;
 	unsigned long __parent_rate;
 	unsigned long best_rate = 0, actual_rate, mclk_rate;
 	unsigned long best_parent_rate;
-- 
2.32.0

