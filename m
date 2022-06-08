Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96009542F39
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 13:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238028AbiFHL3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 07:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237509AbiFHL3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 07:29:21 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06D710C4;
        Wed,  8 Jun 2022 04:29:19 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id x187so8444610ybe.2;
        Wed, 08 Jun 2022 04:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=khxDhYmptRAC+y0a9Wcnwwwf5gnGcTmkn51GhIp4NXc=;
        b=grT7MTE9Xn226wFtEUtiwGmDUlvnPcwXooWQx9Bu+pNHGY1o3prfB2MjGB2hjkW+lH
         b2QbKLm3JxK3A56kUVDmnklRRwvM7lJstJ+CK4XWdBf40RAuDpXAJYi3D9C59qrcLU79
         oj9yZO1gvtHB+BgvE1sTuVJOAsPuHUC9Ghbt8UG8W0kQX2WRpiLbq1TVBKgzvNJrlzR7
         dcmvvsKBszB0JkpSMu0ZMz3vyTBL/GEaVy66IdMZdgHMtjrREIp7xu3A3RYbR5nlMNsO
         K8mBLAQsi+JAd6vZkIOAJNvE1ywfHbYEtPhLomtPJ8lkPzjF56TTl4DBhXbhQnE1iU9a
         DXew==
X-Gm-Message-State: AOAM531WJrw3FDjPNSf3PbGqKcdt7YM/z7uPLTWhOgD1IPg9YGdmPLTH
        BukHws0oYrk/K67xT5dJAPjhvhvXbh62ytH25gI=
X-Google-Smtp-Source: ABdhPJxUyc/DPp0XJmpN+8OkcRJjPOCLfwbcLthNlex6kq0Op0UK0a0LyJWOiBz45YeIZxeOWUF+l2f4fzTkM0MCAk0=
X-Received: by 2002:a25:84ca:0:b0:65c:b5a4:3d0a with SMTP id
 x10-20020a2584ca000000b0065cb5a43d0amr34167073ybm.137.1654687758965; Wed, 08
 Jun 2022 04:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220607202058.8304-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220607202058.8304-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 8 Jun 2022 13:29:08 +0200
Message-ID: <CAJZ5v0gmO-BDyurQtG4sU5KLfe2mjs7vm5kpJQoAaxYxF57t3g@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] driver core: Introduce device_find_first_child() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 7, 2022 at 10:22 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> There are several places in the kernel where this kind of functionality is
> being used. Provide a generic helper for such cases.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/core.c    | 24 ++++++++++++++++++++++++
>  include/linux/device.h |  1 +
>  2 files changed, 25 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 7cd789c4985d..972bfe975cd0 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3832,6 +3832,30 @@ struct device *device_find_child_by_name(struct device *parent,
>  }
>  EXPORT_SYMBOL_GPL(device_find_child_by_name);
>
> +/**
> + * device_find_first_child - device iterator for locating the fist child device.
> + * @parent: parent struct device
> + *
> + * This is similar to the device_find_child() function above, but it
> + * returns a reference to the first child device.
> + *
> + * NOTE: you will need to drop the reference with put_device() after use.
> + */
> +struct device *device_find_first_child(struct device *parent)
> +{
> +       struct klist_iter i;
> +       struct device *child;
> +
> +       if (!parent)
> +               return NULL;
> +
> +       klist_iter_init(&parent->p->klist_children, &i);
> +       child = get_device(next_device(&i));
> +       klist_iter_exit(&i);
> +       return child;
> +}
> +EXPORT_SYMBOL_GPL(device_find_first_child);

I would define it as

static int match_first(struct device *dev, void *)
{
       return 1;
}

struct device *device_find_first_child(struct device *parent)
{
        return device_find_first_child(parent, NULL, match_first);
}
EXPORT_SYMBOL_GPL(device_find_first_child);

which is not that much more overhead.

> +
>  int __init devices_init(void)
>  {
>         devices_kset = kset_create_and_add("devices", &device_uevent_ops, NULL);
> diff --git a/include/linux/device.h b/include/linux/device.h
> index dc941997795c..20171a4358df 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -905,6 +905,7 @@ struct device *device_find_child(struct device *dev, void *data,
>                                  int (*match)(struct device *dev, void *data));
>  struct device *device_find_child_by_name(struct device *parent,
>                                          const char *name);
> +struct device *device_find_first_child(struct device *parent);
>  int device_rename(struct device *dev, const char *new_name);
>  int device_move(struct device *dev, struct device *new_parent,
>                 enum dpm_order dpm_order);
> --
> 2.35.1
>
