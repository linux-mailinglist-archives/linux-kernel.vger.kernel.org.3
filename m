Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5DC947A535
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 07:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237510AbhLTG52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 01:57:28 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41884 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbhLTG51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 01:57:27 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BK6vA69050155;
        Mon, 20 Dec 2021 00:57:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639983430;
        bh=34K0ObKN4Gi3tCKmWNs+0rWwZp0erVuQ1EhAy6igolA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=I1VOdzndFmrbvzIxVPBo2FWSqPD4O344Tpxix8iWvxSBsoquEdrcrhb43KELsv2TJ
         EEfuaDM+74K+LRGmq9uj+gq2ikWLM0q7vqWAsrtjIBtNGyWy7KhuxIBNU3il0asFWk
         3W+Ko+EdG+im/c9QfovqjKK8WoXfe+DSuuhOyl+o=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BK6v9hF121018
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Dec 2021 00:57:09 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Dec 2021 00:57:09 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Dec 2021 00:57:09 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BK6v6Pc118421;
        Mon, 20 Dec 2021 00:57:07 -0600
Subject: Re: [PATCH] mux: add missing mux_state_get
To:     Peter Rosin <peda@axentia.se>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
References: <20211202124053.2835-1-a-govindraju@ti.com>
 <59c57ab7-a272-b925-befc-79f88c925e3c@axentia.se>
 <af642da8-a9e1-6d3a-a928-8a514f1c5eb0@axentia.se>
 <773b9424-a1c7-1955-886c-de36299a6873@axentia.se>
 <031e134d-dbe3-0f39-3e63-647d0efa1576@axentia.se>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <238c5e18-1b1e-9f9c-8c96-f25bd7f7f838@ti.com>
Date:   Mon, 20 Dec 2021 12:27:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <031e134d-dbe3-0f39-3e63-647d0efa1576@axentia.se>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19/12/21 12:07 am, Peter Rosin wrote:
> And implement devm_mux_state_get in terms of the new function.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

Tested-by: Aswath Govindraju <a-govindraju@ti.com>

Thanks,
Aswath

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
>  
>  	ptr = devres_alloc(devm_mux_state_release, sizeof(*ptr), GFP_KERNEL);
>  	if (!ptr)
>  		return ERR_PTR(-ENOMEM);
>  
> -	mux_ctrl = mux_get(dev, mux_name, &state);
> -	if (IS_ERR(mux_ctrl)) {
> +	mstate = mux_state_get(dev, mux_name);
> +	if (IS_ERR(mstate)) {
>  		devres_free(ptr);
> -		return (struct mux_state *)mux_ctrl;
> +		return mstate;
>  	}
>  
> -	mstate->mux = mux_ctrl;
> -	mstate->state = state;
>  	*ptr = mstate;
>  	devres_add(dev, ptr);
>  
> diff --git a/include/linux/mux/consumer.h b/include/linux/mux/consumer.h
> index babf2a744056..944678604549 100644
> --- a/include/linux/mux/consumer.h
> +++ b/include/linux/mux/consumer.h
> @@ -54,6 +54,7 @@ int mux_control_deselect(struct mux_control *mux);
>  int mux_state_deselect(struct mux_state *mstate);
>  
>  struct mux_control *mux_control_get(struct device *dev, const char *mux_name);
> +struct mux_state *mux_state_get(struct device *dev, const char *mux_name);
>  void mux_control_put(struct mux_control *mux);
>  void mux_state_put(struct mux_state *mstate);
>  
> 

