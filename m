Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75F4550369
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 09:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbiFRHuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 03:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiFRHux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 03:50:53 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EBC42EEF
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 00:50:52 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id k24so7936428oij.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 00:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=cBzM9UoVzRVKD1d9z7jyJ0wgTFaTbgRwKQ+AtCKN22k=;
        b=oFRR/QHIy1kXbvE8HuSygPXuyhvoEfDZTEUwq7yW8bivkgqlBsPREjCuLoHkG+ncqR
         t/Gnon+P2IwLpHhZAvVkn9VgWUvT5J0iZjaMFyDqD7rP6U6+6fhGrW4OYorYnxNodt25
         /9hhqOr0436MzoZxPZZJ2cC476nJJ6YQd4lpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=cBzM9UoVzRVKD1d9z7jyJ0wgTFaTbgRwKQ+AtCKN22k=;
        b=C4cHTzaPj+11YD+dCVC136XpZp9oYCAze83q04T9s+m4kOiGmbvwDqPlLMmCy/kNJ5
         ALM06D+9kyfIBwi+WmmOOazo7cB4ajOX19yw1v2SgdW/5NJXw1aRagREWtq/bPA1jG6W
         27b3UabiaMt5jH9gknCc0jyDk37L76nnQepJwpr6bpXnc0pEqq4BRd3VDzCL613Xo7g9
         uECohuft3VkNgkAWBUNosq6lsGaKaxyxHZO5+DHe3Qmv9/2kK+FLOFICes6jO2+PxSHP
         K6cd38lppACNTJp9PZdScdqK5I5Qe3rUB26lgdLWEHOlvwE+KPpM5q9HTpEUZsqD6tXr
         fKjg==
X-Gm-Message-State: AJIora/kGyJIJtT9Ck7SeOw7jrLVLoZwSEYdJUDm28tX/lJOGrlu3b3v
        MeO64Vfc5udZmw1krq4iijknD7VlTPflEhvZ
X-Google-Smtp-Source: AGRyM1uGBDFW3OiAAuhsoORBq5TqhsdimD8p9ZE1UBcG11RRiJATOok2C4RsaRWwtJo1aUNq9XJ/lA==
X-Received: by 2002:a05:6808:300f:b0:2fa:6fd5:9723 with SMTP id ay15-20020a056808300f00b002fa6fd59723mr6928147oib.202.1655538651334;
        Sat, 18 Jun 2022 00:50:51 -0700 (PDT)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com. [209.85.210.54])
        by smtp.gmail.com with ESMTPSA id c6-20020a4a4f06000000b0041b83a0d994sm4078273oob.34.2022.06.18.00.50.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jun 2022 00:50:50 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id q1-20020a056830018100b0060c2bfb668eso4665404ota.8
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 00:50:49 -0700 (PDT)
X-Received: by 2002:a9d:7c87:0:b0:60c:1791:609e with SMTP id
 q7-20020a9d7c87000000b0060c1791609emr5575417otn.229.1655538649249; Sat, 18
 Jun 2022 00:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220617235610.321917-1-ribalda@chromium.org> <20220617235610.321917-5-ribalda@chromium.org>
In-Reply-To: <20220617235610.321917-5-ribalda@chromium.org>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Sat, 18 Jun 2022 09:50:38 +0200
X-Gmail-Original-Message-ID: <CANiDSCu0k6m=rZqd1Tw_mc8M48Mda0S-_du0cUmOqYfZ4Sw1cQ@mail.gmail.com>
Message-ID: <CANiDSCu0k6m=rZqd1Tw_mc8M48Mda0S-_du0cUmOqYfZ4Sw1cQ@mail.gmail.com>
Subject: Re: [PATCH v8 4/9] media: uvcvideo: Use standard names for menus
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, senozhatsky@chromium.org, yunkec@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

