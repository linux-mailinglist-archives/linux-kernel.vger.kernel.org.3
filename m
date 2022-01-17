Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB98849021D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 07:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbiAQGmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 01:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbiAQGmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 01:42:51 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF39C061574;
        Sun, 16 Jan 2022 22:42:50 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id m57so9650451vkf.9;
        Sun, 16 Jan 2022 22:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kg92UeNXQbTbu2TtqxP+BqThXh30oOGlPd8qwnNhS+4=;
        b=XzhQ9TcOSZ5FNRbyZh8X40tgQEEfHOdlRXtlWnYO+TQACZr5idzilMjyAqAS9crgOD
         S1BeXqv5/Xj0zC4nIhOfKiyiFh0DxdoT0/oBxvvrs6UL9wPIMLAvn7szHYrRFW728soT
         hghekcoFVGbXkfitplsbM6FX5pkk+q6njgEtbBzmmchIacqr1KAb3N/3GcDwZl1VHWTQ
         /3V1mkTJSSE3firkcgQIQ+2tkVAQJ9hu8ZBLmU+ziRQZ2y5GlPC4gRHQG74kwfL9MPTI
         eqyGC61+lCYTgSlhDNF++b+OCfXmk1F4P3+bS5rP7eSqJqkdVdMvCrgeXIbdpksuZsiz
         +SvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Kg92UeNXQbTbu2TtqxP+BqThXh30oOGlPd8qwnNhS+4=;
        b=hQneVxCL0zxUdS4QRXixebXwYEVSxsYvBcX09LV8VT1ULVqaD2k8SW1iJ8CMKb14Cc
         6G0q7+bpI8SsESGNuH5G+xFD3LMowXb8wDeJniVnu/q36balhSzQhxiHhimNP5vX2D47
         kLu3sYTAIA1bHMMChpU+12U8Hd4V5hkV6P5RDsd09jOVET+bp0JaKXUfsLubQG8aVmnd
         Sr7itg+DxJ569GGDhOzaiIOqbGP2GDf+3ZNhFwIDlq8oLw4Ge1JNYpadvIQ19pCtCRdS
         LEfDc+8jYksU8Do8qT62gHbci7eHGb1ajNyh4oeN0LxspIFGh3K9sRfFIACB+wCYAYpk
         ivCQ==
X-Gm-Message-State: AOAM5328Ckx5I9S2Oca/EiqDQ+7T0aGylzCDMQHjNTvJJXQVAaU0qkZr
        2as/C91FYMP5q9oMOHhY9jE=
X-Google-Smtp-Source: ABdhPJxq6vU0DbhfjpUnQBTKFG9s8+ZzY7pJhNjlEa9sgpbf1FAuwLR3srgsxHLd6RiR0U6VLGgFzg==
X-Received: by 2002:a1f:a010:: with SMTP id j16mr6974378vke.29.1642401770098;
        Sun, 16 Jan 2022 22:42:50 -0800 (PST)
Received: from kubuntu-desktop.. ([67.8.38.84])
        by smtp.gmail.com with ESMTPSA id j11sm354624vka.52.2022.01.16.22.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 22:42:49 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        fazilyildiran@gmail.com
Subject: [PATCH] crypto: fix unmet dependency on CRYPTO for CRYPTO_LIB_CHACHA_GENERIC
Date:   Mon, 17 Jan 2022 01:42:48 -0500
Message-Id: <20220117064248.102638-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CRYPTO_LIB_CHACHA is selected,
and CRYPTO is not selected,
Kbuild gives the following warning:

WARNING: unmet direct dependencies detected for CRYPTO_LIB_CHACHA_GENERIC
  Depends on [n]: CRYPTO [=n]
  Selected by [y]:
  - CRYPTO_LIB_CHACHA [=y] && (CRYPTO_ARCH_HAVE_LIB_CHACHA [=n] || !CRYPTO_ARCH_HAVE_LIB_CHACHA [=n]) && CRYPTO_ARCH_HAVE_LIB_CHACHA [=n]=n

This is because CRYPTO_LIB_CHACHA selects CRYPTO_LIB_CHACHA_GENERIC,
without selecting or depending on CRYPTO, despite
CRYPTO_LIB_CHACHA_GENERIC depending on CRYPTO.

This unmet dependency bug was detected by Kismet,
a static analysis tool for Kconfig. Please advise
if this is not the appropriate solution.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 lib/crypto/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index 179041b60294..4b4f5062ccc0 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -33,6 +33,7 @@ config CRYPTO_ARCH_HAVE_LIB_CHACHA
 
 config CRYPTO_LIB_CHACHA_GENERIC
 	tristate
+	depends on CRYPTO
 	select CRYPTO_ALGAPI
 	help
 	  This symbol can be depended upon by arch implementations of the
@@ -44,6 +45,7 @@ config CRYPTO_LIB_CHACHA_GENERIC
 config CRYPTO_LIB_CHACHA
 	tristate "ChaCha library interface"
 	depends on CRYPTO_ARCH_HAVE_LIB_CHACHA || !CRYPTO_ARCH_HAVE_LIB_CHACHA
+	depends on CRYPTO
 	select CRYPTO_LIB_CHACHA_GENERIC if CRYPTO_ARCH_HAVE_LIB_CHACHA=n
 	help
 	  Enable the ChaCha library interface. This interface may be fulfilled
@@ -114,6 +116,7 @@ config CRYPTO_LIB_CHACHA20POLY1305
 	tristate "ChaCha20-Poly1305 AEAD support (8-byte nonce library version)"
 	depends on CRYPTO_ARCH_HAVE_LIB_CHACHA || !CRYPTO_ARCH_HAVE_LIB_CHACHA
 	depends on CRYPTO_ARCH_HAVE_LIB_POLY1305 || !CRYPTO_ARCH_HAVE_LIB_POLY1305
+	depends on CRYPTO
 	select CRYPTO_LIB_CHACHA
 	select CRYPTO_LIB_POLY1305
 
-- 
2.32.0

