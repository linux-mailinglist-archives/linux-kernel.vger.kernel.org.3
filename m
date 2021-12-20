Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD1647B635
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 00:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbhLTXhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 18:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhLTXhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 18:37:10 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FB9C061574;
        Mon, 20 Dec 2021 15:37:10 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id b186-20020a1c1bc3000000b00345734afe78so987125wmb.0;
        Mon, 20 Dec 2021 15:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hraqWg5PWkO6+tfHwaIKUlh6JY2C21320PM73mzNHOw=;
        b=k6LLolZNh4iIZvLxOIVtmw8feJjFRGfDrb9lzRw91dR0j2XCGLcs1+L0pCRbMJgPKl
         tF1sxgKZ7GI/cMfh1SPnwkyIY/23Zxo3kRTI0BHNzKGkb/+QxaiMJiJ7tiq5P2AgZM5H
         FB6ffWA4uz3Cm+iWQ1/VXFsOdmJgQY66vrym5FXRZU9oGoAJ86tT5WSpCCC4iJWmWgQL
         Kh9HF9x21bVuVvJzACBlI9FcOz+X2v6pyt2xbeEBeBPuDpKiXlHpudKIxpo+bNe5Swae
         wvaoMsJef3YYB9r3HGbTad1IQslejm9A7TwccvjjiHHephpG3ND+z14Oc3Uj0/6BSGnW
         Xeeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hraqWg5PWkO6+tfHwaIKUlh6JY2C21320PM73mzNHOw=;
        b=dBeAtxrxOFjRunp+OIBtHm0fZzJI5+D965MbSAu33RWe+/M4RmXMjofjvcD3wsOY7Q
         BrnS34nV5Mx+/K1NHvYQNIo2npOVAibAoRo44xUtQOSWhua8pRCDwcWBHBAtS4e1MkZi
         Px2bqDpKysf9yiQeoNrDwAlGU10yVq942GtA98lTEmjr2iPv4TNpvqedMyiT8OZDoZX8
         RQ5MYsnhmtzcCvw1D5vPERHxckwOfuCWXZ4rgB/OPB94E2DV4et585/pN6Z32WQCzOmY
         hX7zhv9djbaI9APlggl1SxRgzMiPKs9AsgtgZ0pevsoTgcOcyYhtyUW0/mGoL2TPhlDO
         u+xg==
X-Gm-Message-State: AOAM530d+pNM6+n9A2E+YnxHPHNvhn04WVInW99o0goFmhRDDh3N2aeh
        HUKn2evkVnj9HiuFKJ3hLrq173KezvI=
X-Google-Smtp-Source: ABdhPJxB9JMVl+Pf+9miHkpICnK+MG3yoLRcCBMr54xK5niUXcY2Joit4s6upOB5Dtf8p+MjtOmyEg==
X-Received: by 2002:a7b:cb90:: with SMTP id m16mr222122wmi.183.1640043429154;
        Mon, 20 Dec 2021 15:37:09 -0800 (PST)
Received: from [192.168.0.16] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id p21sm706314wmq.20.2021.12.20.15.37.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 15:37:08 -0800 (PST)
Subject: Re: [PATCH] software node: fix wrong node passed to find nargs_prop
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20211220210533.3578678-1-clement.leger@bootlin.com>
 <CAHp75Vf+F2L4EFmokRYD+-M9hSuz+SbiiWnqHvFZttRyfKS-mg@mail.gmail.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <d9f5b201-2a00-799d-3a0f-7c9709d77102@gmail.com>
Date:   Mon, 20 Dec 2021 23:37:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vf+F2L4EFmokRYD+-M9hSuz+SbiiWnqHvFZttRyfKS-mg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andy

On 20/12/2021 22:13, Andy Shevchenko wrote:
> + Sakari, Dan
> 
> On Monday, December 20, 2021, Clément Léger <clement.leger@bootlin.com
> <mailto:clement.leger@bootlin.com>> wrote:
> 
>     nargs_prop refers to a property located in the reference that is found
>     within the nargs property.

I think this is right (it's not used in the ACPI version, and the OF
version is quite convoluted so a bit hard to follow)...but also I note
that none of the users of fwnode_property_get_reference_args() pass
anything to nargs_prop anyway...do we even need this?

Use the correct reference node in call to
>     property_entry_read_int_array() to retrieve the correct nargs value.
> 
>     Fixes: b06184acf751 ("software node: Add
>     software_node_get_reference_args()")

I think this might have been introduced later...maybe 996b0830f95d1,
maybe e933bedd45099

>     Signed-off-by: Clément Léger <clement.leger@bootlin.com
>     <mailto:clement.leger@bootlin.com>>
>     ---
>      drivers/base/swnode.c | 2 +-
>      1 file changed, 1 insertion(+), 1 deletion(-)
> 
>     diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
>     index 4debcea4fb12..0a482212c7e8 100644
>     --- a/drivers/base/swnode.c
>     +++ b/drivers/base/swnode.c
>     @@ -529,7 +529,7 @@ software_node_get_reference_args(const struct
>     fwnode_handle *fwnode,
>                     return -ENOENT;
> 
>             if (nargs_prop) {
>     -               error =
>     property_entry_read_int_array(swnode->node->properties,
>     +               error =
>     property_entry_read_int_array(ref->node->properties,
>                                                           nargs_prop,
>     sizeof(u32),
>                                                          
>     &nargs_prop_val, 1);
>                     if (error)
>     -- 
>     2.34.1
> 
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
