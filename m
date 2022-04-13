Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DA84FF915
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbiDMOlP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Apr 2022 10:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiDMOlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:41:14 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F28D60A95;
        Wed, 13 Apr 2022 07:38:52 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id v77so4063296ybi.12;
        Wed, 13 Apr 2022 07:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=80rnXlJvjwg31BPv10O4ldqkvQvXPgrHRPfb/fpogO0=;
        b=xzhg+SN7omcXYwSzk0q0yX8Z9Fba7NVqDaaZvbE+6agGtxFnHG5m+S/EG4hjicWK3T
         XsTkqp+T1buf3r0zmLev1NXUvmNJ2+DZ1gWX93VVdWk75fiNBOzmAuweXn7o86dxyOni
         jGphNSeXvu0Jf9gD7gaFvCAUJxIgWD8XndA9hHFX0lxXTmbETTj0XZNgay3ejhUMktmO
         AxVvscmL1zswAy2tufJFNbtmytKfb5C1b5KcOoY0PVLeoq3Q8AYBV08iFpiCpQqm7Dld
         liKcLD/YjgNpFzUB5LZM3WVAXSyQxipRmM39vbwWYEjWZcU/3cvMsmNFB+vdNaIgJdpT
         v26Q==
X-Gm-Message-State: AOAM531pertQ2vvDVsNknMJlF7WcpbSyTeQxDqWtx6wE+hLRijIoSYgm
        ZBxpGCJSJ+pX5jb+flMN8WxboSVsBlztZ+Au9yg=
X-Google-Smtp-Source: ABdhPJxVM+QHir1XU/QmbuZRMUT4SBGRcdTbZb6s97PDe6A/GOAQBilFQA20R9vUKAc5wUL9dD/4wHVeWSi1xAXg2mI=
X-Received: by 2002:a05:6902:1544:b0:63d:d3a7:8cc4 with SMTP id
 r4-20020a056902154400b0063dd3a78cc4mr31259358ybu.622.1649860731311; Wed, 13
 Apr 2022 07:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220324103443.4563-1-hesham.almatary@huawei.com> <5J099R.20GRUWFVWC5D1@crapouillou.net>
In-Reply-To: <5J099R.20GRUWFVWC5D1@crapouillou.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Apr 2022 16:38:40 +0200
Message-ID: <CAJZ5v0hpRd_zAtrx2nV1X2=ZeNz3sE6h9+2NQZFY92qKJ82qGw@mail.gmail.com>
Subject: Re: [PATCH] thermal:hisi_termal: Switch from CONFIG_PM_SLEEP guards
 to pm_sleep_ptr()
To:     Paul Cercueil <paul@crapouillou.net>,
        Hesham Almatary <hesham.almatary@huawei.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 1:11 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi Hesham,
>
> Le jeu., mars 24 2022 at 10:34:43 +0000, Hesham Almatary
> <hesham.almatary@huawei.com> a écrit :
> > Cleaning up the driver to use pm_sleep_ptr() macro instead of #ifdef
> > guards is simpler and allows the compiler to remove those functions
> > if built without CONFIG_PM_SLEEP support.
> >
> > Signed-off-by: Hesham Almatary <hesham.almatary@huawei.com>
>
> Looks good.
>
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>

And applied as 5.19 material, thanks!

> > ---
> >  drivers/thermal/hisi_thermal.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/thermal/hisi_thermal.c
> > b/drivers/thermal/hisi_thermal.c
> > index 9a21ac0ceb11..b29ab09040d5 100644
> > --- a/drivers/thermal/hisi_thermal.c
> > +++ b/drivers/thermal/hisi_thermal.c
> > @@ -629,7 +629,6 @@ static int hisi_thermal_remove(struct
> > platform_device *pdev)
> >       return 0;
> >  }
> >
> > -#ifdef CONFIG_PM_SLEEP
> >  static int hisi_thermal_suspend(struct device *dev)
> >  {
> >       struct hisi_thermal_data *data = dev_get_drvdata(dev);
> > @@ -651,15 +650,14 @@ static int hisi_thermal_resume(struct device
> > *dev)
> >
> >       return ret;
> >  }
> > -#endif
> >
> > -static SIMPLE_DEV_PM_OPS(hisi_thermal_pm_ops,
> > +static DEFINE_SIMPLE_DEV_PM_OPS(hisi_thermal_pm_ops,
> >                        hisi_thermal_suspend, hisi_thermal_resume);
> >
> >  static struct platform_driver hisi_thermal_driver = {
> >       .driver = {
> >               .name           = "hisi_thermal",
> > -             .pm             = &hisi_thermal_pm_ops,
> > +             .pm             = pm_sleep_ptr(&hisi_thermal_pm_ops),
> >               .of_match_table = of_hisi_thermal_match,
> >       },
> >       .probe  = hisi_thermal_probe,
> > --
> > 2.25.1
> >
>
>
