Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CFF56345A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 15:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiGAN1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 09:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiGAN1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:27:50 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589BB675A6
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 06:27:48 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id k129so1337455wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 06:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vElcCtw04QzuAH22LcbLyJ8OXVl5mqZvOzdsJCSKnNs=;
        b=SV30SZRPWDjribOlXEJdd/yg3juNcqboVOE6JCXCYDcrNei6x23hGFFoTjLeyG5w7s
         8oWs+rkoN0jpkAG4owViglzYHdY/zoC59LuweSuaQMU2oES6Las75LQWod71360VGQsQ
         fxqF643w/vVY4wq3myXS+WkUSXtZVMLQrFyYzdUD020PR2lwg4J/PIIorUhbPHjLyKXl
         eWVvO6aIheXIFXR7rptanl2FwKYc2LwRJXbKOgGiGarJkmhPSIpXFuqrjll593pSlad6
         njT/YBsVcJ///r28v3LoGpgwQSDPxp1VzpKJzu+OD9htbnF4+kaQ3t6G/3lIkRRyuduV
         n4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vElcCtw04QzuAH22LcbLyJ8OXVl5mqZvOzdsJCSKnNs=;
        b=09B+FzLSV61qK31wPiGdo464DQDZAuVa6w5AjOGIKyE3aH8CavX4z0C+uJqaLmO1Of
         GK3PtB69g9KJt4M+0vwZun/Lk1qzs92gUyr54QDxXj82zTKl/9EMkEb70WXWhUeqfYgB
         0ZSEUF3WmUHluSH7UQvmV4HLuaUx64t8f6PtNJj52+aBb29tnm5S0bFzYXYqR0lXS6cO
         jqKrBlJeZNzIhmTw6vZ/ULlfEf2eqbijzNuEPDV/J+dIV2/OdvPmKz31jtdGzcVzb+z6
         QmsH+OrtEfdNzYGy019exC33LALxiKm60bSMms4z6qamllL9K2lUcqozy3EzOFxK/4Dy
         bHHw==
X-Gm-Message-State: AJIora8EHv9QQig1TdsKd/GhjofUnluMQZf/hDLRPjnEj+3Gc4oMQ5HQ
        YB2uPKVpytqWm2pDzqPFbW0TjA==
X-Google-Smtp-Source: AGRyM1sWqkqw8VCKFu9qbSXKAUEUl2mZp5uKcKNoVZAyGcrDq9btYZgn0zHEhiuQOLpImL9tx3r5+w==
X-Received: by 2002:a1c:f20b:0:b0:39e:f4b9:24e3 with SMTP id s11-20020a1cf20b000000b0039ef4b924e3mr16541364wmc.51.1656682066956;
        Fri, 01 Jul 2022 06:27:46 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h13-20020adff4cd000000b002103aebe8absm22354337wrp.93.2022.07.01.06.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 06:27:46 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     herbert@gondor.apana.org.au, hch@lst.de, heiko@sntech.de
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [RFC PATCH] crypto: flush poison data
Date:   Fri,  1 Jul 2022 13:27:35 +0000
Message-Id: <20220701132735.1594822-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On my Allwinner D1 nezha, the sun8i-ce fail self-tests due to:
alg: skcipher: cbc-des3-sun8i-ce encryption overran dst buffer on test vector 0

In fact the buffer is not overran by device but by the dma_map_single() operation.

To prevent any corruption of the poisoned data, simply flush them before
giving the buffer to the tested driver.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---

Hello

I put this patch as RFC, since this behavour happen only on non yet merged RISCV code.
(Mostly riscv: implement Zicbom-based CMO instructions + the t-head variant)

Regards

 crypto/testmgr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index c59bd9e07978..187163e2e593 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -19,6 +19,7 @@
 #include <crypto/aead.h>
 #include <crypto/hash.h>
 #include <crypto/skcipher.h>
+#include <linux/cacheflush.h>
 #include <linux/err.h>
 #include <linux/fips.h>
 #include <linux/module.h>
@@ -205,6 +206,8 @@ static void testmgr_free_buf(char *buf[XBUFSIZE])
 static inline void testmgr_poison(void *addr, size_t len)
 {
 	memset(addr, TESTMGR_POISON_BYTE, len);
+	/* Be sure data is written to prevent corruption from some DMA sync */
+	flush_icache_range((unsigned long)addr, (unsigned long)addr + len);
 }
 
 /* Is the memory region still fully poisoned? */
-- 
2.35.1

