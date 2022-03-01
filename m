Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0583E4C8A89
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 12:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbiCALTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 06:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbiCALTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 06:19:24 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E63D1DA6F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 03:18:41 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id g39so26214590lfv.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 03:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Q+7lXKvJmJfApxgPqSja1YaabJDgfdj5ysiT/jG1H4=;
        b=I+7ITWgPUBiOy092xGztWAiT0XGbypDROgauGgObFuoP8AFQkklQrp0HO/hMkf5anX
         CSQ+ssv/4uyBAxEvjir6uqj5EardhckZ0WwS1dzVLzuoUl/FEPIE4TVbEElwJCZuVydP
         T7KtJRuVdHPHRH0HE60dmzEb2ssMEQZ+cHxx7wZ5u34gmmeJZiLURapQenOZSm1fSYtC
         fv1N3S4++Mnz+NSelQnyD7GTUT1VUxd3sJQ+3TpKn8AOeWm5rRbGPahMEfwomt345g/f
         OCv6KjXiIIwMsbAqyewXKydd6xNn3+Joc1n/0SGkNEAjVDMu8Iz0amZ8ObuigsforRpU
         jMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Q+7lXKvJmJfApxgPqSja1YaabJDgfdj5ysiT/jG1H4=;
        b=BV8tYg3f75Rgdo/10MZ27rLY9QvMb/d93N7hKlA24yNEDA3EMmdOyQhgD5+/AqvP6Y
         mJ809Pv7wqHNoalcO2oDztYe0ZNbSW4aWe7vtZMxdOwZhZIIJU1X5qlTjvKdF+e7Zk4N
         08loGgjh4lQSDDSGCLZcYKHJmeMp+vfOeJv0sO9Fkcb7LEizEPTWpzAHHdU/Hmms8bmf
         atL3Pb5KGqS3WMZGx0RI0VoKjZ3hermN7bodHvwjVCk8DFEVe/w1Zr/GuGvmuU0m0x5j
         8m2sPa3W7LB1pLkJJL99yMawzgrbziOazNc5ao4RbgCONebFQW0pm6pBehrYgFYc3oWg
         7wgQ==
X-Gm-Message-State: AOAM531gFYd9wUFPPP2Iaeom84Mm2FpfX1wWaeNae9yHbwfz0Su15/YM
        hzXRaHspFrwvmVlEHch8PCzD6rgIbF3AngTLGU/w2Q==
X-Google-Smtp-Source: ABdhPJxSiQAQPolHrz0IQWhcpQc3TNLO/Pl+1iEBEd3ZK9erAQE0B0t1tSg5UC7c5c0YuIGQOridzN3CixYYhzPJUQc=
X-Received: by 2002:a19:9144:0:b0:43b:86a4:1497 with SMTP id
 y4-20020a199144000000b0043b86a41497mr15407463lfj.254.1646133519263; Tue, 01
 Mar 2022 03:18:39 -0800 (PST)
MIME-Version: 1.0
References: <20220223083441.1.I925ce9fa12992a58caed6b297e0171d214866fe7@changeid>
 <CAPDyKFrDncw0D2ccw9GJS+oRdm2kROJh25OV9pMs+992vQV-cQ@mail.gmail.com> <Yh36R817IjCw2dMb@pendragon.ideasonboard.com>
In-Reply-To: <Yh36R817IjCw2dMb@pendragon.ideasonboard.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 1 Mar 2022 12:18:02 +0100
Message-ID: <CAPDyKFrchzHnph9zg55yCbpQ5hu9P=ZOdcuigyqC_4yYjFs10Q@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Have devm_pm_runtime_enable() handle pm_runtime_dont_use_autosuspend()
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Mar 2022 at 11:49, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ulf,
>
> On Tue, Mar 01, 2022 at 11:26:46AM +0100, Ulf Hansson wrote:
> > On Wed, 23 Feb 2022 at 17:35, Douglas Anderson <dianders@chromium.org> wrote:
> > >
> > > The PM Runtime docs say:
> > >   Drivers in ->remove() callback should undo the runtime PM changes done
> > >   in ->probe(). Usually this means calling pm_runtime_disable(),
> > >   pm_runtime_dont_use_autosuspend() etc.
> > >
> > > From grepping code, it's clear that many people aren't aware of the
> > > need to call pm_runtime_dont_use_autosuspend().
> >
> > Well, I admit it's good practice that they should take care of this.
> >
> > However, it doesn't really matter to keep the autosuspend turned on
> > when runtime PM becomes disabled, I think. When the driver gets probed
> > again, it will most likely call pm_runtime_use_autosuspend() again,
> > which should work fine, right?
>
> For the probe path I agree, but are there valid use cases where, at
> runtime, a driver would disable runtime PM and re-enable it a bit later
> ? If so, we need to ensure this won't disable auto-suspend.

I am not sure I fully understand whether there is a problem.

Can you perhaps write the sequence of the runtime PM calls that may
cause an issue?

