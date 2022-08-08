Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D4158C1E5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 04:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbiHHCxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 22:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbiHHCx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 22:53:27 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F278388B;
        Sun,  7 Aug 2022 19:53:26 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id f10so3051298uap.2;
        Sun, 07 Aug 2022 19:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+pXr+XtINASTHtS2Vl6bIYsQmgt7hCm2Uk02zirBamE=;
        b=DuIfbPNc/jD0VNTOP+g2ETrBj0e4lcoEJxt0+xWyNjjDJ38fFgmGqqOAlqzAbHD4Kd
         c24UswnzFicvTMSOLtuwPo/5J9vWDYheAaCnP0jSi2rEVAjy1I42niESIVC1yPsq8/Jr
         qa6cSQQ4lkesXFWjp2to05n2Ojnq2ONF6FAihQswTcaWaaNW8K0oc+KG5BHOHTxJvqee
         QoyS6q23KuP+0Pvn68t7wiwX730lDXQpewZdUmFfE3E1b0nwRgh95/bwKMdooFCEngej
         yMdQDfhF44abEobNk4NhCHW+mwcQxe+KdkbkQTa1Je59Di/IwaNkdKczhDmZQDdre69q
         Safw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+pXr+XtINASTHtS2Vl6bIYsQmgt7hCm2Uk02zirBamE=;
        b=0HJN2exEr2Km/BxMnY6E01+/lKTQSy+W3dqfZW50obBFKffyiyPLximtWUcgHYTYel
         SGOjlSK5kmSkd4znWXAxGaX/DuhZT0gH7PoBda7nBoGE7GJ5Q+78N+TM9r8Zj+2UhEXQ
         b3aSvkmuqbv8aLeW6IAFb8ec52E4n8vH2TVg/1+/VzzhyQ0+8NwmyUmL2JtP3J/VJuZT
         UbgawzjjD5Z3MH1rGYm63dd/AYfGhkxcuZJxL6qGK6v2B5LCN6wDKChnjnoHY3Vk6SkL
         jJTjMi7f1mss3sZsR0V7Glyn0oZqe9ev2Yo+1b6g5xVY77wvlV3KZSM+B/PNPD5KEa+N
         MFKw==
X-Gm-Message-State: ACgBeo1n+Vj0MQYyyE3TijBSv/rebj5HJOwskyW6MFXFPG6zFmtrRO4F
        msckk0b7j9H/EhxN+Y6rlvw=
X-Google-Smtp-Source: AA6agR6nrcGsVhmRrgD+6HWTXlPcSeQ6XmGOLfsFd/QFIsTf/jcpqbHZKwGVSQVCG1eWZYCMKT82zQ==
X-Received: by 2002:a9f:35c9:0:b0:387:967a:fa31 with SMTP id u9-20020a9f35c9000000b00387967afa31mr6908438uad.70.1659927205668;
        Sun, 07 Aug 2022 19:53:25 -0700 (PDT)
Received: from bullseye-server.. (179-107-140-16.zamix.com.br. [179.107.140.16])
        by smtp.gmail.com with ESMTPSA id w8-20020ab07288000000b00384293c4199sm8263979uao.23.2022.08.07.19.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 19:53:25 -0700 (PDT)
From:   =?UTF-8?q?Jo=C3=A3o=20H=2E=20Spies?= <jhlspies@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Heiko Stuebner <heiko@sntech.de>,
        Jianqun Xu <jay.xu@rock-chips.com>
Cc:     Maya Matuszczyk <maccraft123mc@gmail.com>,
        =?UTF-8?q?Jo=C3=A3o=20H=2E=20Spies?= <jhlspies@gmail.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: rockchip: Enhance support for IRQ_TYPE_EDGE_BOTH
Date:   Mon,  8 Aug 2022 02:51:20 +0000
Message-Id: <20220808025121.110223-1-jhlspies@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switching between falling/rising edges for IRQ_TYPE_EDGE_BOTH on pins that
require debounce can cause the device to lose events due to a desync
between pin state and irq type.

This problem is resolved by switching between IRQ_TYPE_LEVEL_LOW and
IRQ_TYPE_LEVEL_HIGH instead.

Fixes: 936ee26 ("gpio/rockchip: add driver for rockchip gpio")
Signed-off-by: João H. Spies <jhlspies@gmail.com>
---
 drivers/gpio/gpio-rockchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index 099e358d2491..48b948723077 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -417,11 +417,11 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
 			goto out;
 		} else {
 			bank->toggle_edge_mode |= mask;
-			level |= mask;
+			level &= ~mask;
 
 			/*
 			 * Determine gpio state. If 1 next interrupt should be
-			 * falling otherwise rising.
+			 * low otherwise high.
 			 */
 			data = readl(bank->reg_base + bank->gpio_regs->ext_port);
 			if (data & mask)
-- 
2.30.2

