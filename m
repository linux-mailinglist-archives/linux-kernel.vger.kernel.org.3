Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32414FA54A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 08:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239935AbiDIGE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 02:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiDIGEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 02:04:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E135E3221C4;
        Fri,  8 Apr 2022 23:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=smiL1RX2f47B2GeBUAyx7keJXXFGrb7ob2LG+/xBNFI=; b=jvs8++TGGZAgsbxLcoHOLjO8oS
        BfbWVPaqAKJj638koajoDkn/RxfZ8EUjWykn/TZjLmYcCoJ7o4718GwOgV8dm4vLUi7yzI5YfAxie
        TAZ/rE04176vOVYRkGV9pMrYvK3Lm4191XNwZzB9ThvkU3IJOZ0tnwrUatsbh9rYtkXizNfeg5Jwg
        MyFekmSIUBRtI86+Dz2WPi+leNR0LVLo7nNOOckzJNyRx4XveFbehxl+rmvNwdCRrPkjdKVLi1E5S
        UKhM4IgviInPehp/yDHteB8lElPlilgr67HRzmJCdLAK9LG/rxIqzRXhKFBJBby2iAodQAbLs3Wcd
        FeNMFBYQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nd4Aq-002OJk-Ng; Sat, 09 Apr 2022 06:02:16 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org
Subject: [PATCH] sparc: cacheflush_32.h needs <linux/mm.h>
Date:   Fri,  8 Apr 2022 23:02:15 -0700
Message-Id: <20220409060215.19890-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add <linux/mm.h> to cacheflush_32.h just as in cacheflush_64.h.
Fixes this build warning:

  CC      drivers/crypto/xilinx/zynqmp-sha.o
In file included from ../arch/sparc/include/asm/cacheflush.h:11,
                 from ../include/linux/cacheflush.h:5,
                 from ../drivers/crypto/xilinx/zynqmp-sha.c:6:
../arch/sparc/include/asm/cacheflush_32.h:38:37: warning: 'struct page' declared inside parameter list will not be visible outside of this definition or declaration
   38 | void sparc_flush_page_to_ram(struct page *page);

Exposed by commit 0e03b8fd2936
("crypto: xilinx - Turn SHA into a tristate and allow COMPILE_TEST")
but not Fixes: that commit.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David S. Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/include/asm/cacheflush_32.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/sparc/include/asm/cacheflush_32.h
+++ b/arch/sparc/include/asm/cacheflush_32.h
@@ -2,6 +2,8 @@
 #ifndef _SPARC_CACHEFLUSH_H
 #define _SPARC_CACHEFLUSH_H
 
+#include <linux/mm.h>
+
 #include <asm/cachetlb_32.h>
 
 #define flush_cache_all() \
