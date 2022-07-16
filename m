Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61489577063
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 19:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiGPR31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 13:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiGPR3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 13:29:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC17658C;
        Sat, 16 Jul 2022 10:29:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99DC3611A6;
        Sat, 16 Jul 2022 17:29:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AB4C34114;
        Sat, 16 Jul 2022 17:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657992564;
        bh=s8zWDI7l/NEtm0Ui8Ues2MDYedJLomU5WQ+1kwrGMTc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RzYkRM9JYVwJFJLryAPipOhrM/XTg33zf9V5Qw46GjTEvCx+MR1Nf+91hJyf4jnu8
         VQgnvKCuVquFBKAZYJvBZpaz/RLgxT0AnbB39bsxVSwKe/nzD2WqCXNhdjizKnJJO9
         KKUbH9rCWRPBaAjha1TwQ+YG81Zv1+4Qhy9JYQHVeQid7O7/Ei0OIzEHxQzBoYwWRf
         EZusq9rIeWXhGTf8F1vw6ELestdytxXTej/AQymc4lr0O/g5pBo0LD6uvOUCS0DZWD
         miOTetATkThg/oN6H15XWhJ0PVToeZE9g+/xtDJknHM4kJXkynWV31h7ejxjxUvKC9
         tEhQdIKH0pKjg==
Date:   Sat, 16 Jul 2022 18:39:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        cy_huang <cy_huang@richtek.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] iio: adc: Add rtq6056 support
Message-ID: <20220716183916.7b40d9d5@jic23-huawei>
In-Reply-To: <CADiBU39KYyd9=JK5wLRN1yKn9hxRHVSOATkWrPMpAdTJY04ZxQ@mail.gmail.com>
References: <1657116702-24161-1-git-send-email-u0084500@gmail.com>
        <1657116702-24161-3-git-send-email-u0084500@gmail.com>
        <20220707183027.342f6c88@jic23-huawei>
        <CADiBU3_KQ=WvD-1E4SODkdEY254_b-covw-0SHcAaF3XQqdbaQ@mail.gmail.com>
        <CADiBU39KYyd9=JK5wLRN1yKn9hxRHVSOATkWrPMpAdTJY04ZxQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > > > +
> > > > +static int rtq6056_probe(struct i2c_client *i2c)
> > > > +{
> > > > +     struct iio_dev *indio_dev;
> > > > +     struct rtq6056_priv *priv;
> > > > +     struct device *dev = &i2c->dev;
> > > > +     struct regmap *regmap;
> > > > +     unsigned int vendor_id, shunt_resistor_uohm;
> > > > +     int ret;
> > > > +
> > > > +     if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_WORD_DATA))
> > > > +             return -EOPNOTSUPP;
> > > > +
> > > > +     indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
> > > > +     if (!indio_dev)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     priv = iio_priv(indio_dev);
> > > > +     priv->dev = dev;
> > > > +     priv->vshuntct_us = priv->vbusct_us = 1037;
> > > > +     priv->avg_sample = 1;
> > > > +     i2c_set_clientdata(i2c, priv);
> > > > +
> > > > +     regmap = devm_regmap_init_i2c(i2c, &rtq6056_regmap_config);
> > > > +     if (IS_ERR(regmap))
> > > > +             return dev_err_probe(dev, PTR_ERR(regmap),
> > > > +                                  "Failed to init regmap\n");
> > > > +
> > > > +     priv->regmap = regmap;
> > > > +
> > > > +     ret = regmap_read(regmap, RTQ6056_REG_MANUFACTID, &vendor_id);
> > > > +     if (ret)
> > > > +             return dev_err_probe(dev, ret,
> > > > +                                  "Failed to get manufacturer info\n");
> > > > +
> > > > +     if (vendor_id != RTQ6056_VENDOR_ID)
> > > > +             return dev_err_probe(dev, -ENODEV,
> > > > +                                  "Invalid vendor id 0x%04x\n", vendor_id);
> > > > +
> > > > +     ret = devm_regmap_field_bulk_alloc(dev, regmap, priv->rm_fields,
> > > > +                                        rtq6056_reg_fields, F_MAX_FIELDS);
> > > > +     if (ret)
> > > > +             return dev_err_probe(dev, ret, "Failed to init regmap field\n");
> > > > +
> > > > +     /*
> > > > +      * By default, configure average sample as 1, bus and shunt conversion
> > > > +      * timea as 1037 microsecond, and operating mode to all on.
> > > > +      */
> > > > +     ret = regmap_write(regmap, RTQ6056_REG_CONFIG, RTQ6056_DEFAULT_CONFIG);
> > > > +     if (ret)
> > > > +             return dev_err_probe(dev, ret,
> > > > +                                  "Failed to enable continuous sensing\n");
> > > > +
> > > > +     pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
> > > > +     pm_runtime_use_autosuspend(dev);
> > > > +     pm_runtime_set_active(dev);
> > > > +     pm_runtime_mark_last_busy(dev);
> > > > +     pm_runtime_enable(dev);  
> > >
> > > Look at whether you can use devm_pm_runtime_enable()
> > > Note it handles disabling autosuspend for you.
> > >
> > > When using runtime_pm() you want to ensure that the device works without
> > > runtime pm support being enabled.  As such, you turn the device on before
> > > enabling runtime_pm() and (this is missing I think) turn it off after disabling
> > > runtime pm.  So I'd expect a devm_add_action_or_reset() call to unwind
> > > setting the device into continuous sending above.
> > >  
> > If so, I think it's better to configure the device keep in off state
> > in probe stage.
> > The calling order may need to be changed as below
> > devm_add_action_or_reset...
> >
> > pm_runtime_set_autosuspend_delay
> > pm_runtime_use_auto_suspend
> > devm_pm_runtime_enable
> >  
> Ah, not correct. How about if 'PM_RUNTIME' is not enabled?
> Do we need to consider about this case?
> 
> If yes, the original flow about 'pm_runtime' is correct.
I don't follow.  Perhaps next version will make it clear what you mean.

Jonathan
