Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C59F5925B8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 19:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbiHNRD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 13:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiHNRDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 13:03:54 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD0228E
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 10:03:52 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id t11so4187922qkt.6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 10:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=3R0ylE5QT0Fy4rIa+JIXAubqw04e4sQKICx/p0NaV8Q=;
        b=HSH9plkig4IUERCcoaGPEGOGr0Z3nkvy77EOaPwmcez/6tF15JICc3dwYcr5hhzJnk
         +OhFTcdfJHDZmMaDaB1s0ZshdWEsm62KYlWGVodZ+4hyUD5SOMNJniUFAKeQI+5dnhNj
         plG0Bz4CDXPp7kMC7huzh2ZkGBeLW41VyncP4cdUzo22ooqAweUHFQ53Ycf6SflAlW44
         ef2d2/90FbWwsdyfJ5UmZYhZ4x9AWsjaWwwfk3wWaomcO4jtNyTchoP8noPzDmxe3Lcx
         skM1+eF6oiqNAIiByb9Twto2N5/B7Z3IszVjudCPM9LQCWHHIfbqUQ/p8YMN6ZLnA2if
         qaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=3R0ylE5QT0Fy4rIa+JIXAubqw04e4sQKICx/p0NaV8Q=;
        b=D/TeTVIVt6uXRP2yhmczQJGkmZHfCZ9XQ8beUBfIkRuImHwZsqqOCMzjlamrez61rB
         Zswsa2s2PEtJfBpDgwuYTj+95y7nbOT1iihQc+AT2uuhF30oDRGNxqg0yBeOJHA/GNXa
         Br/OcOgRSyYOG0Qc4+tmx1/82C5Kechvfhtvs6aWQ58cFtQpxo1jWc2iY5JKX8J28bgx
         um5KEwdNarkb+SZRt0dFxRoJ+CyuAULNFFceVNSnxggkRd0WR6W7NloRj7h27+BcaZDE
         ESFmTaHDWKKI3dk9yTQu9cUHEeRX2FSiCglERCkinnNuTsOs1OAHCslO8RIm9YQhgOjD
         pKZA==
X-Gm-Message-State: ACgBeo1EDQPj4N/0qWxIKDgyKHgZiAdwwmjjxjRIjQrau5UreCxjd5pC
        K8lXNQsz2wwoE/s0jWWjsF4f0w==
X-Google-Smtp-Source: AA6agR4uwVfohMHxTZgi2R3NU1qJfui4Z/A/roV8C5PpiQNMfV3doPwSU5ojVVW4LM73jGeQoPNG+Q==
X-Received: by 2002:a05:620a:1a8f:b0:6b5:fe28:f91d with SMTP id bl15-20020a05620a1a8f00b006b5fe28f91dmr9078179qkb.279.1660496631239;
        Sun, 14 Aug 2022 10:03:51 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id 128-20020a370786000000b006b941e994fasm6612954qkh.14.2022.08.14.10.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 10:03:50 -0700 (PDT)
Date:   Sun, 14 Aug 2022 13:03:48 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     vilhelm.gray@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mranostay@ti.com
Subject: Re: [PATCH v4 3/3] counter: capture-tiecap: capture driver support
 for ECAP
Message-ID: <Yvkq9Hy+hxAPQd8J@fedora>
References: <20220810140724.182389-1-jpanis@baylibre.com>
 <20220810140724.182389-4-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FnR7gEYtWnTYunX1"
Content-Disposition: inline
In-Reply-To: <20220810140724.182389-4-jpanis@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FnR7gEYtWnTYunX1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 10, 2022 at 04:07:24PM +0200, Julien Panis wrote:
> ECAP hardware on AM62x SoC supports capture feature. It can be used
> to timestamp events (falling/rising edges) detected on signal input pin.
>=20
> This commit adds capture driver support for ECAP hardware on AM62x SoC.
>=20
> In the ECAP hardware, capture pin can also be configured to be in
> PWM mode. Current implementation only supports capture operating mode.
> Hardware also supports timebase sync between multiple instances, but
> this driver supports simple independent capture functionality.
>=20
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
Hi Julien,

You picked up the Counter paradigm pretty quickly, good job! Some
suggestions and comments inline below.

