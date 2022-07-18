Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4882D577D52
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 10:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiGRIRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 04:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbiGRIRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:17:30 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080D618E15
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:17:29 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v16so15860503wrd.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zJeInjN5r9TMT8hJyXQShX1SUirIzM/Qvoov0K4gWZw=;
        b=KHB5NXU0K2rWPNbHDnAsyA4m/9dPTg5OzyDvJD4tRi9xqxRP8sB/UCQWyjG8mgJ3Fm
         yUIi0jaheXtaZBoKc2DveqzZysee53BlzSmak0FEvHZELjKVe2mCH5v9zvuFMUFKytuT
         Gk6XkDEc94Bj/Hwkp7xTfr47teLzU13/cGxdl8l5khxD1PPmjrZ5xjymStZSSuyT3Yi0
         KUm52Nl7EQPCv6L7QNzwa2YSuCr0jJl+aCDj1IDTx78A+qeG+uQ0IPrydbo538ET4CRR
         rF8jvWwD929Rfp9cUmlMCxVJT7Ko4AwxenU+HOVARoNlBsbkbCpXs/nXsAfzsoMSxsrr
         +6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zJeInjN5r9TMT8hJyXQShX1SUirIzM/Qvoov0K4gWZw=;
        b=wCL/MwHNfGyfgLLwT6iseoyQlbKD8NkmJEe+Lgk3p2hELjN38VIxJt5AtRXw0pJnHH
         qkcm0gZG67IVppCCD/QTPl8cDAFHj/WB331wPU4mnRiuNNY0se5a5u1xrnrwgEwh58Pr
         vJ8SenOvh42EdkAQ/gCIfQNoQZHbYP6NYc1Gg+Iqu/pDTlqJvraQOy2O4oorNrfnliyN
         gFgJ2pAMaMUal6lDO/5x12Cq3ybjKjIS8Tgkb66YPtJcz4XV0/25Yi/S01XRE2RPMKkQ
         FHhtPPYcCdh/dzPc694zS2fpuOj2EXF1gnWfl07kqceFDLEgtfnBJ3LcvgItsnb4IWov
         R0Hw==
X-Gm-Message-State: AJIora9ug3jEJsUkUZ89Q45/4A/yfCFR3W3Ee94AmhSNewrUezZqEjRU
        +otSCdaeF9wDPjxukdXfy8hSCw==
X-Google-Smtp-Source: AGRyM1tCGbQKJQQACy70Ey414eoo+xFjNO70n9Ld0lobkkoMr/BC6pV4DV9fpmthJWPsjb6jV4JvpQ==
X-Received: by 2002:a05:6000:1681:b0:21d:85a7:4ed with SMTP id y1-20020a056000168100b0021d85a704edmr21637533wrd.345.1658132247446;
        Mon, 18 Jul 2022 01:17:27 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id f5-20020a5d58e5000000b0021d83071683sm10035718wrd.64.2022.07.18.01.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 01:17:26 -0700 (PDT)
Date:   Mon, 18 Jul 2022 09:17:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 4/5] mfd: sm5703: Add support for SM5703 MFD
Message-ID: <YtUXFTx1+vSrXx70@google.com>
References: <20220423085319.483524-1-markuss.broks@gmail.com>
 <20220423085319.483524-5-markuss.broks@gmail.com>
 <Yqj+aUNLC00Tcu49@google.com>
 <5498bf71-66a5-957e-ed3d-13e68b982562@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5498bf71-66a5-957e-ed3d-13e68b982562@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022, Markuss Broks wrote:

