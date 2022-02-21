Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B104BED3E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 23:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbiBUWb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 17:31:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiBUWbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 17:31:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78500240AF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 14:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645482689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TBA7vY6vDXXAWUvnPH4B+bcK6pUKZu1J6emvYjOF0V0=;
        b=Ay0gq/A3sjdF6OTJE49ZJs6uqITX0raiLVIcd/lINLdOQHKnmQ4z/kqTibVPKuoynwEXz/
        ODza9cMEed7TLYAVbHFqjGZawaVS9x+0DjbOsx2PVBc+xmFt+PLD3wUKORtHBBtSQBku9q
        xiLG+jpWpk14f6Cffg1NvCyyvUR1OpI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-o0UYvPSWPMSpAfoBQ2XB_w-1; Mon, 21 Feb 2022 17:31:28 -0500
X-MC-Unique: o0UYvPSWPMSpAfoBQ2XB_w-1
Received: by mail-qk1-f199.google.com with SMTP id w4-20020a05620a094400b0060dd52a1445so13640885qkw.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 14:31:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TBA7vY6vDXXAWUvnPH4B+bcK6pUKZu1J6emvYjOF0V0=;
        b=FtEAWoKlkfZQevPkZJjBAHs1uoYi31dkmj2g5FPS6V+v/3FYE6YeVZaxYBPN3t0g4n
         PnwHJf5KzhEBgQpxfQ2gb0KGyOmX3OoTriGpMINkREm1kBmt0eEksl2nZguPS69Z+RXm
         5DpSOqw48dwp2IcPt21Hvaqfff03xPFoNSi2CXTJ6VE+h9QcEEsAUbPQuHTfqyQd9tIG
         9U7/mbowXFnhVC90PIFcRHqZLy6NOvfZX70LY/ueKv/J1JaXZP9YuoM3jZnDszVbW9Xw
         EDUUD9NDodI+hENa5gQdX7bbTaj/J9jUC6Zb/7pggyg0r+1XbZBlKwQ6MrWvAs5FwXWX
         hodg==
X-Gm-Message-State: AOAM532Vt9pF8wqym5CkRDHHbMIwZjM30DCB04y6YiPvzEvitYiojoEJ
        ZxHVG9EMNS0j3LttQPJ7fKP1oBpcUzF6a81BDo2pe/lk01yyW2dOs5YAX2L2PYEXvl9KYuVCuQF
        L7Ot3jheENPKbJbO+/FFYzMCI
X-Received: by 2002:a05:620a:2a11:b0:649:77d:3966 with SMTP id o17-20020a05620a2a1100b00649077d3966mr2036455qkp.310.1645482687068;
        Mon, 21 Feb 2022 14:31:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxbOF/hRKICFGwoBEi81hiBc/WVlGAa7Z9POxkJz1fy0DNgvUj85VvCRTzll+yqZ3kc1Dysww==
X-Received: by 2002:a05:620a:2a11:b0:649:77d:3966 with SMTP id o17-20020a05620a2a1100b00649077d3966mr2036442qkp.310.1645482686811;
        Mon, 21 Feb 2022 14:31:26 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id t23sm9721884qtp.67.2022.02.21.14.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 14:31:26 -0800 (PST)
From:   trix@redhat.com
To:     dhowells@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dan.j.williams@intel.com, song@kernel.org,
        xni@redhat.com
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] crypto: cleanup comments
Date:   Mon, 21 Feb 2022 14:31:18 -0800
Message-Id: <20220221223118.3744238-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

For spdx
/* */ for *.h, // for *.c
Space before spdx tag

Replacements
paramenters to parameters
aymmetric to asymmetric
sigature to signature
boudary to boundary
compliled to compiled
eninges to engines
explicity to explicitly

Signed-off-by: Tom Rix <trix@redhat.com>
---
 crypto/asymmetric_keys/signature.c   | 2 +-
 crypto/asymmetric_keys/x509_parser.h | 2 +-
 crypto/async_tx/async_xor.c          | 8 ++++----
 crypto/async_tx/raid6test.c          | 4 ++--
 crypto/cfb.c                         | 2 +-
 crypto/dh.c                          | 2 +-
 crypto/sm2.c                         | 2 +-
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/crypto/asymmetric_keys/signature.c b/crypto/asymmetric_keys/signature.c
index 4aff3eebec17..2deff81f8af5 100644
--- a/crypto/asymmetric_keys/signature.c
+++ b/crypto/asymmetric_keys/signature.c
@@ -35,7 +35,7 @@ void public_key_signature_free(struct public_key_signature *sig)
 EXPORT_SYMBOL_GPL(public_key_signature_free);
 
 /**
- * query_asymmetric_key - Get information about an aymmetric key.
+ * query_asymmetric_key - Get information about an asymmetric key.
  * @params: Various parameters.
  * @info: Where to put the information.
  */