> ---
>  drivers/counter/Kconfig          |  14 +
>  drivers/counter/Makefile         |   1 +
>  drivers/counter/capture-tiecap.c | 634 +++++++++++++++++++++++++++++++
>  include/uapi/linux/counter.h     |   2 +
>  4 files changed, 651 insertions(+)
>  create mode 100644 drivers/counter/capture-tiecap.c
>=20
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index 5edd155f1911..580640807a94 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -101,4 +101,18 @@ config INTEL_QEP
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called intel-qep.
> =20
> +config CAPTURE_TIECAP
> +	tristate "TI eCAP capture driver"
> +	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE || ARC=
H_K3 || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  Select this option to enable the Texas Instruments Enhanced Capture
> +	  (eCAP) driver in input mode.
> +
> +	  It can be used to timestamp events (falling/rising edges) detected
> +	  on signal input pin.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called capture-tiecap.
> +

The naming convention I typically see is to lead with the company name
followed by device model; e.g. ti-ecap-capture. That should result in
better grouping with the existing drivers in the drivers/counter
directory. It's a minor benefit, so let's use that convention unless
there's a reason why capture-tiecap is better here.

>  endif # COUNTER
> diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
> index 8fde6c100ebc..7fac3e0985b5 100644
> --- a/drivers/counter/Makefile
> +++ b/drivers/counter/Makefile
> @@ -14,3 +14,4 @@ obj-$(CONFIG_TI_EQEP)		+=3D ti-eqep.o
>  obj-$(CONFIG_FTM_QUADDEC)	+=3D ftm-quaddec.o
>  obj-$(CONFIG_MICROCHIP_TCB_CAPTURE)	+=3D microchip-tcb-capture.o
>  obj-$(CONFIG_INTEL_QEP)		+=3D intel-qep.o
> +obj-$(CONFIG_CAPTURE_TIECAP)	+=3D capture-tiecap.o
> diff --git a/drivers/counter/capture-tiecap.c b/drivers/counter/capture-t=
iecap.c
> new file mode 100644
> index 000000000000..0601c65ef203
> --- /dev/null
> +++ b/drivers/counter/capture-tiecap.c
> @@ -0,0 +1,634 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * ECAP Capture driver
> + *
> + * Copyright (C) 2022 Julien Panis <jpanis@baylibre.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/counter.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +
> +#define ECAP_DRV_NAME "ecap"
> +
> +/* Registers */
> +#define ECAP_NB_CAP			4
> +
> +#define ECAP_TSCNT_REG			0x00
> +
> +#define ECAP_CAP_REG(i)		(((i) << 2) + 0x08)
> +
> +#define ECAP_ECCTL_REG			0x28
> +#define ECAP_CAPPOL_BIT(i)		BIT((i) << 1)
> +#define ECAP_EV_MODE_MASK		GENMASK(7, 0)
> +#define ECAP_CAPLDEN_BIT		BIT(8)
> +#define ECAP_CONT_ONESHT_BIT		BIT(16)
> +#define ECAP_STOPVALUE_MASK		GENMASK(18, 17)
> +#define ECAP_REARM_RESET_BIT		BIT(19)
> +#define ECAP_TSCNTSTP_BIT		BIT(20)
> +#define ECAP_SYNCO_DIS_MASK		GENMASK(23, 22)
> +#define ECAP_CAP_APWM_BIT		BIT(25)
> +#define ECAP_ECCTL_EN_MASK		(ECAP_CAPLDEN_BIT | ECAP_TSCNTSTP_BIT)
> +#define ECAP_ECCTL_CFG_MASK		(ECAP_SYNCO_DIS_MASK | ECAP_STOPVALUE_MASK	\
> +					| ECAP_ECCTL_EN_MASK | ECAP_REARM_RESET_BIT	\
> +					| ECAP_CAP_APWM_BIT | ECAP_CONT_ONESHT_BIT)
> +
> +#define ECAP_ECINT_EN_FLG_REG		0x2c
> +#define ECAP_NB_CEVT			(ECAP_NB_CAP + 1)
> +#define ECAP_CEVT_EN_MASK		GENMASK(ECAP_NB_CEVT, ECAP_NB_CAP)
> +#define ECAP_CEVT_FLG_BIT(i)		BIT((i) + 17)
> +
> +#define ECAP_ECINT_CLR_FRC_REG	0x30
> +#define ECAP_INT_CLR_BIT		BIT(0)
> +#define ECAP_CEVT_CLR_BIT(i)		BIT((i) + 1)
> +#define ECAP_CEVT_CLR_MASK		GENMASK(ECAP_NB_CEVT, 0)
> +
> +#define ECAP_PID_REG			0x5c
> +
> +/*
> + * Event modes
> + * One bit for each CAPx register : 1 =3D falling edge / 0 =3D rising ed=
ge
> + * e.g. mode =3D 13 =3D 0xd =3D 0b1101
> + * -> falling edge for CAP1-3-4 / rising edge for CAP2
> + */
> +#define ECAP_EV_MODE_BIT(i)		BIT(i)
> +
> +/* ECAP input */
> +#define ECAP_SIGNAL 0
> +
> +static const struct regmap_config ecap_cnt_regmap_config =3D {
> +	.reg_bits =3D 32,
> +	.reg_stride =3D 4,
> +	.val_bits =3D 32,
> +	.max_register =3D ECAP_PID_REG,
> +};
> +
> +/**
> + * struct ecap_cnt_dev - device private data structure
> + * @enabled:      device state
> + * @clk:          device clock
> + * @clk_rate:     device clock rate
> + * @regmap:       device register map
> + * @elapsed_time: elapsed time since capture start
> + * @lock:         synchronization lock to prevent race conditions when c=
omputing times
> + * @pm_ctx:       device context for PM operations
> + */
> +struct ecap_cnt_dev {
> +	bool enabled;
> +	struct clk *clk;
> +	unsigned long clk_rate;
> +	struct regmap *regmap;
> +	__aligned_u64 elapsed_time;
> +	spinlock_t lock;
> +	struct {
> +		u8 ev_mode;
> +		unsigned int time_cntr;
> +	} pm_ctx;
> +};
> +
> +static u8 ecap_cnt_capture_get_evmode(struct counter_device *counter)
> +{
> +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter);
> +	u8 ev_mode =3D 0;
> +	unsigned int regval;
> +	int i;
> +
> +	pm_runtime_get_sync(counter->parent);
> +	regmap_read(ecap_dev->regmap, ECAP_ECCTL_REG, &regval);
> +	pm_runtime_put_sync(counter->parent);
> +
> +	for (i =3D 0 ; i < ECAP_NB_CAP ; i++) {
> +		if (regval & ECAP_CAPPOL_BIT(i))
> +			ev_mode |=3D ECAP_EV_MODE_BIT(i);
> +	}
> +
> +	return ev_mode;
> +}
> +
> +static void ecap_cnt_capture_set_evmode(struct counter_device *counter, =
u8 ev_mode)
> +{
> +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter);
> +	unsigned int regval =3D 0;
> +	int i;
> +
> +	for (i =3D 0 ; i < ECAP_NB_CAP ; i++) {
> +		if (ev_mode & ECAP_EV_MODE_BIT(i))
> +			regval |=3D ECAP_CAPPOL_BIT(i);
> +	}
> +
> +	pm_runtime_get_sync(counter->parent);
> +	regmap_update_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_EV_MODE_MASK,=
 regval);
