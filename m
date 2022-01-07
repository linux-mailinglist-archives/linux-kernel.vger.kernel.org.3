Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1999648717D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 04:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345960AbiAGDwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 22:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiAGDwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 22:52:09 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AD9C0611FF;
        Thu,  6 Jan 2022 19:52:08 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id s1so4362160pga.5;
        Thu, 06 Jan 2022 19:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bLSoIymaWywWpg+rlWS6uJiYTyIdtugwWHOa7gaHZDM=;
        b=EYDlQwsH8KzlYVUpvuaHHAKitKcdC+0b0KV8Bqc5oHyF7tQOjXM5DO2qJqwRUl7l02
         iwyRB9UNAmHxhPMIuJrHoQPtvNcyQKJnbLtqgDRaxvOfeJh2gAXcMRlQtIfDeAgTn5hw
         ab10B+WoFynuIp1HUVmYy+g3yRe0m/myF/3ag1oLI5jXgPpMTcG9/47wLLVGEL0+6Ciq
         Paxx/EvTIVaIJeJ585JCGEsvqnc4rjyZZ3Pas0C2Z1mfBuy2WDUn90vOzFHj7gK3Wnrg
         vrIzOsx8b0tdM8me4Aa5gnhErKGO3isXKUXUg/FiUxAURszNUaw2fRCNt3fMOl1uU40D
         HB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bLSoIymaWywWpg+rlWS6uJiYTyIdtugwWHOa7gaHZDM=;
        b=7qQnYSLlC5360TzUw5AbWFnF4UKrQ3rpXqCsy9dXoW1QYsuU/xzgWhmsglu+3KH/XW
         ZFC6ovzfGfPtsx5oIobG5PqIjbgOIvFluJYZSTQjvzLz7Es/0zoIDf/8lVR9l1MEXMuu
         SiSdPIVKGRqxPFhVhz4Q3tErxn7eMwUqZaT6UmLxolVbNHi4O6Bd4GTwnQf7I6D0CRFA
         j59ktq9YCnZe8PRQ9YhSdcXTaVRi6ggn6+kcWu4dIBL5y1TxQGmJ5cgbaQc0q88F610m
         5xOwt4EjwU+P4FiqPCF1ccx+801fq9SM3ptrGegjwqFGV+SHcVfwMVrIRe/G9LEIO3AL
         Lr5Q==
X-Gm-Message-State: AOAM533eIrldjVOMZo9nZXtQblJMkLc+UeKV8mp98iBjavSaA5IwJ+Sq
        aoKRXxkRsMWdcmVulJSgSABSS2jaDTQ=
X-Google-Smtp-Source: ABdhPJzX+Onh/IMxOzEfyhzX7C6p/5aaLKHWj5+G82jeUBpJ5iYa788bGG6lf0/j/PL3mZUBBQnl0Q==
X-Received: by 2002:aa7:9904:0:b0:4ba:5abb:aaf9 with SMTP id z4-20020aa79904000000b004ba5abbaaf9mr62062566pff.16.1641527527863;
        Thu, 06 Jan 2022 19:52:07 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j16sm4043855pfj.16.2022.01.06.19.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 19:52:07 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/5] MIPS: BCM47XX: Add support for Netgear R6300 v1
Date:   Thu,  6 Jan 2022 19:51:40 -0800
Message-Id: <20220107035141.2325384-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107035141.2325384-1-f.fainelli@gmail.com>
References: <20220107035141.2325384-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Netgear R6300 v1 Wi-Fi router using a Broadcom
BCM4706 chipset and supporting 802.11n and 802.11ac.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/bcm47xx/board.c                          | 1 +
 arch/mips/bcm47xx/buttons.c                        | 8 ++++++++
 arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h | 1 +
 3 files changed, 10 insertions(+)

diff --git a/arch/mips/bcm47xx/board.c b/arch/mips/bcm47xx/board.c
index d9148c66e0e7..f87b14c73f3c 100644
--- a/arch/mips/bcm47xx/board.c
+++ b/arch/mips/bcm47xx/board.c
@@ -162,6 +162,7 @@ struct bcm47xx_board_type_list1 bcm47xx_board_list_board_id[] __initconst = {
 	{{BCM47XX_BOARD_LUXUL_XWR_600_V1, "Luxul XWR-600 V1"}, "luxul_xwr600_v1"},
 	{{BCM47XX_BOARD_LUXUL_XWR_1750_V1, "Luxul XWR-1750 V1"}, "luxul_xwr1750_v1"},
 	{{BCM47XX_BOARD_NETGEAR_R6200_V1, "Netgear R6200 V1"}, "U12H192T00_NETGEAR"},
+	{{BCM47XX_BOARD_NETGEAR_R6300_V1, "Netgear R6300 V1"}, "U12H218T00_NETGEAR"},
 	{{BCM47XX_BOARD_NETGEAR_WGR614V8, "Netgear WGR614 V8"}, "U12H072T00_NETGEAR"},
 	{{BCM47XX_BOARD_NETGEAR_WGR614V9, "Netgear WGR614 V9"}, "U12H094T00_NETGEAR"},
 	{{BCM47XX_BOARD_NETGEAR_WGR614_V10, "Netgear WGR614 V10"}, "U12H139T01_NETGEAR"},
diff --git a/arch/mips/bcm47xx/buttons.c b/arch/mips/bcm47xx/buttons.c
index baf0a7d58d27..e380baef2458 100644
--- a/arch/mips/bcm47xx/buttons.c
+++ b/arch/mips/bcm47xx/buttons.c
@@ -409,6 +409,11 @@ bcm47xx_buttons_netgear_r6200_v1[] __initconst = {
 	BCM47XX_GPIO_KEY(4, KEY_WPS_BUTTON),
 };
 
+static const struct gpio_keys_button
+bcm47xx_buttons_netgear_r6300_v1[] __initconst = {
+	BCM47XX_GPIO_KEY(6, KEY_RESTART),
+};
+
 static const struct gpio_keys_button
 bcm47xx_buttons_netgear_wndr3400v1[] __initconst = {
 	BCM47XX_GPIO_KEY(4, KEY_RESTART),
@@ -701,6 +706,9 @@ int __init bcm47xx_buttons_register(void)
 	case BCM47XX_BOARD_NETGEAR_R6200_V1:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_r6200_v1);
 		break;
+	case BCM47XX_BOARD_NETGEAR_R6300_V1:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_r6300_v1);
+		break;
 	case BCM47XX_BOARD_NETGEAR_WNDR3400V1:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wndr3400v1);
 		break;
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
index 73e8809600b0..721c65312b19 100644
--- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
+++ b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
@@ -100,6 +100,7 @@ enum bcm47xx_board {
 	BCM47XX_BOARD_MOTOROLA_WR850GV2V3,
 
 	BCM47XX_BOARD_NETGEAR_R6200_V1,
+	BCM47XX_BOARD_NETGEAR_R6300_V1,
 	BCM47XX_BOARD_NETGEAR_WGR614V8,
 	BCM47XX_BOARD_NETGEAR_WGR614V9,
 	BCM47XX_BOARD_NETGEAR_WGR614_V10,
-- 
2.25.1

