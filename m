Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A82F4702DD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 15:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238732AbhLJOdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 09:33:46 -0500
Received: from mga03.intel.com ([134.134.136.65]:51293 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234805AbhLJOdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 09:33:45 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="238296854"
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="238296854"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 06:30:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="463680787"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 10 Dec 2021 06:30:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1B29E329; Fri, 10 Dec 2021 16:30:14 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH v1 1/1] crypto: Replace kernel.h with the necessary inclusions
Date:   Fri, 10 Dec 2021 16:30:09 +0200
Message-Id: <20211210143009.4770-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kernel.h is used in the headers it adds a lot into dependency hell,
especially when there are circular dependencies are involved.

Replace kernel.h inclusion with the list of what is really being used.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/crypto/aead.h        | 4 +++-
 include/crypto/algapi.h      | 5 ++++-
 include/crypto/blake2b.h     | 1 -
 include/crypto/blake2s.h     | 2 +-
 include/crypto/cryptd.h      | 3 ++-
 include/crypto/engine.h      | 6 +++++-
 include/crypto/pcrypt.h      | 2 +-
 include/crypto/scatterwalk.h | 3 ++-
 include/crypto/skcipher.h    | 6 +++++-
 9 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/crypto/aead.h b/include/crypto/aead.h
index 5af914c1ab8e..14db3bee0519 100644
--- a/include/crypto/aead.h
+++ b/include/crypto/aead.h
@@ -8,9 +8,10 @@
 #ifndef _CRYPTO_AEAD_H
 #define _CRYPTO_AEAD_H
 
+#include <linux/container_of.h>
 #include <linux/crypto.h>
-#include <linux/kernel.h>
 #include <linux/slab.h>
+#include <linux/types.h>
 
 /**
  * DOC: Authenticated Encryption With Associated Data (AEAD) Cipher API
@@ -73,6 +74,7 @@
  */
 
 struct crypto_aead;
+struct scatterlist;
 
 /**
  *	struct aead_request - AEAD request
diff --git a/include/crypto/algapi.h b/include/crypto/algapi.h
index 5f6841c73e5a..f76ec723ceae 100644
--- a/include/crypto/algapi.h
+++ b/include/crypto/algapi.h
@@ -7,9 +7,11 @@
 #ifndef _CRYPTO_ALGAPI_H
 #define _CRYPTO_ALGAPI_H
 
+#include <linux/align.h>
 #include <linux/crypto.h>
+#include <linux/kconfig.h>
 #include <linux/list.h>
-#include <linux/kernel.h>
+#include <linux/types.h>
 
 /*
  * Maximum values for blocksize and alignmask, used to allocate
@@ -24,6 +26,7 @@
 struct crypto_aead;
 struct crypto_instance;
 struct module;
+struct notifier_block;
 struct rtattr;
 struct seq_file;
 struct sk_buff;
diff --git a/include/crypto/blake2b.h b/include/crypto/blake2b.h
index 18875f16f8ca..0c0176285349 100644
--- a/include/crypto/blake2b.h
+++ b/include/crypto/blake2b.h
@@ -5,7 +5,6 @@
 
 #include <linux/bug.h>
 #include <linux/types.h>
-#include <linux/kernel.h>
 #include <linux/string.h>
 
 enum blake2b_lengths {
diff --git a/include/crypto/blake2s.h b/include/crypto/blake2s.h
index bc3fb59442ce..df3c6c2f9553 100644
--- a/include/crypto/blake2s.h
+++ b/include/crypto/blake2s.h
@@ -7,8 +7,8 @@
 #define _CRYPTO_BLAKE2S_H
 
 #include <linux/bug.h>
+#include <linux/kconfig.h>
 #include <linux/types.h>
-#include <linux/kernel.h>
 #include <linux/string.h>
 
 enum blake2s_lengths {
diff --git a/include/crypto/cryptd.h b/include/crypto/cryptd.h
index 23169f4d87e6..796d986e58e1 100644
--- a/include/crypto/cryptd.h
+++ b/include/crypto/cryptd.h
@@ -13,7 +13,8 @@
 #ifndef _CRYPTO_CRYPT_H
 #define _CRYPTO_CRYPT_H
 
-#include <linux/kernel.h>
+#include <linux/types.h>
+
 #include <crypto/aead.h>
 #include <crypto/hash.h>
 #include <crypto/skcipher.h>
diff --git a/include/crypto/engine.h b/include/crypto/engine.h
index fd4f2fa23f51..ae133e98d813 100644
--- a/include/crypto/engine.h
+++ b/include/crypto/engine.h
@@ -9,8 +9,10 @@
 
 #include <linux/crypto.h>
 #include <linux/list.h>
-#include <linux/kernel.h>
 #include <linux/kthread.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
 #include <crypto/algapi.h>
 #include <crypto/aead.h>
 #include <crypto/akcipher.h>
@@ -18,6 +20,8 @@
 #include <crypto/skcipher.h>
 #include <crypto/kpp.h>
 
+struct device;
+
 #define ENGINE_NAME_LEN	30
 /*
  * struct crypto_engine - crypto hardware engine
diff --git a/include/crypto/pcrypt.h b/include/crypto/pcrypt.h
index b9bc3436196a..234d7cf3cf5e 100644
--- a/include/crypto/pcrypt.h
+++ b/include/crypto/pcrypt.h
@@ -9,8 +9,8 @@
 #ifndef _CRYPTO_PCRYPT_H
 #define _CRYPTO_PCRYPT_H
 
+#include <linux/container_of.h>
 #include <linux/crypto.h>
-#include <linux/kernel.h>
 #include <linux/padata.h>
 
 struct pcrypt_request {
diff --git a/include/crypto/scatterwalk.h b/include/crypto/scatterwalk.h
index 7af08174a721..6407b4b61350 100644
--- a/include/crypto/scatterwalk.h
+++ b/include/crypto/scatterwalk.h
@@ -12,8 +12,9 @@
 #define _CRYPTO_SCATTERWALK_H
 
 #include <crypto/algapi.h>
+
 #include <linux/highmem.h>
-#include <linux/kernel.h>
+#include <linux/mm.h>
 #include <linux/scatterlist.h>
 
 static inline void scatterwalk_crypto_chain(struct scatterlist *head,
diff --git a/include/crypto/skcipher.h b/include/crypto/skcipher.h
index ef0fc9ed4342..39f5b67c3069 100644
--- a/include/crypto/skcipher.h
+++ b/include/crypto/skcipher.h
@@ -8,9 +8,13 @@
 #ifndef _CRYPTO_SKCIPHER_H
 #define _CRYPTO_SKCIPHER_H
 
+#include <linux/container_of.h>
 #include <linux/crypto.h>
-#include <linux/kernel.h>
 #include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+struct scatterlist;
 
 /**
  *	struct skcipher_request - Symmetric key cipher request
-- 
2.33.0