> +	pm_runtime_put_sync(counter->parent);
> +}
> +
> +static void ecap_cnt_capture_enable(struct counter_device *counter, bool=
 rearm)
> +{
> +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter);
> +	unsigned int regval;
> +
> +	pm_runtime_get_sync(counter->parent);
> +
> +	/* Enable interrupts on events */
> +	regmap_update_bits(ecap_dev->regmap, ECAP_ECINT_EN_FLG_REG,
> +			   ECAP_CEVT_EN_MASK, ECAP_CEVT_EN_MASK);
> +
> +	/* Run counter */
> +	regval =3D ECAP_SYNCO_DIS_MASK | ECAP_STOPVALUE_MASK | ECAP_ECCTL_EN_MA=
SK;
> +	if (rearm) {
> +		ecap_dev->elapsed_time =3D 0;
> +		regmap_write(ecap_dev->regmap, ECAP_TSCNT_REG, 0);
> +		regval |=3D ECAP_REARM_RESET_BIT;
> +	}
> +	regmap_update_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_ECCTL_CFG_MAS=
K, regval);
> +}
> +
> +static void ecap_cnt_capture_disable(struct counter_device *counter)
> +{
> +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter);
> +
> +	/* Disable interrupts on events */
> +	regmap_update_bits(ecap_dev->regmap, ECAP_ECINT_EN_FLG_REG, ECAP_CEVT_E=
N_MASK, 0);
> +
> +	/* Stop counter */
> +	regmap_update_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_ECCTL_EN_MASK=
, 0);
> +
> +	pm_runtime_put_sync(counter->parent);
> +}
> +
> +static int ecap_cnt_count_get_ns(struct counter_device *counter, unsigne=
d int reg, u64 *val)
> +{
> +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter);
> +	unsigned int regval;
> +	unsigned long flags;
> +
> +	pm_runtime_get_sync(counter->parent);
> +	spin_lock_irqsave(&ecap_dev->lock, flags);
> +
> +	/* time_ns =3D 10^9 * (time_cycles + time_cumul) / clk_rate */
> +	regmap_read(ecap_dev->regmap, reg, &regval);
> +	*val =3D (regval + ecap_dev->elapsed_time) * NSEC_PER_SEC;
> +	do_div(*val, ecap_dev->clk_rate);
> +
> +	spin_unlock_irqrestore(&ecap_dev->lock, flags);
> +	pm_runtime_put_sync(counter->parent);
> +
> +	return 0;
> +}
> +
> +static inline int ecap_cnt_count_read(struct counter_device *counter,
> +				      struct counter_count *count,
> +				      u64 *val)
> +{
> +	return ecap_cnt_count_get_ns(counter, ECAP_TSCNT_REG, val);
> +}

