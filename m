Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2095A182D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 19:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242885AbiHYRzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 13:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbiHYRz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 13:55:28 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95BEA1D2D;
        Thu, 25 Aug 2022 10:55:27 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-3376851fe13so528500397b3.6;
        Thu, 25 Aug 2022 10:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=JuYAb54FA4P2yLGLZeyXrMW7j/lrP0AgN+iorFj+61Q=;
        b=AM/HNHMNcSOVpr63bwc79Hs4q/G2CrO3MtqNM7TPogCt3c3GIolj1wO+JvW2GB1gTE
         uos9/LRo8h98au90TWuVwkRhDQ5yjCn6IuyJZnDSilzdYlP2DGp3K1FAQbP6a2lg9kSY
         9W7n7NOGnKAyH1Kn99YnzVvuruLgYGrnxL2NzY76EGLCjHk31lyCsWJDuKWLYkq6ZaNO
         4WkcYCQEHA2Jq/C+Gn79fhPyfIWafqd+k0uTZiUCdq+g/xNIPqCA3mczg76e+CAiNcBX
         TwSieVzcYK+/9uOrX1TbE461xeU462vq06EmZEOZk962LVl+WyRnsShq4R48VhsZZj7c
         Dbbg==
X-Gm-Message-State: ACgBeo11TmeeL9XH9+AtI1PGYreAxHbJYIzVCAIFIsWeNmzK2UU+wNx3
        KtGQ8BPpniRIm9r+PlZi5dmFEqJ4At3SwJnDEZw=
X-Google-Smtp-Source: AA6agR4f6szUO1v4FcOW9D1xe1744DXP1mD+jUX8OQySh7WrxslfFrVCtHSS7d8qdF6spgxK6WnwpFUFMhSvZoQZNDE=
X-Received: by 2002:a0d:e701:0:b0:336:90d7:c67a with SMTP id
 q1-20020a0de701000000b0033690d7c67amr4921528ywe.7.1661450126920; Thu, 25 Aug
 2022 10:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220825173457.23298-1-vimal.kumar32@gmail.com>
In-Reply-To: <20220825173457.23298-1-vimal.kumar32@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Aug 2022 19:55:15 +0200
Message-ID: <CAJZ5v0j_0VAG9tP2+D-vqnG962JZRWnOPXO9z2ZrCbgkHmBG=g@mail.gmail.com>
Subject: Re: [PATCH v2] PM: runtime: Add support to disable wakeup sources
To:     Vimal Kumar <vimal.kumar32@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        chinmoyghosh2001@gmail.com, Mintu Patel <mintupatel89@gmail.com>,
        Vishal Badole <badolevishal1116@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 7:35 PM Vimal Kumar <vimal.kumar32@gmail.com> wrote:
>
> User could find many wakeup sources available in the bsp, which
> they won't be using. Currently users can only get the status and
> list of enabled wakeup sources, but users can't disable it runtime.

What about using the wakeup attribute for devices in sysfs?  That
effectively disables/enables a wakeup source.

> It's very difficult to find the driver for each wakeup sources from
> where it's getting enabled and make the changes for disabling it.

Why do you need to enable/disable them individually, though?

> This will help users to disable any wakeup sources at runtime,
> avoiding any code change and re-compilation. A new class attribute
> "disable_ws" will be added in the wakeup calss. If user want to disable
> any wakeup sources, user need to find the wakeup dev node associated
> with the particular wakeup source and write the devnode name to the
> class attribute "disable_ws".
>
> Example:
> Need to disable the wakeup source '1c08000.qcom,pcie'. The dev node
> associated with this wakeup source is:
> cat /sys/class/wakeup3/name ==> "1c08000.qcom,pcie", then for disabling
> this wakeup source :
>         echo wakeup3 > /sys/class/wakeup/disable_ws

Wouldn't it be more straightforward to add a "disable" attribute for
wakeup sources?

