Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D056055082A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 05:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbiFSDwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 23:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiFSDwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 23:52:51 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C84E5FC4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 20:52:50 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id g8so7005853plt.8
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 20:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SRxgMBh3LSx0X9ElKOeiQdXyG/+f/q7PqwVZVLdt1m0=;
        b=I6IwHlaJ092r96q7USBHlHlm2vIu7/Jr2LrIZEasm2TYLKSTXqrm/0O+dFOZGYO7mc
         BJokeBGKOR3LCtfc7gp1HKkFGMPHHpngWwcZZdZiM05KBYKE3Hv6Fqh7S/tl7EIRx2Ds
         XXr++LMoRW7FcNXRQIw4yicUE+4NAEnRTBXlmzm0gslkKFQGaMt245ebmEuW9Occ7A0H
         A4DChitU6yG7zBbbYnEaQMBwAi7QhIcnQRuyB+Cc6HA/KfU2oGW9vWd20u+gM+PxhC/R
         AyS77OTZgIG5yJNog+4R+e0T4K3Vvlkv2tNRsTKFDO0Ibv2SBAs13pQ/UOxi7vhggQTQ
         TmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=SRxgMBh3LSx0X9ElKOeiQdXyG/+f/q7PqwVZVLdt1m0=;
        b=8O62rAyth4A/Z2NGXT0umY75o0SoP4Fmb/VOUoHZLsfAAGdjhAuu9u8ON0Z4dtImp/
         gTibHzWDBYa3K04+vwcVJ0Cp/u8AuR+yj1sHGs/yRvQsqpBR+ejqtcnmsX36SVz/s9xG
         ysWeWep6EFuACg9J5Q2nuAqIWAmzdBjX0q1N/Zc010ehic9QZFcpFcZrfsh4y7v91DzA
         TxiGIHvqN7YFUbo5wrokpIJbDPydN17gNpdauVHbH5L87+CzZ9tZ3AolIYLnUW/fBC7C
         L4nOajpEI73b5BUHz6AnFHM9PzdBminCwFWuyh2r8G6uZOhOm7eMfaWK8n5CyLGWcLuy
         Ooeg==
X-Gm-Message-State: AJIora9W8PJC0WKy3TCqZQDMnPd12htvwT0QNzsmv5i/WPyGjfjpwaJv
        2mHEwZUSVXGptIb5Xcj/78k=
X-Google-Smtp-Source: AGRyM1vBaXk4a3Ta4H1IaR/y5S8r1+FFtUvL86KgPWpSb4+k6+CE+LKFJRmxLwojDmh2TcKg8Tgj3A==
X-Received: by 2002:a17:90a:4503:b0:1ea:4718:829f with SMTP id u3-20020a17090a450300b001ea4718829fmr19037191pjg.103.1655610769450;
        Sat, 18 Jun 2022 20:52:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jd11-20020a170903260b00b0016a0d350b78sm2803112plb.58.2022.06.18.20.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 20:52:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        ul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH] powerpc/prom_init: Add memset as valid external symbol if CONFIG_KASAN=y
Date:   Sat, 18 Jun 2022 20:52:46 -0700
Message-Id: <20220619035246.2633538-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_KASAN=y, powerpc:allmodconfig fails to build with the following
error.

Error: External symbol 'memset' referenced from prom_init.c

The problem was introduced with commit 41b7a347bf14 ("powerpc: Book3S
64-bit outline-only KASAN support"). So far, with CONFIG_KASAN=y, only
__memset was accepted as valid external symbol in prom_init_check.sh.
Add memset as well to fix the problem.

Fixes: 41b7a347bf14 ("powerpc: Book3S 64-bit outline-only KASAN support")
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Daniel Axtens <dja@axtens.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/powerpc/kernel/prom_init_check.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
index b183ab9c5107..787142b5dd26 100644
--- a/arch/powerpc/kernel/prom_init_check.sh
+++ b/arch/powerpc/kernel/prom_init_check.sh
@@ -16,7 +16,7 @@
 grep "^CONFIG_KASAN=y$" .config >/dev/null
 if [ $? -eq 0 ]
 then
-	MEM_FUNCS="__memcpy __memset"
+	MEM_FUNCS="__memcpy __memset memset"
 else
 	MEM_FUNCS="memcpy memset"
 fi
-- 
2.35.1

