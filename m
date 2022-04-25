Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6475C50E497
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242966AbiDYPm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239926AbiDYPmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:42:54 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E1E4476C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:39:50 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id i27so30374371ejd.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/0fCHT8d6UbpZZCYU9pf93zuTu4eVXI4kauBH+UwTjo=;
        b=XNwRHYP9m96xn4NB39SabkYnxSV4QFB98OwAwX/evNZWj9Hzp4ZDyNuz9JI4pEjbsy
         IEDqWQ32mdxrUgVU7eS/ncSDwYWjQkAdZXZvy5k+RDPo89RBWI8OBkUPWA0787MY5dit
         xGbnOCnZOFVQ+ZA2/3clAD05zgtffwPWiCyL+vy56mSJWecuh2Huu3bOD7YpXM/IV1Nl
         vqIhKqc9oEaDaVlAbY6LIerHHhUT7/2BShsDi2RiNjajKBvD18GP62axCVGwEg3pJcEj
         5sbaqop89z9PvdmTrAKf+JVwVaVJI4p9BvfmuWshMCxX5zePl82onvU1t1wXxwo3gHMc
         LYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/0fCHT8d6UbpZZCYU9pf93zuTu4eVXI4kauBH+UwTjo=;
        b=xv5M6EAue8cZ3WD/3DoajM7Hsca7pqLwIlgwG9EO0L6RzvkZj5KRTsK8bxBvLOiE4U
         HI4pBHNKL8jH2JV8GKKQ8X+5aq5q5MVAdXbuxvNGxIPRSGVPx43H0DzFlddlM/8QYrzq
         VPeVYORwrjKEzTC1q5BVJmxTjCuoWLJZkwNsHjt0lz1nbc4HrzQ2B/Dnb4mgUwT9jPeE
         fFN7xxo4eWEW6yfCfezgxrsYW5gCDQArLYT+pkVVaYnkG7qOwT1IGjdkx8j68z2chdih
         RAI56Q0b3yXU5BUULUrSvR1q6n6806jx5SWXWR4BkfUPpyhxu/i/sGUsc/CYYM6xdhA2
         tFyw==
X-Gm-Message-State: AOAM532XgrV5JUcC1qNYcYbKRoDgVC5JWtMhLLMffxVaeUDK/QVkoRSB
        OrPWK6K1Fz66S7H4n1oZYMPpZrbmatl1eFgbmqGz0Q==
X-Google-Smtp-Source: ABdhPJyLZ5k3NDK6SSiFa5mJWrSi0+8Cb9+M5MiHyehRGFdacIy6Y0/HFe/L1P0zBQhHB3b/EcYmJQk1iHL0TzT41qA=
X-Received: by 2002:a17:907:60cc:b0:6e0:dab3:ca76 with SMTP id
 hv12-20020a17090760cc00b006e0dab3ca76mr17222021ejc.154.1650901188508; Mon, 25
 Apr 2022 08:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220412135534.2796158-1-aford173@gmail.com> <20220412135534.2796158-3-aford173@gmail.com>
In-Reply-To: <20220412135534.2796158-3-aford173@gmail.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Mon, 25 Apr 2022 16:39:32 +0100
Message-ID: <CAPY8ntDE2X3vG3e55CAhqrwfwUhErAPw2x8535jCYJOEQ_OszQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] media: i2c: imx219: Support four-lane operation
To:     Adam Ford <aford173@gmail.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Tim Harvey <tharvey@gateworks.com>,
        cstevens@beaconembedded.com, aford@beaconembedded.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam

Sorry for the delay in reviewing this.

