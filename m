Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F373859B732
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 03:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiHVBRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 21:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbiHVBRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 21:17:03 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106A720BD0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 18:17:01 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id b2so6902029qkh.12
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 18:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=WVXAkdiIs8qCdp71kfWVrJfdNhiDPacGyIIrV/8vW3Q=;
        b=yBid5atMicd3g3iBzJYgNAkNY3QBQMi8cKTVX1HIanJkuLa4mu+V2ylGtdXe6RymDk
         ktZ3VtDvrI/BE7ewZnZqys/DlSn8NlsZqrMGE6Zp/CnP/uZfJX+r5C3+W4GZ9FZkJ3lM
         OTKGY1PJU1MjuZF+xtUVWOTVofnMday8Cb+z1G3vnRjk14Yo/ogVLKhrizUrq8pctyNj
         YvDd8frn8C5Od7nFVUaLNT9eE19lqz7pEQMskuzPvalFX3FnXpT1HbjpryIIkDD/rLLW
         aisdYaI1aSNvC236QySl3KYZPcEA61lYvvCHtMIptgPkMkdFKFmSfQCyfETUtokADNPj
         ToqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=WVXAkdiIs8qCdp71kfWVrJfdNhiDPacGyIIrV/8vW3Q=;
        b=Io71BcePQkkaojR68guEcPR+ILgSPE2HeBMaMjnENfu7ufgMz2msH7JYkGkWQQi4oP
         My2DhicgVwUzMFo+zFgj26yUEBTkkM26N6/iLkxHjkqFjC6eGNvFD2FSzKjuM72GWMX5
         h/wI0E1Uf1Aus7P5yqAxQZKILRKnQBvOITxWe3Z+ToXMU1hU0QyvWEtWGtMs5OPKTQ2l
         CbF34j3nZ6TIW0plW1ph9YUUCvCSLl0+xcofTujBGdJ8Ro98F2ywKG6FPJcr6RhOPmiU
         IoXIl7FUGiFHrEKCU/2QrRM2RKOBUJIcO48TdLsr3jiRTFifzSXCWPFLbadufT5DYcE7
         ygQw==
X-Gm-Message-State: ACgBeo3BRVWTxY9yQv536YjFjiweAybiq9tuCj6dcXYoWJ26im2pChzd
        RinExNHJM0aBOKjaa71pPvqsaA==
X-Google-Smtp-Source: AA6agR73uQdLSwmBe0AE+AS0LAclYplv+xxA7AGMDiaBIdME6ytvL6kNk/hOS608W4jhBhiFKO03KQ==
X-Received: by 2002:a05:620a:2721:b0:6ba:c74f:1e04 with SMTP id b33-20020a05620a272100b006bac74f1e04mr11271818qkp.605.1661131020037;
        Sun, 21 Aug 2022 18:17:00 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id d23-20020ac851d7000000b00342f6c31da7sm7913187qtn.94.2022.08.21.18.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 18:16:59 -0700 (PDT)
Date:   Sun, 21 Aug 2022 21:16:54 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com
Subject: Re: [PATCH v5 3/3] counter: ti-ecap-capture: capture driver support
 for ECAP
Message-ID: <YwLZBpeeqTnjspCQ@fedora>
References: <20220817141620.256481-1-jpanis@baylibre.com>
 <20220817141620.256481-4-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PAd1UVqmvZMkWQHS"
Content-Disposition: inline
In-Reply-To: <20220817141620.256481-4-jpanis@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PAd1UVqmvZMkWQHS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 17, 2022 at 04:16:20PM +0200, Julien Panis wrote:
> ECAP hardware on TI AM62x SoC supports capture feature. It can be used
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
> ---
>  drivers/counter/Kconfig           |  15 +
>  drivers/counter/Makefile          |   1 +
>  drivers/counter/ti-ecap-capture.c | 624 ++++++++++++++++++++++++++++++
>  include/uapi/linux/counter.h      |   2 +
>  4 files changed, 642 insertions(+)
>  create mode 100644 drivers/counter/ti-ecap-capture.c
>=20
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index 5edd155f1911..08235268af0b 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -101,4 +101,19 @@ config INTEL_QEP
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called intel-qep.
> =20
> +config TI_ECAP_CAPTURE
> +	tristate "TI eCAP capture driver"
> +	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE || ARC=
H_K3 || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	select REGMAP_MMIO
> +	help
> +	  Select this option to enable the Texas Instruments Enhanced Capture
> +	  (eCAP) driver in input mode.
> +
> +	  It can be used to timestamp events (falling/rising edges) detected
> +	  on signal input pin.

