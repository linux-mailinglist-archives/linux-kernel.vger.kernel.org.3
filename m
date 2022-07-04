Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35FD565332
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbiGDLW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiGDLW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:22:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5865ABF6C;
        Mon,  4 Jul 2022 04:22:22 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Lc3J424hfzkWjX;
        Mon,  4 Jul 2022 19:20:20 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Jul 2022 19:22:19 +0800
Received: from huawei.com (10.67.175.34) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Jul
 2022 19:22:18 +0800
From:   Ren Zhijie <renzhijie2@huawei.com>
To:     <dhowells@redhat.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <simo@redhat.com>
CC:     <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Ren Zhijie <renzhijie2@huawei.com>
Subject: [PATCH -next] certs: Fix Kconfig dependency
Date:   Mon, 4 Jul 2022 19:20:28 +0800
Message-ID: <20220704112028.183193-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_PKCS7_MESSAGE_PARSER=m and CONFIG_FIPS_SIGNATURE_SELFTEST=y,
make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-, will be failed, like this:

crypto/asymmetric_keys/selftest.o: In function `fips_signature_selftest':
selftest.c:(.init.text+0xc3): undefined reference to `pkcs7_parse_message'
selftest.c:(.init.text+0x101): undefined reference to `pkcs7_supply_detached_data'
selftest.c:(.init.text+0x112): undefined reference to `pkcs7_verify'
selftest.c:(.init.text+0x13f): undefined reference to `pkcs7_validate_trust'
selftest.c:(.init.text+0x169): undefined reference to `pkcs7_free_message'
make: *** [vmlinux] Error 1

To fix this error, add depends on PKCS7_MESSAGE_PARSER=y to FIPS_SIGNATURE_SELFTEST

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 3cde3174eb91 ("certs: Add FIPS selftests")
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
---
 crypto/asymmetric_keys/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index 3df3fe4ed95f..fe007db96c69 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -83,6 +83,6 @@ config FIPS_SIGNATURE_SELFTEST
 	  for FIPS.
 	depends on KEYS
 	depends on ASYMMETRIC_KEY_TYPE
-	depends on PKCS7_MESSAGE_PARSER
+	depends on PKCS7_MESSAGE_PARSER=y
 
 endif # ASYMMETRIC_KEY_TYPE
-- 
2.17.1

