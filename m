Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEBD5842FC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbiG1PWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiG1PVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:21:49 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D446B65558;
        Thu, 28 Jul 2022 08:21:44 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id s9so2600415edd.8;
        Thu, 28 Jul 2022 08:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J+XcpxAZIHMHNGONdx78PErdDSYd+XFkvpXs7VSOMdk=;
        b=oa9WGsAukuXemTpS6eX9qETqa8yGtnVn2FCG9f7+4nwUKlrOWfZiXgtkrXuWJ/Yz7R
         DHq4ez4+OxvxIruajP/mf86Bfz4Smd8FY1SDhiyti+cy9dEyjqkMbgiHUI3HoWxu6En/
         8FLpP6KlxKzB13y49bZrdv2U3c7BZvdIBFS0zKl3qc83ZJFC0PI89UoO7Kkhg+L+RpxW
         dWdCopf/RN/qqVvJjUj3xbgPPHsr8FDfkP19wt/JyXOxERREUQ49XvT5gZUZU5fankYO
         BhXtpgT+1hBla4Nfx0mh3lgh7BXtrAHmJssIJSW1Gij+nJQhr+J26X+Ejz1NcXdQ2zjK
         dsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J+XcpxAZIHMHNGONdx78PErdDSYd+XFkvpXs7VSOMdk=;
        b=kAm359Y1Oetz1kXCZeBKqdLnOJEBXbSwrcUYuTCZdiazHdEivE39a7cWYT9dgsntDT
         QNPQ8VOg+Yd4XmzlUFEQ/Kkf7szqil1YaSjb6qXGJo1J7HuaQamXQ06C/jPvwplE0Ite
         pqTBeM5yeH9wh3I27X2GnkYAOMzghDvbfpeNZXXauCJlmuY17HWXlk72xnSSNghLZi0s
         9OS0NV1jBj/4z/KX1PBhFCZ1pKC/L3EYE613NWa878r05h+nm/br1vj8VhzT0GnhsaSt
         F8Lw4qNHj5a9YNQCPsSRBd+/odIUx8UQAH/7J1UkUobvqFWqleCMYJB8UsxQ7Gm9536G
         lxZg==
X-Gm-Message-State: AJIora9O83PcwX+EIvQVIDH7G/oo8PBrIlqpt/wGmWCquAcgXKmJhlwh
        kCm/9EWTlUIKmp3OwjabU9VekSTSZPA=
X-Google-Smtp-Source: AGRyM1vKd52t4Rw1LnaLLjcVrmFWo/l3sUYmbU60b78Z2TVUU/OCog+Xh+Cl8oOWE6nm8kBvDDDG2A==
X-Received: by 2002:a05:6402:1f01:b0:43a:239e:e65a with SMTP id b1-20020a0564021f0100b0043a239ee65amr27673878edb.428.1659021702919;
        Thu, 28 Jul 2022 08:21:42 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c001-5600-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:c001:5600::e63])
        by smtp.googlemail.com with ESMTPSA id e20-20020a170906315400b0072a881b21d8sm525006eje.119.2022.07.28.08.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 08:21:42 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bert@biot.com, sander@svanheule.net,
        mail@birger-koblitz.de,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 2/2] spi: realtek-rtl: Improve readability when clearing the size mask
Date:   Thu, 28 Jul 2022 17:21:18 +0200
Message-Id: <20220728152118.1429161-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728152118.1429161-1-martin.blumenstingl@googlemail.com>
References: <20220728152118.1429161-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the bitmask RTL_SPI_SFCSR_LEN_MASK so it only sets the bits of
this specific part of the register instead of setting all bits except
the relevant ones. This makes it consistent with single bit macros in
the spi-realtek-rtl driver as well as with the approach that many other
drivers use.

Suggested-by: Sander Vanheule <sander@svanheule.net>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/spi/spi-realtek-rtl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-realtek-rtl.c b/drivers/spi/spi-realtek-rtl.c
index 866b0477dbd7..0371d44cbfbd 100644
--- a/drivers/spi/spi-realtek-rtl.c
+++ b/drivers/spi/spi-realtek-rtl.c
@@ -20,7 +20,7 @@ struct rtspi {
 #define RTL_SPI_SFCSR_CSB1		BIT(30)
 #define RTL_SPI_SFCSR_RDY		BIT(27)
 #define RTL_SPI_SFCSR_CS		BIT(24)
-#define RTL_SPI_SFCSR_LEN_MASK		~(0x03 << 28)
+#define RTL_SPI_SFCSR_LEN_MASK		(0x03 << 28)
 #define RTL_SPI_SFCSR_LEN1		(0x00 << 28)
 #define RTL_SPI_SFCSR_LEN4		(0x03 << 28)
 
@@ -49,7 +49,7 @@ static void set_size(struct rtspi *rtspi, int size)
 	u32 value;
 
 	value = readl(REG(RTL_SPI_SFCSR));
-	value &= RTL_SPI_SFCSR_LEN_MASK;
+	value &= ~RTL_SPI_SFCSR_LEN_MASK;
 	if (size == 4)
 		value |= RTL_SPI_SFCSR_LEN4;
 	else if (size == 1)
-- 
2.37.1

