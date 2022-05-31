Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98764539445
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 17:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345887AbiEaPvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 11:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239673AbiEaPvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 11:51:05 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08ED47A469
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:51:04 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id n13-20020a17090a394d00b001e30a60f82dso3143247pjf.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=63Dh72iBG/bnj2Ixe2jPtaXi8Xp2x1EBc+gxE7+aSbQ=;
        b=GBYAwax/LH+PPez9PmA99SqAUjkVVr19umyNwewxR9RerdRV3RYO4qKW4o+Q9EVm0s
         XpML0WiC+sx2n/dhaQKoI+m3OWRRVaeX+P8sPO/sPMfiW2L1pp5uKUTGW3mdo4qdZIQ8
         3QCY55rz+WLxTmSis/iRPZaARLDqOdkOYe1cM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=63Dh72iBG/bnj2Ixe2jPtaXi8Xp2x1EBc+gxE7+aSbQ=;
        b=ao9u+vFtu1/RzZaUby1si0Yn7lW4g00icLl+cHNUU6YZViJgP+iLUCyrP9Q75glvYD
         YCRdCFxZ3/vwcMgB+jiGtPi1XfLy/NoDFi4nqcc/Xnq789sdpUAcSAycJt2zecWD2rvY
         q9uvQG7whtdlHhuYpCRwPXfYiDfyDoYDllyxh5TAaRcEDtJGfXlDCC1Oaijs5u7yapxO
         RX2LGDRxO5OkOWSflEjBBnKPqU4AzXSwIpRFA/OWbebUkYw3VbZ/M6rSOqARZiQnwoGl
         1DqFDG4rF2Pij0oYaOTm1JVHSWNq65MTs5yIN1ofY6/S1hyfr9jACSFm+wQLXrz3O+1N
         f/0A==
X-Gm-Message-State: AOAM5318VYUgYdVMbJ2WfSEN2O2I3SAMXvdyWsbZviQDG6RZxKYwcACG
        rj8GsVmgYpq5JNEsSo3NqYLsZJkfknHr+ZVAsMjc6Q==
X-Google-Smtp-Source: ABdhPJxfoDHY85r/rxqdbHy68jCot1RJCFffEmcUx/A48bpZHmo7RyFFClwOSUEV1xqItEZe0g5Yh/SmfdJpfrdi+LA=
X-Received: by 2002:a17:902:e552:b0:163:6a5e:4e08 with SMTP id
 n18-20020a170902e55200b001636a5e4e08mr28798445plf.130.1654012263372; Tue, 31
 May 2022 08:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220519075117.1003520-1-tommaso.merciai@amarulasolutions.com>
 <20220519075117.1003520-2-tommaso.merciai@amarulasolutions.com>
 <20220531131409.f54znvogejkwqqkf@uno.localdomain> <20220531154040.GA1331064@tom-ThinkPad-T14s-Gen-2i>
In-Reply-To: <20220531154040.GA1331064@tom-ThinkPad-T14s-Gen-2i>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Tue, 31 May 2022 17:50:51 +0200
Message-ID: <CAOf5uwmNoSPifCo8_hLZyr=DzMqL0r2Ftot2jneEVpAT8AyYVg@mail.gmail.com>
Subject: Re: [PATCH 1/4] media: i2c: ov5695: use regulator_bulk_enable/regulator_bulk
 disable instead of for loop
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     Jacopo Mondi <jacopo@jmondi.org>, linuxfancy@googlegroups.com,
        linux-amarula@amarulasolutions.com,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi

