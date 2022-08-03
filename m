Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1D9589374
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 22:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238635AbiHCUsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 16:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238558AbiHCUsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 16:48:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BE75C95D;
        Wed,  3 Aug 2022 13:47:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DC72F205AE;
        Wed,  3 Aug 2022 20:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659559676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vKzaXxOuodAWNmH75tEbExlIwhjF1u2srkFX6cUqy68=;
        b=1N9xrFj3qsgIi07FRZeT3t2v17ay2mE/+y9hObqOxXtEZRK9BaVfbGIK0zbZTMvY7BqOdb
        M736F8TLWcuN3f6+uxonNWXujE9Bnm+s5rXFIPbYDQ8K4+bHznI0Dqlx3KevV+EkGiv8I3
        AcKeH+t2EsxqZnN2dBvJXzNvJCDTEps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659559676;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vKzaXxOuodAWNmH75tEbExlIwhjF1u2srkFX6cUqy68=;
        b=uP6uiImSTFu9yAAlNQcJk5kVRF+mp7dHlSeJ8nLrZo59FuJ/Ob2qdmuAbTTDKl27qA780e
        gBCD5X7pmiIli+Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FAE113A94;
        Wed,  3 Aug 2022 20:47:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KBlkIfze6mJbMwAAMHmgww
        (envelope-from <jdelvare@suse.de>); Wed, 03 Aug 2022 20:47:56 +0000
Date:   Wed, 3 Aug 2022 22:47:55 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     LKML <linux-kernel@vger.kernel.org>, linux-crypto@vger.kernel.org
Cc:     Declan Murphy <declan.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Prabhjot Khurana <prabhjot.khurana@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH] crypto: keembay-ocs - Drop obsolete dependency on
 COMPILE_TEST
Message-ID: <20220803224755.177de90e@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
is possible to test-build any driver which depends on OF on any
architecture by explicitly selecting OF. Therefore depending on
COMPILE_TEST as an alternative is no longer needed.

It is actually better to always build such drivers with OF enabled,
so that the test builds are closer to how each driver will actually be
built on its intended target. Building them without OF may not test
much as the compiler will optimize out potentially large parts of the
code. In the worst case, this could even pop false positive warnings.
Dropping COMPILE_TEST here improves the quality of our testing and
avoids wasting time on non-existent issues.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Declan Murphy <declan.murphy@intel.com>
Cc: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Cc: Mark Gross <mgross@linux.intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Prabhjot Khurana <prabhjot.khurana@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
---
 drivers/crypto/keembay/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-5.18.orig/drivers/crypto/keembay/Kconfig	2022-05-22 21:52:31.000000000 +0200
+++ linux-5.18/drivers/crypto/keembay/Kconfig	2022-08-03 22:36:27.354500492 +0200
@@ -42,7 +42,7 @@ config CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_CT
 config CRYPTO_DEV_KEEMBAY_OCS_ECC
 	tristate "Support for Intel Keem Bay OCS ECC HW acceleration"
 	depends on ARCH_KEEMBAY || COMPILE_TEST
-	depends on OF || COMPILE_TEST
+	depends on OF
 	depends on HAS_IOMEM
 	select CRYPTO_ECDH
 	select CRYPTO_ENGINE
@@ -64,7 +64,7 @@ config CRYPTO_DEV_KEEMBAY_OCS_HCU
 	select CRYPTO_ENGINE
 	depends on HAS_IOMEM
 	depends on ARCH_KEEMBAY || COMPILE_TEST
-	depends on OF || COMPILE_TEST
+	depends on OF
 	help
 	  Support for Intel Keem Bay Offload and Crypto Subsystem (OCS) Hash
 	  Control Unit (HCU) hardware acceleration for use with Crypto API.


-- 
Jean Delvare
SUSE L3 Support