diff --git a/crypto/asymmetric_keys/x509_parser.h b/crypto/asymmetric_keys/x509_parser.h
index c233f136fb35..668f5c9f0b54 100644
--- a/crypto/asymmetric_keys/x509_parser.h
+++ b/crypto/asymmetric_keys/x509_parser.h
@@ -22,7 +22,7 @@ struct x509_certificate {
 	time64_t	valid_to;
 	const void	*tbs;			/* Signed data */
 	unsigned	tbs_size;		/* Size of signed data */
-	unsigned	raw_sig_size;		/* Size of sigature */
+	unsigned	raw_sig_size;		/* Size of signature */
 	const void	*raw_sig;		/* Signature data */
 	const void	*raw_serial;		/* Raw serial number in ASN.1 */
 	unsigned	raw_serial_size;
diff --git a/crypto/async_tx/async_xor.c b/crypto/async_tx/async_xor.c
index d8a91521144e..1a3855284091 100644
--- a/crypto/async_tx/async_xor.c
+++ b/crypto/async_tx/async_xor.c
@@ -170,8 +170,8 @@ dma_xor_aligned_offsets(struct dma_device *device, unsigned int offset,
  *
  * xor_blocks always uses the dest as a source so the
  * ASYNC_TX_XOR_ZERO_DST flag must be set to not include dest data in
- * the calculation.  The assumption with dma eninges is that they only
- * use the destination buffer as a source when it is explicity specified
+ * the calculation.  The assumption with dma engines is that they only
+ * use the destination buffer as a source when it is explicitly specified
  * in the source list.
  *
  * src_list note: if the dest is also a source it must be at index zero.
@@ -261,8 +261,8 @@ EXPORT_SYMBOL_GPL(async_xor_offs);
  *
  * xor_blocks always uses the dest as a source so the
  * ASYNC_TX_XOR_ZERO_DST flag must be set to not include dest data in
- * the calculation.  The assumption with dma eninges is that they only
- * use the destination buffer as a source when it is explicity specified
+ * the calculation.  The assumption with dma engines is that they only
+ * use the destination buffer as a source when it is explicitly specified
  * in the source list.
  *
  * src_list note: if the dest is also a source it must be at index zero.
diff --git a/crypto/async_tx/raid6test.c b/crypto/async_tx/raid6test.c
index 66db82e5a3b1..c9d218e53bcb 100644
--- a/crypto/async_tx/raid6test.c
+++ b/crypto/async_tx/raid6test.c
@@ -217,7 +217,7 @@ static int raid6_test(void)
 		err += test(12, &tests);
 	}
 
-	/* the 24 disk case is special for ioatdma as it is the boudary point
+	/* the 24 disk case is special for ioatdma as it is the boundary point
 	 * at which it needs to switch from 8-source ops to 16-source
 	 * ops for continuation (assumes DMA_HAS_PQ_CONTINUE is not set)
 	 */
@@ -241,7 +241,7 @@ static void raid6_test_exit(void)
 }
 
 /* when compiled-in wait for drivers to load first (assumes dma drivers
- * are also compliled-in)
+ * are also compiled-in)
  */
 late_initcall(raid6_test);
 module_exit(raid6_test_exit);
diff --git a/crypto/cfb.c b/crypto/cfb.c
index 0d664dfb47bc..5c36b7b65e2a 100644
--- a/crypto/cfb.c
+++ b/crypto/cfb.c
@@ -1,4 +1,4 @@
-//SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0
 /*
  * CFB: Cipher FeedBack mode
  *
diff --git a/crypto/dh.c b/crypto/dh.c
index 27e62a2a8027..be3138636726 100644
--- a/crypto/dh.c
+++ b/crypto/dh.c
@@ -104,7 +104,7 @@ static int dh_set_secret(struct crypto_kpp *tfm, const void *buf,
 /*
  * SP800-56A public key verification:
  *
- * * If Q is provided as part of the domain paramenters, a full validation
+ * * If Q is provided as part of the domain parameters, a full validation
  *   according to SP800-56A section 5.6.2.3.1 is performed.
  *
  * * If Q is not provided, a partial validation according to SP800-56A section
diff --git a/crypto/sm2.c b/crypto/sm2.c
index ae3f77a66070..f3e1592965c0 100644
--- a/crypto/sm2.c
+++ b/crypto/sm2.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * SM2 asymmetric public-key algorithm
  * as specified by OSCCA GM/T 0003.1-2012 -- 0003.5-2012 SM2 and
-- 
2.26.3

