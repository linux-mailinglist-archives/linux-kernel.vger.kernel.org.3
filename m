Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6417E59E615
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241449AbiHWPep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240930AbiHWPeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:34:13 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64A533431;
        Tue, 23 Aug 2022 04:17:37 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id z187so13135882pfb.12;
        Tue, 23 Aug 2022 04:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=0pU5iLLC3ceGYBrxwsq4Hg09zSm+DaoRJ02xrrcMouU=;
        b=L/J2Gt5Jqlon8zl8L69XswAVdKmyHBBm+yg7CgJKoru26DL5+vPXnh3QzqLEUhRGff
         eB7V8HK+J+/69FBQK4AtprGRYQb63wj7Cn37DjIJGxDuVFHEdMzjqHLbihoRXECgclKd
         kNgxhZpvERwxyXaMDYsI29h60D5nGijBM/nG7gKBipWakO9b9J5S63RO8fRxpccnszBM
         9TszvU+cjbUy8TbV6+DFIhNNAtIABTxykXqE/Z0MotEf8GmCQ1pjqova5D+XRhG6EEOI
         uwPzdSOpBktFUHk82Fkc2+l1jnYSP1DAh/xGhpdLoobgMN8K6+mXuLtB/zBbjyMh1qFN
         Ep9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=0pU5iLLC3ceGYBrxwsq4Hg09zSm+DaoRJ02xrrcMouU=;
        b=jz+dBq8S3RKdnV/aQUD3aCYxvrSY4szuawxlqtfh59p6bxFpeCWSfqFx37Q51oizMb
         WuoMl+ehfUXJEnsKIuGCyrhTHpwv8xFb648clgYDABj3PwUKsSV3q+zW2C+DBc/DNq9p
         Xn/GcDHAS3G4c04eQ9+KwobdIizUXQJvhGYJAgXxWR2pdBkSjjcxsJWWEWyDSk/1SuhX
         5KKiHp9Aesfb1f4AcyoDAcMe+rwmqctiyPYmiUKO4UnV5V1nOPk0iVeS9bxSfNlnY1NG
         Dl7sFNlZlXVAYPdaldMIMBO/jsGhzNrdfo24iefj7+uq0MtBrpOdj7LdXrrGD2/RzVvX
         ZdSA==
X-Gm-Message-State: ACgBeo3i+BTOa3XExj6rE54l6NFmizCp9FrKU75/MAOSO1mNWEjRYuYQ
        /U1zUS+sgc1/1dEQIJklEQ78M4Mcpo0atw==
X-Google-Smtp-Source: AA6agR5rs3KV4MIEfAj6rMx6hvhj3C3GIa4ja16PB9v5wE1J9n3s2pDW3NoG4n64a5u3F4JL8JJRTg==
X-Received: by 2002:a05:6a00:1952:b0:537:1bb2:8451 with SMTP id s18-20020a056a00195200b005371bb28451mr369530pfk.77.1661253454738;
        Tue, 23 Aug 2022 04:17:34 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([136.175.179.175])
        by smtp.gmail.com with ESMTPSA id z11-20020a17090a8b8b00b001f51903e03fsm9572023pjn.32.2022.08.23.04.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 04:17:34 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Yang Ling <gnaygnil@gmail.com>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH] MIPS: loongson32: ls1c: Fix hang during startup
Date:   Tue, 23 Aug 2022 19:17:25 +0800
Message-Id: <20220823111725.3134377-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Yang Ling <gnaygnil@gmail.com>

The RTCCTRL reg of LS1C is obselete.
Writing this reg will cause system hang.

Fixes: 60219c563c9b6 ("MIPS: Add RTC support for Loongson1C board")
Signed-off-by: Yang Ling <gnaygnil@gmail.com>
Tested-by: Keguang Zhang <keguang.zhang@gmail.com>
Acked-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 arch/mips/loongson32/ls1c/board.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/loongson32/ls1c/board.c b/arch/mips/loongson32/ls1c/board.c
index e9de6da0ce51..9dcfe9de55b0 100644
--- a/arch/mips/loongson32/ls1c/board.c
+++ b/arch/mips/loongson32/ls1c/board.c
@@ -15,7 +15,6 @@ static struct platform_device *ls1c_platform_devices[] __initdata = {
 static int __init ls1c_platform_init(void)
 {
 	ls1x_serial_set_uartclk(&ls1x_uart_pdev);
-	ls1x_rtc_set_extclk(&ls1x_rtc_pdev);
 
 	return platform_add_devices(ls1c_platform_devices,
 				   ARRAY_SIZE(ls1c_platform_devices));

base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.34.1

