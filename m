Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4195A54F99B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382883AbiFQOrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382858AbiFQOrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:47:16 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFCD4F1D0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:47:16 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y6so4335981pfr.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Et65JYTp6/b5DQwDR3OJdarOhDWj0H1ZupFLqwJaO/E=;
        b=VWnAyE0r32ANng/1Mua4nvT19IbyjE37EWSvexK7FxFvRCLKLtpAP7Ry/tBxftP4+l
         qCIf9s13l856ydPXG5wFcB8ZDXnEQkXLQRin1XYGFG/21oucoeHbyzORysfse4y1eqXm
         /1NiO7RiHCNlZMc8KYaFftqJMpviO6udOHwGSfoAyhbkt8EaWif1vCv3FVBvfIarpFcD
         QiSyGcyeFcxiv4CWCSTfuyZ1YURZe0UYMB4cPe2R8G1AcrWSjln4POVradp9hfg0Ufus
         HfLDQry/qfGaXAV/WpRoUC4lt0y3AtgDtOmI2NeM9pseDwDpF1sn7JVFhRIAhflEx98n
         Ph+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Et65JYTp6/b5DQwDR3OJdarOhDWj0H1ZupFLqwJaO/E=;
        b=iP0Tq3CUVQs11F4ybrU4xwtvkYeM+qaT6WE7sdIt5RW7XNilJMBaSdT4JVEnwLGGK8
         aA2y5kaX5AInA90INDleVHK1XhZ8tSFPPRX2U6gSTNg5rXw8N45HOAGohTUWjhw1SAnW
         4LrnPumzmPNutPD7eyWUUh7cBleOOzhNMwghagafmt+7pUrSOTQwuXbu6TCVX6UjHI6v
         eAw1TG6VTQKMp/YOdxjbAy74L2ffv345cEJLcsjwA1ROHHFMD3gGed0fRAYmtfEDBnvD
         FvSovmUaduAMqEweU300/i5tpeeqgf2QTgdE3uNQD0Sr+gEHUYVxLafC4893QG7Y0J1O
         N2sw==
X-Gm-Message-State: AJIora8MtAe0fyBSpl8sm/6FnYwOtrIXRYuHDGi3HsnK4eDKlAIboPu+
        BxW9p1dZd8A2MbxPX7XtJ9KXjvIidAOQsw==
X-Google-Smtp-Source: AGRyM1s4KWe8ADIbuyJbzwDR2SeFaHw5JtKWbvOKzbvgjxPsirAIInkCMYBr4H693DwLqT0+hhlD1g==
X-Received: by 2002:a62:1cc7:0:b0:51c:b8b9:14a5 with SMTP id c190-20020a621cc7000000b0051cb8b914a5mr10448954pfc.19.1655477235611;
        Fri, 17 Jun 2022 07:47:15 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id o12-20020a63a80c000000b003db822e2170sm3832453pgf.23.2022.06.17.07.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 07:47:15 -0700 (PDT)
From:   Zhang Boyang <zhangboyang.id@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Ivan Djelic <ivan.djelic@parrot.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Zhang Boyang <zhangboyang.id@gmail.com>
Subject: [PATCH v2 2/5] rslib: Fix obvious documentation mistakes
Date:   Fri, 17 Jun 2022 22:46:21 +0800
Message-Id: <20220617144624.158973-3-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220617144624.158973-1-zhangboyang.id@gmail.com>
References: <20220617144624.158973-1-zhangboyang.id@gmail.com>
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

This patch fixes some obvious documentation mistakes.

Signed-off-by: Zhang Boyang <zhangboyang.id@gmail.com>
---
 include/linux/rslib.h           | 4 ++--
 lib/reed_solomon/reed_solomon.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/rslib.h b/include/linux/rslib.h
index 507fa14c03b2..cd0b5a7a5698 100644
--- a/include/linux/rslib.h
+++ b/include/linux/rslib.h
@@ -19,8 +19,8 @@
  *
  * @mm:		Bits per symbol
  * @nn:		Symbols per block (= (1<<mm)-1)
- * @alpha_to:	log lookup table
- * @index_of:	Antilog lookup table
+ * @alpha_to:	exp() lookup table
+ * @index_of:	log() lookup table
  * @genpoly:	Generator polynomial
  * @nroots:	Number of generator roots = number of parity symbols
  * @fcr:	First consecutive root, index form
diff --git a/lib/reed_solomon/reed_solomon.c b/lib/reed_solomon/reed_solomon.c
index bbc01bad3053..9415899bf27c 100644
--- a/lib/reed_solomon/reed_solomon.c
+++ b/lib/reed_solomon/reed_solomon.c
@@ -56,7 +56,7 @@ static DEFINE_MUTEX(rslistlock);
 
 /**
  * codec_init - Initialize a Reed-Solomon codec
- * @symsize:	symbol size, bits (1-8)
+ * @symsize:	the symbol size (number of bits)
  * @gfpoly:	Field generator polynomial coefficients
  * @gffunc:	Field generator function
  * @fcr:	first root of RS code generator polynomial, index form
-- 
2.30.2

