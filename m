Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37FE4CB38B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 01:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiCCAAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 19:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiCCAAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:00:46 -0500
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD804D9CF;
        Wed,  2 Mar 2022 15:59:53 -0800 (PST)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nPXwE-0006DT-Lo; Thu, 03 Mar 2022 09:59:19 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 03 Mar 2022 10:59:18 +1200
Date:   Thu, 3 Mar 2022 10:59:18 +1200
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Harsha <harsha.harsha@xilinx.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        michals@xilinx.com, saratcha@xilinx.com, harshj@xilinx.com,
        git@xilinx.com
Subject: Re: [PATCH V3 0/4] crypto: Add Xilinx ZynqMP SHA3 driver support
Message-ID: <Yh/2xoWQ1Ogq69y7@gondor.apana.org.au>
References: <1645612504-3047-1-git-send-email-harsha.harsha@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645612504-3047-1-git-send-email-harsha.harsha@xilinx.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 04:05:00PM +0530, Harsha wrote:
> This patch set does the following:
>   - Updates the Makefile for xilinx subdirectory
>   - Adds communication layer support for sha_hash in zynqmp.c
>   - Adds Xilinx ZynqMP driver for SHA3 Algorithm
>   - Updates the list of MAINTAINERS
> 
> Following tests have been done for the driver:
>  - Enabled kernel self tests and extra run-time crypto self tests
>  - Tested SHA hash computation for different sizes of data using
>    userspace application
>  - Tested SHA hash computation using multiple updates of data using
>    userspace application
>  - Tested parallel hash computation
>  - Tested using the tcrypt module
> 
> V3 changes:
> Added details of tests in cover letter
> Added SOB for previous poster of RFC patch
> Removed module_platform_driver in 3/4
> Used memzero_explicit instead of memset in 3/4
> 
> V2 changes:
> - Removed dependency on COMPILE_TEST in 3/4
> - Rebased this patchset on latest Cryptodev-2.6 tree which fixed
> below kernel robot warning
>    In file included from ./arch/s390/include/generated/asm/cacheflush.h:1,
>                     from drivers/crypto/xilinx/zynqmp-sha.c:6:
> include/asm-generic/cacheflush.h:53:46: warning: 'struct folio' declared
> inside parameter list will not be visible outside of this definition
> or declaration
>       53 | static inline void flush_dcache_folio(struct folio *folio) { }
>          |
> - Included linux/cacheflush.h instead of asm/cacheflush.h in 3/4
>  
> V1 changes:
> - Converted RFC patch to PATCH
> - Updated zynqmp-sha driver so that it can be self discovered 
> - Removed patch 3/6 and 4/6 as they added support for device tree
> - Substituted hw with hardware in drivers/crypto/Kconfig
> 
> 
> Harsha (4):
>   drivers: crypto: Updated Makefile for xilinx subdirectory
>   firmware: xilinx: Add ZynqMP SHA API for SHA3 functionality
>   crypto: xilinx: Add Xilinx SHA3 driver
>   MAINTAINERS: Add maintainer for Xilinx ZynqMP SHA3 driver
> 
>  MAINTAINERS                          |   5 +
>  drivers/crypto/Kconfig               |  10 ++
>  drivers/crypto/Makefile              |   2 +-
>  drivers/crypto/xilinx/Makefile       |   1 +
>  drivers/crypto/xilinx/zynqmp-sha.c   | 283 +++++++++++++++++++++++++++++++++++
>  drivers/firmware/xilinx/zynqmp.c     |  26 ++++
>  include/linux/firmware/xlnx-zynqmp.h |   8 +
>  7 files changed, 334 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/crypto/xilinx/zynqmp-sha.c

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
