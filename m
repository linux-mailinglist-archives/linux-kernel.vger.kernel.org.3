Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B474C546778
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 15:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbiFJNkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 09:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiFJNkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:40:37 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF2D3A71F;
        Fri, 10 Jun 2022 06:40:35 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-30c143c41e5so272569497b3.3;
        Fri, 10 Jun 2022 06:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uBdKtGW7fZxQ5+SFCWAo4vdz+hLcnONQN5dsbtogcvQ=;
        b=EQDv10Q6xw+t2P4ruF4bxC1Uc+Tuwu75xeYNfsEf1JpfGugYU3q0xT9PnB++Vd9R1W
         CT0XQYMZGfbyfn6c2yz6EH2aJjey8cqX39EWeRPTQYukDJs06q9TyqcSI8jDsO2bwTG8
         3zQYvDfRuAFpOqKoCJUPrW8QsKaInDww0xFe+Rt42c7g67wcaXGSl153ed+udoHoo1I+
         ab4qPgV1L1p+DC3e3NQXpityh16Pmp9TwCUT1DMICHrXRDF3CuWkbwTJ6efyWhAlpC/7
         1n87jcseJYHoApnAbQ04afL8m2z/ZbQiPmJ/pDCMiJAcK6Zsoo/mOVmpcWitdD6WDqK4
         MaNg==
X-Gm-Message-State: AOAM530ZzpwS0w9hfst28oiFthTtnn/n2sReVHbMAsa8kVmZU/cHeUee
        AEJTgFS/Rl6Flv5XR3Rnux1zo0yUhj4NvoU7ONE=
X-Google-Smtp-Source: ABdhPJx9RtNllu+NXEiCLNeoJWKFqffkqoy+hzByxzxKYvlx2QwooTOEmnPA588AgZzx8m+n2clldb+8qAjVgl/ZBEY=
X-Received: by 2002:a81:260a:0:b0:2f4:ca82:a42f with SMTP id
 m10-20020a81260a000000b002f4ca82a42fmr48706250ywm.149.1654868434983; Fri, 10
 Jun 2022 06:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220610120219.18988-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220610120219.18988-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 10 Jun 2022 15:40:23 +0200
Message-ID: <CAJZ5v0g3pHDNkVu6YqANO7yM4s_CPih0nBXcgz3OBmrRSjLh2A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] driver core: Introduce device_find_any_child() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
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

On Fri, Jun 10, 2022 at 2:02 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> There are several places in the kernel where this kind of functionality is
> being used. Provide a generic helper for such cases.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: renamed method (Greg), refactored it (Rafael)
>  drivers/base/core.c    | 20 ++++++++++++++++++++
>  include/linux/device.h |  2 ++
>  2 files changed, 22 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 7cd789c4985d..a519307fda60 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3832,6 +3832,26 @@ struct device *device_find_child_by_name(struct device *parent,
>  }
>  EXPORT_SYMBOL_GPL(device_find_child_by_name);
>
> +static int match_any(struct device *dev, void *unused)
> +{
> +       return 1;
> +}
> +
> +/**
> + * device_find_any_child - device iterator for locating a child device, if any.
> + * @parent: parent struct device
> + *
> + * This is similar to the device_find_child() function above, but it
> + * returns a reference to a child device, if any.
> + *
> + * NOTE: you will need to drop the reference with put_device() after use.
> + */
> +struct device *device_find_any_child(struct device *parent)
> +{
> +       return device_find_child(parent, NULL, match_any);
> +}
> +EXPORT_SYMBOL_GPL(device_find_any_child);

I would call it device_get_any_child() to indicate the reference
counting, but that's a very minor nit.

Regardless of the above

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> +
>  int __init devices_init(void)
>  {
>         devices_kset = kset_create_and_add("devices", &device_uevent_ops, NULL);
> diff --git a/include/linux/device.h b/include/linux/device.h
> index dc941997795c..424b55df0272 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -905,6 +905,8 @@ struct device *device_find_child(struct device *dev, void *data,
>                                  int (*match)(struct device *dev, void *data));
>  struct device *device_find_child_by_name(struct device *parent,
>                                          const char *name);
> +struct device *device_find_any_child(struct device *parent);
> +
>  int device_rename(struct device *dev, const char *new_name);
>  int device_move(struct device *dev, struct device *new_parent,
>                 enum dpm_order dpm_order);
> --
> 2.35.1
>