> Hi Lee,
> 
> Sorry to bother you again, but I've got additional questions while I was
> preparing the next version of the series:
> 
> On 6/15/22 00:32, Lee Jones wrote:
> > On Sat, 23 Apr 2022, Markuss Broks wrote:
> > 
> > > Silicon Mitus SM5703 is a multi-function device, meant to be
> > Please avoid using the term MFD.
> > 
> > How is the device described in the data-sheet?
> > 
> > What do you mean by "meant to be"?
> > 
> > > used in mobile devices. It has several modules: LDO, BUCK regulators,
> > Modules or functions?
> > 
> > > charger circuit, flash LED driver, a fuel gauge for monitoring the battery
> > > and a MUIC USB switcher. The MUIC and fuel gauge parts are separate in that
> > > they use separate i2c lines to communicate with the device, while charger
> > "I2C"
> > 
> > > circuit, LED driver and regulators are on the main i2c line the device is
> > > controlled with.
> > > 
> > > Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> > > ---
> > >   MAINTAINERS                |   8 +++
> > >   drivers/mfd/Kconfig        |  13 +++++
> > >   drivers/mfd/Makefile       |   1 +
> > >   drivers/mfd/sm5703.c       |  78 +++++++++++++++++++++++++++
> > >   include/linux/mfd/sm5703.h | 105 +++++++++++++++++++++++++++++++++++++
> > >   5 files changed, 205 insertions(+)
> > >   create mode 100644 drivers/mfd/sm5703.c
> > >   create mode 100644 include/linux/mfd/sm5703.h
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 6157e706ed02..6125ed1a3be4 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -18172,6 +18172,14 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
> > >   F:	include/linux/srcu*.h
> > >   F:	kernel/rcu/srcu*.c
> > > +SM5703 MFD DRIVER
> > > +M:	Markuss Broks <markuss.broks@gmail.com>
> > > +S:	Maintained
> > > +F:	Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
> > > +F:	Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
> > > +F:	drivers/mfd/sm5703.c
> > > +F:	drivers/regulator/sm5703-regulator.c
> > > +
> > >   SMACK SECURITY MODULE
> > >   M:	Casey Schaufler <casey@schaufler-ca.com>
> > >   L:	linux-security-module@vger.kernel.org
> > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > index 3b59456f5545..c13a99ceae99 100644
> > > --- a/drivers/mfd/Kconfig
> > > +++ b/drivers/mfd/Kconfig
> > > @@ -1237,6 +1237,19 @@ config MFD_SM501
> > >   	  interface. The device may be connected by PCI or local bus with
> > >   	  varying functions enabled.
> > > +config MFD_SM5703
> > > +	tristate "Silicon Mitus SM5703 MFD"
> > > +	depends on I2C
> > > +	depends on OF
> > > +	select MFD_CORE
> > > +	select REGMAP_I2C
> > > +	help
> > > +	  This is the core driver for the Silicon Mitus SM5703 multi-function
> > Please drop the MFD term, as above.
> > 
> > > +	  device. This device is meant to be used in phones and it has numerous
> > "meant to be"?
> > 
> > > +	  modules, including LED controller, regulators, fuel gauge, MUIC and
> > Either "an LED controller" or "LED controllers"
> > 
> > Same with "charger circuit" below.
> > 
> > > +	  charger circuit. It also support muxing a serial interface over USB
> > "supports"
> > 
> > What kind of serial?
> > 
> > > +	  data lines.
> > > +
> > >   config MFD_SM501_GPIO
> > >   	bool "Export GPIO via GPIO layer"
> > >   	depends on MFD_SM501 && GPIOLIB
> > > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > > index 858cacf659d6..ca8b86736a36 100644
> > > --- a/drivers/mfd/Makefile
> > > +++ b/drivers/mfd/Makefile
> > > @@ -275,3 +275,4 @@ rsmu-i2c-objs			:= rsmu_core.o rsmu_i2c.o
> > >   rsmu-spi-objs			:= rsmu_core.o rsmu_spi.o
> > >   obj-$(CONFIG_MFD_RSMU_I2C)	+= rsmu-i2c.o
> > >   obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu-spi.o
> > > +obj-$(CONFIG_MFD_SM5703)	+= sm5703.o
> > > diff --git a/drivers/mfd/sm5703.c b/drivers/mfd/sm5703.c
> > > new file mode 100644
> > > index 000000000000..7f9838149051
> > > --- /dev/null
> > > +++ b/drivers/mfd/sm5703.c
> > > @@ -0,0 +1,78 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +
> > > +#include <linux/err.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/gpio/consumer.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/mfd/core.h>
> > > +#include <linux/mfd/sm5703.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/regmap.h>
> > > +
> > > +static const struct mfd_cell sm5703_devs[] = {
> > > +	{ .name = "sm5703-regulator", },
> > > +};
> > Where are the rest of the child drivers?
> Should those devices still be present even though there's no driver for them
> (yet) ? I have a WIP version of driver for almost every function, but I
> currently lack time to get them done.

Without them the driver-set is useless, no?

We try to refrain from applying dead code.

A lot of it has a tendency to stay that way.

[...]

> > > +++ b/include/linux/mfd/sm5703.h
> > > @@ -0,0 +1,105 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +
> > > +#ifndef _SM5703_H
> > > +#define _SM5703_H
> > > +
> > > +struct sm5703_dev {
> > > +	struct device *dev;
> > > +	struct regmap *regmap;
> > > +	struct gpio_desc *reset_gpio;
> > > +};
> > > +
> > > +// Regulator-related defines
> > No C++ style comments.
> > 
> > > +#define SM5703_REG_LDO1				0x1A
> > I'd drop the REG parts from these.
> I have no issues with that, however the already upstreamed sm5703-regulator
> driver uses those defines. If I change the define name, how should I make
> changes in that driver, would it be reasonable to send an additional patch
> together with the new MFD series?

It would.  You could also keep them in for now.

They're not a major blocker.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
