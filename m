Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59774CB380
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 01:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiCCAAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 19:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiCCAAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:00:47 -0500
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1793E0C5;
        Wed,  2 Mar 2022 15:59:56 -0800 (PST)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nPXv9-0006BV-Q7; Thu, 03 Mar 2022 09:58:12 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 03 Mar 2022 10:58:11 +1200
Date:   Thu, 3 Mar 2022 10:58:11 +1200
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     davem@davemloft.net, jglauber@cavium.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: cavium: zip: register algorithm only if hardware
 is present
Message-ID: <Yh/2g3ckIk5K1Ctb@gondor.apana.org.au>
References: <20220221115234.2544665-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221115234.2544665-1-clabbe@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 11:52:34AM +0000, Corentin Labbe wrote:
> On my renesas salavator-X, I saw some cavium driver failing crypto
> self-tests.
> But salvator does not have such hardware.
> This is due to cavium/zip driver registering algorithms even if hardware
> is not present.
> The solution is to move algorithm registration in the probe function.
> This permits also to simplify module init/exit by using
> module_pci_driver.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> 
> WARNING: this is boot tested only on salvator-X to be sure that the
> cavium/zip driver no longer registers algorithms.
> I do not have any cavium hardware unfortunatly.
> 
>  drivers/crypto/cavium/zip/zip_main.c | 83 ++++++++++++----------------
>  1 file changed, 35 insertions(+), 48 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
