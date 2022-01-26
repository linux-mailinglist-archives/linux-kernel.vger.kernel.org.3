Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0E549C880
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 12:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240613AbiAZLTx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Jan 2022 06:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbiAZLTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:19:52 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B03C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 03:19:51 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DC356100002;
        Wed, 26 Jan 2022 11:19:48 +0000 (UTC)
Date:   Wed, 26 Jan 2022 12:19:47 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@foss.st.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <richard@nod.at>, <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <chenshumin86@sina.com>
Subject: Re: [PATCH 3/3] nvmem: core: Fix a conflict between MTD and NVMEM
 on wp-gpios property
Message-ID: <20220126121947.79890a47@xps13>
In-Reply-To: <9662651a-12d9-4893-95c2-aa1a3a10302d@foss.st.com>
References: <20220105135734.271313-1-christophe.kerello@foss.st.com>
        <20220105135734.271313-4-christophe.kerello@foss.st.com>
        <3f9a9731-c096-bc9b-63df-bd1dff032737@linaro.org>
        <9662651a-12d9-4893-95c2-aa1a3a10302d@foss.st.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

christophe.kerello@foss.st.com wrote on Wed, 26 Jan 2022 12:08:38 +0100:

> Hi Srinivas, Miquel,
> 
> On 1/25/22 11:44, Srinivas Kandagatla wrote:
> > 
> > 
> > On 05/01/2022 13:57, Christophe Kerello wrote:  
> >> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> >> index e765d3d0542e..e11c74db64f9 100644
> >> --- a/drivers/nvmem/core.c
> >> +++ b/drivers/nvmem/core.c
> >> @@ -769,7 +769,7 @@ struct nvmem_device *nvmem_register(const struct >> nvmem_config *config)
> >>       if (config->wp_gpio)
> >>           nvmem->wp_gpio = config->wp_gpio;
> >> -    else
> >> +    else if (config->reg_write)  
> > This is clearly not going to work for everyone.
> > 
> > A flag in nvmem_config to indicate that wp gpio is managed by provider > driver would be the right thing to do here.  
> 
> Based on your inputs, I will add a new boolean flag in nvmen_config (proposal name: skip_wp_gpio) and I will set it to true in mtdcore.c when nvmen_config structure is initialized. It will be part of the V2.

Fine by me. Thanks for your work on this.

> 
> Regards,
> Christophe Kerello.
> 
> >>           nvmem->wp_gpio = gpiod_get_optional(config->dev, "wp",
> >>                               GPIOD_OUT_HIGH);  
> > 
> > --srini
> >   

Cheers,
Miquèl
