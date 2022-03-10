Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D874D5462
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 23:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344337AbiCJWOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 17:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344318AbiCJWOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 17:14:03 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A125473A8;
        Thu, 10 Mar 2022 14:13:01 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id e6so5284022lfc.1;
        Thu, 10 Mar 2022 14:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0uUeeOtLtRATSMAA/PJZKMUOZ4L8d6PHmO/9x9ZaCqM=;
        b=A/tJcbHZDtbPu5MSQEhzXGbsQE3bFVecKhfSfEi64x/nG5hIv5mZsuB2sJqoL/AllB
         FtxqbHdqs2k1ziFxaeZjyitPE3LB3I3xn20kLn9fhGoLUFmtXP8ecet3TpjIH2WZeBCY
         g0viv9hmQOAhJUHpxRYiAfhiWM/+tEUET2XTDEwgZyROKR3t4rKiQKkoCAIp8LzFhC3r
         Ti7T2ksE5DrN85G9FO+R/N6XfSsYRWUOgX4ccmhgtUcNFJpPLVLy1uFgZ1jmAAddqFNZ
         +xRadblglm6u2dflIBZ1UZ6riJDv40DKgXxzMO2Hi1M5AHpGsvx8ZMoeUggYrWIdHhsu
         NLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0uUeeOtLtRATSMAA/PJZKMUOZ4L8d6PHmO/9x9ZaCqM=;
        b=BVq5LCOxIUlYTfGsFo746F3gpHSBr+fayl+IGEISvKPm8nBcObsTcS4hNXyX5gxrUf
         q2LE2JDzfdIvQgPOPNOjYye0we0B0rORU+H4EaMwQcu/VEhLJZl56UX6UFe/fPVqkebp
         84Uina2OWvEXnAiThscBpspwGiXCNGwinw1mWLXGT0lDRznhKXLNsG57RDNMpq/dllwq
         zgyAm9SOYmooCh/Od04M1AtH3Ux3eAoVr2BRNndoH7fY5M4mAU0lRn2dpWHPsPk4YNbQ
         s5pPW1hxdF7xvGOTOxiodtpISihJWn9eZSE7qGk0wdbFISIDkNr2MeKBNCs/REb0aPWg
         JWrg==
X-Gm-Message-State: AOAM533sldvNqsrrRxvTjieKy/2JICAMuGQBQ0gLECIPCMPjmZeukDOS
        Fjwoau1GKPNSzpneZn3GpC8=
X-Google-Smtp-Source: ABdhPJzlybEdm7oayZhC/wo2V53osIIlIRn9ru/Ui1pQEa0n5SmFccHaGYdJk/9SwvIXkFpFp+FLRg==
X-Received: by 2002:a05:6512:3d05:b0:448:39b8:d5ef with SMTP id d5-20020a0565123d0500b0044839b8d5efmr4166323lfv.595.1646950379573;
        Thu, 10 Mar 2022 14:12:59 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id a16-20020a056512375000b004482040d7cdsm1206421lfs.267.2022.03.10.14.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 14:12:59 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH V2] tty: serial: bcm63xx: use more precise Kconfig symbol
Date:   Thu, 10 Mar 2022 23:12:46 +0100
Message-Id: <20220310221246.10009-1-zajec5@gmail.com>
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
V2: Use precise "depends" (exact platforms)
---
 drivers/tty/serial/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index e952ec5c7a7c..46f3c7ca13e0 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1100,7 +1100,8 @@ config SERIAL_TIMBERDALE
 config SERIAL_BCM63XX
 	tristate "Broadcom BCM63xx/BCM33xx UART support"
 	select SERIAL_CORE
-	depends on COMMON_CLK
+	depends on ARCH_BCM4908 || ARCH_BCM_63XX || BCM63XX || BMIPS_GENERIC || COMPILE_TEST
+	default y
 	help
 	  This enables the driver for the onchip UART core found on
 	  the following chipsets:
-- 
2.34.1

