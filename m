Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C48A481642
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 20:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhL2TZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 14:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhL2TZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 14:25:16 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15563C061574;
        Wed, 29 Dec 2021 11:25:16 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l4so14248372wmq.3;
        Wed, 29 Dec 2021 11:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=XWy6zb7VrjyL61C3FIcwxfgOsxnDVpBJZr50LV8zoyg=;
        b=QdY3E+T6Nzxt8AzFFX7vO6vHUytofG/1cq6XPJi6ZvdL/utBcmvgfhMEdZC2rItpKw
         IN477Yjkd9SjAsCbmXtfjHCmWYwXHm+QNFWikdr/82q1Q3wutxL0k8gtgacLmfFbFF4D
         V+ucUKfaCZiDXsAvJL4cg9bme6RRiKN8AzvprAWEuGO5K1lciBEe0WZoxGHoUZZ0pWfi
         1JPqwkMkfsNjl18sem3tgWyVVLG9NhZAaz8xueMUT4lKr3ALMlCTMakept5zGpZmGWoa
         WuM1JTXAegrU2yiXOfm6t8rKNPVR+pSKcuSPtMPcPxW4ElBmDxvsgE2RSECbHUCIsxwM
         izwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XWy6zb7VrjyL61C3FIcwxfgOsxnDVpBJZr50LV8zoyg=;
        b=BkPu193E6azRsKQB3sMaZghXf6mOJ3rKY6p/mepB2Vk7di+KlHgp/MgrYxREmKGt4A
         GPcxO0HSI+ZoFJ0Gdt9aK7FpY8rnlz+viB3rmdRyG6LbJFcw8C+JaZ1LeHY0SKYV//1A
         hLdRdYajJ21hlXoBC+HMGTKGj8Hfr026oQU20zSRaSqv6GCSTYR2t0kg8ey8GgJpzwLB
         uij6+ffSxEbQCt6A9I6yM+6zMkFLsnEzhE7guwQGyCOZIPXkLmOwWZFfujB8NHFJXn3m
         Le3eATGlaMbyyoeG6Jo4L64a0GPXArgdSjTYNowTdjNGXP4vb4/wFYonmoOy4bHJmP0b
         /zSw==
X-Gm-Message-State: AOAM532rJAft7aW553HUk7mUVh13+jT1hECkoJypChTV51gltroXLkZk
        InlxK/VM1ELSmLnymNxwH+g=
X-Google-Smtp-Source: ABdhPJxr0N9dwcDiO5BtWfsoSvknY2HG3QX/qXQ9wJPFG5mOIlJi1trxt+7YS2NOS0sgUWu8J1oquA==
X-Received: by 2002:a7b:c341:: with SMTP id l1mr23876084wmj.60.1640805914522;
        Wed, 29 Dec 2021 11:25:14 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2626:5600:5f5:a4cc:1dcf:a62])
        by smtp.gmail.com with ESMTPSA id g18sm21892379wrv.42.2021.12.29.11.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 11:25:14 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] riscv: canaan: remove useless select of non-existing config SYSCON
Date:   Wed, 29 Dec 2021 20:24:58 +0100
Message-Id: <20211229192458.25138-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The config SYSCON never existed in the kernel repository; so, the select of
that config in ./drivers/soc/canaan/Kconfig has no effect.

Presumably, this was just some mistake, assuming some symmetry in handling
and naming of configs that simply does not exist.

Remove this useless select of a non-existing config.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/soc/canaan/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/canaan/Kconfig b/drivers/soc/canaan/Kconfig
index 853096b7e84c..2527cf5757ec 100644
--- a/drivers/soc/canaan/Kconfig
+++ b/drivers/soc/canaan/Kconfig
@@ -5,7 +5,6 @@ config SOC_K210_SYSCTL
 	depends on RISCV && SOC_CANAAN && OF
 	default SOC_CANAAN
         select PM
-        select SYSCON
         select MFD_SYSCON
 	help
 	  Canaan Kendryte K210 SoC system controller driver.
-- 
2.17.1

