Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB7A516690
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 19:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351432AbiEARSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 13:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiEARSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 13:18:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BD7273C;
        Sun,  1 May 2022 10:15:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 440A660F55;
        Sun,  1 May 2022 17:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3251C385AA;
        Sun,  1 May 2022 17:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651425310;
        bh=q81KPxQv/DdTYHvhbWpl5nvlycZTC4H7TFOwPSGsIA8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=grgoDSHwp9dLge/VniJoEBVxekD00weuqGxY4sFGueaucI/NH2Y5NVilOTGOQMUv+
         RdcgEn87Zx0hk2+gf1D5PXQiQ6JpqSJgQ26kGhQRHW/4SU2tBHT81Y3CxP9SRhkh3N
         CxxAqrdE2sdMmLyPZOKz7QUPfvuPiZsmDR24gE+TVSBvnJ3Fze/DJOpL3QTzdoB2yd
         ug7kzcop05tPIOAlePmR2RMrQMui8n943xGKt7l7hU559HWBxRKYDRPHk/PaGNuRFv
         8mijEru5ngNclm6us8517QdOfPVZ6oZ817hW+pDtL0LPFotbN+YKbLXXidqYSDzVGb
         5oOrdHfjiMKrA==
Date:   Sun, 1 May 2022 18:23:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH v14 01/10] spmi: add a helper to look up an SPMI device
 from a device node
Message-ID: <20220501182323.7b672d8a@jic23-huawei>
In-Reply-To: <20220429220904.137297-2-caleb.connolly@linaro.org>
References: <20220429220904.137297-1-caleb.connolly@linaro.org>
        <20220429220904.137297-2-caleb.connolly@linaro.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2022 23:08:56 +0100
Caleb Connolly <caleb.connolly@linaro.org> wrote:

> The helper function spmi_device_from_of() takes a device node and
> returns the SPMI device associated with it.
> This is like of_find_device_by_node but for SPMI devices.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org> 

Stephen, are you fine with this addition to spmi?

Given bulk of this series in in IIO I'm planning to pick up once
everyone is happy with it.

Thanks,

Jonathan


> ---
>  drivers/spmi/spmi.c  | 17 +++++++++++++++++
>  include/linux/spmi.h |  3 +++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
> index b37ead9e2fad..a456ce5141e1 100644
> --- a/drivers/spmi/spmi.c
> +++ b/drivers/spmi/spmi.c
> @@ -386,6 +386,23 @@ static struct bus_type spmi_bus_type = {
>  	.uevent		= spmi_drv_uevent,
>  };
>  
> +/**
> + * spmi_device_from_of() - get the associated SPMI device from a device node
> + *
> + * @np:		device node
> + *
> + * Returns the struct spmi_device associated with a device node or NULL.
> + */
> +struct spmi_device *spmi_device_from_of(struct device_node *np)
> +{
> +	struct device *dev = bus_find_device_by_of_node(&spmi_bus_type, np);
> +
> +	if (dev)
> +		return to_spmi_device(dev);
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(spmi_device_from_of);
> +
>  /**
>   * spmi_controller_alloc() - Allocate a new SPMI device
>   * @ctrl:	associated controller
> diff --git a/include/linux/spmi.h b/include/linux/spmi.h
> index 729bcbf9f5ad..eac1956a8727 100644
> --- a/include/linux/spmi.h
> +++ b/include/linux/spmi.h
> @@ -164,6 +164,9 @@ static inline void spmi_driver_unregister(struct spmi_driver *sdrv)
>  	module_driver(__spmi_driver, spmi_driver_register, \
>  			spmi_driver_unregister)
>  
> +struct device_node;
> +
> +struct spmi_device *spmi_device_from_of(struct device_node *np);
>  int spmi_register_read(struct spmi_device *sdev, u8 addr, u8 *buf);
>  int spmi_ext_register_read(struct spmi_device *sdev, u8 addr, u8 *buf,
>  			   size_t len);

