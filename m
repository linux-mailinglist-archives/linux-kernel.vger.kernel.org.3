Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8573C4FAA16
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 20:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242968AbiDISHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 14:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238956AbiDISHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 14:07:20 -0400
Received: from mx1.smtp.larsendata.com (mx1.smtp.larsendata.com [91.221.196.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF3E14004
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 11:05:11 -0700 (PDT)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
        by mx1.smtp.larsendata.com (Halon) with ESMTPS
        id 9aa8bf1d-b82f-11ec-8da1-0050568c148b;
        Sat, 09 Apr 2022 18:05:13 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sam@ravnborg.org)
        by mail01.mxhotel.dk (Postfix) with ESMTPSA id 915E1194B94;
        Sat,  9 Apr 2022 20:05:12 +0200 (CEST)
Date:   Sat, 9 Apr 2022 20:05:06 +0200
X-Report-Abuse-To: abuse@mxhotel.dk
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH v2] sparc: cacheflush_32.h needs struct page
Message-ID: <YlHK0rHVcppQSG8L@ravnborg.org>
References: <20220409151609.3715-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409151609.3715-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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
Acked-by: Sam Ravnborg <sam@ravnborg.org>

> ---
> v2: use forward declaration instead of adding <linux/mm.h> (Sam)
> 
>  arch/sparc/include/asm/cacheflush_32.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/arch/sparc/include/asm/cacheflush_32.h
> +++ b/arch/sparc/include/asm/cacheflush_32.h
> @@ -35,6 +35,7 @@
>  #define flush_page_for_dma(addr) \
>  	sparc32_cachetlb_ops->page_for_dma(addr)
>  
> +struct page;
>  void sparc_flush_page_to_ram(struct page *page);
>  
>  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
