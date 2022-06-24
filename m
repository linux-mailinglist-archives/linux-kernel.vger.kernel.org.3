Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35B7559642
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiFXJOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiFXJOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:14:40 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2B54F1DA;
        Fri, 24 Jun 2022 02:14:39 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1o4fOc-00Ai3g-DM; Fri, 24 Jun 2022 19:14:35 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 24 Jun 2022 17:14:34 +0800
Date:   Fri, 24 Jun 2022 17:14:34 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        John Allen <john.allen@amd.com>, Rob Herring <robh@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] crypto: ccp - Fix device IRQ counting by using
 platform_irq_count()
Message-ID: <YrWAen2cJvveBx+B@gondor.apana.org.au>
References: <bf04adfd1dae519cb9377bcc7222089399690a22.1655147787.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf04adfd1dae519cb9377bcc7222089399690a22.1655147787.git.thomas.lendacky@amd.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 02:16:27PM -0500, Tom Lendacky wrote:
> The ccp driver loops through the platform device resources array to get
> the IRQ count for the device. With commit a1a2b7125e10 ("of/platform: Drop
> static setup of IRQ resource from DT core"), the IRQ resources are no
> longer stored in the platform device resource array. As a result, the IRQ
> count is now always zero. This causes the driver to issue a second call to
> platform_get_irq(), which fails if the IRQ count is really 1, causing the
> loading of the driver to fail.
> 
> Replace looping through the resources array to count the number of IRQs
> with a call to platform_irq_count().
> 
> Fixes: a1a2b7125e10 ("of/platform: Drop static setup of IRQ resource from DT core")
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  drivers/crypto/ccp/sp-platform.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