On Sat, 18 Jun 2022 at 01:56, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Instead of duplicating the menu info, use the one from the core.
> Also, do not use extra memory for 1:1 mappings.
>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 116 +++++++++++++++++++++----------
>  drivers/media/usb/uvc/uvc_v4l2.c |  80 ++++++++++++++++-----
>  drivers/media/usb/uvc/uvcvideo.h |   3 +-
>  include/uapi/linux/uvcvideo.h    |   3 +-
>  4 files changed, 144 insertions(+), 58 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index a03714c3a265..1a3021a16b76 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -362,19 +362,31 @@ static const u32 uvc_control_classes[] = {
>         V4L2_CID_USER_CLASS,
>  };
>
> -static const struct uvc_menu_info power_line_frequency_controls[] = {
> -       { 0, "Disabled" },
> -       { 1, "50 Hz" },
> -       { 2, "60 Hz" },
> -       { 3, "Auto" },
> -};
> +static const int exposure_auto_mapping[] = { 2, 1, 4, 8 };
>
> -static const struct uvc_menu_info exposure_auto_controls[] = {
> -       { 2, "Auto Mode" },
> -       { 1, "Manual Mode" },
> -       { 4, "Shutter Priority Mode" },
> -       { 8, "Aperture Priority Mode" },
> -};
> +static u32 uvc_mapping_get_menu_value(struct uvc_control_mapping *mapping,
> +                                     u32 idx)
> +{
> +       if (!test_bit(idx, &mapping->menu_mask))
> +               return 0;
> +
> +       if (mapping->menu_mapping)
> +               return mapping->menu_mapping[idx];
> +
> +       return idx;
> +}
> +
> +static const char
> +*uvc_mapping_get_menu_name(struct uvc_control_mapping *mapping, u32 idx)
> +{
> +       if (!test_bit(idx, &mapping->menu_mask))
> +               return NULL;
> +
> +       if (mapping->menu_names)
> +               return mapping->menu_names[idx];
> +
> +       return v4l2_ctrl_get_menu(mapping->id)[idx];
> +}
>
>  static s32 uvc_ctrl_get_zoom(struct uvc_control_mapping *mapping,
>         u8 query, const u8 *data)
> @@ -523,9 +535,9 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
>                 .offset         = 0,
>                 .v4l2_type      = V4L2_CTRL_TYPE_MENU,
>                 .data_type      = UVC_CTRL_DATA_TYPE_BITMASK,
> -               .menu_info      = exposure_auto_controls,
> +               .menu_mapping   = exposure_auto_mapping,
>                 .menu_mask      =
> -                       BIT_MASK(ARRAY_SIZE(exposure_auto_controls)),
> +                       GENMASK(ARRAY_SIZE(exposure_auto_mapping) - 1, 0),
>                 .slave_ids      = { V4L2_CID_EXPOSURE_ABSOLUTE, },
>         },
>         {
> @@ -730,9 +742,8 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc11[] = {
>                 .offset         = 0,
>                 .v4l2_type      = V4L2_CTRL_TYPE_MENU,
>                 .data_type      = UVC_CTRL_DATA_TYPE_ENUM,
> -               .menu_info      = power_line_frequency_controls,
>                 .menu_mask      =
> -                       BIT_MASK(ARRAY_SIZE(power_line_frequency_controls) - 1),
> +                       GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_60HZ, 0),
>         },
>  };
>
> @@ -745,9 +756,8 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc15[] = {
>                 .offset         = 0,
>                 .v4l2_type      = V4L2_CTRL_TYPE_MENU,
>                 .data_type      = UVC_CTRL_DATA_TYPE_ENUM,
> -               .menu_info      = power_line_frequency_controls,
>                 .menu_mask      =
> -                       BIT_MASK(ARRAY_SIZE(power_line_frequency_controls)),
> +                       GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_AUTO, 0),
>         },
>  };
>
> @@ -970,13 +980,17 @@ static s32 __uvc_ctrl_get_value(struct uvc_control_mapping *mapping,
>         s32 value = mapping->get(mapping, UVC_GET_CUR, data);
>
>         if (mapping->v4l2_type == V4L2_CTRL_TYPE_MENU) {
> -               const struct uvc_menu_info *menu = mapping->menu_info;
>                 unsigned int i;
>
> -               for (i = 1; BIT(i) <= mapping->menu_mask; ++i, ++menu) {
> +               for (i = 1; BIT(i) <= mapping->menu_mask; ++i) {
> +                       u32 menu_value;
> +
>                         if (!test_bit(i, &mapping->menu_mask))
>                                 continue;
> -                       if (menu->value == value) {
> +
> +                       menu_value = uvc_mapping_get_menu_value(mapping, i);
> +
> +                       if (menu_value == value) {
>                                 value = i;
>                                 break;
>                         }
> @@ -1108,7 +1122,6 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>  {
>         struct uvc_control_mapping *master_map = NULL;
>         struct uvc_control *master_ctrl = NULL;
> -       const struct uvc_menu_info *menu;
>         unsigned int i;
>
>         memset(v4l2_ctrl, 0, sizeof(*v4l2_ctrl));
> @@ -1153,11 +1166,15 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>                 v4l2_ctrl->maximum = fls(mapping->menu_mask) - 1;
>                 v4l2_ctrl->step = 1;
>
> -               menu = mapping->menu_info;
> -               for (i = 1; BIT(i) <= mapping->menu_mask; ++i, ++menu) {
> +               for (i = 1; BIT(i) <= mapping->menu_mask; ++i) {
> +                       u32 menu_value;
> +
>                         if (!test_bit(i, &mapping->menu_mask))
>                                 continue;
> -                       if (menu->value == v4l2_ctrl->default_value) {
> +
> +                       menu_value = uvc_mapping_get_menu_value(mapping, i);
> +
> +                       if (menu_value == v4l2_ctrl->default_value) {
>                                 v4l2_ctrl->default_value = i;
>                                 break;
>                         }
> @@ -1250,11 +1267,11 @@ int uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>  int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
>         struct v4l2_querymenu *query_menu)
>  {
> -       const struct uvc_menu_info *menu_info;
>         struct uvc_control_mapping *mapping;
>         struct uvc_control *ctrl;
>         u32 index = query_menu->index;
>         u32 id = query_menu->id;
> +       const char *name;
>         int ret;
>
>         memset(query_menu, 0, sizeof(*query_menu));
> @@ -1276,11 +1293,10 @@ int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
>                 goto done;
>         }
>
> -       menu_info = &mapping->menu_info[query_menu->index];
> -
>         if (mapping->data_type == UVC_CTRL_DATA_TYPE_BITMASK &&
>             (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES)) {
>                 s32 bitmap;
> +               u32 menu_value;
>
>                 if (!ctrl->cached) {
>                         ret = uvc_ctrl_populate_cache(chain, ctrl);
> @@ -1288,15 +1304,22 @@ int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
>                                 goto done;
>                 }
>
> +               menu_value = uvc_mapping_get_menu_value(mapping,
> +                                                       query_menu->index);
> +
>                 bitmap = mapping->get(mapping, UVC_GET_RES,
>                                       uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
> -               if (!(bitmap & menu_info->value)) {
> +               if (!(bitmap & menu_value)) {
>                         ret = -EINVAL;
>                         goto done;
>                 }
>         }
>
> -       strscpy(query_menu->name, menu_info->name, sizeof(query_menu->name));
> +       name = uvc_mapping_get_menu_name(mapping, query_menu->index);
> +       if (name)
> +               strscpy(query_menu->name, name, sizeof(query_menu->name));
> +       else
> +               ret = -EINVAL;
>
>  done:
>         mutex_unlock(&chain->ctrl_mutex);
> @@ -1783,7 +1806,7 @@ int uvc_ctrl_set(struct uvc_fh *handle,
>                 if (!test_bit(xctrl->value, &mapping->menu_mask))
>                         return -EINVAL;
>
> -               value = mapping->menu_info[xctrl->value].value;
> +               value = uvc_mapping_get_menu_value(mapping, xctrl->value);
>
>                 /* Valid menu indices are reported by the GET_RES request for
>                  * UVC controls that support it.
> @@ -2229,12 +2252,28 @@ static int __uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
>
>         INIT_LIST_HEAD(&map->ev_subs);
>
> -       size = sizeof(*mapping->menu_info) * fls(mapping->menu_mask);
> -       map->menu_info = kmemdup(mapping->menu_info, size, GFP_KERNEL);
> -       if (map->menu_info == NULL) {
> -               kfree(map->name);
> -               kfree(map);
> -               return -ENOMEM;
> +       if (mapping->menu_mapping && mapping->menu_mask) {
> +               size = sizeof(mapping->menu_mapping[0]) *
> +                             fls(mapping->menu_mask);
> +               map->menu_mapping = kmemdup(mapping->menu_mapping, size,
> +                                           GFP_KERNEL);
> +               if (!map->menu_mapping) {
> +                       kfree(map->name);
> +                       kfree(map);
> +                       return -ENOMEM;
> +               }
> +       }
> +       if (mapping->menu_names && mapping->menu_mask) {
> +               size = sizeof(mapping->menu_names[0]) *
> +                             fls(mapping->menu_mask);
> +               map->menu_names = kmemdup(mapping->menu_names, size,
> +                                         GFP_KERNEL);
> +               if (!map->menu_names) {
> +                       kfree(map->menu_mapping);
> +                       kfree(map->name);
> +                       kfree(map);
> +                       return -ENOMEM;
> +               }
>         }
>
>         if (map->get == NULL)
> @@ -2577,7 +2616,8 @@ static void uvc_ctrl_cleanup_mappings(struct uvc_device *dev,
>
>         list_for_each_entry_safe(mapping, nm, &ctrl->info.mappings, list) {
>                 list_del(&mapping->list);
> -               kfree(mapping->menu_info);
> +               kfree(mapping->menu_names);
> +               kfree(mapping->menu_mapping);
>                 kfree(mapping->name);
>                 kfree(mapping);
>         }
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index 85aced173daa..0ba1eb92df8e 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -25,6 +25,64 @@
>
>  #include "uvcvideo.h"
>
> +static int uvc_control_xu_2_mapping(struct uvc_control_mapping *map,
> +                                   struct uvc_xu_control_mapping *xmap)
> +{
> +       char (*names)[UVC_MENU_NAME_LEN];
> +       unsigned int i;
> +       u32 *mapping;
> +       size_t size;
> +
> +       /* Prevent excessive memory consumption, as well as integer
> +        * overflows.
> +        */
> +       if (xmap->menu_count == 0 ||
> +           xmap->menu_count > UVC_MAX_CONTROL_MENU_ENTRIES)
> +               return -EINVAL;
> +
> +       map->menu_mask = BIT_MASK(xmap->menu_count);
> +
> +       size = xmap->menu_count * sizeof(*map->menu_mapping);
> +       mapping = kzalloc(size, GFP_KERNEL);
> +       if (!mapping)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < xmap->menu_count ; i++)
> +               if (copy_from_user(&mapping[i], &xmap->menu_info[i].value,
> +                                  sizeof(mapping[i]))) {
> +                       kfree(mapping);
> +                       return -ENOMEM;
> +               }
> +
> +       map->menu_mapping = mapping;
> +
> +       /*
> +        * Always use the standard naming if available.
> +        */
> +       if (v4l2_ctrl_get_menu(map->id))
> +               return 0;

There is a potential invalid memory access here if we use the standard
naming for custom controls.
let's say that the user says that there are 32 values, but picks a
CTRL_ID that only has 3 values.

Simply removing the previous 2 lines should be enough to take care of that.

I will send a new version once there is more feedback on the series.

[did I said that I hate user defined controls :P, is anyone using it? ]

> +
> +       size = xmap->menu_count * sizeof(map->menu_names[0]);
> +       names = kzalloc(size, GFP_KERNEL);
> +       if (!names) {
> +               kfree(mapping);
> +               return -ENOMEM;
> +       }
> +
> +       for (i = 0; i < xmap->menu_count ; i++) {
> +               /* sizeof(names[i]) - 1: to take care of \0 */
> +               if (copy_from_user(&names[i], &xmap->menu_info[i].name,
> +                                  sizeof(names[i]) - 1)) {
> +                       kfree(names);
> +                       kfree(mapping);
> +                       return -ENOMEM;
> +               }
> +       }
> +       map->menu_names = names;
> +
> +       return 0;
> +}
> +
>  /* ------------------------------------------------------------------------
>   * UVC ioctls
>   */
> @@ -32,7 +90,6 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
>         struct uvc_xu_control_mapping *xmap)
>  {
>         struct uvc_control_mapping *map;
> -       unsigned int size;
>         int ret;
>
>         map = kzalloc(sizeof(*map), GFP_KERNEL);
> @@ -63,23 +120,9 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
>                 break;
>
>         case V4L2_CTRL_TYPE_MENU:
> -               /* Prevent excessive memory consumption, as well as integer
> -                * overflows.
> -                */
> -               if (xmap->menu_count == 0 ||
> -                   xmap->menu_count > UVC_MAX_CONTROL_MENU_ENTRIES) {
> -                       ret = -EINVAL;
> -                       goto free_map;
> -               }
> -
> -               size = xmap->menu_count * sizeof(*map->menu_info);
> -               map->menu_info = memdup_user(xmap->menu_info, size);
> -               if (IS_ERR(map->menu_info)) {
> -                       ret = PTR_ERR(map->menu_info);
> +               ret = uvc_control_xu_2_mapping(map, xmap);
> +               if (ret)
>                         goto free_map;
> -               }
> -
> -               map->menu_mask = BIT_MASK(xmap->menu_count);
>                 break;
>
>         default:
> @@ -91,7 +134,8 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
>
>         ret = uvc_ctrl_add_mapping(chain, map);
>
> -       kfree(map->menu_info);
> +       kfree(map->menu_names);
> +       kfree(map->menu_mapping);
>  free_map:
>         kfree(map);
>
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index 0736b8815d79..b702f1c8547b 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -253,7 +253,8 @@ struct uvc_control_mapping {
>         enum v4l2_ctrl_type v4l2_type;
>         u32 data_type;
>
> -       const struct uvc_menu_info *menu_info;
> +       const u32 *menu_mapping;
> +       const char (*menu_names)[UVC_MENU_NAME_LEN];
>         unsigned long menu_mask;
>
>         u32 master_id;
> diff --git a/include/uapi/linux/uvcvideo.h b/include/uapi/linux/uvcvideo.h
> index 8288137387c0..1b64b6aa40b5 100644
> --- a/include/uapi/linux/uvcvideo.h
> +++ b/include/uapi/linux/uvcvideo.h
> @@ -36,9 +36,10 @@
>          UVC_CTRL_FLAG_GET_MAX | UVC_CTRL_FLAG_GET_RES | \
>          UVC_CTRL_FLAG_GET_DEF)
>
> +#define UVC_MENU_NAME_LEN 32
>  struct uvc_menu_info {
>         __u32 value;
> -       __u8 name[32];
> +       __u8 name[UVC_MENU_NAME_LEN];
>  };
>
>  struct uvc_xu_control_mapping {
> --
> 2.37.0.rc0.104.g0611611a94-goog
>


-- 
Ricardo Ribalda
