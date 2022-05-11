Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B161523A37
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344662AbiEKQXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244060AbiEKQXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:23:39 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D88E60BA1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:23:38 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id m20so5078812ejj.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=POdbBUuLUOeD8dnJi9C2So78rhobliTsIgeT1Jg08bk=;
        b=gbgLI2yp/3VCBc7DlaQPxNdeiz65WMkVuJXn1mPLH0mQQ1ZRV2z74XHm/flUlawuiI
         Vf1/8rHCM/p0dFcR/CxKOJPqxWMPYXUtZYqUZvVeTRrYUur/kAi0pk3APCvJZuSE1dIh
         mF5e4Xcl+DYTO6tg7veoz5qFwfthauZyE+Kn2wDQIcxkHbLInY8Qg2vj3/7AEfRF84Df
         S6FZXxkasSWS0s47QTiqqjptEEojp7c9ACoJP1KD7xp0QfvNQJTgbpMtFEjyU2/oQykk
         9h1BNdmfXmpA2f/Z8q6G2hgoloXuy5lrshBqAgxpQBu/NeRfVzyf6Zy3v6IkntTsFzcL
         5DSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=POdbBUuLUOeD8dnJi9C2So78rhobliTsIgeT1Jg08bk=;
        b=cA+SR1iWvzTNcOZ2TN0R3clnC2N2xUqtF3e759tbGW6TE4IH7TgQXCdB3tMZjYXHcY
         koPj25Hm9V92im3NULzcWoBH1Eu7Ys9fQWRgfj1ZpBXEZIw6wnduRUXowfQy0RYpkjQT
         aMOtl5XyxMMXs9GE6jfJBvfVBoLSqT7ab0oZf+8LMb1AVT1fQFe8WjzgW2HuvmW2v2bo
         XpI6RItRIKRT5+oqWllkhPuXiSoP8GIjVFqj3vVdTylp5obPNe7ZqMxVqHHIYlOOIO0z
         /vX05wrRTPByjVWjFvafWDWoSPMpPK7BH9gkgJba4c0+r2tX7GXJgz28CBmaHuBiQ5fZ
         eISQ==
X-Gm-Message-State: AOAM530NggV6U8AY/dYFhGD6hSTd0p0wYjL3/dFDxkit2MNmJgTw2H60
        Xk8rONjiwhSwFf/mEBc9Q4e+0lYzLGcvSnkRrF+PRg==
X-Google-Smtp-Source: ABdhPJxVpcJI5J1XjN8yl3eLnyQ1rHrvKD4tRUFk0C2I3SD6mc/x46SCPzGa2lPgn91Y3rMniYGyUgadmrlhuQUO0HQ=
X-Received: by 2002:a17:907:9711:b0:6f4:6989:6afb with SMTP id
 jg17-20020a170907971100b006f469896afbmr26603981ejc.618.1652286216547; Wed, 11
 May 2022 09:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <YnoJ0k6eIUiwjXSZ@debian-BULLSEYE-live-builder-AMD64>
 <CAHp75Vd574LCnEq-KX=WHnnDyrjZgGu6W9wNEbnw79FBpyx=Lw@mail.gmail.com> <8bd83f45-5278-e817-3f65-88fafd0ad3f4@collabora.com>
In-Reply-To: <8bd83f45-5278-e817-3f65-88fafd0ad3f4@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 11 May 2022 09:23:24 -0700
Message-ID: <CABXOdTe1N7iRTVrCZSgQo=dazofWByM_W6EZgWixLj=Z8Xg0ag@mail.gmail.com>
Subject: Re: [PATCH RESEND v11] platform/chrome: Add ChromeOS ACPI device driver
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>, vbendeb@chromium.org,
        Andy Shevchenko <andy@infradead.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?Q?Bla=C5=BE_Hrastnik?= <blaz@mxxn.io>,
        Darren Hart <dvhart@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeremy Soller <jeremy@system76.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 8:59 AM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> Hi Andy,
