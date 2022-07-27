Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60167582933
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 17:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbiG0PBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 11:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbiG0PBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:01:20 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF93411457;
        Wed, 27 Jul 2022 08:01:18 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id e15so21768175edj.2;
        Wed, 27 Jul 2022 08:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KFkyev3QkBabEIq6oQnHGhKKYmK0I7LOu6yUgtmuHUg=;
        b=LWCh1zscWgLJclCFHlqmVHR3K5BMea2/4aI74l4vojlc3SUun1lPXuqGi8QjFkGb0L
         eE2Ilq5V/WefC1rLwFBN2KfS4AVbVQE08evmaJJKqE2MmFY+mYEI4nI/cZMZgx+zNGPi
         5X8TpaJ6er8QdWe2o+dUmpQBDGOygaMsuh+icAoAwX58/VqvNQvzstIqRCC0pBJu/J34
         htUJawG9bZIpPnBnYZWf2lI6WixrzjkmpsDHEIb8c/+jCqi5/7xP/ctLNAVyfMKG1Wes
         61VUrpTIyVIU6XR4sRQxcqU8I8sb0ewVFvqMsgXoBWyUkiwhYKFXZI8VugbjN6ly5Ree
         luyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KFkyev3QkBabEIq6oQnHGhKKYmK0I7LOu6yUgtmuHUg=;
        b=6x32ef0/Bh/bx5r6sGhoz41opHmXmBZoPjJJi4dzJg+eH83Z7oP00T+wvyP7B8nc1K
         JBp8YvxRPguoie5q0Jv8THQcRqVo4GtyU8FFar0p002k9HEZp+SV55hJEoTEVYCANvkw
         1V3DKYJ1eaCZxt9KPSfQd8AiL5cNwnjaldZGjU0kWkeXf8NFpaIQqsakX82dBV9MAjpR
         2jgFEErGKt8Xb2SMbZUW+ApK8ZXZ7p1bCu7aL+ichmbnAMg+9umJGpHFAJq8SJEnmwT0
         Qh4Z7C0f9f9La0nIaHZ40XcVLLR34ZVKZDwTkyLrWV4rWJgTgd3KaMk/nkQNeZirUvT7
         QaDg==
X-Gm-Message-State: AJIora+MOebcfhBjtDpkdQRu/udHhYSJJ9sDA7QnO02GmK7kTCD6aTLu
        Tlz1lBV6LfPFOe5/n/l9b4Ob5Xu/yReqlFlT0Ag=
X-Google-Smtp-Source: AGRyM1ugJateJ+xk+YdNul/QBXYl1YIV1ac5eDzfoZU+wr7AVOBEQSPOMomoxQZ7VQwDvwViyWNvJ3Q8rCZqaJEfi4c=
X-Received: by 2002:a05:6402:398:b0:43c:cbd7:d0a3 with SMTP id
 o24-20020a056402039800b0043ccbd7d0a3mr1322056edv.238.1658934077148; Wed, 27
 Jul 2022 08:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220709135052.3850913-1-aford173@gmail.com> <20220709135052.3850913-2-aford173@gmail.com>
 <CAPY8ntA-KBfJwgxtsHdG32wA+v518=r5NBNbHZqFgEC7fp5xUA@mail.gmail.com>
In-Reply-To: <CAPY8ntA-KBfJwgxtsHdG32wA+v518=r5NBNbHZqFgEC7fp5xUA@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 27 Jul 2022 10:01:06 -0500
Message-ID: <CAHCN7xKaiThSPwfKpwKP8B=bq6_HXu473VKqtxms7vDtwDU+qQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: i2c: imx219: Support four-lane operation
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     linux-media <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 9:30 AM Dave Stevenson
<dave.stevenson@raspberrypi.com> wrote:
>
> Hi Adam
>
> Sorry for the delay in reviewing.
>
> On Sat, 9 Jul 2022 at 14:51, Adam Ford <aford173@gmail.com> wrote:
> >
> > The imx219 camera is capable of either two-lane or four-lane
> > operation.  When operating in four-lane, both the pixel rate and
> > link frequency change. Regardless of the mode, however, both
> > frequencies remain fixed.
> >
> > Helper functions are needed to read and set pixel and link frequencies
> > which also reduces the number of fixed registers in the table of modes.
> >
> > Since the link frequency and number of lanes is extracted from the
> > endpoint, move the endpoint handling into the probe function and
> > out of the imx219_check_hwcfg.  This simplifies the imx219_check_hwcfg
> > just a bit.
>
> This paragraph isn't relevant any more.