This conversion to nanoseconds is an interpretation of the count value
that belongs in userspace. Instead of converting to nanoseconds here,
simply expose the count value directly and add extensions to expose the
elapsed time (a Count extension) and clock rate (a Signal extension) as
well; with these three values you can derive nanoseconds in userspace
using the time_ns equation in your ecap_cnt_count_get_ns() comment.

> +static int ecap_cnt_function_read(struct counter_device *counter,
> +				  struct counter_count *count,
> +				  enum counter_function *function)
> +{
> +	*function =3D COUNTER_FUNCTION_INCREASE;
> +
> +	return 0;
> +}
> +
> +static int ecap_cnt_action_read(struct counter_device *counter,
> +				struct counter_count *count,
> +				struct counter_synapse *synapse,
> +				enum counter_synapse_action *action)
> +{
> +	*action =3D COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
> +
> +	return 0;
> +}

Right now you have a Signal defined for the ECAPSIG line, but there is
at least one more relevant Signal to define: the clock updating ECAPCNT.
The Synapse action of COUNTER_SYNAPSE_ACTION_BOTH_EDGES is for that
clock Signal, but for the ECAPSIG Signal you will need to report a
Synapse action based on the polarity of the next capture (i.e. whether
high or low).

> +
> +static int ecap_cnt_watch_validate(struct counter_device *counter,
> +				   const struct counter_watch *watch)
> +{
> +	struct counter_event_node *event_node;
> +
> +	if (watch->channel || watch->event !=3D COUNTER_EVENT_CAPTURE)
> +		return -EINVAL;

The intention of this conditional is more obvious if you explicitly
check for watch->channel !=3D 0.

> +
> +	list_for_each_entry(event_node, &counter->next_events_list, l)
> +		if (watch->component.type !=3D COUNTER_COMPONENT_EXTENSION ||
> +		    watch->component.scope !=3D COUNTER_SCOPE_COUNT ||
> +		    watch->component.parent ||
> +		    watch->component.id >=3D ECAP_NB_CAP)
> +			return -EINVAL;

You don't need this list_for_each_entry loop at all. The purpose of the
watch_validate() callback is to make sure a watch isn't added with a
channel or event configuration that conflicts with existing watches in
the next_events_list list.

For example, the 104-QUAD-8 device only allows one particular event to
occur on any given channel. The quad8_watch_validate() function makes
sure that all watches for a particular channel are set for the same
event; if a watch for that channel is set for a different event, then
that watch is invalid because the 104-QUAD-8 device cannot handle such
a request for two different events on the same channel.

Regarding the TI ECAP device, it looks like it only supports that one
COUNTER_EVENT_CAPTURE event so you don't need to check the other watches
in the next_events_list list. Your conditional check above for
watch->channel and watch->event should be enough by itself.

> +
> +	return 0;
> +}
> +
> +static int ecap_cnt_enable_read(struct counter_device *counter,
> +				struct counter_count *count,
> +				u8 *enable)
> +{
> +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter);
> +
> +	*enable =3D ecap_dev->enabled;
> +
> +	return 0;
> +}
> +
> +static int ecap_cnt_enable_write(struct counter_device *counter,
> +				 struct counter_count *count,
> +				 u8 enable)
> +{
> +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter);
> +
> +	if (enable > 1)
> +		return -EINVAL;
> +	if (enable =3D=3D ecap_dev->enabled)
> +		return 0;
> +	if (enable)
> +		ecap_cnt_capture_enable(counter, true);
> +	else
> +		ecap_cnt_capture_disable(counter);
> +	ecap_dev->enabled =3D enable;
> +
> +	return 0;
> +}
> +
> +static int ecap_cnt_cap_get_pol(struct counter_device *counter,
> +				struct counter_signal *signal,
> +				u32 *pol, u8 inst)
> +{
> +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter);
> +
> +	pm_runtime_get_sync(counter->parent);
> +	*pol =3D regmap_test_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_CAPPOL=
_BIT(inst));
> +	pm_runtime_put_sync(counter->parent);
> +
> +	return 0;
> +}
> +
> +static int ecap_cnt_cap_set_pol(struct counter_device *counter,
> +				struct counter_signal *signal,
> +				u32 pol, u8 inst)
> +{
> +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter);
> +
> +	if (ecap_dev->enabled)
> +		return -EBUSY;
> +	if (pol > 1)
> +		return -EINVAL;
> +
> +	pm_runtime_get_sync(counter->parent);
> +	if (pol)
> +		regmap_set_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_CAPPOL_BIT(inst=
));
> +	else
> +		regmap_clear_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_CAPPOL_BIT(in=
st));
> +	pm_runtime_put_sync(counter->parent);
> +
> +	return 0;
> +}
> +
> +static inline int ecap_cnt_cap_read(struct counter_device *counter,
> +				    struct counter_count *count,
> +				    u64 *cap, u8 inst)
> +{
> +	return ecap_cnt_count_get_ns(counter, ECAP_CAP_REG(inst), cap);
> +}