>
> Thank you for reviewing.
>
> On 5/10/22 2:33 PM, Andy Shevchenko wrote:
> > On Tue, May 10, 2022 at 8:44 AM Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >>
> >> From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >>
> >> The x86 Chromebooks have the ChromeOS ACPI device. This driver attaches
> >> to the ChromeOS ACPI device and exports the values reported by ACPI in a
> >> sysfs directory. This data isn't present in ACPI tables when read
> >> through ACPI tools, hence a driver is needed to do it. The driver gets
> >> data from firmware using the ACPI component of the kernel. The ACPI values
> >> are presented in string form (numbers as decimal values) or binary
> >> blobs, and can be accessed as the contents of the appropriate read only
> >> files in the standard ACPI device's sysfs directory tree. This data is
> >> consumed by the ChromeOS user space.
> >
> >> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >> Cc: Hans de Goede <hdegoede@redhat.com>
> >
> > You can use --cc parameter to `git send-email` instead of putting
> > these lines in the commit message.
> >
> > ...
> >
> >> +#define DEV_ATTR(_var, _name)                                  \
> >> +       static struct device_attribute dev_attr_##_var =        \
> >> +               __ATTR(_name, 0444, chromeos_first_level_attr_show, NULL);
> >> +
> >
> > Why not ATTR_RO()?
> It'll not work as attribute name has . in it.
>
> >
> > ...
> >
> >> +#define GPIO_ATTR_GROUP(_group, _name, _num)                                           \
> >> +       static umode_t attr_is_visible_gpio_##_num(struct kobject *kobj,                \
> >> +                                                  struct attribute *attr, int n)       \
> >> +       {                                                                               \
> >> +               if (_num < chromeos_acpi_gpio_groups)                                   \
> >> +                       return attr->mode;                                              \
> >
> >> +               else                                                                    \
> >
> > Redundant.
> We are deciding on run time that how many GPIO attribute groups need to
> be shown. chromeos_acpi_gpio_groups is set at run time. I don't see why
> `else` can be redundant here.
>

else after return is _always_ unnecessary (and results in static
analyzer messages).

> >
> >> +                       return 0;                                                       \
> >> +       }                                                                               \
> >> +       static ssize_t chromeos_attr_show_gpio_##_num(struct device *dev,               \
> >> +                                                     struct device_attribute *attr,    \
> >> +                                                     char *buf)                        \
> >> +       {                                                                               \
> >> +               char name[ACPI_ATTR_NAME_LEN + 1];                                      \
> >> +               int ret, num;                                                           \
> >> +                                                                                       \
> >> +               ret = parse_attr_name(attr->attr.name, name, &num);                     \
> >> +               if (ret)                                                                \
> >> +                       return ret;                                                     \
> >
> >> +               ret = chromeos_acpi_evaluate_method(dev, _num, num, name, buf);         \
> >> +               if (ret < 0)                                                            \
> >> +                       ret = 0;                                                        \
> >
> > Below I saw the same code, why is the error ignored?
> >
> I'll return the error in both places.
>
> >> +               return ret;                                                             \
> >> +       }                                                                               \
> >> +       static struct device_attribute dev_attr_0_##_group =                            \
> >> +               __ATTR(GPIO.0, 0444, chromeos_attr_show_gpio_##_num, NULL);             \
> >> +       static struct device_attribute dev_attr_1_##_group =                            \
> >> +               __ATTR(GPIO.1, 0444, chromeos_attr_show_gpio_##_num, NULL);             \
> >> +       static struct device_attribute dev_attr_2_##_group =                            \
> >> +               __ATTR(GPIO.2, 0444, chromeos_attr_show_gpio_##_num, NULL);             \
> >> +       static struct device_attribute dev_attr_3_##_group =                            \
> >> +               __ATTR(GPIO.3, 0444, chromeos_attr_show_gpio_##_num, NULL);             \
> >> +                                                                                       \
> >> +       static struct attribute *attrs_##_group[] = {                                   \
> >> +               &dev_attr_0_##_group.attr,                                              \
> >> +               &dev_attr_1_##_group.attr,                                              \
> >> +               &dev_attr_2_##_group.attr,                                              \
> >> +               &dev_attr_3_##_group.attr,                                              \
> >> +               NULL                                                                    \
> >> +       };                                                                              \
> >> +       static const struct attribute_group attr_group_##_group = {                     \
> >> +               .name = _name,                                                          \
> >> +               .is_visible = attr_is_visible_gpio_##_num,                              \
> >
> >> +               .attrs = attrs_##_group                                                 \
> >
> > Keep a comma here.
> Is there any particular reason for it? If there is, I'll add commas to
> all the structures.
> ...
> >
> > ...
> >
> >> +static int parse_attr_name(const char *name, char *attr_name, int *attr_num)
> >> +{
> >> +       int ret = 0;
> >> +
> >> +       strscpy(attr_name, name, ACPI_ATTR_NAME_LEN + 1);
> >> +
> >> +       if (strlen(name) > ACPI_ATTR_NAME_LEN)
> >
> > This seems strange, esp. taking into account that strscpy() returns that.
> >
> > int ret;
> >
> > ret = strscpy(...);
> > if (ret == -E2BIG)
> >   return kstrtoint(...);
> >
> > return 0;
> This is very nice way to do it. I'll update.
> ...
>
> --
> Muhammad Usama Anjum
