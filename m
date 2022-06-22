Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2985549C7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239237AbiFVKdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245170AbiFVKdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:33:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29FA163D4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655893989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h/O2yUsrR3zbMDOcI6p2EfJi+EXDXu2J4E4lX2eXiss=;
        b=JpA5gECPGF6y3SAFuYRspT726oVwkjZVNGGXA+l/QMH5R1QHWDozy9e8eqIl/5x8AHdVje
        3Q03m5/eL2NfkAQKaTT0eNN5MG7GY/jbzqQDCcVcXcr8y/qa3eByTkOz4WCXb+QXybkegZ
        kKyb7GDGn84sPs/Ccyi5VaJ0t47PLVE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-410-3fd9EaXNPO-LGIaDapD5NA-1; Wed, 22 Jun 2022 06:33:08 -0400
X-MC-Unique: 3fd9EaXNPO-LGIaDapD5NA-1
Received: by mail-ed1-f71.google.com with SMTP id v16-20020a056402349000b00435a1c942a9so2016874edc.15
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h/O2yUsrR3zbMDOcI6p2EfJi+EXDXu2J4E4lX2eXiss=;
        b=4yHQu2hu/mAy/yx9WzlHLqpYFxERgtHTYczH8zg2YdXNdKDWDMri5wYbcrRWuAQlpY
         bQ0AeMPpPLk0TkKCJpLetcKWNNqIjSzzxfq/LPzaK7N1whQZsEu4ATFu43uqGnOnN54K
         jb1VICimSgtGLjLQrEiRxz1hRMozl0q7xKl672b2eS3IKOG9iQSfnf6glTJujkCVfqpo
         GpkL4kcHtJ210rK7sWXf0h7gwxBluaLvGQ33p7dCJN40epsz9ajyfUFlM+TlJUbMc1+m
         L9tMWOFH15OKJGmV8mEgM4fpXU66lpG2DsUHjAsl2JAZkqI4NezvEFLMda3lX4gUaY3S
         Ebqg==
X-Gm-Message-State: AJIora/mxwrJwWN8lKi3MciUBKPWJFIbYL0mpPMMVSuZGpbTgpuPI276
        1QRE5NfPPGXJ8uW+hT8l7zGlvOAjxIN9ISXFUQs0CbHU937woPNe5BzNBcePDKhvEaCpAZOLtRq
        I8aIFTREKfrKfO9lXp6ZXjDx1
X-Received: by 2002:a17:907:9704:b0:711:f441:dbe6 with SMTP id jg4-20020a170907970400b00711f441dbe6mr2433760ejc.26.1655893986880;
        Wed, 22 Jun 2022 03:33:06 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tUGtmNWueerxyajMELgA1rpfwlIbpcsHiQfl7jJkpWc6IdkKFiMG3zstHY0/rSScR19hrEbQ==
X-Received: by 2002:a17:907:9704:b0:711:f441:dbe6 with SMTP id jg4-20020a170907970400b00711f441dbe6mr2433750ejc.26.1655893986713;
        Wed, 22 Jun 2022 03:33:06 -0700 (PDT)
Received: from [192.168.43.127] ([109.37.135.195])
        by smtp.gmail.com with ESMTPSA id g13-20020aa7c84d000000b004357b717a96sm8196638edt.85.2022.06.22.03.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 03:33:06 -0700 (PDT)
Message-ID: <37d1dd8f-109c-a4b1-b813-8b9ecb69ff92@redhat.com>
Date:   Wed, 22 Jun 2022 12:33:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1 1/2] platform/x86: thinkpad_acpi: Sort headers for
 better maintenance
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <markgross@kernel.org>
References: <20220616224951.66660-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220616224951.66660-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/17/22 00:49, Andy Shevchenko wrote:
> It's quite hard to understand in that zillions of headers that are included
> if any specific one is already listed. Sort headers for better maintenance.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/platform/x86/thinkpad_acpi.c | 58 +++++++++++++++-------------
>  1 file changed, 31 insertions(+), 27 deletions(-)

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index e6cb4a14cdd4..eab50d47f567 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -34,46 +34,50 @@
>   *			    thanks to Chris Wright <chrisw@osdl.org>
>   */
>  
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/init.h>
> -#include <linux/types.h>
> -#include <linux/string.h>
> -#include <linux/list.h>
> -#include <linux/mutex.h>
> -#include <linux/sched.h>
> -#include <linux/sched/signal.h>
> -#include <linux/kthread.h>
> -#include <linux/freezer.h>
> -#include <linux/delay.h>
> -#include <linux/slab.h>
> -#include <linux/nvram.h>
> -#include <linux/proc_fs.h>
> -#include <linux/seq_file.h>
> -#include <linux/sysfs.h>
> +#include <linux/acpi.h>
>  #include <linux/backlight.h>
>  #include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/dmi.h>
>  #include <linux/fb.h>
> -#include <linux/platform_device.h>
> +#include <linux/freezer.h>
>  #include <linux/hwmon.h>
>  #include <linux/hwmon-sysfs.h>
> +#include <linux/init.h>
>  #include <linux/input.h>
> -#include <linux/leds.h>
> -#include <linux/rfkill.h>
> -#include <linux/dmi.h>
>  #include <linux/jiffies.h>
> -#include <linux/workqueue.h>
> -#include <linux/acpi.h>
> +#include <linux/kernel.h>
> +#include <linux/kthread.h>
> +#include <linux/leds.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/nvram.h>
>  #include <linux/pci.h>
> -#include <linux/power_supply.h>
> +#include <linux/platform_device.h>
>  #include <linux/platform_profile.h>
> -#include <sound/core.h>
> -#include <sound/control.h>
> -#include <sound/initval.h>
> +#include <linux/power_supply.h>
> +#include <linux/proc_fs.h>
> +#include <linux/rfkill.h>
> +#include <linux/sched.h>
> +#include <linux/sched/signal.h>
> +#include <linux/seq_file.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
>  #include <linux/uaccess.h>
> +#include <linux/workqueue.h>
> +
>  #include <acpi/battery.h>
>  #include <acpi/video.h>
> +
>  #include <drm/drm_privacy_screen_driver.h>
> +
> +#include <sound/control.h>
> +#include <sound/core.h>
> +#include <sound/initval.h>
> +
>  #include "dual_accel_detect.h"
>  
>  /* ThinkPad CMOS commands */

