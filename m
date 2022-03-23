Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847FE4E4B84
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 04:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241535AbiCWDgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 23:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbiCWDgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 23:36:49 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788FF7087E;
        Tue, 22 Mar 2022 20:35:19 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nWrmB-0003Nm-JV; Wed, 23 Mar 2022 14:35:12 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 23 Mar 2022 15:35:10 +1200
Date:   Wed, 23 Mar 2022 15:35:10 +1200
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Harsha <harsha.harsha@xilinx.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] cacheflush.h: Add forward declaration for struct folio
Message-ID: <YjqVblTmjNYl3Zjc@gondor.apana.org.au>
References: <Yigc4cQlTJRRZsQg@gondor.apana.org.au>
 <20220322131327.GA747088@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322131327.GA747088@roeck-us.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 06:13:27AM -0700, Guenter Roeck wrote:
> On Wed, Mar 09, 2022 at 03:20:01PM +1200, Herbert Xu wrote:
> > This patch turns the new SHA driver into a tristate and also allows
> > compile testing.
> > 
> > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> This results in:
> 
> Building s390:allmodconfig ... failed
> --------------
> Error log:
> In file included from drivers/crypto/xilinx/zynqmp-sha.c:6:
> include/linux/cacheflush.h:12:46: error: 'struct folio' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
>    12 | static inline void flush_dcache_folio(struct folio *folio)

This should be fixed in cacheflush.h:

---8<---
The struct folio is not declared in cacheflush.h so we need to
provide a forward declaration as otherwise users of this header
file may get warnings.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 522a0032af00 ("Add linux/cacheflush.h")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/include/linux/cacheflush.h b/include/linux/cacheflush.h
index fef8b607f97e..a6189d21f2ba 100644
--- a/include/linux/cacheflush.h
+++ b/include/linux/cacheflush.h
@@ -4,6 +4,8 @@
 
 #include <asm/cacheflush.h>
 
+struct folio;
+
 #if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
 #ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO
 void flush_dcache_folio(struct folio *folio);
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
