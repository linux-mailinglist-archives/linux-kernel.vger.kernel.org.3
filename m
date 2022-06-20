Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261B55510DB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 09:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239024AbiFTHB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 03:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237913AbiFTHBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:01:55 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210FA6268
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 00:01:52 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:1949:b867:c4bf:a30a])
        by andre.telenet-ops.be with bizsmtp
        id lK1o2700t3sdbfl01K1o0j; Mon, 20 Jun 2022 09:01:49 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o3BPw-004lue-9r; Mon, 20 Jun 2022 09:01:48 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o3BPv-00Cg83-Mw; Mon, 20 Jun 2022 09:01:47 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        kernel test robot <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2] sh: Convert nommu io{re,un}map() to static inline functions
Date:   Mon, 20 Jun 2022 09:01:43 +0200
Message-Id: <8d1b1766260961799b04035e7bc39a7f59729f72.1655708312.git.geert+renesas@glider.be>
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
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
v2:
  - Add Acked-by, Reviewed-by.

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