The phrase "signal input pin" sounds ambiguous; perhaps "ECAP input
signal" or similar works better here.

> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called ti-ecap-capture.
> +
>  endif # COUNTER
> diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
> index 8fde6c100ebc..b9a369e0d4fc 100644
> --- a/drivers/counter/Makefile
> +++ b/drivers/counter/Makefile
> @@ -14,3 +14,4 @@ obj-$(CONFIG_TI_EQEP)		+=3D ti-eqep.o
>  obj-$(CONFIG_FTM_QUADDEC)	+=3D ftm-quaddec.o
>  obj-$(CONFIG_MICROCHIP_TCB_CAPTURE)	+=3D microchip-tcb-capture.o
>  obj-$(CONFIG_INTEL_QEP)		+=3D intel-qep.o
> +obj-$(CONFIG_TI_ECAP_CAPTURE)	+=3D ti-ecap-capture.o
> diff --git a/drivers/counter/ti-ecap-capture.c b/drivers/counter/ti-ecap-=
capture.c
> new file mode 100644
> index 000000000000..b00ddf122bbd
> --- /dev/null
> +++ b/drivers/counter/ti-ecap-capture.c
> @@ -0,0 +1,624 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * ECAP Capture driver
> + *
> + * Copyright (C) 2022 Julien Panis <jpanis@baylibre.com>
> + */
> +
> +#include <linux/atomic.h>
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
> +/* ECAP event IDs */
> +enum ecap_event_id {
> +	/* Capture events */
> +	ECAP_CEVT1,
> +	ECAP_CEVT2,
> +	ECAP_CEVT3,
> +	ECAP_CEVT4,
> +	/* Counter overflow event */
> +	ECAP_CNTOVF,
> +	/* Helpers for capture events */
> +	ECAP_CEVT_LAST =3D ECAP_CEVT4,
> +	ECAP_NB_CEVT =3D ECAP_CEVT_LAST + 1,
> +	/* Helpers for all events */
> +	ECAP_EVT_LAST =3D ECAP_CNTOVF,
> +	ECAP_NB_EVT =3D ECAP_EVT_LAST + 1,
> +};

