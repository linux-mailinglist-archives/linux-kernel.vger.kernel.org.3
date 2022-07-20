Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0563057B2CD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 10:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239974AbiGTIWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 04:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239877AbiGTIWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 04:22:43 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049EE6BC28
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:22:41 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bk26so25023246wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zNztUh6p8QlexvR3ymKoFnbrTntENcC8FNn5qsdnr04=;
        b=jpxh+1Joi2LXODFXFO27Ji9zy+L9BrEv9z2MH4aI8OofyOaJ8DBWYfNVqLAfsDy9wF
         VhNKlohUWkkIiDi6LXlOUf4IvQuAXix13q8FoJJiu4OD+5gp8o2qOMQ7cFykGEdv8Xmo
         794t9IcX/cC08ErPDP9G1+sfMvxq6pNuvESQ2jCKZMPA0S3PShrEnp7wjUpR+P7hZR6h
         sdkxeKJS0WW2bMH0SEEabzTrCTSj0L4wZ3gIOoV7C5VsjOnBt0GIFJqV1LoYVG5dlWwm
         McUDUmyJ4+3RuGNEler94/CLHXcZcRVk5CuW8Y7X+klqjrXseBZSrDOHn87ttqNJ51l+
         tioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zNztUh6p8QlexvR3ymKoFnbrTntENcC8FNn5qsdnr04=;
        b=8PCXdl8m8kGERUCTemTyN5Ymoqxmejp9WVLH/NMcnFlVErTXDEO1fP5Bk0S8vjyEy+
         2pXN5c8soQ/Nq2ffth7kFTUnyOMiXXp8naB6typPnbDSK2LC15zDVKSg+hlYhy7AB/To
         rghZ2ZgwfWl3DyeoxaRWIirCz1sQ0M+nLbCA8ZMnDm/xJeLcgAK5eFYmivjrJ/mfEnOA
         BzR9J9EMKZ/BVci68IQICdvEtJg7NEe0mt9jE5Ka/XoI+d+w7vCG90VDqxgEMSBnufLl
         CA59CsepGmjFyakINLuSBquJWlehGXkvtbTMGP/W0JOOTsF4sHWUFuxTg6sttuuklQO+
         WAqg==
X-Gm-Message-State: AJIora8vCPaBCHKZXx9BvfVHZgyozI04V4BxRrASHysdULuyrs/qYTGC
        Bqw6BHhvTZHyeDJ5M5QsRBUPwg==
X-Google-Smtp-Source: AGRyM1vVWdYXwzYj15yVGb0oLrG8ROtJxu5aOUmyxArxI+j1STpgDzT2Rlfx3Hd11V92QdZNicdH7g==
X-Received: by 2002:a5d:58ef:0:b0:21d:9fc8:302e with SMTP id f15-20020a5d58ef000000b0021d9fc8302emr28758844wrd.22.1658305360419;
        Wed, 20 Jul 2022 01:22:40 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id z12-20020adfdf8c000000b0021e4cf58155sm410748wrl.17.2022.07.20.01.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 01:22:39 -0700 (PDT)
Date:   Wed, 20 Jul 2022 09:22:38 +0100
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
Message-ID: <Yte7Tgq3w8fowTYA@google.com>
References: <20220423085319.483524-1-markuss.broks@gmail.com>
 <20220423085319.483524-5-markuss.broks@gmail.com>
 <Yqj+aUNLC00Tcu49@google.com>
 <5498bf71-66a5-957e-ed3d-13e68b982562@gmail.com>
 <YtUXFTx1+vSrXx70@google.com>
 <295e1809-f6f2-ca31-5c36-be133ffdc93b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <295e1809-f6f2-ca31-5c36-be133ffdc93b@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022, Markuss Broks wrote:

