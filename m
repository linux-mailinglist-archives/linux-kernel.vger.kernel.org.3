Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980A656D730
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiGKH4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiGKH4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:56:24 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465521AF0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 00:56:22 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z12so5880739wrq.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 00:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=sKkZ7/Q/K9Q/sXgFuA0gAflfil/CLZ0p6StfFEg8nR8=;
        b=s7i1I56YvzM46mtZQRunYDg5XIgJBb5tiEtkaWXeKEwoVS6JeIyKRh8Jvf4O5wOW+z
         ak6CPvdefTVUYin40r8D+h0x1ulauO8TC9fe5XuasEfMn4kdr8f/iEMhCQYtPmBBGVG0
         r3XsOtVtHFoSLyzODC+OBfUa9nj3ZaDjiEvRZ+sbkhpgEbxOCNWTJK5soE+oLcZXY14Y
         HPtpVPPLZJGPBpjKpBkxbG+9B7fr1in762kRl+0NE3hTeeDwvvUtFW7OXi/4ouHOHhM2
         yEqhz8zwbJpk7lWGiEZQufDi6tgDT9ozjBDYkk8kWPm2vK0YAOgfkKosNoBnVMuv7S1v
         UNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sKkZ7/Q/K9Q/sXgFuA0gAflfil/CLZ0p6StfFEg8nR8=;
        b=NQ3udQOXQ/S6BWKqJ/eLW7TOs9RF+aFieP0AjECn6LY7N/rAgfXmpS/E7Jf6WQK3DA
         ZUOzmNWfdjdCecz2FuekG5ejgzYrbro/0Ru5lJzPJ7+HEYGSo/Kk8rV74zTItHmPYmo8
         iHpatlpYCx5rTgspDCgoApzxRCj1u5wL9zMaJIWQP4UgpqCe0gVXz5isTIbJA+luDFo0
         jPkpA6gAjnmskhwQ8zImQcnypYmYH83i2s2qXG7Mc0cSTAy4ZJJm7LsqXGW+3Uif6ZQP
         v1j1UkX0EreoUwk4H7estAQJ1Ao6H5UyeUu3xvFbGjvE9ef/7xlvGu2Q08j0CV+XJZmI
         +MoA==
X-Gm-Message-State: AJIora+yNQGI0Xh4mRDNbskxoWHw60KJoTg/3VmvFYauac3XMNQ/6MBn
        bPNBqBdZQ3Gf0YwEvAfJ2LWejA==
X-Google-Smtp-Source: AGRyM1s6svVopaidI0OqhRnWkGg8+xnz5jCXAwHpMAKVlD9l503OW6LkbUqRx2CDpsnrcEh3ryN9Gg==
X-Received: by 2002:a5d:68c1:0:b0:21d:8810:23c0 with SMTP id p1-20020a5d68c1000000b0021d881023c0mr16086309wrw.711.1657526180807;
        Mon, 11 Jul 2022 00:56:20 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id c8-20020a05600c0a4800b003a03e63e428sm13082839wmq.36.2022.07.11.00.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 00:56:20 -0700 (PDT)
Date:   Mon, 11 Jul 2022 08:56:18 +0100
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
Message-ID: <YsvXom7CQ8qpzR5O@google.com>
References: <20220423085319.483524-1-markuss.broks@gmail.com>
 <20220423085319.483524-5-markuss.broks@gmail.com>
 <Yqj+aUNLC00Tcu49@google.com>
 <3ec8570e-a730-b572-8246-631b91f46735@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ec8570e-a730-b572-8246-631b91f46735@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 09 Jul 2022, Markuss Broks wrote:

> Hi Lee,
> 
> On 6/15/22 00:32, Lee Jones wrote:
> > On Sat, 23 Apr 2022, Markuss Broks wrote:
> > 
> > > Silicon Mitus SM5703 is a multi-function device, meant to be
> > Please avoid using the term MFD.
> > 
> > How is the device described in the data-sheet?
> I don't have a data-sheet for this device. The only reference I have is
> downstream Linux driver. Maybe a better way to call it would be PMIC?

Yes, if that's what this is, PMIC sounds better.

> > What do you mean by "meant to be"?
> "designed to be", it appears that this part is almost exclusively used by
> Samsung in its mobile phones.

"designed to be" sounds better.

> > > used in mobile devices. It has several modules: LDO, BUCK regulators,
> > Modules or functions?
> 
> Some of "modules" are quite separate, so I decided to call it that way. How
> should it be called?

Functions.

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
> UART as a standard Samsung debug port interface (619K Ohm resistor between
> data lines is Samsung's debug cable).

Probably best to state that then.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
