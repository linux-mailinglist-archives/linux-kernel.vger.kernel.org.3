Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA014D2693
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiCIDXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 22:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiCIDXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 22:23:49 -0500
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D626DE4;
        Tue,  8 Mar 2022 19:22:52 -0800 (PST)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nRmuL-0002xZ-Oe; Wed, 09 Mar 2022 14:22:38 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 09 Mar 2022 15:22:37 +1200
Date:   Wed, 9 Mar 2022 15:22:37 +1200
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     davem@davemloft.net, harsha.harsha@xilinx.com,
        kalyani.akula@xilinx.com, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: xilinx: prevent probing on non-xilinx hardware
Message-ID: <Yigdfa9Is4o8r5pA@gondor.apana.org.au>
References: <20220304073648.972270-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304073648.972270-1-clabbe@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 07:36:48AM +0000, Corentin Labbe wrote:
> The zynqmp-sha driver is always loaded and register its algorithm even on
> platform which do not have the proper hardware.
> This lead to a stacktrace due to zynqmp-sha3-384 failing its crypto
> self tests.
> So check if hardware is present via the firmware API call get_version.
> 
> While at it, simplify the platform_driver by using module_platform_driver()
> 
> Furthermore the driver should depend on ZYNQMP_FIRMWARE since it cannot
> work without it.
> 
> Fixes: 7ecc3e34474b ("crypto: xilinx - Add Xilinx SHA3 driver")
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  drivers/crypto/Kconfig             |  2 +-
>  drivers/crypto/xilinx/zynqmp-sha.c | 35 +++++++-----------------------
>  2 files changed, 9 insertions(+), 28 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