On Tue, 12 Apr 2022 at 14:55, Adam Ford <aford173@gmail.com> wrote:
>
> The imx219 camera is capable of either two-lane or four-lane
> operation.  When operating in four-lane, both the pixel rate and
> link frequency change. Regardless of the mode, however, both
> frequencies remain fixed.
>
> Helper functions are needed to read and set pixel and link frequencies
> which also reduces the number of fixed registers in the table of modes.
>
> Since the link frequency and number of lanes is extracted from the
> endpoint, move the endpoint handling into the probe function and
> out of the imx219_check_hwcfg.  This simplifies the imx219_check_hwcfg
> just a bit, and places all the parameters into the imx219 structure.
> It then allows imx219_check_hwcfg to simply validate the settings.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>  drivers/media/i2c/imx219.c | 144 ++++++++++++++++++++++++-------------
>  1 file changed, 96 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
> index b7cc36b16547..d13ce5c1ece6 100644
> --- a/drivers/media/i2c/imx219.c
> +++ b/drivers/media/i2c/imx219.c
> @@ -42,10 +42,16 @@
>  /* External clock frequency is 24.0M */
>  #define IMX219_XCLK_FREQ               24000000
>
> -/* Pixel rate is fixed at 182.4M for all the modes */
> +/* Pixel rate is fixed for all the modes */
>  #define IMX219_PIXEL_RATE              182400000
> +#define IMX219_PIXEL_RATE_4LANE                280800000
>
>  #define IMX219_DEFAULT_LINK_FREQ       456000000
> +#define IMX219_DEFAULT_LINK_FREQ_4LANE 702000000

My datasheet table 9-2 lists pll1_vt_freq as being 702MHz, and
Speed/Lane (Ch) is 726Mbps, so a link frequency of 363MHz.
Total output rate is 2.904Gbps, which is the 726Mbps * 4 lanes.

