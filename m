Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151BF4DA364
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351415AbiCOTkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351387AbiCOTkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:40:19 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE72D27B03;
        Tue, 15 Mar 2022 12:39:06 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id eq14so321945qvb.3;
        Tue, 15 Mar 2022 12:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KBxpEzoITwpU6kRtLWtpxV0a9ktQzPhWaCO/U0K4p2c=;
        b=XdzVQlWtFuwhv2KKVJvudG1KFS1VEslxYAFcjhLcAc061BST9gME1NKzu4mGfSvDuW
         8n1l1sWbJhRlhZRZ8A/QebvedXpumD81wGEc+gSr5yL4Qw1QGJYeuVaCsaEBNQyD+mtq
         iGAbsZ5gGGosDXD+76Y5tIl45WE8faqRL1R8lOEIFyi5OWociN4w4ejp54ph1Ir6YS2L
         oeGNRbGhv9TgkEOOc++cSuh5y0vffeszOwnkMTAIrIZou59eOhAqaWK9gbHwlLBnKaA6
         1aU89b8tYDIrEFQUfitkeCVkr+xlQqv7nMkzG4g+3vHps7O6db44L1go5LfJVSzPKWGg
         ClZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KBxpEzoITwpU6kRtLWtpxV0a9ktQzPhWaCO/U0K4p2c=;
        b=xTPNrssimuo0T+qxkIS9bRhK1q5QEZhMzefSplJ+dS3Sdd2mhv+F/g6eN2fY1wCO6j
         RtOC1QT50HV7187kkw6O9+f1wbAUTLJdWTWPjtJxwl9b/q6cypCVBpd8eGqqu/e8bo4T
         Y6suaC7VMyt5gfSYSMSLed3r1NwWnRPOe6QOYNPs+fRssYcTfIjSX0X8+8ZpisxuGE1A
         7xVJWVna2k6naXJ5UkqV0lr+j+kmYu2OZKOIMiQ9OGL1rfNqeTm3EZc1m3Vho45qM8v8
         U7Cbc1il1uxc50R9uEyZ8hYFvwkM8hSgr6laADN+SCYS63rIYbdCfaVskM62H7KPW0oD
         hP9w==
X-Gm-Message-State: AOAM533heXpahWJdYrDtTbXmDxBmV/mD3i6+HjgaMXt1wAvH/pqtmjet
        2QiP7P+p6VEccFpuEMPzoY4=
X-Google-Smtp-Source: ABdhPJz8vcAdgiHLoJc84Zb8vEocnkd+b3eDP5CmaX3KcjgI26RtA+QjPQhFt+uMPD3IzwC1FqbDhQ==
X-Received: by 2002:a0c:be89:0:b0:42c:4194:6adb with SMTP id n9-20020a0cbe89000000b0042c41946adbmr22624611qvi.6.1647373145823;
        Tue, 15 Mar 2022 12:39:05 -0700 (PDT)
Received: from ishi.. (072-189-064-222.res.spectrum.com. [72.189.64.222])
        by smtp.gmail.com with ESMTPSA id o4-20020a05620a22c400b0067e02a697e0sm1440798qki.33.2022.03.15.12.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 12:39:05 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Syed Nayyar Waris <syednwaris@gmail.com>
Subject: [RESEND PATCH 1/6] counter: 104-quad-8: Add COMPILE_TEST depends
Date:   Tue, 15 Mar 2022 15:38:52 -0400
Message-Id: <3917721e792d362ee108b2f12cd2223675449d05.1647373009.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647373009.git.vilhelm.gray@gmail.com>
References: <cover.1647373009.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

104_QUAD_8 depends on X86, but compiles fine on ARCH=arm. This patch
adds support for COMPILE_TEST which is useful for compile testing code
changes to the driver and Counter subsystem.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Syed Nayyar Waris <syednwaris@gmail.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20220105094137.259111-1-vilhelm.gray@gmail.com
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index 3dcdb681c4e4..5edd155f1911 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -14,7 +14,7 @@ if COUNTER
 
 config 104_QUAD_8
 	tristate "ACCES 104-QUAD-8 driver"
-	depends on PC104 && X86
+	depends on (PC104 && X86) || COMPILE_TEST
 	select ISA_BUS_API
 	help
 	  Say yes here to build support for the ACCES 104-QUAD-8 quadrature
-- 
2.35.1

