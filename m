Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6098B5AFC6A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiIGGaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiIGG3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:29:54 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C81183BC;
        Tue,  6 Sep 2022 23:29:37 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oVoYj-001uKt-VX; Wed, 07 Sep 2022 16:29:15 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 07 Sep 2022 14:29:13 +0800
Date:   Wed, 7 Sep 2022 14:29:13 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Sven van Ashbrook <svenva@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alex Levin <levinale@google.com>,
        Rajat Jain <rajatja@google.com>,
        Andrey Pronin <apronin@google.com>,
        Stephen Boyd <swboyd@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Biggers <ebiggers@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Olivia Mackall <olivia@selenic.com>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v1 2/2] hwrng: core: fix potential suspend/resume race
 condition
Message-ID: <Yxg6OayyEFWIax/r@gondor.apana.org.au>
References: <20220831172024.1613208-1-svenva@chromium.org>
 <20220831172024.1613208-2-svenva@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831172024.1613208-2-svenva@chromium.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 05:20:24PM +0000, Sven van Ashbrook wrote:
> The hwrng fill function runs as a normal kthread. This thread
> doesn't get frozen by the PM, i.e. it will keep running during,
> or in, system suspend. It may call the client driver's
> data_present()/data_read() functions during, or in, suspend;
> which may generate errors or warnings. For example, if the
> client driver uses an i2c bus, the following warning may be
> intermittently generated:
> 
>   i2c: Transfer while suspended
> 
> Fix by converting the delay polled kthread into an ordered work
> queue running a single, self-rearming delayed_work. Make the
> workqueue WQ_FREEZABLE, so the PM will drain any work items
> before going into suspend. This prevents client drivers from
> being accessed during, or in, suspend.
> 
> Tested on a Chromebook containing an cr50 tpm over i2c. The test
> consists of 31000 suspend/resume cycles. Occasional
> "i2c: Transfer while suspended" warnings are seen. After applying
> this patch, these warnings disappear.
> 
> This patch also does not appear to cause any regressions on the
> ChromeOS test queues.
> 
> Signed-off-by: Sven van Ashbrook <svenva@chromium.org>

The general concept seems to be fine.

> -		if (rc <= 0) {
> -			pr_warn("hwrng: no data available\n");
> -			msleep_interruptible(10000);
> -			continue;
> -		}
> +	if (!quality)
> +		return;
>  
> +	if (rc > 0) {
>  		/* If we cannot credit at least one bit of entropy,
>  		 * keep track of the remainder for the next iteration
>  		 */

You need to refresh your patch-set against the latest tree.  This
function has changed quite a bit.


> @@ -541,14 +536,12 @@ static void hwrng_manage_rngd(struct hwrng *rng)
>  	if (WARN_ON(!mutex_is_locked(&rng_mutex)))
>  		return;
>  
> -	if (rng->quality == 0 && hwrng_fill)
> -		kthread_stop(hwrng_fill);
> -	if (rng->quality > 0 && !hwrng_fill) {
> -		hwrng_fill = kthread_run(hwrng_fillfn, NULL, "hwrng");
> -		if (IS_ERR(hwrng_fill)) {
> -			pr_err("hwrng_fill thread creation failed\n");
> -			hwrng_fill = NULL;
> -		}
> +	if (rng->quality == 0 && is_hwrng_wq_running) {
> +		cancel_delayed_work(&hwrng_fill_dwork);
> +		is_hwrng_wq_running = false;
> +	} else if (rng->quality > 0 && !is_hwrng_wq_running) {
> +		mod_delayed_work(hwrng_wq, &hwrng_fill_dwork, 0);
> +		is_hwrng_wq_running = true;
>  	}
>  }
>  
> @@ -631,8 +624,7 @@ void hwrng_unregister(struct hwrng *rng)
>  	new_rng = get_current_rng_nolock();
>  	if (list_empty(&rng_list)) {
>  		mutex_unlock(&rng_mutex);
> -		if (hwrng_fill)
> -			kthread_stop(hwrng_fill);
> +		cancel_delayed_work_sync(&hwrng_fill_dwork);

What if hwrng_manage_rngd races against hwrng_unregister?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
