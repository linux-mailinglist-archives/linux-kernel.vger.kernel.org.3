Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF3957B785
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbiGTNaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240449AbiGTNaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:30:09 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034E565545
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:29:49 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id f24-20020a1cc918000000b003a30178c022so1348158wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DK1JQpkmSmLaPYH2VON507TntVLKPJOm+v6NeqoLJWM=;
        b=NbQT+2v4JM6NlAKDlXu8hnf2t6kvTJUAF6wCxYAR7cgqyxTdWVQzCbYhx7/BMdCByy
         ln8U64JRNkIz/AZZc2+xeMmCzYiHhuC2B3t2efDBv7sLKZWuEmQppFmDVbXC7y+XAdRw
         J7S1l7rXQDoR3d8PRqglLlAjbe2c8RPy6kv9PXj3nxmTrMTCGoA2lNtxry4PuaFUi8wT
         lIp5muDMKkr9jm0Ta0Q8OhTvjHuKHuhS9Y6p/V5ZKYZTP0Wi6ZP5pz4dOVebwcRLLPyV
         T5bmH20bTYQEjZf6Q5oksYmDdZvrM738FVURukBLjJPaSHHgV2xtH7bdArOmA1ZHksnt
         /X4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DK1JQpkmSmLaPYH2VON507TntVLKPJOm+v6NeqoLJWM=;
        b=581Ba8QOtrob1b73nm5t7eC8jD66h/njSutyBjabkeTZvxOUE4r994ScAnc/eJ4Myx
         NDRc0bgtC4moee+B46aJZBcnxyML5BnNRYN7QbOfQG12GJ7jEwPIBwezqs0tYdzLqczq
         XJZXrVjn1xlW4mFGSWCiY9nIgn690URPHmpEEJucMOpgDO5zJRJo2tTBwh8FQ30pkztC
         kYiSpDssihI3l6oXwXLC+v4w8r90N4kL4Ys1CBMAJ7Jj3J+YE52V3cwdhcUiMTmxpS/m
         5AVYF+G+mMT7oiNUqm4F1Yk0hjYFOlO71U1NuVFLwcV/IxgqJmqxTW4GJLFHQ4dZRMRO
         sLQw==
X-Gm-Message-State: AJIora9QtKoYk8iI8V0t3TShPfhXnNGbwh4NRn8D/1HFF141akmSvlQi
        +32gI0tWVbCocGaYOuiwJz8Bgg==
X-Google-Smtp-Source: AGRyM1sw+SHCwJS/cMVhYgkOZ7Jkh8g5qCEQsE4blkm+DE0L1zRJRaOicmhj9zlyoyKY52uI83rD2g==
X-Received: by 2002:a7b:c401:0:b0:3a2:ca58:85bc with SMTP id k1-20020a7bc401000000b003a2ca5885bcmr3942374wmi.156.1658323787988;
        Wed, 20 Jul 2022 06:29:47 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id u4-20020a05600c00c400b0039c454067ddsm2456381wmm.15.2022.07.20.06.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 06:29:47 -0700 (PDT)
Date:   Wed, 20 Jul 2022 14:29:45 +0100
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
Message-ID: <YtgDSelfobu/a/be@google.com>
References: <20220423085319.483524-1-markuss.broks@gmail.com>
 <20220423085319.483524-5-markuss.broks@gmail.com>
 <Yqj+aUNLC00Tcu49@google.com>
 <5498bf71-66a5-957e-ed3d-13e68b982562@gmail.com>
 <YtUXFTx1+vSrXx70@google.com>
 <295e1809-f6f2-ca31-5c36-be133ffdc93b@gmail.com>
 <Yte7Tgq3w8fowTYA@google.com>
 <4be15cff-b0af-8671-57aa-6567c0206715@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4be15cff-b0af-8671-57aa-6567c0206715@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2022, Markuss Broks wrote:

