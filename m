Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660145010F3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 16:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245673AbiDNNnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 09:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245346AbiDNN2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:28:52 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94239BACC;
        Thu, 14 Apr 2022 06:22:29 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id mm4-20020a17090b358400b001cb93d8b137so9298944pjb.2;
        Thu, 14 Apr 2022 06:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iG0+fzJA3WfbtsbeAXJRn3UF7d+JM9mLiaa4XhIRYeQ=;
        b=nMBgd09CE7b5rTckWpLklvzI5V3JTVPhgkT8CcThKiiEliAJhR7K7nJxePO/wmrbSK
         qurcoT2FL16z98UiL0l2apGMiLJ+46C/LOC+yr+5N9YOOXpIK93wASr8DjGt/MeSVCFV
         7loVjKar43XQlaMstd0tEJTUxxpKtkIHuPng33ETlGlev4TefuT4B6RPBpKTHY6rvlfd
         6nQdAYxD3x/8ZvEdq74hlhnCcC0kGmxFRe/9nN5/ICdoqYWP/nmXEtYzGxNeQGzH+b8G
         csLTldLprtLtZ6NEQNMgpX0vd9e0UGSu+vf5urR6JZTqREiprEOlY41xXmPL/nrCHRAM
         LLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iG0+fzJA3WfbtsbeAXJRn3UF7d+JM9mLiaa4XhIRYeQ=;
        b=W5HR8GI957ciLR8K0FUKZShP+0tqjqsM3Co6VpJAcyHXTrBTr7/Qi4N2uqIob+O6l+
         L2WnovGPhCFOCzcLnzSi1yu5LWu7jYPUVjcQIu8rfyUkvKyqxAxkRUe47E9ulaIPgcsO
         r+APytAro4Pa8e10C5eCaW38pbEMbCBy1CNqgNvrFGYjt2Mh+nUBRbF9ErSFpHeO7BlG
         QKPvY3VGnjhOkhBKJSHr4nnzdSVSWRiLFxRNkZzS5dlaXgnpJK4yxucohyHmeAEJAPwu
         L75iKEqwtDflwIqiuV92tuaE2b5Qe8YXOoAqM+bw/Ko9aDmTAZXqvdoj4NArpx22MsIa
         broQ==
X-Gm-Message-State: AOAM530NpI9Vakf1u8XflL7oZNtQzbyWVK0qFnJeKRqKcbLVyd4o5I0L
        7RivtWBfk1me2ILkhfzr/JU=
X-Google-Smtp-Source: ABdhPJyAQBZUGFm0lZEIn8UwJD25eH1DbMwB/a8BKyw1vd6GZwDGGWGDsxBcQU7m6nLL7AsyktkpuQ==
X-Received: by 2002:a17:90a:7:b0:1c7:c286:abc2 with SMTP id 7-20020a17090a000700b001c7c286abc2mr3756658pja.65.1649942549138;
        Thu, 14 Apr 2022 06:22:29 -0700 (PDT)
Received: from jagath-PC ([115.99.143.29])
        by smtp.gmail.com with ESMTPSA id r32-20020a17090a43a300b001cdbda883ccsm2326255pjg.38.2022.04.14.06.22.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Apr 2022 06:22:28 -0700 (PDT)
Date:   Thu, 14 Apr 2022 18:52:24 +0530
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dan Robertson <dan@dlrobertson.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/9] iio: accel: bma400: Add triggered buffer support
Message-ID: <20220414132223.GA3742@jagath-PC>
References: <20220411203133.19929-1-jagathjog1996@gmail.com>
 <20220411203133.19929-5-jagathjog1996@gmail.com>
 <CAHp75VfHa9afhSdyi8dj5GpzrYE=hLacayu58+PHjXhMxTo9eg@mail.gmail.com>
 <20220412193013.GA25279@jagath-PC>
 <CAHp75Vc9MO2GxX81JQfzGRjM=nWLaQ-Uy9bV-dR1GMj1oQwjSQ@mail.gmail.com>
 <CAHp75Vef21YmiKAvz-Kt-C=jb+mMCJeV_fwPAza9UwCuKy6omQ@mail.gmail.com>
 <20220413142345.GA3283@jagath-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220413142345.GA3283@jagath-PC>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Wed, Apr 13, 2022 at 07:53:46PM +0530, Jagath Jog J wrote:
