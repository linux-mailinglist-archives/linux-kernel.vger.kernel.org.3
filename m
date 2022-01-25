Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11B649B16A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241520AbiAYKOw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Jan 2022 05:14:52 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:44729 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243069AbiAYKL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:11:59 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7B2D6C000F;
        Tue, 25 Jan 2022 10:11:53 +0000 (UTC)
Date:   Tue, 25 Jan 2022 11:11:52 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@foss.st.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <chenshumin86@sina.com>
Subject: Re: [PATCH 3/3] nvmem: core: Fix a conflict between MTD and NVMEM
 on wp-gpios property
Message-ID: <20220125111152.4fa65ee4@xps13>
In-Reply-To: <20220105135734.271313-4-christophe.kerello@foss.st.com>
References: <20220105135734.271313-1-christophe.kerello@foss.st.com>
        <20220105135734.271313-4-christophe.kerello@foss.st.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

christophe.kerello@foss.st.com wrote on Wed, 5 Jan 2022 14:57:34 +0100:

Sorry for the time it took me to review this patchset.

> Wp-gpios property can be used on NVMEN nodes and the same property can
> be also used on MTD NAND nodes. In case of the wp-gpios property is
> defined at NAND level node, the GPIO management is done at NAND driver
> level. Write protect is disabled when the driver is probed or resumed
> and is enabled when the driver is released or suspended.
> 
> When no partitions are defined in the NAND DT node, then the NAND DT node
> will be passed to NVMEM framework. If wp-gpios property is defined in
> this node, the GPIO resource is taken twice and the NAND controller
> driver fails to probe.
> 
> It would be possible to set config->wp_gpio at MTD level before calling
> nvmem_register function but NVMEM framework will toggled this GPIO on

toggle

> each write when this GPIO should only be controlled at NAND level driver
> to ensure that the Write Protect has not been enabled.
> 
> As MTD framework is only using NVMEN framework in read only, a way to fix

NVMEM

> this conflict is to get the GPIO resource at NVMEM level only if reg_write
> API is defined. This GPIO is only toggled if reg_write ops is defined.

The solution looks a bit hackish to me.

The nvmem_config structure already contains a field named wp_gpio which
seem to imply that callers can provide a wp_gpio handle there if they
want. But yet the nvmem core ignores if no gpio was provided and will
try to get one anyway. Shouldn't this behavior be changed?

There are already a big number of callers for nvmem_register() so I
understand it might be a bit tedious to just drop the else part of
that condition, but maybe we can provide a dummy cookie into the
wp_gpio field which would be interpreted as: "don't mess with it". Or
perhaps an additional flag somewhere else just to clearly skip the
wp_gpio thing entirely?

> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> ---
>  drivers/nvmem/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index e765d3d0542e..e11c74db64f9 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -769,7 +769,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>  
>  	if (config->wp_gpio)
>  		nvmem->wp_gpio = config->wp_gpio;
> -	else
> +	else if (config->reg_write)
>  		nvmem->wp_gpio = gpiod_get_optional(config->dev, "wp",
>  						    GPIOD_OUT_HIGH);
>  	if (IS_ERR(nvmem->wp_gpio)) {

Thanks,
Miquèl
