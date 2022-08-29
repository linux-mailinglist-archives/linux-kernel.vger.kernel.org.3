Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C940E5A43AA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 09:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiH2HWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 03:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiH2HV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:21:57 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FBC2B24A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 00:21:56 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 27T71GNp042078;
        Mon, 29 Aug 2022 15:01:16 +0800 (GMT-8)
        (envelope-from neal_liu@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 29 Aug
 2022 15:20:46 +0800
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
CC:     <linux-aspeed@lists.ozlabs.org>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <BMC-SW@aspeedtech.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] crypto: aspeed: fix build module error
Date:   Mon, 29 Aug 2022 15:20:35 +0800
Message-ID: <20220829072035.1539399-1-neal_liu@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.10.10]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 27T71GNp042078
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_MODULES=y and CONFIG_CRYPTO_DEV_ASPEED=m,
build modpost would be failed.

Error messages:
  ERROR: modpost: "aspeed_register_hace_hash_algs"
  [drivers/crypto/aspeed/aspeed_crypto.ko] undefined!
  ERROR: modpost: "aspeed_unregister_hace_hash_algs"
  [drivers/crypto/aspeed/aspeed_crypto.ko] undefined!

Change build sequence to fix this.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
---
 drivers/crypto/aspeed/Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/aspeed/Makefile b/drivers/crypto/aspeed/Makefile
index 421e2ca9c53e..4cc1a7ad3652 100644
--- a/drivers/crypto/aspeed/Makefile
+++ b/drivers/crypto/aspeed/Makefile
@@ -1,9 +1,9 @@
-obj-$(CONFIG_CRYPTO_DEV_ASPEED) += aspeed_crypto.o
-aspeed_crypto-objs := aspeed-hace.o	\
-		      $(hace-hash-y)	\
-		      $(hace-crypto-y)
-
 obj-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) += aspeed-hace-hash.o
 hace-hash-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) := aspeed-hace-hash.o
 obj-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO) += aspeed-hace-crypto.o
 hace-crypto-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO) := aspeed-hace-crypto.o
+
+obj-$(CONFIG_CRYPTO_DEV_ASPEED) += aspeed_crypto.o
+aspeed_crypto-objs := aspeed-hace.o	\
+		      $(hace-hash-y)	\
+		      $(hace-crypto-y)
-- 
2.25.1