> On Wed, Apr 13, 2022 at 12:24:54AM +0300, Andy Shevchenko wrote:
> > On Wednesday, April 13, 2022, Andy Shevchenko <andy.shevchenko@gmail.com>
> > wrote:
> > 
> > >
> > >
> > > On Tuesday, April 12, 2022, Jagath Jog J <jagathjog1996@gmail.com> wrote:
> > >
> > >> Hello Andy,
> > >>
> > >> On Tue, Apr 12, 2022 at 12:12:21PM +0300, Andy Shevchenko wrote:
> > >> > On Mon, Apr 11, 2022 at 11:31 PM Jagath Jog J <jagathjog1996@gmail.com>
> > >> wrote:
> > >> > >
> > >> > > Added trigger buffer support to read continuous acceleration
> > >> > > data from device with data ready interrupt which is mapped
> > >> > > to INT1 pin.
> > >> >
> > >> > Can you explain the locking schema in this driver?
> > >> >
> > >> > > +       /* Configure INT1 pin to open drain */
> > >> > > +       ret = regmap_write(data->regmap, BMA400_INT_IO_CTRL_REG,
> > >> 0x06);
> > >> > > +       if (ret)
> > >> > > +               return ret;
> > >> >
> > >> > No locking (or regmap only locking).
> > >>
> > >> This is bma400_init() function which will run when probe runs so there is
> > >> no
> > >> locking in this bma400_init().
> > >>
> > >> >
> > >> > ...
> > >> >
> > >> > > +static int bma400_data_rdy_trigger_set_state(struct iio_trigger
> > >> *trig,
> > >> > > +                                            bool state)
> > >> > > +{
> > >> > > +       struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> > >> > > +       struct bma400_data *data = iio_priv(indio_dev);
> > >> > > +       int ret;
> > >> > > +
> > >> > > +       ret = regmap_update_bits(data->regmap,
> > >> BMA400_INT_CONFIG0_REG,
> > >> > > +                                BMA400_INT_DRDY_MSK,
> > >> > > +                                FIELD_PREP(BMA400_INT_DRDY_MSK,
> > >> state));
> > >> > > +       if (ret)
> > >> > > +               return ret;
> > >> > > +
> > >> > > +       return regmap_update_bits(data->regmap, BMA400_INT1_MAP_REG,
> > >> > > +                                 BMA400_INT_DRDY_MSK,
> > >> > > +                                 FIELD_PREP(BMA400_INT_DRDY_MSK,
> > >> state));
> > >> > > +}
> > >> >
> > >> > Ditto.
> > >>
> > >> Sorry, I missed this.
> > >> I will add lock and unlocking in the next patch.
> > >>
> > >> >
> > >> > ...
> > >> >
> > >> > > +       mutex_lock(&data->mutex);
> > >> > > +
> > >> > > +       /* bulk read six registers, with the base being the LSB
> > >> register */
> > >> > > +       ret = regmap_bulk_read(data->regmap, BMA400_X_AXIS_LSB_REG,
> > >> > > +                              &data->buffer.buff,
> > >> sizeof(data->buffer.buff));
> > >> > > +       mutex_unlock(&data->mutex);
> > >> > > +       if (ret)
> > >> > > +               return IRQ_NONE;
> > >> >
> > >> > But here only above with locking...
> > >> >
> > >> > > +       ret = regmap_read(data->regmap, BMA400_TEMP_DATA_REG, &temp);
> > >> > > +       if (ret)
> > >> > > +               return IRQ_NONE;
> > >> >
> > >> > ...followed by no locking.
> > >>
> > >> Okay I will add lock in the next patch.
> > >>
> > >> >
> > >> > ...
> > >> >
> > >> > > +       mutex_lock(&data->mutex);
> > >> > > +       ret = regmap_bulk_read(data->regmap, BMA400_INT_STAT0_REG,
> > >> &status,
> > >> > > +                              sizeof(status));
> > >> > > +       mutex_unlock(&data->mutex);
> > >> > > +       if (ret)
> > >> > > +               return IRQ_NONE;
> > >> >
> > >> > And again with locking.
> > >> >
> > >> > ...
> > >> >
> > >> > So,
> > >> > 1) Does regmap is configured with locking? What for?
> > >> > 2) What's the role of data->mutex?
> > >>
> > >> 1.
> > >> NO,
> > >
> > >
> > > Are you sure?
> > >
> > >
> > >>  regmap is not configured with locking.
> > >> In the remap_config structure variable below these members are not defined
> > >> in the driver.
> > >>
> > >> struct regmap_config {
> > >>         regmap_lock lock;
> > >>         regmap_unlock unlock;
> > >>         void *lock_arg;
> > >>
> > >>
> > > It means that default may be used.
> > >
> > >
> > >> 2.
> > >> data->mutex is used to protect the register read, write access from the
> > >> device.
> > >>
> > >> Is the regmap functions handle locking and unlocking internally if these
> > >> below
> > >> struct members are not defined?
> > >
> > >
> > > Yes. Look at this: https://elixir.bootlin.com/linux/latest/C/ident/
> > > disable_locking
> 
> Please your advise will be very helpful for this.
> 
> I'm going through the same documentation. In this driver, disable_locking is
> not initialized.
> 
> The functions which are called in the bma400_init() are not protected by mutex
> for regmap since bma400_init() will run when the probe runs.
> 
> The functions which are called by read_raw() and write_raw() are protected by
> mutex for regmap access.
> 
> There are some members in the device's private data structure and they are being
> accessed in multiple places in the driver.
> 
> struct bma400_data {
> enum bma400_power_mode power_mode;                                      
> struct bma400_sample_freq sample_freq;                                  
> int oversampling_ratio;
> int scale;
> .....
> 
> I think mutex is used to protect these above struct members since they are
> critical resource, but in the struct bma400_data comment for mutex 
> is "data register lock".

Sorry, I got my mistake about mutex lock and unlocking and I will correct those
in the next patch series.

Thank you
Jagath
> 
> 
> > >
> > >
> > >>
> > >> regmap_lock lock;
> > >> regmap_unlock unlock;
> > >> void *lock_arg;
> > >>
> > >>
> > >> >
> > >> > --
> > >> > With Best Regards,
> > >> > Andy Shevchenko
> > >>
> > >
> > >>
> > 
> > You may read the kernel documentation what those fields mean:
> >  https://elixir.bootlin.com/linux/latest/source/include/linux/regmap.h#L278
> > 
> > 
> > 
> > > --
> > > With Best Regards,
> > > Andy Shevchenko
> > >
> > >
> > >
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> 
> Thank you,
> Jagath
