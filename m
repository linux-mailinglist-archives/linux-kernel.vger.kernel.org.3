Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593694D8623
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 14:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242003AbiCNNmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 09:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241979AbiCNNmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 09:42:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D48FDBC16;
        Mon, 14 Mar 2022 06:41:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BCC1ED1;
        Mon, 14 Mar 2022 06:41:25 -0700 (PDT)
Received: from [10.57.21.234] (unknown [10.57.21.234])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 394C03F7D7;
        Mon, 14 Mar 2022 06:41:24 -0700 (PDT)
Message-ID: <8529a647-6127-539f-20ba-271be293fe2f@arm.com>
Date:   Mon, 14 Mar 2022 13:41:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] thermal: devfreq_cooling: use local ops instead of global
 ops
Content-Language: en-US
To:     Kant Fan <kant@allwinnertech.com>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "supporter:THERMAL" <rafael@kernel.org>,
        "supporter:THERMAL" <daniel.lezcano@linaro.org>
References: <20220312045922.9779-1-kant@allwinnertech.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220312045922.9779-1-kant@allwinnertech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kant,

On 3/12/22 04:59, Kant Fan wrote:
> Fix access illegal address problem in following condition:
> There are muti devfreq cooling devices in system, some of them has
> em model but other does not, energy model ops such as state2power will
> append to global devfreq_cooling_ops when the cooling device with
> em model register. It makes the cooling device without em model
> also use devfreq_cooling_ops after appending when register later by
> of_devfreq_cooling_register_power() or of_devfreq_cooling_register().
> 
> IPA governor regards the cooling devices without em model as a power actor
> because they also have energy model ops, and will access illegal address
> at dfc->em_pd when execute cdev->ops->get_requested_power,
> cdev->ops->state2power or cdev->ops->power2state.
> 
> Signed-off-by: Kant Fan <kant@allwinnertech.com>

Thank you for finding this issue. This was also an issue since the
beginning of that code. The modified global ops after first registration
which went through, was also previously there. Thus, we would need two
different patches for stable kernels.

For this one, please add the tag:
Fixes: 615510fe13bd2 ("thermal: devfreq_cooling: remove old power model 
and use EM")

This patch would also go via stable tree for kernels v5.11+
Please read the process how to send a patch which will be merged to the
stable tree.

There will be a need to create another patch(es) for stable kernels with
Fixes: a76caf55e5b35 ("thermal: Add devfreq cooling")
In those kernels also the global ops is modified and might not support
properly many cooling devices. It's present in other stable kernels:
v5.10 and older

> ---
>   drivers/thermal/devfreq_cooling.c | 25 ++++++++++++++++++-------
>   1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
> index 4310cb342a9f..d38a80adec73 100644
> --- a/drivers/thermal/devfreq_cooling.c
> +++ b/drivers/thermal/devfreq_cooling.c
> @@ -358,21 +358,28 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
>   	struct thermal_cooling_device *cdev;
>   	struct device *dev = df->dev.parent;
>   	struct devfreq_cooling_device *dfc;
> +	struct thermal_cooling_device_ops *ops;
>   	char *name;
>   	int err, num_opps;
>   
> -	dfc = kzalloc(sizeof(*dfc), GFP_KERNEL);
> -	if (!dfc)
> +	ops = kmemdup(&devfreq_cooling_ops, sizeof(*ops), GFP_KERNEL);
> +	if (!ops)
>   		return ERR_PTR(-ENOMEM);
>   
> +	dfc = kzalloc(sizeof(*dfc), GFP_KERNEL);
> +	if (!dfc) {
> +		err = -ENOMEM;
> +		goto free_ops;
> +	}
> +
>   	dfc->devfreq = df;
>   
>   	dfc->em_pd = em_pd_get(dev);
>   	if (dfc->em_pd) {
> -		devfreq_cooling_ops.get_requested_power =
> +		ops->get_requested_power =
>   			devfreq_cooling_get_requested_power;
> -		devfreq_cooling_ops.state2power = devfreq_cooling_state2power;
> -		devfreq_cooling_ops.power2state = devfreq_cooling_power2state;
> +		ops->state2power = devfreq_cooling_state2power;
> +		ops->power2state = devfreq_cooling_power2state;
>   
>   		dfc->power_ops = dfc_power;
>   
> @@ -407,8 +414,7 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
>   	if (!name)
>   		goto remove_qos_req;
>   
> -	cdev = thermal_of_cooling_device_register(np, name, dfc,
> -						  &devfreq_cooling_ops);
> +	cdev = thermal_of_cooling_device_register(np, name, dfc, ops);
>   	kfree(name);
>   
>   	if (IS_ERR(cdev)) {
> @@ -429,6 +435,8 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
>   	kfree(dfc->freq_table);
>   free_dfc:
>   	kfree(dfc);
> +free_ops:
> +	kfree(ops);
>   
>   	return ERR_PTR(err);
>   }
> @@ -510,11 +518,13 @@ EXPORT_SYMBOL_GPL(devfreq_cooling_em_register);
>   void devfreq_cooling_unregister(struct thermal_cooling_device *cdev)
>   {
>   	struct devfreq_cooling_device *dfc;
> +	const struct thermal_cooling_device_ops *ops;
>   	struct device *dev;
>   
>   	if (IS_ERR_OR_NULL(cdev))
>   		return;
>   
> +	ops = cdev->ops;
>   	dfc = cdev->devdata;
>   	dev = dfc->devfreq->dev.parent;
>   
> @@ -525,5 +535,6 @@ void devfreq_cooling_unregister(struct thermal_cooling_device *cdev)
>   
>   	kfree(dfc->freq_table);
>   	kfree(dfc);
> +	kfree(ops);
>   }
>   EXPORT_SYMBOL_GPL(devfreq_cooling_unregister);

The fix looks good.
