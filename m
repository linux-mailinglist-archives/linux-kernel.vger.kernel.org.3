Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A4A4D5E78
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347519AbiCKJd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347506AbiCKJdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:33:51 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBD46580B;
        Fri, 11 Mar 2022 01:32:47 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id h11so11297273ljb.2;
        Fri, 11 Mar 2022 01:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=22OynrwRfUmM6HyLJLZTgW4CgzT5GjNvtS3ZAyzd8ks=;
        b=bl/7bM6eRjZ70uLFQ3B96n/Nip1gGazFbixDvAvHOk76JxUxhxUu08bl+wsnwANU60
         TQop/jQmB0spSHG1caccnJiBa5iiLa76qRy26zhj9WpGM2uARcwU/HqB+Njt67wo9AZJ
         fTiz6Uy4W/lCrVbCIHqLuzP8NiI2ekn7zZe7zIg4ekJLJv7AcahFsd5SWQYlwXsJExaN
         /boti6xqRPRjzLIRJgpfEqbITfEOGJ4SRNkjpC9aPSfLmSWQoB66d6po3+2Or6C0M95L
         KlXkLTmo/IZMk5qqsAUMDzqfli9Qn9rDp5d5kMBJMbJQhjNnOnX2v4Kdo/PfDaTvC7Sj
         ldxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=22OynrwRfUmM6HyLJLZTgW4CgzT5GjNvtS3ZAyzd8ks=;
        b=KdTcpEECa3IFFYRlOsEE81HbgigidgxrkWdJnu6fKtujkbaMcYEehWqyBv/QepHQpD
         m6X8O4kyvIyL+JilpeIMfKHEcvW+xnjIxcbwecSLqoBHCKPkgEwGQuiuOtaJG07KKBAc
         ze248EZpWZXQznitYvx/htUvX504DQZB55fz3+HocvIDdyu6lcKsr90DCr1PTZ1n2A3O
         qMdTlWDV40TPTGOEnWHBcV39SMHfxso2N9KrCMAKeE2gbdrfQtJHHaHEsNygDadtsqI4
         nPvHNlq5+TD0zA6U98R39GvQUP0YlnAesgHkm1WriskjVuBosQQBdBbehbvu5VjCZxwE
         yCsg==
X-Gm-Message-State: AOAM532DgSENygzrza1tlyioESe7Hn9ZaF9jHW91YJU+zj4En3T0w2M9
        SQcUA2Z7BgVJXyQ612NDyyE=
X-Google-Smtp-Source: ABdhPJwd+CjY/Pi0ZOurKwWT7pB19cIeDyTOOH7yYWDN8VeY0LbziJLcsRiP52SI00Bk4AtNlyrV5g==
X-Received: by 2002:a2e:871a:0:b0:246:ee2:1109 with SMTP id m26-20020a2e871a000000b002460ee21109mr5459122lji.165.1646991166086;
        Fri, 11 Mar 2022 01:32:46 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id r7-20020ac25f87000000b004484fed8a9esm1506940lfe.268.2022.03.11.01.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 01:32:45 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH V3] tty: serial: bcm63xx: use more precise Kconfig symbol
Date:   Fri, 11 Mar 2022 10:32:33 +0100
Message-Id: <20220311093233.10012-1-zajec5@gmail.com>
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
V3: Don't default y for COMPILE_TEST
---
 drivers/tty/serial/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index e952ec5c7a7c..b51341678b8a 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1100,7 +1100,8 @@ config SERIAL_TIMBERDALE
 config SERIAL_BCM63XX
 	tristate "Broadcom BCM63xx/BCM33xx UART support"
 	select SERIAL_CORE
-	depends on COMMON_CLK
+	depends on ARCH_BCM4908 || ARCH_BCM_63XX || BCM63XX || BMIPS_GENERIC || COMPILE_TEST
+	default ARCH_BCM4908 || ARCH_BCM_63XX || BCM63XX || BMIPS_GENERIC
 	help
 	  This enables the driver for the onchip UART core found on
 	  the following chipsets:
-- 
2.34.1