You're relying on a side-effect of enum structures to define your ECAP_*
constants in sequence; this obscures the intention of your code and
makes it more difficult to understand the purpose of the constants.
The enum structure is unnecessary; these are register flags so C defines
are sufficent and clear enough to represent these values.

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
> +			   ECAP_EVT_EN_MASK, ECAP_EVT_EN_MASK);
> +
> +	/* Run counter */
> +	regval =3D ECAP_SYNCO_DIS_MASK | ECAP_STOPVALUE_MASK | ECAP_ECCTL_EN_MA=
SK;
> +	if (rearm) {
> +		atomic_set(&ecap_dev->nb_ovf, 0);
> +		regmap_write(ecap_dev->regmap, ECAP_TSCNT_REG, 0);

Looks like you're resetting both nb_ovf and TSCNT here. This combines
too many operations in one extension, whereas extensions are intended to
serve a restricted and well-defined scope of behavior. The "enable"
extension is intended to serve as a pause/unpause mechanism for the
respective Count, so don't reset the Count data here. Instead break
these operations into their own extensions: implement a count_write()
callback to reset TSCNT, and similarly for nb_ovf.

> +static int ecap_cnt_action_read(struct counter_device *counter,
> +				struct counter_count *count,
> +				struct counter_synapse *synapse,
> +				enum counter_synapse_action *action)
> +{
> +	*action =3D COUNTER_SYNAPSE_ACTION_NONE;
> +
> +	return 0;
> +}

This action_read() callback serves both "ECAP Input Signal" and "ECAP
Clock Signal" so you need to check the struct counter_synapse to see
which Signal is being handled. Return COUNTER_SYNAPSE_ACTION_NONE for
ECAP_INPUT_SIG, and COUNTER_SYNAPSE_ACTION_BOTH_EDGES for ECAP_CLOCK_SIG
(assuming TSCNT increments on both edges of the clock).

> +
> +static int ecap_cnt_watch_validate(struct counter_device *counter,
> +				   const struct counter_watch *watch)
> +{
> +	return (watch->channel =3D=3D ECAP_CHAN &&
> +		(watch->event =3D=3D COUNTER_EVENT_CAPTURE ||
> +		 watch->event =3D=3D COUNTER_EVENT_OVERFLOW)) ? 0 : -EINVAL;

One-liners are typically nice, but it is difficult to parse the meaning
of expressions with multiple layers. The logic of this conditional check
is clearer if you separate the channel validation from the event type
validation with their own if-statement blocks.

> +static int ecap_cnt_cap_set_pol(struct counter_device *counter,
> +				struct counter_signal *signal,
> +				u8 inst, u32 pol)
> +{
> +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter);
> +
> +	if (ecap_dev->enabled)
> +		return -EBUSY;
> +	if (pol > 1)
> +		return -EINVAL;

The boundary check for "pol" can be removed; COUNTER_COMP_SIGNAL_ENUM
already ensures that "pol" will be within the boundaries of your Counter
enum array.

> +static int ecap_cnt_count_cumul_read(struct counter_device *counter,
> +				     struct counter_count *count, u64 *val)
> +{
> +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter);
> +
> +	*val =3D ((u64)U32_MAX + 1) * atomic_read(&ecap_dev->nb_ovf);
> +
> +	return 0;
> +}

Reimplement this as "ceiling" and "num_overflows"; simply return U32_MAX
and nb_ovf respectively.

> +static int ecap_cnt_clk_get_freq(struct counter_device *counter,
> +				 struct counter_signal *signal, u64 *freq)
> +{
> +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter);
> +
> +	*freq =3D ecap_dev->clk_rate;

Looks like this is the only place you ever use clk_rate. Just perform
the clk_get_rate() call here and you won't need clk_rate in ecap_dev
anymore.

> +static const struct counter_ops ecap_cnt_ops =3D {
> +	.count_read =3D ecap_cnt_count_read,
> +	.function_read =3D ecap_cnt_function_read,
> +	.action_read =3D ecap_cnt_action_read,
> +	.watch_validate =3D ecap_cnt_watch_validate,
> +};

Add a count_write callback to set TSCNT. This will allow users to reset
TSCNT back to 0 when desired.

> +static const enum counter_synapse_action ecap_cnt_actions[] =3D {
> +	COUNTER_SYNAPSE_ACTION_NONE,
> +};

Define a second array with just COUNTER_SYNAPSE_ACTION_BOTH_EDGES for
the clock Signal (assuming the count increments on both edges) and pass
it to the respective clock signal Synapse actions_list.

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

Zero-based indexing is typically expected so start at polarity0 instead
of polarity1.

> +static struct counter_signal ecap_cnt_signals[] =3D {
> +	{
> +		.id =3D ECAP_INPUT_SIG,
> +		.name =3D "ECAP Input Signal",
> +		.ext =3D ecap_cnt_signal_ext,
> +		.num_ext =3D ARRAY_SIZE(ecap_cnt_signal_ext),
> +	},
> +	{
> +		.id =3D ECAP_CLOCK_SIG,
> +		.name =3D "ECAP Clock Signal",
> +		.ext =3D ecap_cnt_clock_ext,
> +		.num_ext =3D ARRAY_SIZE(ecap_cnt_clock_ext),
> +	},
> +};
> +
> +static struct counter_synapse ecap_cnt_synapses[] =3D {
> +	{
> +		.actions_list =3D ecap_cnt_actions,
> +		.num_actions =3D ARRAY_SIZE(ecap_cnt_actions),
> +		.signal =3D &ecap_cnt_signals[ECAP_INPUT_SIG],
> +	},
> +	{
> +		.actions_list =3D ecap_cnt_actions,
> +		.num_actions =3D ARRAY_SIZE(ecap_cnt_actions),
> +		.signal =3D &ecap_cnt_signals[ECAP_CLOCK_SIG],
> +	},
> +};

I find it more natural to list the clock signal first because that's
what's incrementing the TSCNT counter. But this isn't necessarily wrong,
so I'll leave it up to you if you want to reorder your Signals and
Synapses arrays.

> +static struct counter_comp ecap_cnt_count_ext[] =3D {
> +	COUNTER_COMP_COUNT_U64("capture1", ecap_cnt_cap1_read, NULL),
> +	COUNTER_COMP_COUNT_U64("capture2", ecap_cnt_cap2_read, NULL),
> +	COUNTER_COMP_COUNT_U64("capture3", ecap_cnt_cap3_read, NULL),
> +	COUNTER_COMP_COUNT_U64("capture4", ecap_cnt_cap4_read, NULL),

Same comment about zero-based indexing here as with the polarity
extensions: start with capture0 instead of capture 1.

> +	COUNTER_COMP_COUNT_U64("count_cumul", ecap_cnt_count_cumul_read, NULL),
> +	COUNTER_COMP_ENABLE(ecap_cnt_enable_read, ecap_cnt_enable_write),
> +};

Replace "count_cumul" with "num_overflows" (COUNTER_COMP_COUNT_U64) and
"ceiling" (COUNTER_COMP_CEILING).

> +static struct counter_count ecap_cnt_counts[] =3D {
> +	{
> +		.id =3D 0,
> +		.name =3D "ECAP Timestamp Counter",

You probably don't need "ECAP" in the Count name because users already
know they interacting with an ECAP device when they read the sysfs
"counterX/name" attribute.

> +static irqreturn_t ecap_cnt_isr(int irq, void *dev_id)
> +{
> +	struct counter_device *counter_dev =3D dev_id;
> +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter_dev);
> +	unsigned int clr =3D 0;
> +	unsigned int flg;
> +	int i;
> +
> +	regmap_read(ecap_dev->regmap, ECAP_ECINT_EN_FLG_REG, &flg);
> +
> +	for (i =3D ECAP_CEVT_LAST ; i <=3D ECAP_EVT_LAST ; i++) {
> +		if (flg & ECAP_EVT_FLG_BIT(i)) {

Use the for_each_set_bit() macro to simplify this for-loop+if check.

> +			if (i !=3D ECAP_CNTOVF) {

Move the check for overflow outside of the for-loop because it's
conceptually unrelated to the other flags. The for-loop can then be
focused on just the capture events.

> +				/* Input signal edge detected on last CAP (CAP4) */
> +				counter_push_event(counter_dev, COUNTER_EVENT_CAPTURE, ECAP_CHAN);

Restricting event pushes to just CAP4 means losing three quarters of the
possible captures events this device is capable of reporting. By pushing
a Counter event on every capture, users have much finer control over the
operation of their device, allowing them to perform measurements of
instantaneous pulse widths among other such cycle analyses.

Your particular use-case requires analysing four captures at a time. If
you push every capture event on the same channel, you would have to
ignore the majority of them; checking for CAP4 on every capture event is
cumbersome for userspace in such a scenario. To reconcile the need to
report all device events with the desire to filter some of those capture
events, the solution is to push each CAPx event to respective Counter
event channels::

    counter_push_event(counter_dev, COUNTER_EVENT_CAPTURE, i);

This intuitively matches an update to a capture buffer element with a
respective Counter event channel. For your use-case, this requires no
change to a userspace application reading the sysfs attributes, and a
minimal change to one interacting with the character device node:
specifying the particular Counter event channel in your Counter watches;
the rest of users are able to watch all capture events, or just some, as
they please.

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
> +	ecap_dev->clk =3D devm_clk_get_enabled(dev, "fck");
> +	if (IS_ERR(ecap_dev->clk))
> +		return dev_err_probe(dev, PTR_ERR(ecap_dev->clk), "failed to get clock=
\n");
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
> +	ret =3D platform_get_irq(pdev, 0);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to get irq\n");
> +
> +	ret =3D devm_request_irq(dev, ret, ecap_cnt_isr, 0, pdev->name, counter=
_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to request irq\n");
> +
> +	platform_set_drvdata(pdev, counter_dev);
> +
> +	pm_runtime_enable(dev);
> +
> +	/* Register a cleanup callback to care for disabling PM */
> +	ret =3D devm_add_action_or_reset(dev, ecap_cnt_pm_disable, dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to add pm disable action\n");
> +
> +	ecap_dev->enabled =3D 0;

The devm_counter_alloc() function ensures your ecap_dev structure is
zero-initialized so you don't need to explicitly set "enabled" to 0
here. However, it's not harmful so I'll leave it up to you if you want
to remove this line.

William Breathitt Gray

--PAd1UVqmvZMkWQHS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYwLZBgAKCRC1SFbKvhIj
K7n6AQC6m1hZL7zaHXXgI7K3A2JfiIKjCFl5E8Yl493eZc2P6QD/c5LSpIIf7CVz
4dkI9ONABCUAZ1f7aJRpj4SP5TqPFwo=
=VYRz
-----END PGP SIGNATURE-----

--PAd1UVqmvZMkWQHS--