> Hi Lee,
> 
> On 7/20/22 11:22, Lee Jones wrote:
> > On Tue, 19 Jul 2022, Markuss Broks wrote:
> > 
> > > Hi Lee,
> > > 
> > > On 7/18/22 11:17, Lee Jones wrote:
> > > > On Fri, 15 Jul 2022, Markuss Broks wrote:
> > > > 
> > > > > Hi Lee,
> > > > > 
> > > > > Sorry to bother you again, but I've got additional questions while I was
> > > > > preparing the next version of the series:
> > > > > 
> > > > > On 6/15/22 00:32, Lee Jones wrote:
> > > > > > On Sat, 23 Apr 2022, Markuss Broks wrote:
> > > > > > 
> > > > > > > Silicon Mitus SM5703 is a multi-function device, meant to be
> > > > > > Please avoid using the term MFD.
> > > > > > 
> > > > > > How is the device described in the data-sheet?
> > > > > > 
> > > > > > What do you mean by "meant to be"?
> > > > > > 
> > > > > > > used in mobile devices. It has several modules: LDO, BUCK regulators,
> > > > > > Modules or functions?
> > > > > > 
> > > > > > > charger circuit, flash LED driver, a fuel gauge for monitoring the battery
> > > > > > > and a MUIC USB switcher. The MUIC and fuel gauge parts are separate in that
> > > > > > > they use separate i2c lines to communicate with the device, while charger
> > > > > > "I2C"
> > > > > > 
> > > > > > > circuit, LED driver and regulators are on the main i2c line the device is
> > > > > > > controlled with.
> > > > > > > 
> > > > > > > Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> > > > > > > ---
> > > > > > >     MAINTAINERS                |   8 +++
> > > > > > >     drivers/mfd/Kconfig        |  13 +++++
> > > > > > >     drivers/mfd/Makefile       |   1 +
> > > > > > >     drivers/mfd/sm5703.c       |  78 +++++++++++++++++++++++++++
> > > > > > >     include/linux/mfd/sm5703.h | 105 +++++++++++++++++++++++++++++++++++++
> > > > > > >     5 files changed, 205 insertions(+)
> > > > > > >     create mode 100644 drivers/mfd/sm5703.c
> > > > > > >     create mode 100644 include/linux/mfd/sm5703.h
> > > > > > > 
> > > > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > > > index 6157e706ed02..6125ed1a3be4 100644
> > > > > > > --- a/MAINTAINERS
> > > > > > > +++ b/MAINTAINERS
> > > > > > > @@ -18172,6 +18172,14 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
> > > > > > >     F:	include/linux/srcu*.h
> > > > > > >     F:	kernel/rcu/srcu*.c
> > > > > > > +SM5703 MFD DRIVER
> > > > > > > +M:	Markuss Broks <markuss.broks@gmail.com>
> > > > > > > +S:	Maintained
> > > > > > > +F:	Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
> > > > > > > +F:	Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
> > > > > > > +F:	drivers/mfd/sm5703.c
> > > > > > > +F:	drivers/regulator/sm5703-regulator.c
> > > > > > > +
> > > > > > >     SMACK SECURITY MODULE
> > > > > > >     M:	Casey Schaufler <casey@schaufler-ca.com>
> > > > > > >     L:	linux-security-module@vger.kernel.org
> > > > > > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > > > > > index 3b59456f5545..c13a99ceae99 100644
> > > > > > > --- a/drivers/mfd/Kconfig
> > > > > > > +++ b/drivers/mfd/Kconfig
> > > > > > > @@ -1237,6 +1237,19 @@ config MFD_SM501
> > > > > > >     	  interface. The device may be connected by PCI or local bus with
> > > > > > >     	  varying functions enabled.
> > > > > > > +config MFD_SM5703
> > > > > > > +	tristate "Silicon Mitus SM5703 MFD"
> > > > > > > +	depends on I2C
> > > > > > > +	depends on OF
> > > > > > > +	select MFD_CORE
> > > > > > > +	select REGMAP_I2C
> > > > > > > +	help
> > > > > > > +	  This is the core driver for the Silicon Mitus SM5703 multi-function
> > > > > > Please drop the MFD term, as above.
> > > > > > 
> > > > > > > +	  device. This device is meant to be used in phones and it has numerous
> > > > > > "meant to be"?
> > > > > > 
> > > > > > > +	  modules, including LED controller, regulators, fuel gauge, MUIC and
> > > > > > Either "an LED controller" or "LED controllers"
> > > > > > 
> > > > > > Same with "charger circuit" below.
> > > > > > 
> > > > > > > +	  charger circuit. It also support muxing a serial interface over USB
> > > > > > "supports"
> > > > > > 
> > > > > > What kind of serial?
> > > > > > 
> > > > > > > +	  data lines.
> > > > > > > +
> > > > > > >     config MFD_SM501_GPIO
> > > > > > >     	bool "Export GPIO via GPIO layer"
> > > > > > >     	depends on MFD_SM501 && GPIOLIB
> > > > > > > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > > > > > > index 858cacf659d6..ca8b86736a36 100644
> > > > > > > --- a/drivers/mfd/Makefile
> > > > > > > +++ b/drivers/mfd/Makefile
> > > > > > > @@ -275,3 +275,4 @@ rsmu-i2c-objs			:= rsmu_core.o rsmu_i2c.o
> > > > > > >     rsmu-spi-objs			:= rsmu_core.o rsmu_spi.o
> > > > > > >     obj-$(CONFIG_MFD_RSMU_I2C)	+= rsmu-i2c.o
> > > > > > >     obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu-spi.o
> > > > > > > +obj-$(CONFIG_MFD_SM5703)	+= sm5703.o
> > > > > > > diff --git a/drivers/mfd/sm5703.c b/drivers/mfd/sm5703.c
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..7f9838149051
> > > > > > > --- /dev/null
> > > > > > > +++ b/drivers/mfd/sm5703.c
> > > > > > > @@ -0,0 +1,78 @@
> > > > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > > > +
> > > > > > > +#include <linux/err.h>
> > > > > > > +#include <linux/delay.h>
> > > > > > > +#include <linux/gpio/consumer.h>
> > > > > > > +#include <linux/i2c.h>
> > > > > > > +#include <linux/mfd/core.h>
> > > > > > > +#include <linux/mfd/sm5703.h>
> > > > > > > +#include <linux/module.h>
> > > > > > > +#include <linux/of_device.h>
> > > > > > > +#include <linux/regmap.h>
> > > > > > > +
> > > > > > > +static const struct mfd_cell sm5703_devs[] = {
> > > > > > > +	{ .name = "sm5703-regulator", },
> > > > > > > +};
> > > > > > Where are the rest of the child drivers?
> > > > > Should those devices still be present even though there's no driver for them
> > > > > (yet) ? I have a WIP version of driver for almost every function, but I
> > > > > currently lack time to get them done.
> > > > Without them the driver-set is useless, no?
> > > > 
> > > > We try to refrain from applying dead code.
> > > > 
> > > > A lot of it has a tendency to stay that way.
> > > Well, in my opinion, having just the regulator driver is already useful
> > > enough: my board (Samsung Galaxy J5 (2015) ) uses one of LDO outputs for
> > > powering the touchscreen. Touchscreen is kind of vital functionality for a
> > > phone so I decided to upstream parts that are necessary for it first and
> > > finish up other stuff later. It's not the only board that uses SM5703's
> > > regulators for supplying all different kinds of hardware, either.

> > Upstreaming functionality which is useful on its own is fine, but that
> > doesn't tick all of the boxes to justify an MFD.  This is a lot of
> > code which is hard to justify if it only registers a Regulator driver.

> Do you think I should hold on this series until I have other things done?
> Alternatively, I could make the regulator driver standalone, dedicated, but
> then when I'd add other functionality I'd have to redo it and add the MFD
> driver back, that I believe would be quite annoying from maintainers' and
> sanity perspective. The other functions left on the main control I2C are
> also not really "vital" to device's functionality (Flash LED and charger),
> so the regulator function makes the most sense to be available first, which
> was my motivation behind upstreaming that first.

What's the reason for this being an MFD in the first place?

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