Return the captured count value directly here; userspace can handle the
nanosecond interpretation for the same reason explained earlier for the
ECAPCNT count value.

> +static inline int ecap_cnt_cap1_get_pol(struct counter_device *counter,
> +					struct counter_signal *signal, u32 *pol)
> +{
> +	return ecap_cnt_cap_get_pol(counter, signal, pol, 0);
> +}
> +
> +static inline int ecap_cnt_cap2_get_pol(struct counter_device *counter,
> +					struct counter_signal *signal, u32 *pol)
> +{
> +	return ecap_cnt_cap_get_pol(counter, signal, pol, 1);
> +}
> +
> +static inline int ecap_cnt_cap3_get_pol(struct counter_device *counter,
> +					struct counter_signal *signal, u32 *pol)
> +{
> +	return ecap_cnt_cap_get_pol(counter, signal, pol, 2);
> +}
> +
> +static inline int ecap_cnt_cap4_get_pol(struct counter_device *counter,
> +					struct counter_signal *signal, u32 *pol)
> +{
> +	return ecap_cnt_cap_get_pol(counter, signal, pol, 3);
> +}
> +
> +static inline int ecap_cnt_cap1_set_pol(struct counter_device *counter,
> +					struct counter_signal *signal, u32 pol)
> +{
> +	return ecap_cnt_cap_set_pol(counter, signal, pol, 0);
> +}
> +
> +static inline int ecap_cnt_cap2_set_pol(struct counter_device *counter,
> +					struct counter_signal *signal, u32 pol)
> +{
> +	return ecap_cnt_cap_set_pol(counter, signal, pol, 1);
> +}
> +
> +static inline int ecap_cnt_cap3_set_pol(struct counter_device *counter,
> +					struct counter_signal *signal, u32 pol)
> +{
> +	return ecap_cnt_cap_set_pol(counter, signal, pol, 2);
> +}
> +
> +static inline int ecap_cnt_cap4_set_pol(struct counter_device *counter,
> +					struct counter_signal *signal, u32 pol)
> +{
> +	return ecap_cnt_cap_set_pol(counter, signal, pol, 3);
> +}
> +
> +static inline int ecap_cnt_cap1_read(struct counter_device *counter,
> +				     struct counter_count *count, u64 *cap)
> +{
> +	return ecap_cnt_cap_read(counter, count, cap, 0);
> +}
> +
> +static inline int ecap_cnt_cap2_read(struct counter_device *counter,
> +				     struct counter_count *count, u64 *cap)
> +{
> +	return ecap_cnt_cap_read(counter, count, cap, 1);
> +}
> +
> +static inline int ecap_cnt_cap3_read(struct counter_device *counter,
> +				     struct counter_count *count, u64 *cap)
> +{
> +	return ecap_cnt_cap_read(counter, count, cap, 2);
> +}
> +
> +static inline int ecap_cnt_cap4_read(struct counter_device *counter,
> +				     struct counter_count *count, u64 *cap)
> +{
> +	return ecap_cnt_cap_read(counter, count, cap, 3);
> +}

