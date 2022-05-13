Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83324525B94
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377373AbiEMG0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377309AbiEMG0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:26:24 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB83275CF;
        Thu, 12 May 2022 23:26:21 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id F3FD0201409;
        Fri, 13 May 2022 06:26:05 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 18A7B80914; Fri, 13 May 2022 08:18:30 +0200 (CEST)
Date:   Fri, 13 May 2022 08:18:30 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] random: credit architectural init the exact amount
Message-ID: <Yn34NiJUnZOgK99X@owl.dominikbrodowski.net>
References: <20220512133835.102028-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512133835.102028-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, May 12, 2022 at 03:38:35PM +0200 schrieb Jason A. Donenfeld:
> RDRAND and RDSEED can fail sometimes, which is fine. We currently
> initialize the RNG with 512 bits of RDRAND/RDSEED. We only need 256 bits
> of those to succeed in order to initialize the RNG. Instead of the
> current "all or nothing" approach, actually credit these contributions
> the amount that is actually contributed.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index bd80d74a7f8c..9ffa41c5e092 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -934,9 +934,8 @@ static struct notifier_block pm_notifier = { .notifier_call = random_pm_notifica
>   */
>  int __init random_init(const char *command_line)
>  {
> -	size_t i;
>  	ktime_t now = ktime_get_real();
> -	bool arch_init = true;
> +	unsigned int i, arch_init;

Maybe s/arch_init/arch_init_cnt/g to clarify that this is now used as a
counter?

Otherwise, looks good:

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