>
> > > When brainstorming solutions, one idea that came up was to leverage
> > > the new-ish devm_pm_runtime_enable() function. The idea here is that:
> > > * When the devm action is called we know that the driver is being
> > >   removed. It's the perfect time to undo the use_autosuspend.
> > > * The code of pm_runtime_dont_use_autosuspend() already handles the
> > >   case of being called when autosuspend wasn't enabled.
> >
> > Hmm, I am hesitating to extend devm_pm_runtime_enable(), as it
> > currently makes it look too simple to turn off things at ->remove()
> > for runtime PM. While in fact it's more complicated.
> >
> > A bigger problem, for example, is that a driver calls
> > pm_runtime_put_sync() during ->remove(), relying on that it actually
> > ends up calling its ->runtime_suspend() callback to turn off various
> > specific resources for the device. And in fact there are no guarantees
> > that will happen - and when it doesn't, the next time the driver's
> > ->probe() runs, things are likely to be really screwed up.
> >
> > To cover this case, one could use the below code in the ->remove() callback:
> >
> > ...
> > pm_runtime_get_sync();
> >
> > "turn off resources for the devices - like calling
> > clk_disable_unprepare(), for example"
> >
> > pm_runtime_disable();
> > pm_runtime_put_noidle();
> > ...
> >
> > In this example, it would be too late to call pm_runtime_disable()
> > through the pm_runtime_disable_action().
>
> My experience with runtime PM is that it's hard to use, at least if you
> want to get it right :-) That's especially the case if a driver wants to
> support both CONFIG_PM and !CONFIG_PM. Here's an example at probe time:
>
>         /*
>          * We need the driver to work in the event that CONFIG_PM is disabled in
>          * the kernel, so power up and verify the chip now. In the event that
>          * CONFIG_PM is disabled this will leave the chip on, so that streaming
>          * will work.
>          */
>         ret = ov5693_sensor_powerup(ov5693);
>         if (ret)
>                 goto err_media_entity_cleanup;
>
>         ret = ov5693_detect(ov5693);
>         if (ret)
>                 goto err_powerdown;
>
>         pm_runtime_set_active(&client->dev);
>         pm_runtime_get_noresume(&client->dev);
>         pm_runtime_enable(&client->dev);
>
>         ret = v4l2_async_register_subdev_sensor(&ov5693->sd);
>         if (ret) {
>                 dev_err(&client->dev, "failed to register V4L2 subdev: %d",
>                         ret);
>                 goto err_pm_runtime;
>         }
>
>         pm_runtime_set_autosuspend_delay(&client->dev, 1000);
>         pm_runtime_use_autosuspend(&client->dev);
>         pm_runtime_put_autosuspend(&client->dev);
>
> And the corresponding code at remove time:
>
>         /*
>          * Disable runtime PM. In case CONFIG_PM is disabled in the kernel,
>          * make sure to turn power off manually.
>          */
>         pm_runtime_disable(&client->dev);
>         if (!pm_runtime_status_suspended(&client->dev))
>                 ov5693_sensor_powerdown(ov5693);
>         pm_runtime_set_suspended(&client->dev);
>
> And of course there's no documentation that explains all this, so there
> are endless variations of patterns originating from cargo-cult
> programming.
>
> I don't know what the right solution is, but we need to move towards an
> easier to use API if we want drivers to get it right. Any step in that
> direction would be welcome.

Yep, I fully agree with you, while it's not an easy task. At least the
example above looks fine to me. :-)

Recently I noticed that some drivers are calling
pm_runtime_force_suspend() at ->remove(). This works fine in quite
many cases, but it wouldn't solve the case when CONFIG_PM is unset.

Perhaps we should explore adding a new API, along the lines of
pm_runtime_force_suspend(), but make it specific for the ->remove()
path, and in some way make it work for when CONFIG_PM is unset too.

Kind regards
Uffe

>
> > > Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > >
> > >  drivers/base/power/runtime.c | 5 +++++
> > >  include/linux/pm_runtime.h   | 4 ++++
> > >  2 files changed, 9 insertions(+)
> > >
> > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > > index 2f3cce17219b..d4059e6ffeae 100644
> > > --- a/drivers/base/power/runtime.c
> > > +++ b/drivers/base/power/runtime.c
> > > @@ -1476,11 +1476,16 @@ EXPORT_SYMBOL_GPL(pm_runtime_enable);
> > >
> > >  static void pm_runtime_disable_action(void *data)
> > >  {
> > > +       pm_runtime_dont_use_autosuspend(data);
> > >         pm_runtime_disable(data);
> > >  }
> > >
> > >  /**
> > >   * devm_pm_runtime_enable - devres-enabled version of pm_runtime_enable.
> > > + *
> > > + * NOTE: this will also handle calling pm_runtime_dont_use_autosuspend() for
> > > + * you at driver exit time if needed.
> > > + *
> > >   * @dev: Device to handle.
> > >   */
> > >  int devm_pm_runtime_enable(struct device *dev)
> > > diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> > > index 9f09601c465a..2bff6a10095d 100644
> > > --- a/include/linux/pm_runtime.h
> > > +++ b/include/linux/pm_runtime.h
> > > @@ -567,6 +567,10 @@ static inline void pm_runtime_disable(struct device *dev)
> > >   * Allow the runtime PM autosuspend mechanism to be used for @dev whenever
> > >   * requested (or "autosuspend" will be handled as direct runtime-suspend for
> > >   * it).
> > > + *
> > > + * NOTE: It's important to undo this with pm_runtime_dont_use_autosuspend()
> > > + * at driver exit time unless your driver initially enabled pm_runtime
> > > + * with devm_pm_runtime_enable() (which handles it for you).
> > >   */
> > >  static inline void pm_runtime_use_autosuspend(struct device *dev)
> > >  {
>
> --
> Regards,
>
> Laurent Pinchart
