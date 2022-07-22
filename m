Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD0F57E00F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbiGVKcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGVKb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:31:58 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D47B504B;
        Fri, 22 Jul 2022 03:31:57 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id e15so5334281edj.2;
        Fri, 22 Jul 2022 03:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IFnsmnbjcLlYoAr+xu6Ngnb6y3ZV0ANVWM4gMEJHPHs=;
        b=ODcKD8AKT8ZDFo1Dq1Me1oMI0j3JdBF/BczXgmiYMw21AhSv0qxXSpkVlPAFbQHi3w
         JcUMMZ+2Z0VrdUZ4t53DgWZDjo0dkP2ECKnmqlb0vaHElM6lMjXhZ2xtP1fLuFhtjIwm
         li9GhqCYir0h+IoaJ0IEOhpfO6l8enuHGnWR94y2kAlWQrudeiaW6flY4Kx1QT0sCAig
         262JebI8msFNSZE/iF3Uic+zO4uarea7WPSf6rBSmp7MqZV5lPrwdCgAIjYqAbNbPvai
         IJXNwlOmaUcCqOUMov2mmvucDBFjIA3MJ3fZLE8Uz+CQvUuzWaErz6x1qYDdjS0RbS03
         +Aeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IFnsmnbjcLlYoAr+xu6Ngnb6y3ZV0ANVWM4gMEJHPHs=;
        b=VGe9u5PzAx5Q5YHPvJG7oGOQzXHEqY+PhVTJFD8z1kUEvrGD/Nr85Z/aVlMK+bTjqv
         zfs9qM4GmQq6TBJRy7FlX8h/rVBRjgeeYK5NO8PHiWWgpVawZeJVBL0ZRGaH5GehCPVn
         Oyf0R2ch+A7jXShoPfABXTL11YyqBiYQFwMbalnzndDSvOxJzKdUxRsQZ88YftLpza4u
         X5x7UNUjYPTpQCS6ygkwIRPYe/Rb9C4OXNmNa7DPMmziaVgeFKxTE6YB15+pTDY7XG0h
         UznM+G7V8u62Ho9rLWrOA1lWP9kfeMnC3A7B4z52Vzgm6AX7DxIVqTbGdOu+4K3L2jSD
         UHvw==
X-Gm-Message-State: AJIora9aOge5R0e8YbClG+c2abit9a1epmYfioIaR1EktUnaX+h+e98n
        m/etckYkwwYxELSwb/lPBmM=
X-Google-Smtp-Source: AGRyM1s4VWxM8kdBPaogcz5EkWQVbnvREQtxatII7yHeZJssaVyWzvpJpywlE5aDi7jeDqYKENptAQ==
X-Received: by 2002:a05:6402:28c3:b0:43a:6d78:1b64 with SMTP id ef3-20020a05640228c300b0043a6d781b64mr2866830edb.93.1658485915793;
        Fri, 22 Jul 2022 03:31:55 -0700 (PDT)
Received: from felia.fritz.box (200116b826e64200edeeb77a6a94b0d2.dip.versatel-1u1.de. [2001:16b8:26e6:4200:edee:b77a:6a94:b0d2])
        by smtp.gmail.com with ESMTPSA id lu44-20020a170906faec00b006fe9ec4ba9esm1856159ejb.52.2022.07.22.03.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 03:31:54 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Tomer Maimon <tmaimon77@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: rectify entry for ARM/NUVOTON NPCM ARCHITECTURE
Date:   Fri, 22 Jul 2022 12:31:29 +0200
Message-Id: <20220722103129.22998-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 08e950449c62 ("dt-binding: clk: npcm845: Add binding for Nuvoton
NPCM8XX Clock") obviously adds nuvoton,npcm845-clk.h, but the file entry in
MAINTAINERS, added with commit 3670d2ec13ee ("arm64: npcm: Add support for
Nuvoton NPCM8XX BMC SoC") then refers to nuvoton,npcm8xx-clock.h.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Repair this file reference in ARM/NUVOTON NPCM ARCHITECTURE.

Fixes: 3670d2ec13ee ("arm64: npcm: Add support for Nuvoton NPCM8XX BMC SoC")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Arnd, please pick this patch on top of the commits above.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d14a446df13..e2734926f6ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2488,7 +2488,7 @@ F:	arch/arm64/boot/dts/nuvoton/
 F:	drivers/*/*npcm*
 F:	drivers/*/*/*npcm*
 F:	include/dt-bindings/clock/nuvoton,npcm7xx-clock.h
-F:	include/dt-bindings/clock/nuvoton,npcm8xx-clock.h
+F:	include/dt-bindings/clock/nuvoton,npcm845-clk.h
 
 ARM/NUVOTON WPCM450 ARCHITECTURE
 M:	Jonathan Neuschäfer <j.neuschaefer@gmx.net>
-- 
2.17.1

