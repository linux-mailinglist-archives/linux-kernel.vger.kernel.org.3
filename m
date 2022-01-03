Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9745748311B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 13:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiACMmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 07:42:09 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:51512 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiACMmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 07:42:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9BB80CE0FB6
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 12:42:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4EFC36AEB;
        Mon,  3 Jan 2022 12:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641213725;
        bh=y3Hz66uJnIA+3fLaJuXQl5Lm6dRMG2pa3SX2VYmbK6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MXBHpMnSLag83ebaOLnt22e0bgPE9NLrLvACZtSFlE0z19UD0xgSSW8wXrVX8fuGb
         v6vgaMaziszpHN3fY0o2JzPNXwCwyF9g3IPlz8RoGtZKsO7X1++Zi0w3NWGPCoOQTB
         VGGCGb56r9KDKxUWCdbSp+IYDaRgHFqzYVewh+dA=
Date:   Mon, 3 Jan 2022 13:42:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Aswath Govindraju <a-govindraju@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] mux: add missing mux_state_get
Message-ID: <YdLvGge5SbuhAi3N@kroah.com>
References: <94ab71e1-2e68-def2-95b8-33162172f65c@axentia.se>
 <90c40462-9672-949a-14cd-e13e440fe177@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90c40462-9672-949a-14cd-e13e440fe177@axentia.se>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2022 at 11:38:36PM +0100, Peter Rosin wrote:
> From: Peter Rosin <peda@axentia.se>
> 
> And implement devm_mux_state_get in terms of the new function.
> 
> Tested-by: Aswath Govindraju <a-govindraju@ti.com>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/mux/core.c           | 41 ++++++++++++++++++++++++++----------
>  include/linux/mux/consumer.h |  1 +
>  2 files changed, 31 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mux/core.c b/drivers/mux/core.c
> index 7d38e7c0c02e..90073ce01539 100644
> --- a/drivers/mux/core.c
> +++ b/drivers/mux/core.c
> @@ -673,6 +673,33 @@ struct mux_control *devm_mux_control_get(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_mux_control_get);
>  
> +/**
> + * mux_state_get() - Get the mux-state for a device.
> + * @dev: The device that needs a mux-state.
> + * @mux_name: The name identifying the mux-state.
> + *
> + * Return: A pointer to the mux-state, or an ERR_PTR with a negative errno.
> + */
> +struct mux_state *mux_state_get(struct device *dev, const char *mux_name)
> +{
> +	struct mux_state *mstate;
> +
> +	mstate = kzalloc(sizeof(*mstate), GFP_KERNEL);
> +	if (!mstate)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mstate->mux = mux_get(dev, mux_name, &mstate->state);

will this build?  I haven't applied it but mux_get() in my tree right
now is defined as:
	static inline void mux_get(struct gsm_mux *gsm)



> +	if (IS_ERR(mstate->mux)) {
> +		int err = PTR_ERR(mstate->mux);
> +
> +		kfree(mstate);
> +		return ERR_PTR(err);
> +	}
> +
> +	return mstate;
> +}
> +EXPORT_SYMBOL_GPL(mux_state_get);

No need to export it or make it global if no one is using it, right?

Also, who frees this new memory you just allocated?

> +
>  /**
>   * mux_state_put() - Put away the mux-state for good.
>   * @mstate: The mux-state to put away.
> @@ -705,25 +732,17 @@ struct mux_state *devm_mux_state_get(struct device *dev,
>  				     const char *mux_name)
>  {
>  	struct mux_state **ptr, *mstate;
> -	struct mux_control *mux_ctrl;
> -	int state;
> -
> -	mstate = devm_kzalloc(dev, sizeof(struct mux_state), GFP_KERNEL);
> -	if (!mstate)
> -		return ERR_PTR(-ENOMEM);

Before this state memory was here, assigned to the device, so it was
freed when the device was unbound.  I'm missing where this now
happens...

thanks,

greg k-h
