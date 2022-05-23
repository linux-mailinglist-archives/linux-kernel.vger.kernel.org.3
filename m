Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80FE530A3F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiEWHoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiEWHow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:44:52 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF1A2189
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:44:50 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 421C83F1B6
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653287162;
        bh=T9i8ORAVhIu/VmTqgBVlMEyLEI0YNqPc0fC/Z3hDN78=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Um2MhiQFXMby1aBouIpm/ngtqBBjNYbey0T/NikMTc70Iu3vT/TBv/x1xazmKAhQw
         NwnKtoROHRR8LpIRLMvrm1teWKmrkNw0LSXnPegKvxFad7vkQTqZbNxuHgkm6Lco6h
         ql9XyHp0tUbYXxVv8NBXSCXeQF69CeL3RaFenS9lZQYWZjm97U+ayyJmkvisFu5UTH
         fd6SWB8dILv2ZE30vflWpZUMK6kqbVA68y6zQ8fz10T+Q8Yrx67cA0xlSY7V92UmT/
         qVvOv5ufC+gccs5ma+sq/6/uQqdni9Dd6FI2g9KfvLEpmpo/piI1NnhUzmRHo/B6nd
         BtLUTgS6xZURA==
Received: by mail-ej1-f72.google.com with SMTP id ks1-20020a170906f84100b006fee53b22c2so451824ejb.10
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 23:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T9i8ORAVhIu/VmTqgBVlMEyLEI0YNqPc0fC/Z3hDN78=;
        b=krmbC245R1BmGb2f4p6azpyBKa7TgZqhuVGEjzKbijxIRfEL3aH8Lju9/jy6JCjMXi
         RLzNrukTVavNEOjZkW/USEm8diYCPOLRR/C8WBrzoXVOaFv6sl84O9rvSDjNP50bI8NC
         b1EGbWJh9kLz4nPeN2bWKiqHLdJ5pDAukUpXsTtwKUgFYPsbfF/AzyPzMfXXkwytNrSZ
         2Dofdoj9d9Iq+GbUo5Ch0LqpOj0WmLfUqbgjZsZS4YTk9nh1Qlv6jEUPUcSTg1E8sni1
         r8I4oFU4IQb/WVtmsifsb7XNxC/Jb7PqjG4pr4WoSt4op6KlNy+p14NoYakpYrdSytmY
         GsDg==
X-Gm-Message-State: AOAM532WramDgVQmhi0usLo5s619D9KqlQ3JmcsHhBeh9czFIdzhM2uT
        l//CpagSr5R7VxrjVvxtGj0gQsEJOnH4HP/SgiTBY9URUhXf3oXYDO+kn/n0Annq5vWJpiBOYLa
        Q1JJTJmknG2pzm1A4PoQsjiFVtoWgfVx/4mEQb14PmQ==
X-Received: by 2002:a17:907:60cc:b0:6f4:ffba:489 with SMTP id hv12-20020a17090760cc00b006f4ffba0489mr18298672ejc.666.1653287161272;
        Sun, 22 May 2022 23:26:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqLPjO3sMKdWQU7rwBED6VSYtMw6O/JAthU9O7jc9TcU3UYkst8XK3xIUe21AgQm75shQeKw==
X-Received: by 2002:a17:907:60cc:b0:6f4:ffba:489 with SMTP id hv12-20020a17090760cc00b006f4ffba0489mr18298661ejc.666.1653287161063;
        Sun, 22 May 2022 23:26:01 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id 27-20020a170906329b00b006feec47dadfsm514214ejw.156.2022.05.22.23.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 23:26:00 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     lkundrak@v3.sk, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH] ARM: mmp: Kconfig: Fix indentation
Date:   Mon, 23 May 2022 08:25:57 +0200
Message-Id: <20220523062557.10212-1-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 arch/arm/mach-mmp/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index 0dd999212944..a9a21b3e01c8 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -169,7 +169,7 @@ config CPU_MMP2
 	  Select code specific to MMP2. MMP2 is ARMv7 compatible.
 
 config USB_EHCI_MV_U2O
-        bool "EHCI support for PXA USB OTG controller"
+	bool "EHCI support for PXA USB OTG controller"
 	depends on USB_EHCI_MV
 	help
 	  Enables support for OTG controller which can be switched to host mode.
-- 
2.32.0