Oops.  I forgot to review the commit message.  I'll fix on V4.
>
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> > V3:  Keep the helper function doing the link and lane parsing to
> >      keep th probe function small.
> >
> > diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
> > index faa5dab3c2ec..bb4125e7e113 100644
> > --- a/drivers/media/i2c/imx219.c
> > +++ b/drivers/media/i2c/imx219.c
> > @@ -42,10 +42,16 @@
> >  /* External clock frequency is 24.0M */
> >  #define IMX219_XCLK_FREQ               24000000
> >
> > -/* Pixel rate is fixed at 182.4M for all the modes */
> > +/* Pixel rate is fixed for all the modes */
> >  #define IMX219_PIXEL_RATE              182400000
> > +#define IMX219_PIXEL_RATE_4LANE                280800000
> >
> >  #define IMX219_DEFAULT_LINK_FREQ       456000000
> > +#define IMX219_DEFAULT_LINK_FREQ_4LANE 363000000
> > +
> > +#define IMX219_REG_CSI_LANE_MODE       0x0114
> > +#define IMX219_CSI_2_LANE_MODE         0x01
> > +#define IMX219_CSI_4_LANE_MODE         0x03
> >
> >  /* V_TIMING internal */
> >  #define IMX219_REG_VTS                 0x0160
> > @@ -299,6 +305,10 @@ static const s64 imx219_link_freq_menu[] = {
> >         IMX219_DEFAULT_LINK_FREQ,
> >  };
> >
> > +static const s64 imx219_link_freq_4lane_menu[] = {
> > +       IMX219_DEFAULT_LINK_FREQ_4LANE,
> > +};
> > +
> >  static const char * const imx219_test_pattern_menu[] = {
> >         "Disabled",
> >         "Color Bars",
> > @@ -474,6 +484,9 @@ struct imx219 {
> >
> >         /* Streaming on/off */
> >         bool streaming;
> > +
> > +       /* Two or Four lanes */
> > +       u8 lanes;
> >  };
> >
> >  static inline struct imx219 *to_imx219(struct v4l2_subdev *_sd)
> > @@ -936,6 +949,13 @@ static int imx219_get_selection(struct v4l2_subdev *sd,
> >         return -EINVAL;
> >  }
> >
> > +static int imx219_configure_lanes(struct imx219 *imx219)
> > +{
> > +       return imx219_write_reg(imx219, IMX219_REG_CSI_LANE_MODE,
> > +                               IMX219_REG_VALUE_08BIT, (imx219->lanes == 2) ?
> > +                               IMX219_CSI_2_LANE_MODE : IMX219_CSI_4_LANE_MODE);
> > +};
> > +
> >  static int imx219_start_streaming(struct imx219 *imx219)
> >  {
> >         struct i2c_client *client = v4l2_get_subdevdata(&imx219->sd);
> > @@ -953,6 +973,13 @@ static int imx219_start_streaming(struct imx219 *imx219)
> >                 goto err_rpm_put;
> >         }
> >
> > +       /* Configure two or four Lane mode */
> > +       ret = imx219_configure_lanes(imx219);
> > +       if (ret) {
> > +               dev_err(&client->dev, "%s failed to configure lanes\n", __func__);
> > +               goto err_rpm_put;
> > +       }
> > +
> >         /* Apply default values of current mode */
> >         reg_list = &imx219->mode->reg_list;
> >         ret = imx219_write_regs(imx219, reg_list->regs, reg_list->num_of_regs);
> > @@ -1184,6 +1211,11 @@ static const struct v4l2_subdev_internal_ops imx219_internal_ops = {
> >         .open = imx219_open,
> >  };
> >
> > +static unsigned long imx219_get_pixel_rate(struct imx219 *imx219)
> > +{
> > +       return (imx219->lanes == 2) ? IMX219_PIXEL_RATE : IMX219_PIXEL_RATE_4LANE;
> > +}
> > +
> >  /* Initialize control handlers */
> >  static int imx219_init_controls(struct imx219 *imx219)
> >  {
> > @@ -1205,15 +1237,16 @@ static int imx219_init_controls(struct imx219 *imx219)
> >         /* By default, PIXEL_RATE is read only */
> >         imx219->pixel_rate = v4l2_ctrl_new_std(ctrl_hdlr, &imx219_ctrl_ops,
> >                                                V4L2_CID_PIXEL_RATE,
> > -                                              IMX219_PIXEL_RATE,
> > -                                              IMX219_PIXEL_RATE, 1,
> > -                                              IMX219_PIXEL_RATE);
> > +                                              imx219_get_pixel_rate(imx219),
> > +                                              imx219_get_pixel_rate(imx219), 1,
> > +                                              imx219_get_pixel_rate(imx219));
> >
> >         imx219->link_freq =
> >                 v4l2_ctrl_new_int_menu(ctrl_hdlr, &imx219_ctrl_ops,
> >                                        V4L2_CID_LINK_FREQ,
> >                                        ARRAY_SIZE(imx219_link_freq_menu) - 1, 0,
> > -                                      imx219_link_freq_menu);
> > +                                      (imx219->lanes == 2) ? imx219_link_freq_menu :
> > +                                      imx219_link_freq_4lane_menu);
> >         if (imx219->link_freq)
> >                 imx219->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
> >
> > @@ -1308,7 +1341,7 @@ static void imx219_free_controls(struct imx219 *imx219)
> >         mutex_destroy(&imx219->mutex);
> >  }
> >
> > -static int imx219_check_hwcfg(struct device *dev)
> > +static int imx219_check_hwcfg(struct device *dev, struct imx219 *imx219)
> >  {
> >         struct fwnode_handle *endpoint;
> >         struct v4l2_fwnode_endpoint ep_cfg = {
> > @@ -1328,10 +1361,12 @@ static int imx219_check_hwcfg(struct device *dev)
> >         }
> >
> >         /* Check the number of MIPI CSI2 data lanes */
> > -       if (ep_cfg.bus.mipi_csi2.num_data_lanes != 2) {
> > -               dev_err(dev, "only 2 data lanes are currently supported\n");
> > +       if (ep_cfg.bus.mipi_csi2.num_data_lanes != 2 &&
> > +           ep_cfg.bus.mipi_csi2.num_data_lanes != 4) {
> > +               dev_err(dev, "only 2 or 4 data lanes are currently supported\n");
> >                 goto error_out;
> >         }
> > +       imx219->lanes = ep_cfg.bus.mipi_csi2.num_data_lanes;
> >
> >         /* Check the link frequency set in device tree */
> >         if (!ep_cfg.nr_of_link_frequencies) {
> > @@ -1339,8 +1374,8 @@ static int imx219_check_hwcfg(struct device *dev)
> >                 goto error_out;
> >         }
> >
> > -       if (ep_cfg.nr_of_link_frequencies != 1 ||
> > -           ep_cfg.link_frequencies[0] != IMX219_DEFAULT_LINK_FREQ) {
> > +       if (ep_cfg.link_frequencies[0] != ((imx219->lanes == 2) ?
> > +           IMX219_DEFAULT_LINK_FREQ : IMX219_DEFAULT_LINK_FREQ_4LANE)) {
>
> You've lost the check of ep_cfg.nr_of_link_frequencies != 1 in this update.

oops.  I'll fix in V4.
>
> Otherwise it looks good to me.
>
Thanks for the review and feedback.

adam

>   Dave
>
> >                 dev_err(dev, "Link frequency not supported: %lld\n",
> >                         ep_cfg.link_frequencies[0]);
> >                 goto error_out;
> > @@ -1368,7 +1403,7 @@ static int imx219_probe(struct i2c_client *client)
> >         v4l2_i2c_subdev_init(&imx219->sd, client, &imx219_subdev_ops);
> >
> >         /* Check the hardware configuration in device tree */
> > -       if (imx219_check_hwcfg(dev))
> > +       if (imx219_check_hwcfg(dev, imx219))
> >                 return -EINVAL;
> >
> >         /* Get system clock (xclk) */
> > --
> > 2.34.1
> >
