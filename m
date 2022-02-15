Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485404B668F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbiBOIvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:51:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiBOIvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:51:22 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BF4113AC1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 00:51:11 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:8c73:faf1:1d11:4a47])
        by andre.telenet-ops.be with bizsmtp
        id vLr72600J3BmCM301Lr7lU; Tue, 15 Feb 2022 09:51:09 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nJtYB-000rJO-4t; Tue, 15 Feb 2022 09:51:07 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nJtYA-00AkYi-Ko; Tue, 15 Feb 2022 09:51:06 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        kernel test robot <lkp@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] sh: Convert nommu io{re,un}map() to static inline functions
Date:   Tue, 15 Feb 2022 09:51:05 +0100
Message-Id: <4ed0a7a0d3fa912a5b44c451884818f2c138ef42.1644914600.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, nommu iounmap() was converted from a static inline function to
a macro again, basically reverting commit 4580ba4ad2e6b8dd ("sh: Convert
iounmap() macros to inline functions").  With -Werror, this leads to
build failures like:

    drivers/iio/adc/xilinx-ams.c: In function ‘ams_iounmap_ps’:
    drivers/iio/adc/xilinx-ams.c:1195:14: error: unused variable ‘ams’ [-Werror=unused-variable]
     1195 |  struct ams *ams = data;
	  |              ^~~

Fix this by replacing the macros for ioremap() and iounmap() by static
inline functions, based on <asm-generic/io.h>.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Fixes: 13f1fc870dd74713 ("sh: move the ioremap implementation out of line")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This is actually the third time this change was made, as Christoph
converted iounmap() to a macro before in commit 98c90e5ea34e98bd ("sh:
remove __iounmap"), reverting commit 733f0025f0fb43e3 ("sh: prevent
warnings when using iounmap").

Probably sh-nommu should include <asm-generic/io.h>, but that would
require a lot more changes.
---
 arch/sh/include/asm/io.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index cf9a3ec32406f856..fba90e670ed41d48 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -271,8 +271,12 @@ static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
 #endif /* CONFIG_HAVE_IOREMAP_PROT */
 
 #else /* CONFIG_MMU */
-#define iounmap(addr)		do { } while (0)
-#define ioremap(offset, size)	((void __iomem *)(unsigned long)(offset))
+static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
+{
+	return (void __iomem *)(unsigned long)offset;
+}
+
+static inline void iounmap(volatile void __iomem *addr) { }
 #endif /* CONFIG_MMU */
 
 #define ioremap_uc	ioremap
-- 
2.25.1

