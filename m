Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CAE4E52D7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 14:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244177AbiCWNN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 09:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243354AbiCWNNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:13:24 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C617CDD8;
        Wed, 23 Mar 2022 06:11:52 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-de3ca1efbaso1596647fac.9;
        Wed, 23 Mar 2022 06:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=K4W6Y+CN8/9SzAkq0QdFDjJP1aWJA1yahZp6GBIYFME=;
        b=y0t/czAvPZkiTOM6jr+Jor74Y26WJWaEYEU6rp4v/g9WHyCGb/e1CaGsyjHSj+QleT
         kxRswsAzlOBrq2092RX16glm5eY1/9GWuvC2k02gRwNGcYRpYbR1phPYmXwSN6/1rDt2
         Rmh3HNzgzWO96yUETDvm8n7vj/PKqs4Sw0TRNNO1r+MiXfKHtgbAKfVir1WL5NnNyYT9
         GKVJtK8i43byoDGSCoc4nH7gR/8Mc06uV5OhIRfT3B/8pTSo077FbcgGPQNeR3yyon78
         FBDDO5viGdFoBfYjb3hnmY4qLVNl64A2Jm20XT44F9gPfROQyqNJAlvPe+s+JNb+Yn6N
         2/1Q==
X-Gm-Message-State: AOAM5302W+1QNFi3dTpvkmrZxJUaHDJyq4NNLLLWT5ezOyMVlFI0ib1+
        hh/wLwv9soK5De0M+gsVsA==
X-Google-Smtp-Source: ABdhPJztrzqDz7pcATE6tXz438YRHf0Hzhlaxp7/q1WkwDhYorMA3clcu/PDqYYjVk/H2NNtrB4Z6Q==
X-Received: by 2002:a05:6870:4411:b0:de:6c37:43b4 with SMTP id u17-20020a056870441100b000de6c3743b4mr2172391oah.25.1648041112279;
        Wed, 23 Mar 2022 06:11:52 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t17-20020a9d7f91000000b005c925454e6fsm9996868otp.69.2022.03.23.06.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 06:11:51 -0700 (PDT)
Received: (nullmailer pid 3935370 invoked by uid 1000);
        Wed, 23 Mar 2022 13:11:49 -0000
Date:   Wed, 23 Mar 2022 08:11:49 -0500
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
Message-ID: <YjsclWsqGX3JrknM@robh.at.kernel.org>
References: <20220321162916.1116541-1-15330273260@189.cn>
 <20220321162916.1116541-8-15330273260@189.cn>
 <Yjo2R5LQrRICr7dC@robh.at.kernel.org>
 <9ea4d326-ad5f-4f2c-1609-4ca772699d1b@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ea4d326-ad5f-4f2c-1609-4ca772699d1b@189.cn>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 12:12:43PM +0800, Sui Jingfeng wrote:
> 
> On 2022/3/23 04:49, Rob Herring wrote:
> > > +/*
> > > + * mainly for dc in ls7a1000 which have builtin gpio emulated i2c
> > > + *
> > > + * @index : output channel index, 0 for DVO0, 1 for DVO1
> > > + */
> > > +struct lsdc_i2c *lsdc_create_i2c_chan(struct device *dev, void *base, unsigned int index)
> > > +{
> > > +	char compat[32] = {0};
> > > +	unsigned int udelay = 5;
> > > +	unsigned int timeout = 2200;
> > > +	int nr = -1;
> > > +	struct i2c_adapter *adapter;
> > > +	struct lsdc_i2c *li2c;
> > > +	struct device_node *i2c_np;
> > > +	int ret;
> > > +
> > > +	li2c = devm_kzalloc(dev, sizeof(*li2c), GFP_KERNEL);
> > > +	if (!li2c)
> > > +		return ERR_PTR(-ENOMEM);
> > > +
> > > +	li2c->index = index;
> > > +	li2c->dev = dev;
> > > +
> > > +	if (index == 0) {
> > > +		li2c->sda = 0x01;
> > > +		li2c->scl = 0x02;
> > > +	} else if (index == 1) {
> > > +		li2c->sda = 0x04;
> > > +		li2c->scl = 0x08;
> > Just require this to be in DT rather than having some default.
> > 
> By design,  I am try very hard to let the code NOT fully  DT dependent. DT is nice , easy to learn and use.
> But kernel side developer plan to follow UEFI + ACPI Specification on LS3A5000 + LS7A1000 platform. See [1]
> There will no DT support then, provide a convention support  make the driver more flexible. I want the
> driver works with minimal requirement. The driver just works on simple boards by put the following dc device
> node in arch/mips/dts/loongson/loongson64g_4core_ls7a.dts,

Pick DT or ACPI for the platform, not both. We don't need to have both 
in the kernel to support.

Rob
