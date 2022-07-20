Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E2D57B460
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 12:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbiGTKT0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 20 Jul 2022 06:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbiGTKTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 06:19:22 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4720E9FD2;
        Wed, 20 Jul 2022 03:19:21 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id i14so31343642yba.1;
        Wed, 20 Jul 2022 03:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gmnaYydXeu6KmnaPeDNjcb+0LYhzy8t1JjW01YQWpj0=;
        b=Q/tdzyjmjuKnYw/+8CGQM63mEbRWB/x592lqa9BM7rdEKsNVhNr3srRUUIADQRFROC
         Iy86rF2pEM/es1n6w230RsEFFEixHXh7GK2ZrBu04aBdWpH3BvYnPLdMAi7TXsoo024V
         Vydsjun7LziABtxjTabE03L5Hj6/2TWhyI01AAPkA++2M5PU0oBNIwWnEC2dIMm5z3vr
         pAc+C7bs+tq+1973cti+3OHtXeNVn0ZA0M/JyGaUfqgqFk0tHpHh1oBS4mxLwh62zY26
         21eKnbQCofBfC0sFWyzWMYNUestmziCBpxV9WpqnnYnRrh0qpfpqLl0OYk+KVYCL5drO
         emUQ==
X-Gm-Message-State: AJIora8W6XWCGwzvlpkUREPJcunyhOwsetPgLyx5RlAaKjXod91n3sTu
        T92CLY5BWOvsxnd1Z53WFgL45G2cSjAUDQIad93TAS9S
X-Google-Smtp-Source: AGRyM1tTbLGKrKq5D0At+VDdq6SY/8i+nzsabVbfGCPQPNKykLXmqlyKpG7RE4WIPiPcFjTg4ftXplEHFvcozTlioz4=
X-Received: by 2002:a25:828f:0:b0:670:22f9:f7eb with SMTP id
 r15-20020a25828f000000b0067022f9f7ebmr18861407ybk.137.1658312360538; Wed, 20
 Jul 2022 03:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220713084739.j4cqab6rfz22nlko@pengutronix.de>
 <CAJZ5v0h4qQoo5uVBLtSFhdVBpD1tpd-SmVzV1dE0+VZMrr-eTA@mail.gmail.com> <20220720060627.r7ifcxu6uopgsasw@pengutronix.de>
In-Reply-To: <20220720060627.r7ifcxu6uopgsasw@pengutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Jul 2022 12:19:09 +0200
Message-ID: <CAJZ5v0gxg+igNpfe1_xyPS=L8jzgS0v7dzCPcZUueRtF68oQSA@mail.gmail.com>
Subject: Re: pm_runtime_resume_and_get in .remove callbacks
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 8:06 AM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Rafael,
>
> On Wed, Jul 13, 2022 at 07:47:39PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jul 13, 2022 at 10:47 AM Uwe Kleine-König
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > Hello,
> > >
> > > there is a big bunch of kernel drivers (here:
> > > drivers/i2c/busses/i2c-sprd.c) that have a remove callback that looks as
> > > follows:
> > >
> > >         static int sprd_i2c_remove(struct platform_device *pdev)
> > >         {
> > >                 struct sprd_i2c *i2c_dev = platform_get_drvdata(pdev);
> > >                 int ret;
> > >
> > >                 ret = pm_runtime_resume_and_get(i2c_dev->dev);
> > >                 if (ret < 0)
> > >                         return ret;
> > >
> > >                 i2c_del_adapter(&i2c_dev->adap);
> > >                 clk_disable_unprepare(i2c_dev->clk);
> > >
> > >                 pm_runtime_put_noidle(i2c_dev->dev);
> > >                 pm_runtime_disable(i2c_dev->dev);
> > >
> > >                 return 0;
> > >         }
> > >
> > > If pm_runtime_resume_and_get fails, the i2c adapter isn't removed, but
> > > as the memory backing i2c_dev goes away---it was allocated using
> > > devm_kzalloc in .probe()---the next i2c action will probably access
> > > freed memory.
> > >
> > > I'm not familiar enough with pm-runtime stuff, but wonder what
> > > can/should be done about that. The obvious (to me) candidates are:
> > >
> > >  - log an error if pm_runtime_resume_and_get() fails, but continue to
> > >    clean up
> > >  - don't check the return value at all
> > >
> > > What do you think?
> >
> > (1) Use pm_runtime_get_sync() instead of pm_runtime_resume_and_get()
> > and don't check its return value,
> >
> > or if that is not viable, because something really can run if and only
> > if the device is operational,
> >
> > (2) do something like
> >
> > ret = pm_runtime_resume_and_get(i2c_dev->dev);
> > i2c_del_adapter(&i2c_dev->adap);
> > if (ret >= 0)
> >         clk_disable_unprepare(i2c_dev->clk);
> >
> > pm_runtime_put_noidle(i2c_dev->dev);
> > pm_runtime_disable(i2c_dev->dev);
>
> Why would you not disable the clk if the resume failed?

I thought that it might lead to problems if the device that failed to
resume was expected to be accessible.

If that's not the case, you can simply do (1).

> Is it an option to not call one of the resume variants at all and only
> call pm_runtime_disable()?

That depends on whether or not you need to manipulate the hardware in
the del/disable part.  If you need to access it there, it is better to
resume I think.  Otherwise, you don't have to do anything, but then
the next probe needs to be prepared for finding the device in the
suspended state.