> Co-developed-by: Mintu Patel <mintupatel89@gmail.com>
> Signed-off-by: Mintu Patel <mintupatel89@gmail.com>
> Co-developed-by: Vishal Badole <badolevishal1116@gmail.com>
> Signed-off-by: Vishal Badole <badolevishal1116@gmail.com>
> Signed-off-by: Vimal Kumar <vimal.kumar32@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-class-wakeup | 16 +++++
>  drivers/base/power/wakeup_stats.c            | 65 +++++++++++++++++++-
>  2 files changed, 80 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-class-wakeup b/Documentation/ABI/testing/sysfs-class-wakeup
> index 754aab8b6dcd..75b9a6fe737a 100644
> --- a/Documentation/ABI/testing/sysfs-class-wakeup
> +++ b/Documentation/ABI/testing/sysfs-class-wakeup
> @@ -74,3 +74,19 @@ Contact:     Tri Vo <trong@android.com>
>  Description:
>                 The file contains the total amount of time this wakeup source
>                 has been preventing autosleep, in milliseconds.
> +
> +What:          /sys/class/wakeup/disable_ws
> +Date:          Aug 2022
> +Contact:       Vimal Kumar <vimal.kumar@gmail.com>
> +Description:
> +               This file can be used to disable a wakeup source at runtime.
> +               If user want to disable any wakeup sources, user need to find
> +               the wakeup dev node associated with the particular wakeup source
> +               and write the devnode name to this file "disable_ws".
> +
> +               Example:
> +               If user Need to disable the wakeup source '1c08000.qcom,pcie', and
> +               the wakeup dev node associated with this wakeup source is:
> +                       cat /sys/class/wakeup3/name ==> "1c08000.qcom,pcie"
> +               Then for disabling this wakeup source :
> +                       echo wakeup3 > /sys/class/wakeup/disable_ws
> diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeup_stats.c
> index 924fac493c4f..497402a28028 100644
> --- a/drivers/base/power/wakeup_stats.c
> +++ b/drivers/base/power/wakeup_stats.c
> @@ -15,6 +15,7 @@
>  #include <linux/kobject.h>
>  #include <linux/slab.h>
>  #include <linux/timekeeping.h>
> +#include <linux/uaccess.h>
>
>  #include "power.h"
>
> @@ -208,9 +209,71 @@ void wakeup_source_sysfs_remove(struct wakeup_source *ws)
>         device_unregister(ws->dev);
>  }
>
> +static ssize_t disable_ws_store(struct class *class,
> +                               struct class_attribute *attr,
> +                               const char *buf, size_t len)
> +{
> +       struct device           *dev;
> +       struct wakeup_source    *ws;
> +       char                    *ws_name;
> +       int                     status;
> +
> +       ws_name = kzalloc(len+1, GFP_KERNEL);
> +       if (!ws_name)
> +               return -ENOMEM;
> +
> +       if (sscanf(buf, "%s", ws_name) != 1)
> +               return -EFAULT;
> +
> +       dev = class_find_device_by_name(wakeup_class, ws_name);
> +       if (!dev) {
> +               pr_err("%s : wakeup device not found\n", __func__);
> +               return -EINVAL;
> +       }
> +
> +       ws = dev_get_drvdata(dev);
> +       if (ws->dev->parent != NULL) {
> +
> +               status = device_wakeup_disable(ws->dev->parent);
> +               if (status < 0) {
> +                       /* In case of virtual device, return code will be -EINVAL
> +                        * then unregister the wakeup source associated with it
> +                        */
> +                       wakeup_source_unregister(ws);
> +               }
> +       } else
> +               /* If the parent device is NULL, just unregister the wakeup source */
> +               wakeup_source_unregister(ws);
> +
> +       return len;
> +}
> +
> +static CLASS_ATTR_WO(disable_ws);
> +
> +static struct attribute *wakeup_class_attrs[] = {
> +       &class_attr_disable_ws.attr,
> +       NULL,
> +};
> +ATTRIBUTE_GROUPS(wakeup_class);
> +
>  static int __init wakeup_sources_sysfs_init(void)
>  {
> -       wakeup_class = class_create(THIS_MODULE, "wakeup");
> +       int status;
> +
> +       wakeup_class = kzalloc(sizeof(*wakeup_class), GFP_KERNEL);
> +       if (!wakeup_class)
> +               return -ENOMEM;
> +
> +       wakeup_class->name = "wakeup";
> +       wakeup_class->owner = THIS_MODULE;
> +       wakeup_class->class_groups = wakeup_class_groups;
> +
> +       status = class_register(wakeup_class);
> +
> +       if (status < 0) {
> +               pr_err("%s: class register failed %d\n", __func__, status);
> +               return status;
> +       }
>
>         return PTR_ERR_OR_ZERO(wakeup_class);
>  }
> --
> 2.25.1
>
