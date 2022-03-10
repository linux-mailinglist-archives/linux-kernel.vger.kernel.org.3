Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181A74D41BD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 08:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237837AbiCJHX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 02:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiCJHX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 02:23:56 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1AB4F9D0;
        Wed,  9 Mar 2022 23:22:55 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id l20so7814932lfg.12;
        Wed, 09 Mar 2022 23:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uRNunbfVJZj3V0khFzxC/exb9GUQby76Xdm8mxOwtM0=;
        b=DPAc3c3nnRtlOHHtjP2fyr/s7e94DFESjfTzk9QZ6Q7yiwbI/nqyNz4TB+C2UKsDiq
         /73o4A3M9ECUpbR1iBVfXIGYxdgiZF/ZYjHMnhi/YTiMElZ9canqG5ZkxZSsUYQb1MqF
         rQjEHFnhdrHbfyuee3+Bmx67MhVMUAMJTwEWGyzKRr4tjzqrJBIG3G/0+V9CCEkZQOrJ
         qmfAVhgBb43mGrPsiigZsBDUc7xxaWbKR3lrVWMst3LNeUHtwaHUMAyN1rrNA7ajwBwq
         dBCWmQgupSWWsnaPOyrlmIXiO6w1GFtNUR+OBwmObY5jOgPf7MDTaO9UIfaR5sIO8guJ
         I0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uRNunbfVJZj3V0khFzxC/exb9GUQby76Xdm8mxOwtM0=;
        b=nuLzegrWJjU6c1aR1xaFBasDHbZBPd96qfj9nFejuXafOq80fEEGhxsGHt1DnlaKlG
         Hv2T0uF61lsFhW3MG4mVNo0NbHYgyn74w68JZG93PnYgEhY8Vgk3guqO/9z6QNi0utGP
         5qoC0++JFEfBUGF6QQtqyuTgJq5RijpRi92nBFRQDyGN/U84rCWzLvb9g7HZya73kTUk
         StiN1+GOxLQAV7fZRIhlpehtt3Uh+AUU/zfgML2+XXBvOv+l8JgWms2KpZ5g5EE+iya7
         1dP82TGsJE5r+tiAcXbonfbFTtI7ybVIMhelE6bkTatkNXI/oBCoWPYEtC9IbQkbHpa1
         xeRQ==
X-Gm-Message-State: AOAM5321MsoHCSDpLnHD8tslMRx9j3KbnzUnt49SEAistcQ5fnrCHSEz
        2fOSHxVZn4g9rRkT2OvN1ec=
X-Google-Smtp-Source: ABdhPJx1HRJ6odDkpoCnKTs3Zu46b1u9QFUfxqdZZRDSKc8J875snzWrgbaWzfBjTjwbZjrEq+KrkA==
X-Received: by 2002:a05:6512:10c8:b0:448:3fdc:6407 with SMTP id k8-20020a05651210c800b004483fdc6407mr2112352lfg.360.1646896974120;
        Wed, 09 Mar 2022 23:22:54 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id y23-20020a2e95d7000000b00247e4e386aasm894075ljh.121.2022.03.09.23.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 23:22:53 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] tty: serial: bcm63xx: use more precise Kconfig symbol
Date:   Thu, 10 Mar 2022 08:22:39 +0100
Message-Id: <20220310072239.4489-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Patches lowering SERIAL_BCM63XX dependencies led to a discussion and
documentation change regarding "depends" usage. Adjust Kconfig entry to
match current guidelines. Make this symbol available for relevant
architectures only.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Ref: f35a07f92616 ("tty: serial: bcm63xx: lower driver dependencies")
Ref: 18084e435ff6 ("Documentation/kbuild: Document platform dependency practises")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/tty/serial/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index e952ec5c7a7c..99313e16c2be 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1100,7 +1100,8 @@ config SERIAL_TIMBERDALE
 config SERIAL_BCM63XX
 	tristate "Broadcom BCM63xx/BCM33xx UART support"
 	select SERIAL_CORE
-	depends on COMMON_CLK
+	depends on MIPS || ARM || ARM64 || COMPILE_TEST
+	default ARCH_BCM4908 || BCM63XX || BMIPS_GENERIC
 	help
 	  This enables the driver for the onchip UART core found on
 	  the following chipsets:
-- 
2.34.1