> Hi Lee,
> 
> On 7/18/22 11:17, Lee Jones wrote:
> > On Fri, 15 Jul 2022, Markuss Broks wrote:
> > 
> > > Hi Lee,
> > > 
> > > Sorry to bother you again, but I've got additional questions while I was
> > > preparing the next version of the series:
> > > 
> > > On 6/15/22 00:32, Lee Jones wrote:
> > > > On Sat, 23 Apr 2022, Markuss Broks wrote:
> > > > 
> > > > > Silicon Mitus SM5703 is a multi-function device, meant to be
> > > > Please avoid using the term MFD.
> > > > 
> > > > How is the device described in the data-sheet?
> > > > 
> > > > What do you mean by "meant to be"?
> > > > 
> > > > > used in mobile devices. It has several modules: LDO, BUCK regulators,
> > > > Modules or functions?
> > > > 
> > > > > charger circuit, flash LED driver, a fuel gauge for monitoring the battery
> > > > > and a MUIC USB switcher. The MUIC and fuel gauge parts are separate in that
> > > > > they use separate i2c lines to communicate with the device, while charger
> > > > "I2C"
> > > > 
> > > > > circuit, LED driver and regulators are on the main i2c line the device is
> > > > > controlled with.
> > > > > 
> > > > > Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> > > > > ---
> > > > >    MAINTAINERS                |   8 +++
> > > > >    drivers/mfd/Kconfig        |  13 +++++
> > > > >    drivers/mfd/Makefile       |   1 +
> > > > >    drivers/mfd/sm5703.c       |  78 +++++++++++++++++++++++++++
> > > > >    include/linux/mfd/sm5703.h | 105 +++++++++++++++++++++++++++++++++++++
> > > > >    5 files changed, 205 insertions(+)
> > > > >    create mode 100644 drivers/mfd/sm5703.c
> > > > >    create mode 100644 include/linux/mfd/sm5703.h
> > > > > 
> > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > index 6157e706ed02..6125ed1a3be4 100644
> > > > > --- a/MAINTAINERS
> > > > > +++ b/MAINTAINERS
> > > > > @@ -18172,6 +18172,14 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
> > > > >    F:	include/linux/srcu*.h
> > > > >    F:	kernel/rcu/srcu*.c
> > > > > +SM5703 MFD DRIVER
> > > > > +M:	Markuss Broks <markuss.broks@gmail.com>
> > > > > +S:	Maintained
> > > > > +F:	Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
> > > > > +F:	Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
> > > > > +F:	drivers/mfd/sm5703.c
> > > > > +F:	drivers/regulator/sm5703-regulator.c
> > > > > +
> > > > >    SMACK SECURITY MODULE
> > > > >    M:	Casey Schaufler <casey@schaufler-ca.com>
> > > > >    L:	linux-security-module@vger.kernel.org
> > > > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > > > index 3b59456f5545..c13a99ceae99 100644
> > > > > --- a/drivers/mfd/Kconfig
> > > > > +++ b/drivers/mfd/Kconfig
> > > > > @@ -1237,6 +1237,19 @@ config MFD_SM501
> > > > >    	  interface. The device may be connected by PCI or local bus with
> > > > >    	  varying functions enabled.
> > > > > +config MFD_SM5703
> > > > > +	tristate "Silicon Mitus SM5703 MFD"
> > > > > +	depends on I2C
> > > > > +	depends on OF
> > > > > +	select MFD_CORE
> > > > > +	select REGMAP_I2C
> > > > > +	help
> > > > > +	  This is the core driver for the Silicon Mitus SM5703 multi-function
> > > > Please drop the MFD term, as above.
> > > > 
> > > > > +	  device. This device is meant to be used in phones and it has numerous
> > > > "meant to be"?
> > > > 
> > > > > +	  modules, including LED controller, regulators, fuel gauge, MUIC and
> > > > Either "an LED controller" or "LED controllers"
> > > > 
> > > > Same with "charger circuit" below.
> > > > 
> > > > > +	  charger circuit. It also support muxing a serial interface over USB
> > > > "supports"
> > > > 
> > > > What kind of serial?
> > > > 
> > > > > +	  data lines.
> > > > > +
> > > > >    config MFD_SM501_GPIO
> > > > >    	bool "Export GPIO via GPIO layer"
> > > > >    	depends on MFD_SM501 && GPIOLIB
> > > > > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > > > > index 858cacf659d6..ca8b86736a36 100644
> > > > > --- a/drivers/mfd/Makefile
> > > > > +++ b/drivers/mfd/Makefile
> > > > > @@ -275,3 +275,4 @@ rsmu-i2c-objs			:= rsmu_core.o rsmu_i2c.o
> > > > >    rsmu-spi-objs			:= rsmu_core.o rsmu_spi.o
> > > > >    obj-$(CONFIG_MFD_RSMU_I2C)	+= rsmu-i2c.o
> > > > >    obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu-spi.o
> > > > > +obj-$(CONFIG_MFD_SM5703)	+= sm5703.o
> > > > > diff --git a/drivers/mfd/sm5703.c b/drivers/mfd/sm5703.c
> > > > > new file mode 100644
> > > > > index 000000000000..7f9838149051
> > > > > --- /dev/null
> > > > > +++ b/drivers/mfd/sm5703.c
> > > > > @@ -0,0 +1,78 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > +
> > > > > +#include <linux/err.h>
> > > > > +#include <linux/delay.h>
> > > > > +#include <linux/gpio/consumer.h>
> > > > > +#include <linux/i2c.h>
> > > > > +#include <linux/mfd/core.h>
> > > > > +#include <linux/mfd/sm5703.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/of_device.h>
> > > > > +#include <linux/regmap.h>
> > > > > +
> > > > > +static const struct mfd_cell sm5703_devs[] = {
> > > > > +	{ .name = "sm5703-regulator", },
> > > > > +};
> > > > Where are the rest of the child drivers?
> > > Should those devices still be present even though there's no driver for them
> > > (yet) ? I have a WIP version of driver for almost every function, but I
> > > currently lack time to get them done.
> > Without them the driver-set is useless, no?
> > 
> > We try to refrain from applying dead code.
> > 
> > A lot of it has a tendency to stay that way.
> Well, in my opinion, having just the regulator driver is already useful
> enough: my board (Samsung Galaxy J5 (2015) ) uses one of LDO outputs for
> powering the touchscreen. Touchscreen is kind of vital functionality for a
> phone so I decided to upstream parts that are necessary for it first and
> finish up other stuff later. It's not the only board that uses SM5703's
> regulators for supplying all different kinds of hardware, either.

Upstreaming functionality which is useful on its own is fine, but that 
doesn't tick all of the boxes to justify an MFD.  This is a lot of
code which is hard to justify if it only registers a Regulator driver.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