> +
> +#define IMX219_REG_CSI_LANE_MODE       0x0114
> +#define IMX219_CSI_2_LANE_MODE         0x01
> +#define IMX219_CSI_4_LANE_MODE         0x03
>
>  /* V_TIMING internal */
>  #define IMX219_REG_VTS                 0x0160
> @@ -175,7 +181,6 @@ static const struct imx219_reg pll_clk_table[] = {
>   * 3280x2464 = mode 2, 1920x1080 = mode 1, 1640x1232 = mode 4, 640x480 = mode 7.
>   */
>  static const struct imx219_reg mode_3280x2464_regs[] = {
> -       {0x0114, 0x01},
>         {0x0128, 0x00},
>         {0x012a, 0x18},
>         {0x012b, 0x00},
> @@ -216,7 +221,6 @@ static const struct imx219_reg mode_3280x2464_regs[] = {
>  };
>
>  static const struct imx219_reg mode_1920_1080_regs[] = {
> -       {0x0114, 0x01},
>         {0x0128, 0x00},
>         {0x012a, 0x18},
>         {0x012b, 0x00},
> @@ -257,7 +261,6 @@ static const struct imx219_reg mode_1920_1080_regs[] = {
>  };
>
>  static const struct imx219_reg mode_1640_1232_regs[] = {
> -       {0x0114, 0x01},
>         {0x0128, 0x00},
>         {0x012a, 0x18},
>         {0x012b, 0x00},
> @@ -298,7 +301,6 @@ static const struct imx219_reg mode_1640_1232_regs[] = {
>  };
>
>  static const struct imx219_reg mode_640_480_regs[] = {
> -       {0x0114, 0x01},
>         {0x0128, 0x00},
>         {0x012a, 0x18},
>         {0x012b, 0x00},
> @@ -352,6 +354,7 @@ static const struct imx219_reg raw10_framefmt_regs[] = {
>
>  static const s64 imx219_link_freq_menu[] = {
>         IMX219_DEFAULT_LINK_FREQ,
> +       IMX219_DEFAULT_LINK_FREQ_4LANE,

This one always feels weird to me. There is only one link frequency
supported at a time defined by the number of lanes. OK it's a read
only control, but having 2 link_freq_menu arrays of 1 element each,
and choosing the appropriate one seems more logical to me.

>  };
>
>  static const char * const imx219_test_pattern_menu[] = {
> @@ -529,6 +532,13 @@ struct imx219 {
>
>         /* Streaming on/off */
>         bool streaming;
> +
> +       /* Two or Four lanes */
> +       u8 lanes;
> +
> +       /* Link Frequency info */
> +       unsigned int nr_of_link_frequencies;
> +       u64 link_frequency;
>  };
>
>  static inline struct imx219 *to_imx219(struct v4l2_subdev *_sd)
> @@ -991,6 +1001,20 @@ static int imx219_get_selection(struct v4l2_subdev *sd,
>         return -EINVAL;
>  }
>
> +static int imx219_configure_lanes(struct imx219 *imx219)
> +{
> +       int ret;
> +
> +       /* imx219->lanes has already been validated to be either 2 or 4 */
> +       if (imx219->lanes == 2)
> +               ret = imx219_write_reg(imx219, IMX219_REG_CSI_LANE_MODE,
> +                                      IMX219_REG_VALUE_08BIT, IMX219_CSI_2_LANE_MODE);
> +       else
> +               ret = imx219_write_reg(imx219, IMX219_REG_CSI_LANE_MODE,
> +                                      IMX219_REG_VALUE_08BIT, IMX219_CSI_4_LANE_MODE);
> +       return ret;

Could be condensed to the one liner (with appropriate wrapping):
return imx219_write_reg(imx219, IMX219_REG_CSI_LANE_MODE,
           IMX219_REG_VALUE_08BIT,
           (imx219->lanes == 2) ? IMX219_CSI_2_LANE_MODE :
IMX219_CSI_4_LANE_MODE);

> +};
> +
>  static int imx219_start_streaming(struct imx219 *imx219)
>  {
>         struct i2c_client *client = v4l2_get_subdevdata(&imx219->sd);
> @@ -1008,6 +1032,13 @@ static int imx219_start_streaming(struct imx219 *imx219)
>                 goto err_rpm_put;
>         }
>
> +       /* Configure two or four Lane mode */
> +       ret = imx219_configure_lanes(imx219);
> +       if (ret) {
> +               dev_err(&client->dev, "%s failed to configure lanes\n", __func__);
> +               goto err_rpm_put;
> +       }
> +
>         /* Apply default values of current mode */
>         reg_list = &imx219->mode->reg_list;
>         ret = imx219_write_regs(imx219, reg_list->regs, reg_list->num_of_regs);
> @@ -1247,6 +1278,14 @@ static const struct v4l2_subdev_internal_ops imx219_internal_ops = {
>         .open = imx219_open,
>  };
>
> +static unsigned long imx219_get_pixel_rate(struct imx219 *imx219)
> +{
> +       if (imx219->lanes == 2)
> +               return IMX219_PIXEL_RATE;
> +       else
> +               return IMX219_PIXEL_RATE_4LANE;

Again:
return (imx219->lanes == 2) ? IMX219_PIXEL_RATE : IMX219_PIXEL_RATE_4LANE;
?

> +}
> +
>  /* Initialize control handlers */
>  static int imx219_init_controls(struct imx219 *imx219)
>  {
> @@ -1268,14 +1307,15 @@ static int imx219_init_controls(struct imx219 *imx219)
>         /* By default, PIXEL_RATE is read only */
>         imx219->pixel_rate = v4l2_ctrl_new_std(ctrl_hdlr, &imx219_ctrl_ops,
>                                                V4L2_CID_PIXEL_RATE,
> -                                              IMX219_PIXEL_RATE,
> -                                              IMX219_PIXEL_RATE, 1,
> -                                              IMX219_PIXEL_RATE);
> +                                              imx219_get_pixel_rate(imx219),
> +                                              imx219_get_pixel_rate(imx219), 1,
> +                                              imx219_get_pixel_rate(imx219));
>
>         imx219->link_freq =
>                 v4l2_ctrl_new_int_menu(ctrl_hdlr, &imx219_ctrl_ops,
>                                        V4L2_CID_LINK_FREQ,
> -                                      ARRAY_SIZE(imx219_link_freq_menu) - 1, 0,
> +                                      ARRAY_SIZE(imx219_link_freq_menu) - 1,
> +                                      (imx219->lanes == 4),
>                                        imx219_link_freq_menu);
>         if (imx219->link_freq)
>                 imx219->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
> @@ -1371,67 +1411,75 @@ static void imx219_free_controls(struct imx219 *imx219)
>         mutex_destroy(&imx219->mutex);
>  }
>
> -static int imx219_check_hwcfg(struct device *dev)
> +static int imx219_check_hwcfg(struct imx219 *imx219)
>  {
> -       struct fwnode_handle *endpoint;
> +       struct i2c_client *client = v4l2_get_subdevdata(&imx219->sd);
> +
> +       /* Check the number of MIPI CSI2 data lanes */
> +       if (imx219->lanes != 2 && imx219->lanes != 4) {
> +               dev_err(&client->dev, "only 2 or 4 data lanes are currently supported\n");
> +               return -EINVAL;
> +       }
> +
> +       if (imx219->link_frequency != IMX219_DEFAULT_LINK_FREQ &&
> +           imx219->link_frequency != IMX219_DEFAULT_LINK_FREQ_4LANE) {

This permits choosing 4 lane operation with a link frequency of
IMX219_DEFAULT_LINK_FREQ, or 2 lane operation with a link frequency of
IMX219_DEFAULT_LINK_FREQ_4LANE.

> +               dev_err(&client->dev, "Link frequency not supported: %lld\n",
> +                       imx219->link_frequency);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int imx219_probe(struct i2c_client *client)
> +{
> +       struct device *dev = &client->dev;
> +       struct imx219 *imx219;
>         struct v4l2_fwnode_endpoint ep_cfg = {
>                 .bus_type = V4L2_MBUS_CSI2_DPHY
>         };
> -       int ret = -EINVAL;
> +       struct fwnode_handle *endpoint;
> +       int ret = 0;
> +
> +       imx219 = devm_kzalloc(&client->dev, sizeof(*imx219), GFP_KERNEL);
> +       if (!imx219)
> +               return -ENOMEM;
>
> +       v4l2_i2c_subdev_init(&imx219->sd, client, &imx219_subdev_ops);
> +
> +       /* Fetch the endpoint to extract lanes and link-frequency */
>         endpoint = fwnode_graph_get_next_endpoint(dev_fwnode(dev), NULL);
>         if (!endpoint) {
>                 dev_err(dev, "endpoint node not found\n");
> -               return -EINVAL;
> +               ret = -EINVAL;
> +               goto fwnode_cleanup;
>         }
>
>         if (v4l2_fwnode_endpoint_alloc_parse(endpoint, &ep_cfg)) {
>                 dev_err(dev, "could not parse endpoint\n");
> -               goto error_out;
> +               ret = -EINVAL;
> +               goto fwnode_cleanup;
>         }
>
> -       /* Check the number of MIPI CSI2 data lanes */
> -       if (ep_cfg.bus.mipi_csi2.num_data_lanes != 2) {
> -               dev_err(dev, "only 2 data lanes are currently supported\n");
> -               goto error_out;
> -       }
> +       imx219->lanes = ep_cfg.bus.mipi_csi2.num_data_lanes;
> +       imx219->nr_of_link_frequencies = ep_cfg.nr_of_link_frequencies;
>
> -       /* Check the link frequency set in device tree */
> -       if (!ep_cfg.nr_of_link_frequencies) {
> +       if (imx219->nr_of_link_frequencies != 1) {
>                 dev_err(dev, "link-frequency property not found in DT\n");
> -               goto error_out;
> -       }
> -
> -       if (ep_cfg.nr_of_link_frequencies != 1 ||
> -           ep_cfg.link_frequencies[0] != IMX219_DEFAULT_LINK_FREQ) {
> -               dev_err(dev, "Link frequency not supported: %lld\n",
> -                       ep_cfg.link_frequencies[0]);
> -               goto error_out;
> +               ret = -EINVAL;
> +               goto fwnode_cleanup;
>         }
> +       imx219->link_frequency = ep_cfg.link_frequencies[0];

imx219->link_frequency is only used within imx219_check_hwcfg, which
is called from imx219_probe.
Pass it as a parameter instead of storing it in the state structure?

Cheers.
  Dave

>
> -       ret = 0;
> -
> -error_out:
> +       /* Cleanup endpoint and handle any errors from above */
> +fwnode_cleanup:
>         v4l2_fwnode_endpoint_free(&ep_cfg);
>         fwnode_handle_put(endpoint);
> -
> -       return ret;
> -}
> -
> -static int imx219_probe(struct i2c_client *client)
> -{
> -       struct device *dev = &client->dev;
> -       struct imx219 *imx219;
> -       int ret;
> -
> -       imx219 = devm_kzalloc(&client->dev, sizeof(*imx219), GFP_KERNEL);
> -       if (!imx219)
> -               return -ENOMEM;
> -
> -       v4l2_i2c_subdev_init(&imx219->sd, client, &imx219_subdev_ops);
> +       if (ret)
> +               return ret;
>
>         /* Check the hardware configuration in device tree */
> -       if (imx219_check_hwcfg(dev))
> +       if (imx219_check_hwcfg(imx219))
>                 return -EINVAL;
>
>         /* Get system clock (xclk) */
> --
> 2.34.1
>
