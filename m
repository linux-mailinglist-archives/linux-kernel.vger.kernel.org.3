Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92244FEB7C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiDLXcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiDLXb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:31:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C468FE76;
        Tue, 12 Apr 2022 15:17:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7B5EB82052;
        Tue, 12 Apr 2022 21:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C00C385A5;
        Tue, 12 Apr 2022 21:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649799734;
        bh=Qh6+GqKN5meXd+LrkS0vT//U/JIDvmn9UR+juFg+GOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BNWc2i8NJ+1xk3Yc5bV/Y4/0DVgsiI/qFCzSa6+4eaO/L0OOYDqRIKL8eCEU7JK6N
         v8iObN66NfBfCTlbiBuRNpdNXoMXG6e5AztgPW2fI7e7Fx0r/ZsEoCyl7UWTXjp1p6
         /ZPQJffSRcbFZMpZBKDIQek+1HsyHqh5YlZL5wFfUDvWi1RObgDeq1q2rbazpvzgNS
         we9pmNCoho5u+Fh8ddWbULv6+PDMWIXFlaAMC0UGqCm5JjBFaOMjzvG5mOCwLJR/ts
         1rFZBGeePi9JcTqg/VIH4gbPoSWMsAHDOIbB0e8s9pORF3itl+TErmZaJCmVDjQVeW
         ertRqqXzWy5aA==
Date:   Tue, 12 Apr 2022 14:42:11 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        ndesaulniers@google.com, sven@svenpeter.dev, alyssa@rosenzweig.io,
        marcan@marcan.st, martink@posteo.de, saranya.gopal@intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] usb: typec: tipd: improve handling of failures in
 interrupt handlers
Message-ID: <YlXyM7e+Bkqa3HCZ@dev-arch.thelio-3990X>
References: <20220409130013.1474412-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409130013.1474412-1-trix@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

Thanks for the patch!

On Sat, Apr 09, 2022 at 09:00:13AM -0400, Tom Rix wrote:
> clang static analysis reports this representative issue
> core.c:516:6: warning: Branch condition evaluates
>   to a garbage value
>   if (event)
>       ^~~~~
> 
> In cd321x_interrupt(), a successful call to
> tps6598x_read64() is the only way event is set,
> and if a failure happens the irq should not be
> reported as handled.
> 
> Instead of initializing event, rework the
> usage of ret by initializing it to IRQ_NONE
> and then setting it when event is known to
> be not zero.  This removes the if-statement
> before the return.
> 
> tps6598x_interrupt() is similar.
> 
> Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")

I am not sure this fixes tag is accurate. At that point in time,
tps6598x_interrupt() did not have any use of event1 or event2 that was
uninitialized.

I think

Fixes: c7260e29dd20 ("usb: typec: tipd: Add short-circuit for no irqs")
Fixes: 45188f27b3d0 ("usb: typec: tipd: Add support for Apple CD321X")

is a more accurate set, as these changes made it possible for the event
variables to be used uninitialized.

> Signed-off-by: Tom Rix <trix@redhat.com>

I found one issue below. With that addressed, feel free to carry
forward:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  drivers/usb/typec/tipd/core.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 16b4560216ba..88a20cc15da4 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -478,12 +478,11 @@ static irqreturn_t cd321x_interrupt(int irq, void *data)
>  	struct tps6598x *tps = data;
>  	u64 event;
>  	u32 status;
> -	int ret;
> +	int ret = IRQ_NONE;
>  
>  	mutex_lock(&tps->lock);
>  
> -	ret = tps6598x_read64(tps, TPS_REG_INT_EVENT1, &event);
> -	if (ret) {
> +	if (tps6598x_read64(tps, TPS_REG_INT_EVENT1, &event)) {
>  		dev_err(tps->dev, "%s: failed to read events\n", __func__);
>  		goto err_unlock;
>  	}
> @@ -492,6 +491,8 @@ static irqreturn_t cd321x_interrupt(int irq, void *data)
>  	if (!event)
>  		goto err_unlock;
>  
> +	ret = IRQ_HANDLED;
> +
>  	if (!tps6598x_read_status(tps, &status))
>  		goto err_clear_ints;
>  
> @@ -513,9 +514,7 @@ static irqreturn_t cd321x_interrupt(int irq, void *data)
>  err_unlock:
>  	mutex_unlock(&tps->lock);
>  
> -	if (event)
> -		return IRQ_HANDLED;
> -	return IRQ_NONE;
> +	return ret;
>  }
>  
>  static irqreturn_t tps6598x_interrupt(int irq, void *data)
> @@ -524,13 +523,12 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
>  	u64 event1;
>  	u64 event2;
>  	u32 status;
> -	int ret;
> +	int ret = IRQ_NONE;
>  
>  	mutex_lock(&tps->lock);
>  
> -	ret = tps6598x_read64(tps, TPS_REG_INT_EVENT1, &event1);
> -	ret |= tps6598x_read64(tps, TPS_REG_INT_EVENT2, &event2);
> -	if (ret) {
> +	if (tps6598x_read64(tps, TPS_REG_INT_EVENT1, &event1) ||
> +	    tps6598x_read64(tps, TPS_REG_INT_EVENT2, &event2)) {

This change is incorrect. If the first tps6598x_read64() call succeeds,
then the second tps6598x_read64() will not be called, which would leave
event2 uninitialized. This should be a bitwise OR so that both calls to
tps6598x_read64() occur.

>  		dev_err(tps->dev, "%s: failed to read events\n", __func__);
>  		goto err_unlock;
>  	}
> @@ -539,6 +537,8 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
>  	if (!(event1 | event2))
>  		goto err_unlock;
>  
> +	ret = IRQ_HANDLED;
> +
>  	if (!tps6598x_read_status(tps, &status))
>  		goto err_clear_ints;
>  
> @@ -561,9 +561,7 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
>  err_unlock:
>  	mutex_unlock(&tps->lock);
>  
> -	if (event1 | event2)
> -		return IRQ_HANDLED;
> -	return IRQ_NONE;
> +	return ret;
>  }
>  
>  static int tps6598x_check_mode(struct tps6598x *tps)
> -- 
> 2.27.0
> 
> 