On Tue, May 31, 2022 at 5:40 PM Tommaso Merciai
<tommaso.merciai@amarulasolutions.com> wrote:
>
> Hi Jacopo,
> On Tue, May 31, 2022 at 03:14:09PM +0200, Jacopo Mondi wrote:
> > Hi Tommaso,
> >
> > On Thu, May 19, 2022 at 09:51:14AM +0200, Tommaso Merciai wrote:
> > > Enable regulator using regulator_bulk_enable/regulatore_bulk_disable
> > > function in __ov5695_power_on/__ov5695_power_off function instead of for loop.
> > > This reduce code size and make things more clear
> > >
> > > Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> > > Co-Developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> > > ---
> > >  drivers/media/i2c/ov5695.c | 25 +++++++------------------
> > >  1 file changed, 7 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/media/i2c/ov5695.c b/drivers/media/i2c/ov5695.c
> > > index 439385938a51..880b586e55fe 100644
> > > --- a/drivers/media/i2c/ov5695.c
> > > +++ b/drivers/media/i2c/ov5695.c
> > > @@ -972,7 +972,7 @@ static int ov5695_s_stream(struct v4l2_subdev *sd, int on)
> > >
> > >  static int __ov5695_power_on(struct ov5695 *ov5695)
> > >  {
> > > -   int i, ret;
> > > +   int ret;
> > >     struct device *dev = &ov5695->client->dev;
> > >
> > >     ret = clk_prepare_enable(ov5695->xvclk);
> > > @@ -987,13 +987,10 @@ static int __ov5695_power_on(struct ov5695 *ov5695)
> > >      * The hardware requires the regulators to be powered on in order,
> > >      * so enable them one by one.
> > >      */
> >
> > The comment says that the hardware requires regulators to be enabled
> > in precise order
> >

They are enabled on the array order.

> > > -   for (i = 0; i < OV5695_NUM_SUPPLIES; i++) {
> > > -           ret = regulator_enable(ov5695->supplies[i].consumer);
> > > -           if (ret) {
> > > -                   dev_err(dev, "Failed to enable %s: %d\n",
> > > -                           ov5695->supplies[i].supply, ret);
> > > -                   goto disable_reg_clk;
> > > -           }
> > > +   ret = regulator_bulk_enable(ARRAY_SIZE(ov5695->supplies), ov5695->supplies);
> >
> > bulk_enable() uses the async API (async_schedule_domain() in
> > particular) which by the name makes me think such ordering guarantee
> > cannot be respected.

I don't think so. Will make no sense because if it fails, revert them.
Even the bulk disable disable them
in reverse order

> >
> > However most sensors require some kind of ordering when enabling
> > regulators, and most of the use the bulk API anyhow. The fact this
> > driver uses the bulk API to get an release the regulators but not for
> > enabling them and the above comment, makes me think it has been done
> > on purpose ? Could you check with the driver author maybe ?
>
> Thanks for suggestion, good question.
> I see also ov5693 driver use bulk_enable/bulk_disable
> on ov5693_sensor_powerdown and ov5693_sensor_powerup functions, I take
> this as reference (and I'm wrong)
>
> In a functional test on PX30_Mini_evb_v11_20190507, after this series
> I'm able to see the correct chip id during probe and do some capture.
>
> I think you are right Jacopo, we can drop off this [PATCH 1/4]
> On the following link I found the issue that you describe: [1]
>

WHy drop?

Michael

> >
> > > +   if (ret) {
> > > +           dev_err(dev, "Failed to enable regulators %d\n", ret);
> > > +           goto disable_reg_clk;
> > >     }
> > >
> > >     gpiod_set_value_cansleep(ov5695->reset_gpio, 0);
> > > @@ -1003,8 +1000,7 @@ static int __ov5695_power_on(struct ov5695 *ov5695)
> > >     return 0;
> > >
> > >  disable_reg_clk:
> > > -   for (--i; i >= 0; i--)
> > > -           regulator_disable(ov5695->supplies[i].consumer);
> > > +   regulator_bulk_disable(ARRAY_SIZE(ov5695->supplies), ov5695->supplies);
> >
> > FYI the bulk API does this for you if enabling any of the regulators fails.
> > Hence this should not be necessary.
>
> Thanks for sharing! This is new to me.
> I'll update the series on v2 removing this patch.
>
> Regards,
> Tommaso
>
> [1]: https://mailweb.openeuler.org/hyperkitty/list/kernel@openeuler.org/message/4X54QYJDRRE4K5BW4FTDZUGRAL4GRQWY/
>
> > Thanks
> >    j
> >
> > >     clk_disable_unprepare(ov5695->xvclk);
> > >
> > >     return ret;
> > > @@ -1012,8 +1008,6 @@ static int __ov5695_power_on(struct ov5695 *ov5695)
> > >
> > >  static void __ov5695_power_off(struct ov5695 *ov5695)
> > >  {
> > > -   struct device *dev = &ov5695->client->dev;
> > > -   int i, ret;
> > >
> > >     clk_disable_unprepare(ov5695->xvclk);
> > >     gpiod_set_value_cansleep(ov5695->reset_gpio, 1);
> > > @@ -1022,12 +1016,7 @@ static void __ov5695_power_off(struct ov5695 *ov5695)
> > >      * The hardware requires the regulators to be powered off in order,
> > >      * so disable them one by one.
> > >      */
> > > -   for (i = OV5695_NUM_SUPPLIES - 1; i >= 0; i--) {
> > > -           ret = regulator_disable(ov5695->supplies[i].consumer);
> > > -           if (ret)
> > > -                   dev_err(dev, "Failed to disable %s: %d\n",
> > > -                           ov5695->supplies[i].supply, ret);
> > > -   }
> > > +   regulator_bulk_disable(ARRAY_SIZE(ov5695->supplies), ov5695->supplies);
> > >  }
> > >
> > >  static int __maybe_unused ov5695_runtime_resume(struct device *dev)
> > > --
> > > 2.25.1
> > >
>
> --
> Tommaso Merciai
> Embedded Linux Engineer
> tommaso.merciai@amarulasolutions.com
> __________________________________
>
> Amarula Solutions SRL
> Via Le Canevare 30, 31100 Treviso, Veneto, IT
> T. +39 042 243 5310
> info@amarulasolutions.com
> www.amarulasolutions.com



-- 
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
