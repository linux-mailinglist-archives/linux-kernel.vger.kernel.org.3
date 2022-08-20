Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC36859ADB9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 13:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345913AbiHTL6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 07:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345813AbiHTL60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 07:58:26 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF4D1F2EB;
        Sat, 20 Aug 2022 04:58:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B6799CE0DDB;
        Sat, 20 Aug 2022 11:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D86EC433D6;
        Sat, 20 Aug 2022 11:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660996702;
        bh=IYMBEBmZvHHQ3M0wfJWctteV1udRO4RyU3hBgvn/yts=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nnNMkbHpeJ+yFppGPHQpoEiv1ReEAoUAuZUg8Ifae7i3GL9tOk2fIRO0THNcLWQxS
         asWnR8FPikI5ZUYWN0BFOd+zUb/s6nYFATiZor6TTZMCabVDvVDzzwOjaifXnKLrtT
         LuVJlGBvJ+a9XLY5SGtwo+h1gPuKEEferk0qEskq66BavYFFDIJ0tYpQcEDY2aQUA2
         MfFhzSRxy/OeT0L/NuL7MG4D7gLJvjlInmrmpM6e/OFcbimTSzzMAvUmA3/F2rZ1oI
         33zv8AtN9bwkbTmNImXoqtUANBV3/m6ZD1rNv2ktlB+sDLrG3kUap9D3k2hvapQQhc
         Qe7CyZtHpxoDQ==
Date:   Sat, 20 Aug 2022 13:08:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        David Lechner <david@lechnology.com>
Subject: Re: [PATCH] counter: Move symbols into COUNTER namespace
Message-ID: <20220820130856.52c3ff04@jic23-huawei>
In-Reply-To: <20220815220321.74161-1-william.gray@linaro.org>
References: <20220815220321.74161-1-william.gray@linaro.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2022 18:03:21 -0400
William Breathitt Gray <william.gray@linaro.org> wrote:

> Counter subsystem symbols are only relevant to counter drivers. A
> COUNTER namespace is created to control the availability of these
> symbols to modules that import this namespace explicitly.
> 
> Cc: Patrick Havelange <patrick.havelange@essensium.com>
> Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Cc: Oleksij Rempel <linux@rempel-privat.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: David Lechner <david@lechnology.com>
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>

I'm kind of amazed the interface is this small :)

