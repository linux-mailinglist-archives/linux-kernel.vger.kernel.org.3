Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0F0494F2E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240084AbiATNk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239461AbiATNk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:40:56 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2535C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 05:40:55 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso22068147wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 05:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RdQgp0z7jAUFjQOMn5ng6ONbiIyYZr0uioKFtudkYTE=;
        b=CXcvQdOP2rvNkOEtKNH6VOk1Hb/LXxy6JbE2SWTpZ3aD2q2j7cFd+7eIFMLkmipQOh
         5pIUDEpIw9gAoAXu1aQ/yRMuMJicfWD1PXfKIgiOaY5Nen7p7SdOlMtz4eCjWWn8mvi0
         GqwyVD2igMMtJEH68jVQcskMnZHuurvWzeEX0ErXRivmaeaGE07OAVISbhO2HsBnZt9u
         c7mzl+6S5U6R1ICKVSK0JDOucoHmU3U5LAk6HcxC/8AY7W9JVwSHTXWKfgL9t+klbOXV
         Z5vd/H/esO0PMnlbhGP+WPa9TBsdEkjuI6icUSk21pec3CwVAB39rax1d4iAe1F4fYtq
         +waw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RdQgp0z7jAUFjQOMn5ng6ONbiIyYZr0uioKFtudkYTE=;
        b=2SeToRqoa9+eOsHZnHP7jFWsDNFU5SyRXkuNpMgxYaltXGrhbO1WRZAB9oZ3yqJPME
         5Hjk5x57l+wGDrOL48ONUQRE9XaRiVM0E5STrGM23FsIR7D28ZVjzOleYpJswwTl0Y3d
         bkPu8lUYlgK617BZqJCmOEaMn3NvXO2iCielAGXh4Fphhy1Io0G9nDr3vYlBlUHnhotj
         2WM3IMIE5qgH03V5baLvM8edkITiScXix2mAIoXtRALYudXPHzuSv1INUR2ltvAbQmiA
         /PxosEJgEPq9EX2tqptMq9pKnzMTTfXTHf4tXYT3eiipf+jTSU66K0iPTV+Vx43xg/gb
         /+Xg==
X-Gm-Message-State: AOAM5335jJXRhFmdIkK0cG+ODLIU8A8bBYY6LsegzK2UnVSfPHZHdXYx
        Jnbjsc7SflJbUFdPQt/EhOY=
X-Google-Smtp-Source: ABdhPJyytsaDSqFfQ0C/HgqRe1W+9nmU1r7oXnvJcfC0c4d6ExyeZPjAlBres4pfxFO6/2HXNxZhCQ==
X-Received: by 2002:adf:e84f:: with SMTP id d15mr33479132wrn.15.1642686054209;
        Thu, 20 Jan 2022 05:40:54 -0800 (PST)
Received: from localhost.localdomain ([195.245.21.30])
        by smtp.gmail.com with ESMTPSA id f10sm3094344wri.50.2022.01.20.05.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 05:40:53 -0800 (PST)
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Russell King <linux@armlinux.org.uk>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] ep93xx: clock: Don't use plain integer as NULL pointer
Date:   Thu, 20 Jan 2022 14:37:39 +0100
Message-Id: <20220120133739.4170298-2-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220120133739.4170298-1-alexander.sverdlin@gmail.com>
References: <20220120133739.4170298-1-alexander.sverdlin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:
arch/arm/mach-ep93xx/clock.c:210:35: sparse: sparse: Using plain integer as NULL pointer

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/TLFJ6D7WGMDJSQ6XK7UZE4XR2PLRZJSV/
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 arch/arm/mach-ep93xx/clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index 4aee14f18123..71c54da0c1e1 100644
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -209,7 +209,7 @@ static int ep93xx_mux_determine_rate(struct clk_hw *hw,
 				struct clk_rate_request *req)
 {
 	unsigned long rate = req->rate;
-	struct clk *best_parent = 0;
+	struct clk *best_parent = NULL;
 	unsigned long __parent_rate;
 	unsigned long best_rate = 0, actual_rate, mclk_rate;
 	unsigned long best_parent_rate;
-- 
2.34.1

