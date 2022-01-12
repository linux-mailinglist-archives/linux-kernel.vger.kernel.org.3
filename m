Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F367C48C559
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 14:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353823AbiALN7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 08:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241570AbiALN7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 08:59:00 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914D2C061751
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 05:59:00 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:76d0:2bff:fec8:549])
        by albert.telenet-ops.be with bizsmtp
        id hpyx2600Q0kcUhD06pyyov; Wed, 12 Jan 2022 14:58:58 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1n7e9R-009GVN-En; Wed, 12 Jan 2022 14:58:57 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1n7e9Q-000TvB-VF; Wed, 12 Jan 2022 14:58:56 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Srujana Challa <schalla@marvell.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] crypto: marvell - Fix platform dependency for CRYPTO_DEV_OCTEONTX2_CPT
Date:   Wed, 12 Jan 2022 14:58:55 +0100
Message-Id: <7c89454656dd825b38b0364bbb2a849554e6f57d.1641995837.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd pointed out that OcteonTX2 is Thunder, not ThunderX2
(ThunderX2 is CN99XX, formerly named Broadcom Vulcan).

Fixes: 42e6f351dcb05fd1 ("crypto: marvell - CRYPTO_DEV_OCTEONTX2_CPT should depend on ARCH_THUNDER2")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/crypto/marvell/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/marvell/Kconfig b/drivers/crypto/marvell/Kconfig
index 9125199f1702bbeb..3221a9d39dec604c 100644
--- a/drivers/crypto/marvell/Kconfig
+++ b/drivers/crypto/marvell/Kconfig
@@ -38,7 +38,7 @@ config CRYPTO_DEV_OCTEONTX_CPT
 
 config CRYPTO_DEV_OCTEONTX2_CPT
 	tristate "Marvell OcteonTX2 CPT driver"
-	depends on ARCH_THUNDER2 || COMPILE_TEST
+	depends on ARCH_THUNDER || COMPILE_TEST
 	depends on PCI_MSI && 64BIT
 	depends on CRYPTO_LIB_AES
 	depends on NET_VENDOR_MARVELL
-- 
2.25.1

