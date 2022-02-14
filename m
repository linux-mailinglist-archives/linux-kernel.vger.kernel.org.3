Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241204B3EFE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 02:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239062AbiBNBs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 20:48:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbiBNBsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 20:48:55 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EA0527F9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 17:48:47 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id f6so5650629pfj.11
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 17:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GZi2a4c2Jxa4BMeSk+Zmf4PjSVvBkZeBTKVe1UpGOyc=;
        b=Oixljf7Y4Rc4hsV5RQnXgzw6w/IPLzae3N5/ib4Q+arZrU6I4tr29e7MUBwWpyslVW
         mrZ8F56F0mypAXenhZLboqC/gqKVaf2XoOuGrRIlx2wIcNNuu87Xq0QMy8xNOAPxHYU3
         KxRbiYdLSvBBvYMWzxS2Wt9pLOs/lL8ksgbp5auTSHoDvnO3hHhzHfFyyV1pR/PwoZhI
         PBE+eQH26THiWKJd0G+ARAkwSvPX5OcM41WRIWfvHpGOEQDu90BcbWbw2CH1rUUTtgpA
         GnY0zZF92NaVWA7zNReuNM7yC6ycEqrvGWlr4HsStogYnzMEqk2BAhglA93LozJmXaGM
         H+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GZi2a4c2Jxa4BMeSk+Zmf4PjSVvBkZeBTKVe1UpGOyc=;
        b=YbCf9AB4lXNDwF8bFpJVXFnB0+3rak2/AB0isKy6lsw8F20ocXXJek1juI0nf5RXgC
         4VWDZXto5dVEVByxCvRDMyWqDf8hKK9dz+cCs2oGZDKLDiVAeehGZvpV+2CUwsOG++O1
         RbKGJWF2Nftv/Tw5XeAAYjh818jWKRlRFCovB6R9tHY5jqnsvLATCFQHs+pRvKmldd+8
         Cw1DUfRHpcXdsl/ENRNlGrvY5cLBy8sqYlmLWLkEmmCskgpIPcmEBbJhOpEn4Mfx6/RD
         WoJ8kFEJDB1g0jhFB+WOYGrRDRQclXvyLD03kW9R/caOT3q453ZQo/rq0KpRoG6mZzpt
         8sQA==
X-Gm-Message-State: AOAM533mOL7yYwiwqF4M1F9OqA5Dnz6FpauQpjfKSrF0waYr9qBcBTk5
        HAi2Gog7UD4h3r3urbbbcLCd+g==
X-Google-Smtp-Source: ABdhPJyVbgZq7AFilr/qbRUu5X7MgQByixiKeGtzVaE4n3F7z1+ittFaB3Nw8616WEg7V+oHaXMoFw==
X-Received: by 2002:a63:c156:: with SMTP id p22mr9819599pgi.215.1644803326515;
        Sun, 13 Feb 2022 17:48:46 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:78cf:362f:f9d8:32f])
        by smtp.gmail.com with ESMTPSA id a9sm24379552pgb.56.2022.02.13.17.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 17:48:46 -0800 (PST)
Date:   Mon, 14 Feb 2022 09:48:43 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Sami Kyostila <skyostil@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, bleung@chromium.org,
        arnd@arndb.de, gregkh@linuxfoundation.org, evanbenn@chromium.org,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH v3 1/1] platform/chrome: add a driver for HPS
Message-ID: <Ygm0+3S/Q+JHzzxB@google.com>
References: <20220207013613.1150783-1-skyostil@chromium.org>
 <20220207013613.1150783-2-skyostil@chromium.org>
 <YgSli/6HuZ+i+2gb@google.com>
 <CAPuLczuizJkwHsKo+W3MEjX7T_fHXApVyou3BuMH_aAQfyk1Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPuLczuizJkwHsKo+W3MEjX7T_fHXApVyou3BuMH_aAQfyk1Vg@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Left some follow-up questions before going for the v4.  Please also cc the
following patches to <chrome-platform@lists.linux.dev> in case we would
overlook them from LKML.

On Fri, Feb 11, 2022 at 08:08:45PM +1100, Sami Kyostila wrote:
> ( to 10. helmik. 2022 klo 16.41 Tzung-Bi Shih (tzungbi@google.com) kirjoitti:
> >
> > On Mon, Feb 07, 2022 at 12:36:13PM +1100, Sami Kyöstilä wrote:
> > > When loaded, the driver exports the sensor to userspace through a
> > > character device. This device only supports power management, i.e.,
> > > communication with the sensor must be done through regular I2C
> > > transmissions from userspace.
> > >
> > > Power management is implemented by enabling the respective power GPIO
> > > while at least one userspace process holds an open fd on the character
> > > device. By default, the device is powered down if there are no active
> > > clients.
> > >
> > > Note that the driver makes no effort to preserve the state of the sensor
> > > between power down and power up events. Userspace is responsible for
> > > reinitializing any needed state once power has been restored.
> >
> > It's weird.  If most of the thing is done by userspace programs, couldn't it
> > set the power GPIO via userspace interface (e.g. [1]) too?
> 
> I agree that's a little unusual, but there are some good reasons for
> this to be in the kernel. First, it lets us turn HPS off during system
> suspend -- which I'm not sure how you'd do from userspace. Second, it
> avoids the need to give write access to the entire GPIO chip to the
> hpsd userspace daemon. We just need a single line, while the
> controller in this case has a total of 360 gpios. Finally, HPS also
> has an interrupt line, and we're planning to let it wake up the host,
> which I also believe needs to be done in the kernel.

What prevents it from implementing the I2C communication in kernel?

Did you investigate if there are any existing frameworks for HPS
(e.g. drivers/iio/)?  I am wondering if kernel already has some abstract code
for HPS.

Only found one via:
$ git grep 'human presence sensor'
drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h: [...]

> > > +static void hps_unload(void *drv_data)
> > > +{
> > > +     struct hps_drvdata *hps = drv_data;
> > > +
> > > +     hps_set_power(hps, true);
> >
> > Why does it need to set to true when device removing?
> 
> By default, HPS is powered on when the system starts and before the
> driver is loaded. We want to restore it to that default state here.
> This is needed for example for automated testing, where we can unbind
> the driver to make sure HPS stays powered.

Echo to the idea of previous comment: does kernel have any frameworks for HPS?
"HPS is powered on when the system starts" sounds like a chip specific
implementation.

> > > +static int hps_suspend(struct device *dev)
> > > +{
> > > +     struct i2c_client *client = to_i2c_client(dev);
> > > +     struct hps_drvdata *hps = i2c_get_clientdata(client);
> > > +
> > > +     hps_set_power(hps, false);
> > > +     return 0;
> > > +}
> > > +
> > > +static int hps_resume(struct device *dev)
> > > +{
> > > +     struct i2c_client *client = to_i2c_client(dev);
> > > +     struct hps_drvdata *hps = i2c_get_clientdata(client);
> > > +
> > > +     hps_set_power(hps, true);
> > > +     return 0;
> > > +}
> >
> > Does it need to save the old state before suspending?  Instead of turning on
> > the power after every resumes.
> 
> No, the runtime pm system makes sure suspend and resume are only
> called when needed. For example, if someone has an open reference to
> the device when the system goes to sleep, suspend and resume are
> called appropriately. If HPS was already suspended, then neither
> entrypoint gets called when going to sleep or waking up.

It uses UNIVERSAL_DEV_PM_OPS() which also sets for .suspend() and .resume().
OTOH, the documentation suggests it has deprecated (see include/linux/pm.h).
