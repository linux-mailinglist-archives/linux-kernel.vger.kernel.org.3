Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0733D51E444
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 07:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378483AbiEGF3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 01:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343722AbiEGF33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 01:29:29 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CC5186FA;
        Fri,  6 May 2022 22:25:42 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 2475NJLO010324;
        Sat, 7 May 2022 14:23:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 2475NJLO010324
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651901000;
        bh=tyBhf7vinz91xAdojDk/vHB9k4N+USKeN0boS3UKMi0=;
        h=From:To:Cc:Subject:Date:From;
        b=MyQqkfukocT4P6SYGHT9jyZdlJSEclUtI/bfhgZbIYQ5tjayEQa9Cg6OyS+Lj+a/J
         TP+64xIcG86oTCOuQat8leqB0WqsLtw5yeGEvsXs71/WGMDGVUahHqpsOFo2VXBbI/
         DV/MFv7PgLeMLuh83hbxX8WuU2vP4R88esyLH3CFe2W16wqCix0Jd6e6XiJZghowEF
         YMcas1Ab9Q7fg08rTUgSQSfh34cxz7WEwxsYG9i3xykI4WvNOMLkJIwdCVnLThhkdX
         mAhZeaZdVP7GALzFOBSGGTbhigZ2BokpGf1Ngrhre4L34CZS4k6BOwv2HDA9VgRYZ3
         4i6U0iwtXly1A==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?UTF-8?q?Breno=20Leit=C3=A3o?= <leitao@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nayna Jain <nayna@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] crypto: vmx - Fix build error
Date:   Sat,  7 May 2022 14:22:43 +0900
Message-Id: <20220507052244.1426765-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I refactored this Makefile, I accidentally changed the CONFIG
option.

Fixes: b52455a73db9 ("crypto: vmx - Align the short log with Makefile cleanups")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/crypto/vmx/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/vmx/Makefile b/drivers/crypto/vmx/Makefile
index df93ba63b1cd..2560cfea1dec 100644
--- a/drivers/crypto/vmx/Makefile
+++ b/drivers/crypto/vmx/Makefile
@@ -3,7 +3,7 @@ obj-$(CONFIG_CRYPTO_DEV_VMX_ENCRYPT) += vmx-crypto.o
 vmx-crypto-objs := vmx.o aesp8-ppc.o ghashp8-ppc.o aes.o aes_cbc.o aes_ctr.o aes_xts.o ghash.o
 
 quiet_cmd_perl = PERL    $@
-      cmd_perl = $(PERL) $< $(if $(CONFIG_LITTLE_ENDIAN), linux-ppc64le, linux-ppc64) > $@
+      cmd_perl = $(PERL) $< $(if $(CONFIG_CPU_LITTLE_ENDIAN), linux-ppc64le, linux-ppc64) > $@
 
 targets += aesp8-ppc.S ghashp8-ppc.S
 
-- 
2.32.0

