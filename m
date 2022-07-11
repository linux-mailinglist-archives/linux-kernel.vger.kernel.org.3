Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B8557004C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiGKLXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiGKLWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:22:51 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD3533A27;
        Mon, 11 Jul 2022 03:50:06 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t3so5475049edd.0;
        Mon, 11 Jul 2022 03:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=zfyolTFID8xhViXE+u1/8e+Wzla73AuvDzsmwKE1sQ4=;
        b=GXF1fwSaKTgvV8DBW/wKTIAjMbvQyia0ceCdUfz+jo+fA40QBzTk3GOxKUq2d4UXPp
         Lki7csV6vSyLyT5HidpiSbOooGJR/VkF3W6Tc/bRvH2x9ijmeGfWM+cYgjQKbLZBdGvU
         mBzTnWgZh9WCR6Xtjwzm4SagzynWkaOvdMr2eqnRcpZ+8coEmdpsT6MqS6R1V1bYytbn
         +hmHJ3oUJDO04HFMiT40M1GesGL57FQzDqEVQ6IMqdlJFiEoVJrd5SKtvpATVBe8NHWp
         Srt0kfuhPXBZbKU4OSHPEJ94HUWwSPrPQtHLKXxhHmJQxYADN1lt6nadP1f2ha3/41OL
         R15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zfyolTFID8xhViXE+u1/8e+Wzla73AuvDzsmwKE1sQ4=;
        b=EaNPbcdjwewbtpNBneUDdiVSeMOvuNuEXEtGZKdQ4tK/rtP4ke3t77pXpd0Rf2VL4y
         casVNotEnkHYjdAjRF/j7XvcaxvPCWbMo+CVzZArfypM5nJg5srZCcWzQWdnHo1vwU8C
         q2SalOtzKSw+u8Ta/0kahxsw608J3LiFW3LTpZvr78MP+2fsq0kxqiNfpkuM3fxDL8nE
         J8Jr9aV5vjlw0ikqvtPzqvumxw9Ib5aMmnvDTE0EVWbN9TyTyJXE+29r5uqBSBYHyXU+
         za30vt0XuUt9G7dDojV8zxZalTc0vDRf1ToQvy0lERW+Xs2lQLjYWJDr2usXg4qi3fOi
         p6gg==
X-Gm-Message-State: AJIora8kvoXrtxOpWgeT0Bl6hJS0DqEMeLS03dGP7QIegMwVWdfxPohj
        K71HJhehkhculeeBo/Mm86U=
X-Google-Smtp-Source: AGRyM1uImai7zOCOj1ESgSTujQz6aYcaSMlx0EZle9YmsPYF5MVaqsF03Ttpz6jXBOxKqNUtQuljpw==
X-Received: by 2002:a05:6402:22b5:b0:43a:8e9f:f495 with SMTP id cx21-20020a05640222b500b0043a8e9ff495mr23119816edb.324.1657536604557;
        Mon, 11 Jul 2022 03:50:04 -0700 (PDT)
Received: from felia.fritz.box (200116b8266e42009c70ae84c5cabc2b.dip.versatel-1u1.de. [2001:16b8:266e:4200:9c70:ae84:c5ca:bc2b])
        by smtp.gmail.com with ESMTPSA id q21-20020a17090676d500b006fe8a4ec62fsm2541775ejn.4.2022.07.11.03.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 03:50:03 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] mfd: ab8500: clean up definitions in header after debugfs removal
Date:   Mon, 11 Jul 2022 12:48:29 +0200
Message-Id: <20220711104829.17940-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3d4d1266597c ("mfd: ab8500: Drop debugfs module") removes the config
AB8500_DEBUG in drivers/mfd/Kconfig, but missed a reference to this config
in include/linux/mfd/abx500/ab8500.h.

The functions ab8500_dump_all_banks() and ab8500_debug_register_interrupt()
in the ab8500 header, previously with definitions conditioned on
AB8500_DEBUG, are now completely needless to define and handle at all.

The function ab8500_debug_register_interrupt() is not used at all and can
just be removed.

The function ab8500_dump_all_banks() is just registered in the abx500_ops
struct in the dump_all_banks field, but this is then not further referenced
anywhere else at all. So, safely drop the dump_all_banks field from
abx500_ops and delete the ab8500_dump_all_banks() definition.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
Lee, please pick this minor clean-up patch.

v1:
  https://lore.kernel.org/all/20220311145209.17346-1-lukas.bulwahn@gmail.com/

v1 -> v2:
  - leave "," in as requested in https://lore.kernel.org/all/Yi8BtWlhWjiUOADk@google.com/
  - add Reviewed-by tag from Linus W. from 
    https://lore.kernel.org/all/CACRpkdbjy2Cpzs7j6=iWw+wnJxBHkaxgcO2SOx6DeTLeF4ogPw@mail.gmail.com/ 

 drivers/mfd/ab8500-core.c         | 1 -
 include/linux/mfd/abx500.h        | 1 -
 include/linux/mfd/abx500/ab8500.h | 9 ---------
 3 files changed, 11 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 9d9e9787d5e8..eb11caadb801 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -329,7 +329,6 @@ static struct abx500_ops ab8500_ops = {
 	.mask_and_set_register = ab8500_mask_and_set_register,
 	.event_registers_startup_state_get = NULL,
 	.startup_irq_enabled = NULL,
-	.dump_all_banks = ab8500_dump_all_banks,
 };
 
 static void ab8500_irq_lock(struct irq_data *data)
diff --git a/include/linux/mfd/abx500.h b/include/linux/mfd/abx500.h
index 7f07cfe44753..507e3d2f062f 100644
--- a/include/linux/mfd/abx500.h
+++ b/include/linux/mfd/abx500.h
@@ -63,7 +63,6 @@ struct abx500_ops {
 	int (*mask_and_set_register) (struct device *, u8, u8, u8, u8);
 	int (*event_registers_startup_state_get) (struct device *, u8 *);
 	int (*startup_irq_enabled) (struct device *, unsigned int);
-	void (*dump_all_banks) (struct device *);
 };
 
 int abx500_register_ops(struct device *core_dev, struct abx500_ops *ops);
diff --git a/include/linux/mfd/abx500/ab8500.h b/include/linux/mfd/abx500/ab8500.h
index 302a330c5c84..42fd5da7d8a7 100644
--- a/include/linux/mfd/abx500/ab8500.h
+++ b/include/linux/mfd/abx500/ab8500.h
@@ -503,13 +503,4 @@ static inline int is_ab9540_2p0_or_earlier(struct ab8500 *ab)
 
 void ab8500_override_turn_on_stat(u8 mask, u8 set);
 
-#ifdef CONFIG_AB8500_DEBUG
-extern int prcmu_abb_read(u8 slave, u8 reg, u8 *value, u8 size);
-void ab8500_dump_all_banks(struct device *dev);
-void ab8500_debug_register_interrupt(int line);
-#else
-static inline void ab8500_dump_all_banks(struct device *dev) {}
-static inline void ab8500_debug_register_interrupt(int line) {}
-#endif
-
 #endif /* MFD_AB8500_H */
-- 
2.17.1