There's a lot of boilerplate code here for each ECAP register read/write
callback. Try defining a macro to build these so you can define each
read/write callback pair more succinctly.

> +static const struct counter_ops ecap_cnt_ops =3D {
> +	.count_read =3D ecap_cnt_count_read,
> +	.function_read =3D ecap_cnt_function_read,
> +	.action_read =3D ecap_cnt_action_read,
> +	.watch_validate =3D ecap_cnt_watch_validate,
> +};
> +
> +static const enum counter_function ecap_cnt_functions[] =3D {
> +	COUNTER_FUNCTION_INCREASE,
> +};
> +
> +static const enum counter_synapse_action ecap_cnt_actions[] =3D {
> +	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
> +};
> +
> +static const char *const ecap_cnt_cap_polarities[] =3D {
> +	"rising",
> +	"falling",
> +};
> +
> +static DEFINE_COUNTER_ENUM(ecap_cnt_cap_avail_pol, ecap_cnt_cap_polariti=
es);
> +
> +static struct counter_comp ecap_cnt_signal_ext[] =3D {
> +	COUNTER_COMP_SIGNAL_ENUM("polarity1", ecap_cnt_cap1_get_pol,
> +				 ecap_cnt_cap1_set_pol, ecap_cnt_cap_avail_pol),
> +	COUNTER_COMP_SIGNAL_ENUM("polarity2", ecap_cnt_cap2_get_pol,
> +				 ecap_cnt_cap2_set_pol, ecap_cnt_cap_avail_pol),
> +	COUNTER_COMP_SIGNAL_ENUM("polarity3", ecap_cnt_cap3_get_pol,
> +				 ecap_cnt_cap3_set_pol, ecap_cnt_cap_avail_pol),
> +	COUNTER_COMP_SIGNAL_ENUM("polarity4", ecap_cnt_cap4_get_pol,
> +				 ecap_cnt_cap4_set_pol, ecap_cnt_cap_avail_pol),
> +};
> +
> +static struct counter_signal ecap_cnt_signals[] =3D {
> +	{
> +		.id =3D ECAP_SIGNAL,
> +		.name =3D "ECAPSIG",
> +		.ext =3D ecap_cnt_signal_ext,
> +		.num_ext =3D ARRAY_SIZE(ecap_cnt_signal_ext),
> +	},
> +};

As mentioned earlier, define another Signal here representing the clock
feeding ECAPCNT. You should also define another extensions array for
this new Signal that will provide the clock rate for userspace to read.

> +static struct counter_synapse ecap_cnt_synapses[] =3D {
> +	{
> +		.actions_list =3D ecap_cnt_actions,
> +		.num_actions =3D ARRAY_SIZE(ecap_cnt_actions),
> +		.signal =3D &ecap_cnt_signals[ECAP_SIGNAL],
> +	},
> +};

You will need to define another Synapse here for the clock Signal
mentioned above; similarly, you need to define another actions array for
the possible edge triggers.

