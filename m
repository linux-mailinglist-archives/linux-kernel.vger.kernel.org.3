Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9CD57C88D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbiGUKGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiGUKGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:06:14 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AFD18B32
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 03:06:12 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id mf4so2320327ejc.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 03:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NwiMegOpXCfUqhqPIrggWB1DmC50mg6UP2utw91aj3Y=;
        b=S1kkuEw3U6eRQULtD757AiAjxl9ZZx0s8+xqaO9D9jvMxivXeYiHWqZKffi4rzPXth
         P3H0Us2awB8PTm8MF6oAamlZ/EK4bP41lQnKb20nyknQrFe3ZUcY455I8k1zSiA/7OZE
         80Gr1mzRvIUA5VNzcAOxlbkTx5iUZIx/me1axmi9GQ0OkC5FP+9b0/96SjSkrOyyCHl2
         Jol7m54y8y9ZfnAWt4lcF0edS1Yjxl70CAW/5dlerNiuDV6Pu2TdPmLO3FwGrSJLmzqz
         42A8JRM2hShqeVeSZjUxj/RKXtyAEAUzV/VhQDVXUeh7iu/0IX2D2QOi0vkKpxqNILOu
         efkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NwiMegOpXCfUqhqPIrggWB1DmC50mg6UP2utw91aj3Y=;
        b=vJey6wvuCgVbaIEgBssbZVh0v7asRj6SPHvpSTSsT8GkMMPD+XOBG6TGuytg7fsri4
         JDZpBy4g8N+yzaAJ8sokpv+2UZNQiXGSp7TtlEKxQ8AC9p5DiY22yZBy27LGGFEVzsUt
         1bKfHEMP4oZOdk8f+FlZ0f2MwWAtkZIOpcLF64rUzD7Vi/Bbu/bLms7XRC8JP8dDdD5m
         yTXc/xk4yNgZ9W44exx54KTtYwmr10IDHcokQnS/SnQUtvFyDW/cASdBO8A0BSX2I4JD
         pculOkjU9q4Lnrnt9mzdlkLElhvc8l0hPyO65lokObxUGjjazhhwfWfgNYJWA4cnrOUQ
         3Hpg==
X-Gm-Message-State: AJIora/AeUPhvXX4XYLn997NI7EBWD5SzIfFf8FuGh+mNqTZQtpbpJ7Y
        jvNqeZroefl59/hUUkGG/vQ=
X-Google-Smtp-Source: AGRyM1vJP5rO5P6g5q0YTMHYKpmmEyLgk1Qyj5abW2xGMo/WpivPw5xtN1DTyNArw4QV/F3gw8x+Cg==
X-Received: by 2002:a17:907:e8b:b0:72b:811a:1193 with SMTP id ho11-20020a1709070e8b00b0072b811a1193mr40692750ejc.265.1658397971310;
        Thu, 21 Jul 2022 03:06:11 -0700 (PDT)
Received: from localhost (92.40.202.7.threembb.co.uk. [92.40.202.7])
        by smtp.gmail.com with ESMTPSA id kx18-20020a170907775200b0072b13fa5e4csm668776ejc.58.2022.07.21.03.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 03:06:10 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     cw00.choi@samsung.com, krzysztof.kozlowski@linaro.org,
        b.zolnierkie@samsung.com, myungjoo.ham@samsung.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH -next] extcon: max77843: Replace irqchip mask_invert with unmask_base
Date:   Thu, 21 Jul 2022 11:07:11 +0100
Message-Id: <20220721100711.15847-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following recent changes in regmap-irq, unmask registers can now
describe inverted mask registers where a '1' bit enables an IRQ.
Because this implements the same functionality as mask_invert and
is more straightforward, the mask_invert flag has been deprecated.

Update the driver by replacing all uses of mask_base & mask_invert
with unmask_base.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
This patch depends on the "regmap-irq cleanups and refactoring" series
which (at time of writing) is already in linux-next.
Link: https://lore.kernel.org/lkml/20220623211420.918875-1-aidanmacdonald.0x0@gmail.com/

 drivers/extcon/extcon-max77843.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/extcon/extcon-max77843.c b/drivers/extcon/extcon-max77843.c
index 8e6e97ec65a8..1bc0426ce3f1 100644
--- a/drivers/extcon/extcon-max77843.c
+++ b/drivers/extcon/extcon-max77843.c
@@ -189,8 +189,7 @@ static const struct regmap_irq max77843_muic_irq[] = {
 static const struct regmap_irq_chip max77843_muic_irq_chip = {
 	.name           = "max77843-muic",
 	.status_base    = MAX77843_MUIC_REG_INT1,
-	.mask_base      = MAX77843_MUIC_REG_INTMASK1,
-	.mask_invert    = true,
+	.unmask_base    = MAX77843_MUIC_REG_INTMASK1,
 	.num_regs       = 3,
 	.irqs           = max77843_muic_irq,
 	.num_irqs       = ARRAY_SIZE(max77843_muic_irq),

base-commit: 353f7988dd8413c47718f7ca79c030b6fb62cfe5
prerequisite-patch-id: a45db1cac7537769dc10087fc61f977dc150744c
prerequisite-patch-id: cb8aa009c7bb7a6575eb05e3af65342dc8d0efa3
prerequisite-patch-id: 8d32557e53b894d1fb17250d2d0eb3673f068d37
prerequisite-patch-id: 5b293867ef81e3697892ac51b941bb53680a70dc
prerequisite-patch-id: 8138d39a4817e804141bfe8c2ad37d9c55456a40
prerequisite-patch-id: b01216129e887519d441cf556bbc75c397871773
prerequisite-patch-id: b5dcf0c0609113c2d81bc557c1fc95ef23f40811
prerequisite-patch-id: 622ca1c10e851b1889aaa567c1d2a0adf43cca44
prerequisite-patch-id: d28c5187f9bf0e43f27b2f4aa8dcf7fd91842a03
prerequisite-patch-id: d29d54b756be73304f844abeeaf9b46a5c0119d5
prerequisite-patch-id: 5d405790ae89c0831b46a359f86e94bac5a67470
prerequisite-patch-id: c90120e79acbb52ffa148bfedee1df9d35b5eced
prerequisite-patch-id: 2e35247a5cfe5a28565c9272b85fc6835011b032
-- 
2.35.1

