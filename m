Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD7453B38B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiFBG1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiFBG1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:27:08 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38B1CCE;
        Wed,  1 Jun 2022 23:27:05 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id w2-20020a17090ac98200b001e0519fe5a8so4028710pjt.4;
        Wed, 01 Jun 2022 23:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sgetwGF1PvFvysoUcKKwVGNS/40oEtUezOmpaPDogiY=;
        b=ZMFPdPunvlYPQPU3WvFgrloJ8uyHxXAWCOMTRSZ9UdgD6rlNisHeAFF5/aY9eRXA0W
         RVgqJzVwNnaI7+v11DYXSCOX+1qoTZ4UHTG6/wQD/YlQrYt1Hwg51G8tJEPipcv4GY66
         4jWv5S3N+GmyqU6l+K858iXVMtXZSPnh1xSRU4u2GJihLrDkY356tc/U6/el6POMbuSC
         BVjvraKgPJFIcs7OPE4lDWq0kSaW9OyCoibbg40N5i4AFl2cRDJlVWQrlLKvz816fS2X
         IAmGmyJ+ToO08AHPxyjQEN6ZAc0PXhytlp05lepN1qcMlsN3si+QLc1JoCpWctNrxLBb
         JqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sgetwGF1PvFvysoUcKKwVGNS/40oEtUezOmpaPDogiY=;
        b=Hisg3jz96Bfk9TZJSXpNCalvL2TC1Y3S4vXcaQ0MC3ZqP7Y9fjPuD0Id08enRmxfg9
         GTAll6DYGjof5vq3Rykit9qYL/6drMcio9OMBDsGTx5mcWWrS19lPYc9v9ITEmRsaQ1u
         wrhQUdpGrIEXX/Tg+4lsAopt1PIQF0n4WXhgnaBfUvBCeYdX5rJYScj8ua99+1NPXr23
         BeH26iYZEWA4jwzsk19qYbXO2XJul7ZsH3nGSAM3JkWcdoHnhIkDDrzErA0Lp3jyM/CP
         fydfU136CdEe9c0Rg9Lkop6C3Jpn4wyLELua7pZBWbyUh4s9StZhy1xnVbsB4sgz+8+t
         CgjA==
X-Gm-Message-State: AOAM531G2h5P/O9IgGjburLp3AGksWrmlqu/22mAuXaedLrNX5HrvUqJ
        RG1NiYlktChxn88Xc2pC/lA=
X-Google-Smtp-Source: ABdhPJw/XVMZxQqn7LbpCVPeOLw0PRZZYK3mOXAw1YPVhpRYJee8hLeBKf1SThBKLbxC47OMbHQhGw==
X-Received: by 2002:a17:903:40ce:b0:164:248:1464 with SMTP id t14-20020a17090340ce00b0016402481464mr3355617pld.16.1654151225424;
        Wed, 01 Jun 2022 23:27:05 -0700 (PDT)
Received: from cyhuang-hp-elitebook-840-g3.rt ([2402:7500:569:e4e7:9594:e92e:b3a9:bf26])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902714e00b0015e8d4eb1f9sm2650433plm.67.2022.06.01.23.26.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jun 2022 23:27:04 -0700 (PDT)
Date:   Thu, 2 Jun 2022 14:26:51 +0800
From:   ChiYuan Huang <u0084500@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     ChiaEn Wu <peterwu.pub@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Helge Deller <deller@gmx.de>, cy_huang@richtek.com,
        alice_chen@richtek.com, chiaen_wu@richtek.com, u0084500@gmail.com,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>
Subject: Re: [PATCH 06/14] leds: mt6370: Add Mediatek MT6370 Indicator support
Message-ID: <20220602062643.GA13824@cyhuang-hp-elitebook-840-g3.rt>
References: <20220531102809.11976-1-peterwu.pub@gmail.com>
 <20220531102809.11976-7-peterwu.pub@gmail.com>
 <CAHp75Vd8taco19vsDmBcCv8euV1SvwSiY5=P9oMkA6zWsjwXxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vd8taco19vsDmBcCv8euV1SvwSiY5=P9oMkA6zWsjwXxg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 11:48:58AM +0200, Andy Shevchenko wrote:
> On Tue, May 31, 2022 at 1:16 PM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
> >
> > From: Alice Chen <alice_chen@richtek.com>
> 
> All below comments are applicable to the rest of the series as well
> (one way or another), so please fix all your patches where it's
> appropriate.
> 
> >
> > Add Mediatek MT6370 Indicator support
> 
> What indicator?
It's RGB curent sink type LED driver (maximum supported current is only 24mA).
> Please also keep attention on English punctuation (missed period).
> 
Ack in next.
> ...
>
> > +       help
> > +         Support 4 channels and reg/pwm/breath mode.
> > +         Isink4 can also use as a CHG_VIN power good Indicator.
> 
> be used
> 
Ack in next.
> > +         Say Y here to enable support for
> > +         MT6370_RGB_LED device.
> 
> ...
> 
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/platform_device.h>
> 
> > +#include <linux/of.h>
> 
> Are you sure this is the correct header? Seems you need
> mod_devicetable.h instead.
> 
It's the correct header and be used for the struct 'of_device_id'.
> > +#include <linux/property.h>
> > +#include <linux/regmap.h>
> 
> ...
> 
> > +struct mt6370_priv {
> > +       struct mutex lock;
> 
> Do you use regmap locking?
>
MFD regmap register already the access lock.

This lock is just to guarantee only one user can access the RGB register
part.

Sorry, from the comment, do you want us to rename or remove this lock?
> > +       struct device *dev;
> 
> > +       struct regmap *regmap;
> 
> > +       struct regmap_field *fields[F_MAX_FIELDS];
> > +       const struct reg_field *reg_fields;
> > +       const struct linear_range *ranges;
> > +       struct reg_cfg *reg_cfgs;
> > +       unsigned int leds_count;
> > +       unsigned int leds_active;
> > +       bool is_mt6372;
> > +       struct mt6370_led leds[];
> > +};
> 
> ...
> 
> > +static const unsigned int common_tfreqs[] = {
> > +       10000, 5000, 2000, 1000, 500, 200, 5, 1
> 
> Leave a comma at the end.
> 
Ack in next.
> > +};
> > +
> > +static const unsigned int mt6372_tfreqs[] = {
> > +       8000, 4000, 2000, 1000, 500, 250, 8, 4
> 
> Ditto.
> 
Ack in next.
> > +};
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