> +static struct counter_comp ecap_cnt_count_ext[] =3D {
> +	COUNTER_COMP_COUNT_U64("capture1", ecap_cnt_cap1_read, NULL),
> +	COUNTER_COMP_COUNT_U64("capture2", ecap_cnt_cap2_read, NULL),
> +	COUNTER_COMP_COUNT_U64("capture3", ecap_cnt_cap3_read, NULL),
> +	COUNTER_COMP_COUNT_U64("capture4", ecap_cnt_cap4_read, NULL),
> +	COUNTER_COMP_ENABLE(ecap_cnt_enable_read, ecap_cnt_enable_write),

I just want to verify: this enable extension should disable the ECAPCNT
count itself (i.e. no more increasing count value). Is that what's
happening here, or is this meant to disable just the captures?

> +};
> +
> +static struct counter_count ecap_cnt_counts[] =3D {
> +	{
> +		.id =3D 0,
> +		.name =3D "ECAPCNT",
> +		.functions_list =3D ecap_cnt_functions,
> +		.num_functions =3D ARRAY_SIZE(ecap_cnt_functions),
> +		.synapses =3D ecap_cnt_synapses,
> +		.num_synapses =3D ARRAY_SIZE(ecap_cnt_synapses),
> +		.ext =3D ecap_cnt_count_ext,
> +		.num_ext =3D ARRAY_SIZE(ecap_cnt_count_ext),
> +	},
> +};
> +
> +static irqreturn_t ecap_cnt_isr(int irq, void *dev_id)
> +{
> +	struct counter_device *counter_dev =3D dev_id;
> +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter_dev);
> +	unsigned int clr =3D 0;
> +	unsigned int flg;
> +	int i;
> +	unsigned long flags;
> +
> +	regmap_read(ecap_dev->regmap, ECAP_ECINT_EN_FLG_REG, &flg);
> +
> +	for (i =3D ECAP_NB_CAP - 1 ; i < ECAP_NB_CEVT ; i++) {

Would you walk me through the logic for this loop. Is this for-loop
intended to loop through all four capture indices? ECAP_NB_CAP and
ECAP_NB_CEVT are defines, so your for-loop has i=3D3 and i<5; is this what
you want?

> +		if (flg & ECAP_CEVT_FLG_BIT(i)) {
> +			if (i < ECAP_NB_CAP) {
> +				/* Input signal edge detected on last CAP (CAP4) */
> +				counter_push_event(counter_dev, COUNTER_EVENT_CAPTURE, 0);
> +			} else {
> +				/* Counter overflow */
> +				spin_lock_irqsave(&ecap_dev->lock, flags);
> +				ecap_dev->elapsed_time +=3D (u64)U32_MAX + 1;
> +				spin_unlock_irqrestore(&ecap_dev->lock, flags);

Should we push COUNTER_EVENT_OVERFLOW here? Since elapsed_time always
increments by the same constant (U32_MAX), it would be better to replace
this with an atomic_t "num_overflows" to track the number of overflows
with atomic_inc() and compute the particular elapsed_time later.

William Breathitt Gray

> +			}
> +
> +			clr |=3D ECAP_CEVT_CLR_BIT(i);
> +		}
> +	}
> +
> +	clr |=3D ECAP_INT_CLR_BIT;
> +	regmap_update_bits(ecap_dev->regmap, ECAP_ECINT_CLR_FRC_REG, ECAP_CEVT_=
CLR_MASK, clr);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void ecap_cnt_clk_disable(void *clk)
> +{
> +	clk_disable_unprepare(clk);
> +}
> +
> +static int ecap_cnt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct ecap_cnt_dev *ecap_dev;
> +	struct counter_device *counter_dev;
> +	void __iomem *mmio_base;
> +	int ret;
> +
> +	counter_dev =3D devm_counter_alloc(dev, sizeof(*ecap_dev));
> +	if (IS_ERR(counter_dev))
> +		return PTR_ERR(counter_dev);
> +
> +	counter_dev->name =3D ECAP_DRV_NAME;
> +	counter_dev->parent =3D dev;
> +	counter_dev->ops =3D &ecap_cnt_ops;
> +	counter_dev->signals =3D ecap_cnt_signals;
> +	counter_dev->num_signals =3D ARRAY_SIZE(ecap_cnt_signals);
> +	counter_dev->counts =3D ecap_cnt_counts;
> +	counter_dev->num_counts =3D ARRAY_SIZE(ecap_cnt_counts);
> +
> +	ecap_dev =3D counter_priv(counter_dev);
> +
> +	ecap_dev->clk =3D devm_clk_get(dev, "fck");
> +	if (IS_ERR(ecap_dev->clk))
> +		return dev_err_probe(dev, PTR_ERR(ecap_dev->clk), "failed to get clock=
\n");
> +
> +	ret =3D clk_prepare_enable(ecap_dev->clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable clock\n");
> +		return ret;
> +	}
> +
> +	ret =3D devm_add_action_or_reset(dev, ecap_cnt_clk_disable, ecap_dev->c=
lk);
> +	if (ret) {
> +		dev_err(dev, "failed to add clock disable action\n");
> +		return ret;
> +	}
> +
> +	ecap_dev->clk_rate =3D clk_get_rate(ecap_dev->clk);
> +	if (!ecap_dev->clk_rate) {
> +		dev_err(dev, "failed to get clock rate\n");
> +		return -EINVAL;
> +	}
> +
> +	mmio_base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(mmio_base))
> +		return PTR_ERR(mmio_base);
> +
> +	ecap_dev->regmap =3D devm_regmap_init_mmio(dev, mmio_base, &ecap_cnt_re=
gmap_config);
> +	if (IS_ERR(ecap_dev->regmap))
> +		return dev_err_probe(dev, PTR_ERR(ecap_dev->regmap), "failed to init r=
egmap\n");
> +
> +	spin_lock_init(&ecap_dev->lock);
> +
> +	ret =3D platform_get_irq(pdev, 0);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to get irq\n");
> +		return ret;
> +	}
> +
> +	ret =3D devm_request_irq(dev, ret, ecap_cnt_isr, 0, pdev->name, counter=
_dev);
> +	if (ret) {
> +		dev_err(dev, "failed to request irq\n");
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, counter_dev);
> +	pm_runtime_enable(dev);
> +
> +	ecap_dev->enabled =3D 0;
> +	ecap_cnt_capture_set_evmode(counter_dev, 0);
> +
> +	ret =3D devm_counter_add(dev, counter_dev);
> +	if (ret) {
> +		dev_err(dev, "failed to add counter\n");
> +		pm_runtime_disable(dev);
> +	}
> +
> +	return ret;
> +}
> +
> +static int ecap_cnt_remove(struct platform_device *pdev)
> +{
> +	struct counter_device *counter_dev =3D platform_get_drvdata(pdev);
> +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter_dev);
> +
> +	if (ecap_dev->enabled)
> +		ecap_cnt_capture_disable(counter_dev);
> +
> +	pm_runtime_disable(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +static int ecap_cnt_suspend(struct device *dev)
> +{
> +	struct counter_device *counter_dev =3D dev_get_drvdata(dev);
> +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter_dev);
> +
> +	/* If eCAP is running, stop capture then save timestamp counter */
> +	if (ecap_dev->enabled) {
> +		ecap_cnt_capture_disable(counter_dev);
> +
> +		pm_runtime_get_sync(dev);
> +		regmap_read(ecap_dev->regmap, ECAP_TSCNT_REG, &ecap_dev->pm_ctx.time_c=
ntr);
> +		pm_runtime_put_sync(dev);
> +	}
> +
> +	ecap_dev->pm_ctx.ev_mode =3D ecap_cnt_capture_get_evmode(counter_dev);
> +
> +	return 0;
> +}
> +
> +static int ecap_cnt_resume(struct device *dev)
> +{
> +	struct counter_device *counter_dev =3D dev_get_drvdata(dev);
> +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter_dev);
> +
> +	ecap_cnt_capture_set_evmode(counter_dev, ecap_dev->pm_ctx.ev_mode);
> +
> +	/* If eCAP was running, restore timestamp counter then run capture */
> +	if (ecap_dev->enabled) {
> +		pm_runtime_get_sync(dev);
> +		regmap_write(ecap_dev->regmap, ECAP_TSCNT_REG, ecap_dev->pm_ctx.time_c=
ntr);
> +		pm_runtime_put_sync(dev);
> +
> +		ecap_cnt_capture_enable(counter_dev, false);
> +	}
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(ecap_cnt_pm_ops, ecap_cnt_suspend, ecap_=
cnt_resume);
> +
> +static const struct of_device_id ecap_cnt_of_match[] =3D {
> +	{ .compatible	=3D "ti,am62-ecap-capture" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ecap_cnt_of_match);
> +
> +static struct platform_driver ecap_cnt_driver =3D {
> +	.probe =3D ecap_cnt_probe,
> +	.remove =3D ecap_cnt_remove,
> +	.driver =3D {
> +		.name =3D "ecap-capture",
> +		.of_match_table =3D ecap_cnt_of_match,
> +		.pm =3D pm_sleep_ptr(&ecap_cnt_pm_ops),
> +	},
> +};
> +module_platform_driver(ecap_cnt_driver);
> +
> +MODULE_DESCRIPTION("ECAP Capture driver");
> +MODULE_AUTHOR("Julien Panis <jpanis@baylibre.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
> index 96c5ffd368ad..4c5372c6f2a3 100644
> --- a/include/uapi/linux/counter.h
> +++ b/include/uapi/linux/counter.h
> @@ -63,6 +63,8 @@ enum counter_event_type {
>  	COUNTER_EVENT_INDEX,
>  	/* State of counter is changed */
>  	COUNTER_EVENT_CHANGE_OF_STATE,
> +	/* Count value is captured */
> +	COUNTER_EVENT_CAPTURE,
>  };
> =20
>  /**
> --=20
> 2.25.1
>=20

--FnR7gEYtWnTYunX1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYvkq9AAKCRC1SFbKvhIj
K0BVAQDhFln5vWAtGxnR3LZHXTdPGshQkH+QTlszvTngpoeypgD/QyLpTDn8DmaW
bjIEhoyhIj4Mm3JSRKo4c5xgMRI2EQk=
=42eD
-----END PGP SIGNATURE-----

--FnR7gEYtWnTYunX1--
