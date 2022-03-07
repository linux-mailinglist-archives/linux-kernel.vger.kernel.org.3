Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E4C4CF053
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 04:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbiCGDiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 22:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbiCGDiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 22:38:05 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F6D5EBFA
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 19:37:09 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2dbf52cc4b9so122943437b3.18
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 19:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ARpa6zPvm9PZGcuhaMPlpvBKRkuGs23E2qbxbopfbZE=;
        b=MCCElJilTvr7B+pD7gKcvQr3ZDXAlzmXGgob1nCokYBs+kB9L9gbZZcowbYbvdwNX8
         2ea0s2xtzpM00b2h1SF+GNyA2hOZidBC0B5tFnW0Foojz2QhIVyc5nv2yQFk9Rd7tfkg
         pJPK2LGns7HIOwY3SKlwazz6YMfXHZsw+Omj+Tt9ZnjqkP4xbTo/aD7odi4qKS5JJHY+
         bhanhrsRkzChc23du1M8OFUaXclZVPfqjBe6umiBZs4I/BNVY/OVUF9huoJf58CCnTC0
         UymJ3wYRkn+hrd7zNq5laZI3suCMgJM9ipS2dLOcaa3+A/PmgD3wOHNwmtkpmLW2HIJh
         9a2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ARpa6zPvm9PZGcuhaMPlpvBKRkuGs23E2qbxbopfbZE=;
        b=1WcaP2C3XAIzBpa8P1KSQamKHI5YpZCxIkzCNSXstqrmtP4v/V9QtnNvqlRr0h9qDC
         ywllNyyn28/OPvBDmLS4RgCN7gm8Uko/cK1yJIVefQcfzeTxe5gpi/NnosTX5SgzXV/f
         BXSv0Pd8IZwiSBkY3euogp4pf5W0Te3xV8JDymdP9BpSfzIC03202lUt/lJ0PHHWfUv3
         1xzLnhRDgc/RFyvwZPk8vkoe5fZSMwdQVLKxq4fNJihA2I6EoaLQFpavakWIMZOMOGgy
         5j3zIQsojkPFuA3AwqTD+7RCcUzpLBJaWdYtzFBGEanhAGd+y61NQJLHX/xlvPEdyFyb
         XG5A==
X-Gm-Message-State: AOAM531gWXQfges4TTReq+TKshaSxepf/xaYFcsB7BPHbx+o5XiaurSt
        SzkKKJHqE1jtLqnbeRk/j/tRf7y8jA==
X-Google-Smtp-Source: ABdhPJy1CbjnoFeTL/HWc58+lRRM4BCd1WNPaT1xh27NXWX5WTgImWN4e5HS6Yq2RCMg/Y19e6ct8oySSg==
X-Received: from wjack.tao.corp.google.com ([2401:fa00:fd:203:309f:cb85:fb3d:7ae0])
 (user=wjack job=sendgmr) by 2002:a81:5545:0:b0:2db:effc:f88a with SMTP id
 j66-20020a815545000000b002dbeffcf88amr7072121ywb.370.1646624228824; Sun, 06
 Mar 2022 19:37:08 -0800 (PST)
Date:   Mon,  7 Mar 2022 11:31:08 +0800
Message-Id: <20220307033110.283379-1-wjack@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v1] power: supply: add dock type
From:   Jack Wu <wjack@google.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Jack Wu <wjack@google.com>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dock power_supply_type for the drivers which supports dock can
register a power supply class device with POWER_SUPPLY_TYPE_DOCK.

Signed-off-by: Jack Wu <wjack@google.com>
---
 drivers/power/supply/power_supply_sysfs.c | 1 +
 include/linux/power_supply.h              | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index c3d7cbcd4fad..53494b56bbb4 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -57,6 +57,7 @@ static const char * const POWER_SUPPLY_TYPE_TEXT[] = {
 	[POWER_SUPPLY_TYPE_USB_PD_DRP]		= "USB_PD_DRP",
 	[POWER_SUPPLY_TYPE_APPLE_BRICK_ID]	= "BrickID",
 	[POWER_SUPPLY_TYPE_WIRELESS]		= "Wireless",
+	[POWER_SUPPLY_TYPE_DOCK]		= "Dock",
 };
 
 static const char * const POWER_SUPPLY_USB_TYPE_TEXT[] = {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 9ca1f120a211..fa80eaa54242 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -187,6 +187,7 @@ enum power_supply_type {
 	POWER_SUPPLY_TYPE_USB_PD_DRP,		/* PD Dual Role Port */
 	POWER_SUPPLY_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
 	POWER_SUPPLY_TYPE_WIRELESS,		/* Wireless */
+	POWER_SUPPLY_TYPE_DOCK,			/* Dock Charging */
 };
 
 enum power_supply_usb_type {
-- 
2.34.1.173.g76aa8bc2d0-goog

