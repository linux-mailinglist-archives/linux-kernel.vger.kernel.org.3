Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44866570D4F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 00:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiGKW3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 18:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiGKW31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 18:29:27 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A5328E01
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:29:26 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id fz10so6023553pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VyL7asK1scBF1mPZ2L7z6bMsluDLvhYrqVJVCB+vemM=;
        b=O+HCjEoX6qSXT2UA5BAKG+ranugXqfYlH63+FxBfRleRV6u5f53KvBBWsEvM7cwRJx
         Dujc8Me3OT7Ta0nD6FPsC4cbJ52HflEnbkJRglQXf75ry81iIZ1kAEjyxEUGKd5iGesy
         kJHG96j6+2UXiAbFDXXBdlzbPZpTj4TsP4e85yB12EF63pV5X1L60CVYIm6kQyIj9DsL
         SCDYPRPNRQNlPnbgieIA5m9861segQ+YGyXFtXTBUCfPmpIzGgMvdYjvgHmQ0S3my1sw
         y9wn8x/E5hDe0lKMeaZ6X0OBiU4q2Pc01UNidIgIx7NIsf06Zahj4HThH+nmRlTfqSKS
         U70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VyL7asK1scBF1mPZ2L7z6bMsluDLvhYrqVJVCB+vemM=;
        b=2KLtzyAA6heQjMwLHv4/9naBLNtvI2Q4B/OhHriO9l9dzMWRF8EpiLaypuxruZkzMb
         Fz0C8i19B9OSD4YWiPUU9L+4wK7P/r7FroHlT/Tcjlc4pqVwnGKglgBpH0JqVQ2aS1qN
         iCJLVIZuDWGqeTadd+IuzgLI9Cf8F0DkxqIOCZGvEIuowZDCvfJbSf1BqoX+lCbfO+Sf
         b+MOG71byDQShGxBxhIq7caeLcJn6w4y8ZtTaA88DNvJ9ZS7Dw06NB4hm1af/nrFOQvU
         v8Pj6TqER85ViQSbPu5eS5DqB63T6ululiRWR4RGwqXVDAtd7sBS+2JsUg0tnlMy5PFS
         MwTw==
X-Gm-Message-State: AJIora9RClxaDKUR7WhJzEK2zAhDzUzmTCXZhb84AqIgIQru6jIbXtYj
        sTVImgZeZpZ1mkpRFhPvJJM=
X-Google-Smtp-Source: AGRyM1tqeFyV+nmz3Dmsng5PU3dh6LktZkbJqW4xu0bl6w+N9D7nRu5SL2yvp6GuNNu/z24rxv5gaA==
X-Received: by 2002:a17:90a:588c:b0:1ef:b0a2:b719 with SMTP id j12-20020a17090a588c00b001efb0a2b719mr637908pji.13.1657578565955;
        Mon, 11 Jul 2022 15:29:25 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id ka19-20020a17090b475300b001ec798b0dc4sm5266485pjb.38.2022.07.11.15.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 15:29:25 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: bcm: NSP: Removed forced thermal selection
Date:   Mon, 11 Jul 2022 15:29:19 -0700
Message-Id: <20220711222919.4048833-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

Both THERMAL and THERMA_OF are user-selectable and we should not force
the selection of those Kconfig entries.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mach-bcm/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index f73a056bf560..bf6b1218cc05 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -54,8 +54,6 @@ config ARCH_BCM_NSP
 	select ARM_ERRATA_775420
 	select ARM_ERRATA_764369 if SMP
 	select ARM_TIMER_SP804
-	select THERMAL
-	select THERMAL_OF
 	help
 	  Support for Broadcom Northstar Plus SoC.
 	  Broadcom Northstar Plus family of SoCs are used for switching control
-- 
2.25.1

