Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED30523BC2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345722AbiEKRl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345733AbiEKRlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:41:14 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E827E219F69;
        Wed, 11 May 2022 10:41:09 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id p18so3426277edr.7;
        Wed, 11 May 2022 10:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Ke+AGfzv6tvoEFSxFKuURhI7WvGdekzVHjZqAbbO8s=;
        b=G9wqQwuFFHa1lknmirIg8grgSmlGhY4vOMeTI7ajMbQFOkPDfAjxkC53pYWGPJ2cZF
         JYFgcz/9NdUz5O/wqsbhfPi2zN/aY/XE8j2tiIE+GNsGbyuPFnW8P1tp2iJW3pJ7hdxQ
         0IWMmg6WoVXdfvmSzYuR0vhQNDCC0PHJKULu799/jK8hUupfLZ4wSeZ7OW6yle+knuIx
         wKXck2gICgiHyMkOEoopjNhzgzuCsUiXl0Fc8RjVEZqu59KvypFwP3AWHlhIyW+2eUvJ
         9/csBr94Q6HkyJhoRRrkcPuuXe8cn9wJZuWneLmHD2vUIG70ZoAZdfhxmnMfAxo/8/s1
         RtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Ke+AGfzv6tvoEFSxFKuURhI7WvGdekzVHjZqAbbO8s=;
        b=IyTEu0BCJo1oB/cUJnUAJCpi9etJdWOi4APkhpkhnU3OK4KyJvQw2Sbnthwgb7Kxu1
         UKcGilb7cwwvXQo510/KQU4oxvdmispBYROdmkre/SAUi3kWcfnVzHZNDVsx9jZ6qW6A
         XtbkR1ReBjaHUJEssFgr2CaAsbCF4eQCrYlHRIhuDXjMV2ieCMxOiVhDeWeo3CCExoLV
         3mNFTUP4FdL/nD0Ux8TQXNYC+y3JFOvCI8tJZTFpUk956cYjQVPlvDNuNC3DquaSCo+L
         m2IMd6Ovc74Evo611BIhymOWbwjpiRDLSWzd4wDwywGCgK6oToRl24HAOKpgtVRzqzhP
         ZEnA==
X-Gm-Message-State: AOAM533bLk4qWjQvGFDPtfc/i5dIJE2ibDasrobjBAftnPcZbBzuO9TQ
        HHeUQgZvcfSS74UGlrwTBImL5b8PiyHNmllKooQ=
X-Google-Smtp-Source: ABdhPJypHOUVtZ/mWQM6O1I1uprLxF37dkIpuFfu2UGbONcylK6L0+EILGXJ8zFdWrxtLQMY1Q94ZDxv7qrd1l5g0T4=
X-Received: by 2002:a05:6402:1d4c:b0:427:d1f5:3a41 with SMTP id
 dz12-20020a0564021d4c00b00427d1f53a41mr29873435edb.218.1652290868261; Wed, 11
 May 2022 10:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <YnoJ0k6eIUiwjXSZ@debian-BULLSEYE-live-builder-AMD64>
 <CAHp75Vd574LCnEq-KX=WHnnDyrjZgGu6W9wNEbnw79FBpyx=Lw@mail.gmail.com> <8bd83f45-5278-e817-3f65-88fafd0ad3f4@collabora.com>
In-Reply-To: <8bd83f45-5278-e817-3f65-88fafd0ad3f4@collabora.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 11 May 2022 19:40:31 +0200
Message-ID: <CAHp75VcQYncfCv-2GE0a0e=0iOLBC6wMvoH8pFCirN3NyLzdhw@mail.gmail.com>
Subject: Re: [PATCH RESEND v11] platform/chrome: Add ChromeOS ACPI device driver
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 5:59 PM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
> On 5/10/22 2:33 PM, Andy Shevchenko wrote:
> > On Tue, May 10, 2022 at 8:44 AM Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:

...

> >> +       static struct attribute *attrs_##_group[] = {                                   \
> >> +               &dev_attr_0_##_group.attr,                                              \
> >> +               &dev_attr_1_##_group.attr,                                              \
> >> +               &dev_attr_2_##_group.attr,                                              \
> >> +               &dev_attr_3_##_group.attr,                                              \
> >> +               NULL                                                                    \

(1)

> >> +       };                                                                              \
> >> +       static const struct attribute_group attr_group_##_group = {                     \
> >> +               .name = _name,                                                          \
> >> +               .is_visible = attr_is_visible_gpio_##_num,                              \
> >
> >> +               .attrs = attrs_##_group                                                 \
> >
> > Keep a comma here.

> Is there any particular reason for it?

Yes, if it's not a terminator entry, like (1), the comma would help to
avoid unneeded churm in the future in case someone wants to add
another initialization member.

> If there is, I'll add commas to
> all the structures.

It depends if it is a terminator entry or not, so please check
carefully where to add and where not (the latter example is (1) where
comma is not needed and theoretically might add a confusion).

-- 
With Best Regards,
Andy Shevchenko
