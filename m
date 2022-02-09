Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F1D4AEF52
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 11:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiBIKbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 05:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiBIKbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 05:31:42 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8C5E1397D8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 02:22:06 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id s10so3167440wra.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 02:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KHn/1GnLkO+cAfLyFzRg/GDk3ijEdB8uM8SM4d9QIy4=;
        b=KLxD3BmGKTKsbl31hONDsn+QLA8sf00qG4CDP7rwSaqjzmWawGylMu0ZPHWA+d9ggb
         FqugVsdV4JNntA55ZyL0Qp214YaLayaYgUVQHXS3PwiCu3z76W4j1bsfb3ePNnZ+UjC/
         G5Xa7+cMzlMBZxpKWE+uYVN3uCa7UJ1c5MRy9O+gdJ8FlFest5VNJEwJ5g5yEN57x9LI
         kcTFHV8Pu1/UN8Od/ixxNfOgft0g1Q2S5L8TlKrokHAfhGIt+4ENckOspP2qA5NjV988
         3dPap8OlEW6Q75vafMhv4z8idGJ1y+xS0x86sf0VbRS/XmJD5kIf6k92oFvvJyPA4p66
         lBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KHn/1GnLkO+cAfLyFzRg/GDk3ijEdB8uM8SM4d9QIy4=;
        b=ypv5b03FB8KeprHyodeCIKS8qgg5fZtqsWhr4wcvdzYwtAFkV70m31KbIxMer7xzYn
         mQBANYpH6Sd/uajFBJTHD/feYGd1ay/H3Zs/uuJxKk8rfVHJNMzWqY49/qHYffZ6vXPX
         i7Jsdy7EAe7OfQ+hRfFHmVw0WhcG7KhRnizu2jS4rsAeKiBCAxmVE32f1PjpmHwaSwym
         bIExx54GOK+WH8HbLDVaGxET8d0lcUnv3j6cZHiv5SjWU4byLPHmt6NzXL1LONM5oxwC
         d3ASdeDoxoRcWgGIQS38ycLsdgqDCGuafu+/rQByt/FFtvPAmk4x45k2qbPtX1hIzk0m
         /q0Q==
X-Gm-Message-State: AOAM531S9jF5gD7zM3ovfszFuM8sjxg0yoz3Tfv10WRbha4uyP3fL0Jt
        K07Wum3LBt0YHrrneVjYgn8JOg==
X-Google-Smtp-Source: ABdhPJzR0ymzxsVN/1lOSnhyjzWRuaU9S9tnS9OP9miFe2z9vDbMl/4a8hLFMgbN079yxZ7zkvP9kw==
X-Received: by 2002:adf:f58b:: with SMTP id f11mr589980wro.427.1644402124499;
        Wed, 09 Feb 2022 02:22:04 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z17sm4360429wmf.11.2022.02.09.02.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 02:22:04 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] crypto: cavium/nitro: fix typo on crypto
Date:   Wed,  9 Feb 2022 10:21:58 +0000
Message-Id: <20220209102158.1661976-1-clabbe@baylibre.com>
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

crypto had a typo, fix it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/cavium/nitrox/nitrox_req.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_req.h b/drivers/crypto/cavium/nitrox/nitrox_req.h
index ed174883c8e3..6bf088bcdd11 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_req.h
+++ b/drivers/crypto/cavium/nitrox/nitrox_req.h
@@ -440,7 +440,7 @@ struct aqmq_command_s {
 /**
  * struct ctx_hdr - Book keeping data about the crypto context
  * @pool: Pool used to allocate crypto context
- * @dma: Base DMA address of the cypto context
+ * @dma: Base DMA address of the crypto context
  * @ctx_dma: Actual usable crypto context for NITROX
  */
 struct ctx_hdr {
-- 
2.34.1