Definitely a good thing to do.  Sometime soon I'll finish
doing equivalent for IIO.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/counter/104-quad-8.c            |  1 +
>  drivers/counter/counter-chrdev.c        |  2 +-
>  drivers/counter/counter-core.c          | 14 +++++++-------
>  drivers/counter/ftm-quaddec.c           |  1 +
>  drivers/counter/intel-qep.c             |  1 +
>  drivers/counter/interrupt-cnt.c         |  1 +
>  drivers/counter/microchip-tcb-capture.c |  1 +
>  drivers/counter/stm32-lptimer-cnt.c     |  1 +
>  drivers/counter/stm32-timer-cnt.c       |  1 +
>  drivers/counter/ti-eqep.c               |  1 +
>  10 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 62c2b7ac4339..1323edfbe40c 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -1241,3 +1241,4 @@ module_isa_driver(quad8_driver, num_quad8);
>  MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
>  MODULE_DESCRIPTION("ACCES 104-QUAD-8 driver");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(COUNTER);
> diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
> index 69d340be9c93..4e71a19d7e6a 100644
> --- a/drivers/counter/counter-chrdev.c
> +++ b/drivers/counter/counter-chrdev.c
> @@ -574,4 +574,4 @@ void counter_push_event(struct counter_device *const counter, const u8 event,
>  	if (copied)
>  		wake_up_poll(&counter->events_wait, EPOLLIN);
>  }
> -EXPORT_SYMBOL_GPL(counter_push_event);
> +EXPORT_SYMBOL_NS_GPL(counter_push_event, COUNTER);
> diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
> index 938651f9e9e0..09c77afb33ca 100644
> --- a/drivers/counter/counter-core.c
> +++ b/drivers/counter/counter-core.c
> @@ -73,7 +73,7 @@ void *counter_priv(const struct counter_device *const counter)
>  
>  	return &ch->privdata;
>  }
> -EXPORT_SYMBOL_GPL(counter_priv);
> +EXPORT_SYMBOL_NS_GPL(counter_priv, COUNTER);
>  
>  /**
>   * counter_alloc - allocate a counter_device
> @@ -133,13 +133,13 @@ struct counter_device *counter_alloc(size_t sizeof_priv)
>  
>  	return NULL;
>  }
> -EXPORT_SYMBOL_GPL(counter_alloc);
> +EXPORT_SYMBOL_NS_GPL(counter_alloc, COUNTER);
>  
>  void counter_put(struct counter_device *counter)
>  {
>  	put_device(&counter->dev);
>  }
> -EXPORT_SYMBOL_GPL(counter_put);
> +EXPORT_SYMBOL_NS_GPL(counter_put, COUNTER);
>  
>  /**
>   * counter_add - complete registration of a counter
> @@ -166,7 +166,7 @@ int counter_add(struct counter_device *counter)
>  	/* implies device_add(dev) */
>  	return cdev_device_add(&counter->chrdev, dev);
>  }
> -EXPORT_SYMBOL_GPL(counter_add);
> +EXPORT_SYMBOL_NS_GPL(counter_add, COUNTER);
>  
>  /**
>   * counter_unregister - unregister Counter from the system
> @@ -188,7 +188,7 @@ void counter_unregister(struct counter_device *const counter)
>  
>  	mutex_unlock(&counter->ops_exist_lock);
>  }
> -EXPORT_SYMBOL_GPL(counter_unregister);
> +EXPORT_SYMBOL_NS_GPL(counter_unregister, COUNTER);
>  
>  static void devm_counter_release(void *counter)
>  {
> @@ -223,7 +223,7 @@ struct counter_device *devm_counter_alloc(struct device *dev, size_t sizeof_priv
>  
>  	return counter;
>  }
> -EXPORT_SYMBOL_GPL(devm_counter_alloc);
> +EXPORT_SYMBOL_NS_GPL(devm_counter_alloc, COUNTER);
>  
>  /**
>   * devm_counter_add - complete registration of a counter
> @@ -244,7 +244,7 @@ int devm_counter_add(struct device *dev,
>  
>  	return devm_add_action_or_reset(dev, devm_counter_release, counter);
>  }
> -EXPORT_SYMBOL_GPL(devm_counter_add);
> +EXPORT_SYMBOL_NS_GPL(devm_counter_add, COUNTER);
>  
>  #define COUNTER_DEV_MAX 256
>  
> diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
> index 2a58582a9df4..aea6622a9b13 100644
> --- a/drivers/counter/ftm-quaddec.c
> +++ b/drivers/counter/ftm-quaddec.c
> @@ -325,3 +325,4 @@ module_platform_driver(ftm_quaddec_driver);
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Kjeld Flarup <kfa@deif.com>");
>  MODULE_AUTHOR("Patrick Havelange <patrick.havelange@essensium.com>");
> +MODULE_IMPORT_NS(COUNTER);
> diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
> index 47a6a9dfc9e8..af5942e66f7d 100644
> --- a/drivers/counter/intel-qep.c
> +++ b/drivers/counter/intel-qep.c
> @@ -523,3 +523,4 @@ MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@linux.intel.com>");
>  MODULE_AUTHOR("Raymond Tan <raymond.tan@intel.com>");
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Intel Quadrature Encoder Peripheral driver");
> +MODULE_IMPORT_NS(COUNTER);
> diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
> index 3b13f56bbb11..5a11b65fc0e5 100644
> --- a/drivers/counter/interrupt-cnt.c
> +++ b/drivers/counter/interrupt-cnt.c
> @@ -242,3 +242,4 @@ MODULE_ALIAS("platform:interrupt-counter");
>  MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
>  MODULE_DESCRIPTION("Interrupt counter driver");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(COUNTER);
> diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
> index 00844445143b..f9dee15d9777 100644
> --- a/drivers/counter/microchip-tcb-capture.c
> +++ b/drivers/counter/microchip-tcb-capture.c
> @@ -394,3 +394,4 @@ module_platform_driver(mchp_tc_driver);
>  MODULE_AUTHOR("Kamel Bouhara <kamel.bouhara@bootlin.com>");
>  MODULE_DESCRIPTION("Microchip TCB Capture driver");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(COUNTER);
> diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
> index 68031d93ce89..d6b80b6dfc28 100644
> --- a/drivers/counter/stm32-lptimer-cnt.c
> +++ b/drivers/counter/stm32-lptimer-cnt.c
> @@ -520,3 +520,4 @@ MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@st.com>");
>  MODULE_ALIAS("platform:stm32-lptimer-counter");
>  MODULE_DESCRIPTION("STMicroelectronics STM32 LPTIM counter driver");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(COUNTER);
> diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
> index 5779ae7c73cf..9bf20a5d6bda 100644
> --- a/drivers/counter/stm32-timer-cnt.c
> +++ b/drivers/counter/stm32-timer-cnt.c
> @@ -417,3 +417,4 @@ MODULE_AUTHOR("Benjamin Gaignard <benjamin.gaignard@st.com>");
>  MODULE_ALIAS("platform:stm32-timer-counter");
>  MODULE_DESCRIPTION("STMicroelectronics STM32 TIMER counter driver");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(COUNTER);
> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index 0489d26eb47c..b0f24cf3e891 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c
> @@ -456,3 +456,4 @@ module_platform_driver(ti_eqep_driver);
>  MODULE_AUTHOR("David Lechner <david@lechnology.com>");
>  MODULE_DESCRIPTION("TI eQEP counter driver");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(COUNTER);
> 
> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868

