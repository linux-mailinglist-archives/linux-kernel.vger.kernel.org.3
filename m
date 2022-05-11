Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44841523A5D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344774AbiEKQay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344759AbiEKQau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:30:50 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869F16242;
        Wed, 11 May 2022 09:30:46 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 6A2651F43201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652286615;
        bh=McJOd1OtcooV/2GyTlhAmO/oG/dgXkbBGxYysmipYdk=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=VzCtVwdQlqPakSLJ6UCDMWheZMYOIyk+aHp5prPY5f2IR/g2qQeolRqAShBqjyVwC
         mIdleiFJViLVz0xD9K0oZ/6AFzVyJ2+meMAX6iNMj1+Mk2+c1V3HdwHCLHqjGzaERA
         DJdI53Z2A9U2w+mxEKUa45Ge1RwTDk4fq2iwJdNxGLpjd6qHdQ0eEK/bo7KDlr9YDy
         hKgS3leqKfT5sRj/D3AML6U5N8j52eL0ZZ4NhxVqe5anKMELARxa5iESwkoAT5P6bV
         a6NQZIItNU8tY60jaZcImHIvT9ZtZkNKIehK7hMiMlwu6bg0/Sv2+2dAWiHxv2Pkyc
         DEQC6VYsFEzHw==
Message-ID: <4bcd4fd7-ff81-b480-6ad6-ae027e268c7e@collabora.com>
Date:   Wed, 11 May 2022 21:29:46 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Cc:     usama.anjum@collabora.com, "Rafael J. Wysocki" <rafael@kernel.org>,
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
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
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
Subject: Re: [PATCH RESEND v11] platform/chrome: Add ChromeOS ACPI device
 driver
Content-Language: en-US
To:     Guenter Roeck <groeck@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <YnoJ0k6eIUiwjXSZ@debian-BULLSEYE-live-builder-AMD64>
 <CAHp75Vd574LCnEq-KX=WHnnDyrjZgGu6W9wNEbnw79FBpyx=Lw@mail.gmail.com>
 <8bd83f45-5278-e817-3f65-88fafd0ad3f4@collabora.com>
 <CABXOdTe1N7iRTVrCZSgQo=dazofWByM_W6EZgWixLj=Z8Xg0ag@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABXOdTe1N7iRTVrCZSgQo=dazofWByM_W6EZgWixLj=Z8Xg0ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/22 9:23 PM, Guenter Roeck wrote:
> On Wed, May 11, 2022 at 8:59 AM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>>> +#define GPIO_ATTR_GROUP(_group, _name, _num)                                           \
>>>> +       static umode_t attr_is_visible_gpio_##_num(struct kobject *kobj,                \
>>>> +                                                  struct attribute *attr, int n)       \
>>>> +       {                                                                               \
>>>> +               if (_num < chromeos_acpi_gpio_groups)                                   \
>>>> +                       return attr->mode;                                              \
>>>
>>>> +               else                                                                    \
>>>
>>> Redundant.
>> We are deciding on run time that how many GPIO attribute groups need to
>> be shown. chromeos_acpi_gpio_groups is set at run time. I don't see why
>> `else` can be redundant here.
>>
> 
> else after return is _always_ unnecessary (and results in static
> analyzer messages).
> 
Got it. I'll update. Thank you.

-- 
Muhammad Usama Anjum
