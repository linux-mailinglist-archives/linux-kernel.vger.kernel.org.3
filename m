Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29694E6443
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 14:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350540AbiCXNoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 09:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238731AbiCXNoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:44:22 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A501A94D2;
        Thu, 24 Mar 2022 06:42:50 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id k10so4952440oia.0;
        Thu, 24 Mar 2022 06:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=k0XLE9bSSftZDbfLEu3mqCg9VES7NclFvpk1DiwzsCU=;
        b=p6GCh5GiyGdgcTRqCr9sf40dOthH6RFI9f3DQBGolTm/yV4gKKEQjYDjbRZE/pdake
         cvZ62/ccounWNOFXPUdn9eldhe/nvapUKjbFYnWXk8G4+V8gxccWZbTrPBitgz+oqRtx
         z4Ov0qE3B2E8yswlz2d8goxHWD0dhy7D3wzpc0di3VYkD7EsiV0sq5u/AQNJEpswkqhE
         EGiEkmZ/tH7ppP9mbgmYcdJllVRvXazs6eOG1AgmhLQtkPuvjK1hvK/RSRQ3Tpa81aue
         AKdKBhBqlOu9WNRQXrOnbsMobPSn2KeiU6hBnBw1gxjRFamHuC0ZBWChRjA7lQL8cPHu
         2NoA==
X-Gm-Message-State: AOAM5321WR9boytR//PFppQwEoutBjKjXQBJX4xslhotWAEHyqtKACVt
        EFepRFTzlibv4e6HS5wpVw==
X-Google-Smtp-Source: ABdhPJzqqN+FJJDwdKcMMRgy5goFaR/Q6upsH/doVxugr8UxtoUj4bHD6zeF85BdW4NQ+asO8xTuOw==
X-Received: by 2002:a05:6808:208b:b0:2d3:a5cc:540 with SMTP id s11-20020a056808208b00b002d3a5cc0540mr2700275oiw.41.1648129369806;
        Thu, 24 Mar 2022 06:42:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p16-20020a05680811d000b002d72ec3a921sm1463006oiv.21.2022.03.24.06.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 06:42:48 -0700 (PDT)
Received: (nullmailer pid 1940986 invoked by uid 1000);
        Thu, 24 Mar 2022 13:42:47 -0000
Date:   Thu, 24 Mar 2022 08:42:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sui Jingfeng <15330273260@189.cn>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Qing Zhang <zhangqing@loongson.cn>,
        suijingfeng <suijingfeng@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v11 7/7] drm/lsdc: add drm driver for loongson display
 controller
Message-ID: <Yjx1V1Lx0bAtgsCp@robh.at.kernel.org>
References: <20220321162916.1116541-1-15330273260@189.cn>
 <20220321162916.1116541-8-15330273260@189.cn>
 <Yjo2R5LQrRICr7dC@robh.at.kernel.org>
 <33766d08-bd88-2234-0f85-5926e4256dfb@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33766d08-bd88-2234-0f85-5926e4256dfb@189.cn>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 09:39:49AM +0800, Sui Jingfeng wrote:
> 
> On 2022/3/23 04:49, Rob Herring wrote:
> > On Tue, Mar 22, 2022 at 12:29:16AM +0800, Sui Jingfeng wrote:
> > > From: suijingfeng <suijingfeng@loongson.cn>
> > > 
> > > There is a display controller in loongson's LS2K1000 SoC and LS7A1000
> > > bridge chip, the display controller is a PCI device in those chips. It
> > > has two display pipes but with only one hardware cursor. Each way has
> > > a DVO interface which provide RGB888 signals, vertical & horizontal
> > > synchronisations, data enable and the pixel clock. Each CRTC is able to
> > > scanout from 1920x1080 resolution at 60Hz, the maxmium resolution is
> > > 2048x2048 according to the hardware spec. Loongson display controllers
> > > are simple which require scanout buffers to be physically contiguous.

[...]

> > > +			val |= mask;
> > > +		else
> > > +			val &= ~mask;
> > > +		writeb(val, li2c->dat_reg);
> > Shouldn't you set the data register low first and then change the
> > direction? Otherwise, you may be driving high for a moment. However, if
> > high is always done by setting the direction as input, why write the
> > data register each time? I'm assuming whatever is written to the dat_reg
> > is maintained regardless of pin state.
> > 
> When the pin is input, i am not sure value written to it will be preserved.
> 
> I'm worry about it get flushed by the external input value.
> 
> Because the output data register is same with the input data register(
> offset is  0x1650).
> 
> The hardware designer do not provided a  separation.

Usually for GPIO data registers the read value is current pin state 
regardless of direction and the written value is what to drive as an 
output. But your h/w could be different.


> > > +
> > > +		/* Optional properties which made the driver more flexible */
> > > +		of_property_read_u32(i2c_np, "udelay", &udelay);
> > > +		of_property_read_u32(i2c_np, "timeout", &timeout);
> > These aren't documented. Do you really need them in DT?
> 
> Yes, in very rare case:
> 
> When debugging, sometimes one way I2C works, another way I2C not on specific
> board.

This is not specific to you, so why do you solve it in a way that only 
works for you? If you want to add tuning parameters to the i2c bit 
algorithm, why don't you do so in a way that works for all users? I'm 
sure the I2C maintainer and others have some opinion on this, but 
they'll never see it hidden away in some display driver.


> and you want to see what will happen if you change it from 5 to 2.
> 
> modify device tree is enough, have to recompile the kernel and driver
> modules every time.

Modifying the DT is not the easiest way to debug either.


> It is optional through.

Lots of properties are optional, what's your point?


> Please do not ask me to document such a easy thing,

Everything must be documented. There's nothing more to discuss.


> DT itself is a documention, human readable,  it already speak for itself.

It is machine readable too. Undocumented properties generate warnings 
now.

Rob
