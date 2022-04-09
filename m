Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50894FA93A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 17:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241593AbiDIPS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 11:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242429AbiDIPSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 11:18:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2499D2632;
        Sat,  9 Apr 2022 08:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=DWJgIpccgAwiD7TVhNFpkZOWqtVX9h8FRKAluJQvIhU=; b=2GCyGWBHoZwI1xTAyiCq4XPl0x
        omnN5J0sdbTSBIVxm207lFJBJ7pWbWs3HAIG1e9jzvELgpJfFHRa39UASiRTRTyP7UAYxk1TUbjut
        /mjz+U2qbbJlwv04Yvuob96ouAT1exFqTYhMZ7WjWVFYaW4Hu3GevtEmk2ClMuQBddXygY0fB23lU
        gjq4gb7jpW0mjGQBFWKAKBh90EJV294iCLv7mHfNKmr7cxHTcvWCkLpLn/m3lsGZJtsQumGCR0uiK
        yZSo4zJpM5wEoFNYuMsARpjsf24+HxNYXkCk5evL6wdvvPgvadyxaihVQW9wBv9asWfU50IFA6tPO
        Bndolyiw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndCos-003O0g-NJ; Sat, 09 Apr 2022 15:16:10 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Sam Ravnborg <sam@ravnborg.org>, sparclinux@vger.kernel.org
Subject: [PATCH v2] sparc: cacheflush_32.h needs struct page
Date:   Sat,  9 Apr 2022 08:16:09 -0700
Message-Id: <20220409151609.3715-1-rdunlap@infradead.org>
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

Add a struct page forward declaration to cacheflush_32.h.
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
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: sparclinux@vger.kernel.org
---
v2: use forward declaration instead of adding <linux/mm.h> (Sam)

 arch/sparc/include/asm/cacheflush_32.h |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/sparc/include/asm/cacheflush_32.h
+++ b/arch/sparc/include/asm/cacheflush_32.h
@@ -35,6 +35,7 @@
 #define flush_page_for_dma(addr) \
 	sparc32_cachetlb_ops->page_for_dma(addr)
 
+struct page;
 void sparc_flush_page_to_ram(struct page *page);
 
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
