Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9FB48B7A7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 20:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240743AbiAKTxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 14:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236475AbiAKTxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:53:14 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7572AC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 11:53:14 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id w188so494464oiw.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 11:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tjcdg3Ey3f8JqyyzT+Cl24fjuGmW4SbKqOF/PBidjqw=;
        b=hi83Xs0ac2F2+QsZ7+i2Hvbx/N2A5elBXFw59+QgJjNTybr6QyoaM6Zfx7JgdZslxu
         rYjHABxNI2z+2nxJQBInxUuqgV+q+FJc+NPZMSPAL/qaCRlnwZfY1+iWE+hugdo0Q3+j
         jfNOQIMppS9rJOWHEeQkr+4yXDt0DhCdAzvp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Tjcdg3Ey3f8JqyyzT+Cl24fjuGmW4SbKqOF/PBidjqw=;
        b=gMT+O7GhktA7ACAlYJZjg02sn+2vOq+iwkfx5DHnNcM18Fsrv62RUqM26WODWuGa1Y
         neqh6knWxRKI38uG6q7UOt070+A+7rFYkxVa2nKJ3Gzix3Pi5rr8yPDMSIWw43m+gsvs
         agz9NGxjuOzAvz+rlSQRhdTqLqpxehtzwf/1z515wxuvK+FR8h9L+41GukHQKU+bGi5v
         HuWMiB6sbD9VrrXvb3Med8A2K7EQ1VdWN0a3cGb/tkxDJFNCyGqa8n5YSNS66hd3o0AF
         x+R1BbFgtTTgZp0Xs0Pa4fQ4apX2ccvK8LRej2FbB+5irH/omH/aYOYFVO2Hi8N2ni24
         zn/Q==
X-Gm-Message-State: AOAM530Ig/1rW27AUpAM0UMoZD7wjgJ1q5bjFttpKHtZl1z4lp46u4tM
        PLEzN1kovT137r9tZR+DBg66fkdcvF6Q0PcK
X-Google-Smtp-Source: ABdhPJx4/yEP3bceehG7/01WrYo9pOVIDHPGvoHXeK1GTaH4YVVWOuoHDy92ZZExzuMV5qgkl5CD0g==
X-Received: by 2002:a05:6808:169f:: with SMTP id bb31mr3002278oib.87.1641930793777;
        Tue, 11 Jan 2022 11:53:13 -0800 (PST)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id bb20sm2178310oob.4.2022.01.11.11.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 11:53:12 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
From:   "Justin M. Forbes" <jforbes@fedoraproject.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jmforbes@linuxtx.org,
        "Justin M. Forbes" <jforbes@fedoraproject.org>
Subject: [PATCH] lib/crypto: add prompts back to crypto libraries
Date:   Tue, 11 Jan 2022 13:53:08 -0600
Message-Id: <20220111195309.634965-1-jforbes@fedoraproject.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6048fdcc5f269 ("lib/crypto: blake2s: include as built-in") took
away a number of prompt texts from other crypto libraries. This makes
values flip from built-in to module when oldconfig runs, and causes
problems when these crypto libs need to be built in for thingslike
BIG_KEYS.

Fixes: 6048fdcc5f269 ("lib/crypto: blake2s: include as built-in")
Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>
---
 lib/crypto/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index 8620f38e117c..a3e41b7a8054 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -40,7 +40,7 @@ config CRYPTO_LIB_CHACHA_GENERIC
 	  of CRYPTO_LIB_CHACHA.

 config CRYPTO_LIB_CHACHA
-	tristate
+	tristate "ChaCha library interface"
 	depends on CRYPTO_ARCH_HAVE_LIB_CHACHA || !CRYPTO_ARCH_HAVE_LIB_CHACHA
 	select CRYPTO_LIB_CHACHA_GENERIC if CRYPTO_ARCH_HAVE_LIB_CHACHA=n
 	help
@@ -65,7 +65,7 @@ config CRYPTO_LIB_CURVE25519_GENERIC
 	  of CRYPTO_LIB_CURVE25519.

 config CRYPTO_LIB_CURVE25519
-	tristate
+	tristate "Curve25519 scalar multiplication library"
 	depends on CRYPTO_ARCH_HAVE_LIB_CURVE25519 || !CRYPTO_ARCH_HAVE_LIB_CURVE25519
 	select CRYPTO_LIB_CURVE25519_GENERIC if CRYPTO_ARCH_HAVE_LIB_CURVE25519=n
 	help
@@ -100,7 +100,7 @@ config CRYPTO_LIB_POLY1305_GENERIC
 	  of CRYPTO_LIB_POLY1305.

 config CRYPTO_LIB_POLY1305
-	tristate
+	tristate "Poly1305 library interface"
 	depends on CRYPTO_ARCH_HAVE_LIB_POLY1305 || !CRYPTO_ARCH_HAVE_LIB_POLY1305
 	select CRYPTO_LIB_POLY1305_GENERIC if CRYPTO_ARCH_HAVE_LIB_POLY1305=n
 	help
@@ -109,7 +109,7 @@ config CRYPTO_LIB_POLY1305
 	  is available and enabled.

 config CRYPTO_LIB_CHACHA20POLY1305
-	tristate
+	tristate "ChaCha20-Poly1305 AEAD support (8-byte nonce library version)"
 	depends on CRYPTO_ARCH_HAVE_LIB_CHACHA || !CRYPTO_ARCH_HAVE_LIB_CHACHA
 	depends on CRYPTO_ARCH_HAVE_LIB_POLY1305 || !CRYPTO_ARCH_HAVE_LIB_POLY1305
 	select CRYPTO_LIB_CHACHA
-- 
2.34.1

