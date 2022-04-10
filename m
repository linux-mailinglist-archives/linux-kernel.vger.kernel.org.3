Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1404FAB56
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 03:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbiDJBYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 21:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiDJBYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 21:24:06 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FDE1149;
        Sat,  9 Apr 2022 18:21:56 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1ndMGq-000zpF-Oj; Sun, 10 Apr 2022 11:21:42 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sun, 10 Apr 2022 09:21:41 +0800
Date:   Sun, 10 Apr 2022 09:21:41 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sam Ravnborg <sam@ravnborg.org>, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2] sparc: cacheflush_32.h needs struct page
Message-ID: <YlIxJWek5a4wB8Jt@gondor.apana.org.au>
References: <20220409151609.3715-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409151609.3715-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2022 at 08:16:09AM -0700, Randy Dunlap wrote:
> Add a struct page forward declaration to cacheflush_32.h.
> Fixes this build warning:
> 
>   CC      drivers/crypto/xilinx/zynqmp-sha.o
> In file included from ../arch/sparc/include/asm/cacheflush.h:11,
>                  from ../include/linux/cacheflush.h:5,
>                  from ../drivers/crypto/xilinx/zynqmp-sha.c:6:
> ../arch/sparc/include/asm/cacheflush_32.h:38:37: warning: 'struct page' declared inside parameter list will not be visible outside of this definition or declaration
>    38 | void sparc_flush_page_to_ram(struct page *page);
> 
> Exposed by commit 0e03b8fd2936
> ("crypto: xilinx - Turn SHA into a tristate and allow COMPILE_TEST")
> but not Fixes: that commit.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: sparclinux@vger.kernel.org
> ---
> v2: use forward declaration instead of adding <linux/mm.h> (Sam)
> 
>  arch/sparc/include/asm/cacheflush_32.h |    1 +
>  1 file changed, 1 insertion(+)

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
