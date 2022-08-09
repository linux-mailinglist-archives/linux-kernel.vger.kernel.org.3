Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B7E58D687
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 11:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiHIJ16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 05:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241674AbiHIJ1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 05:27:55 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9EB21833;
        Tue,  9 Aug 2022 02:27:54 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id b24so1861799qka.5;
        Tue, 09 Aug 2022 02:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=LBewkbkfdjM1X0jLUkdZkMkLM7T0T/ZVPTroOUPncQc=;
        b=LpgMuquK8oIev0WPu106oH3gphhbyFNnrix319tG6frjyWWNBRCcVfms4JVXqDf5Od
         R/YPmMkXRJ1oagleQ6c07ja4FQ3LSk43l8++aqcOnqTzf9Ml2O0AVtVtMxd4vAVpxK71
         eVZY3o9ixva0Wo/YKaCIkXpFm15QBKhsNRCaiLdo6Z9YrxaDLJGOHQxsKY0JZiq9xQFQ
         UXUBTkmiBpUoTCI7HcZoUqi5Rig3rNgDvCSLbSSA+tZEShX7K9urJlZSkZJ3HnWzzgG9
         L6jFyt6YBh15hH3jfl6OO1BvSp3HIA0EBqKr3JHXshCgYlI8t+zm8DPvhhOC0V3FQYlY
         opng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=LBewkbkfdjM1X0jLUkdZkMkLM7T0T/ZVPTroOUPncQc=;
        b=RrHNJhNCfK2zuQEZb5yT77kSQs437jcbYPgQVeBy6lqt9UI0YQg+FmlRnfeSwnh8cZ
         kSCBPifpXhcasVPYnEr869xrqbltljOh66imSc5E7gU3hRqGHaFLkNdkjM2ay2hqW7Vg
         NtdthyrM/HHdV88cOqLfW3XObkgWRskEU8xBHITMiZermVQauhWdStezgsR1awUKLh7T
         qTBihmM8PRAHTun7dXJ+IXSvP7f4K0yMZ9NHCq11+V+KTlZR4GP9p5jepXtpEihvlMFv
         zfA3Y22lFsyQ8yRoBzafn15Xcdal3kPRzOzx6Ak2Nc9U+pFZght+1h3cBninkVmx1fuI
         reXA==
X-Gm-Message-State: ACgBeo2/TM1jhJU6Zg7SldvuxOP/A3STmdJ3IEpIIlTS4bSD7QCNqFmA
        Vp6MiasIb2kIYOYQ7IIHtLRbgf/7wyZ6elH++n8=
X-Google-Smtp-Source: AA6agR6DX4MNlmOlwo6inp6h2vQCPNZQ01BhE4BAuRN8+mrcJZNk82NKDxuBWvmpb3tQ4iXDQ6c+no9nBypWyxlxxl4=
X-Received: by 2002:ae9:e88d:0:b0:6b9:4a0b:cea5 with SMTP id
 a135-20020ae9e88d000000b006b94a0bcea5mr6596942qkg.748.1660037272986; Tue, 09
 Aug 2022 02:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220809025054.1626339-1-luke@ljones.dev> <20220809025054.1626339-6-luke@ljones.dev>
In-Reply-To: <20220809025054.1626339-6-luke@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Aug 2022 11:27:15 +0200
Message-ID: <CAHp75VdoqPOZz4GG6Sr2npZwjYHDVMo2pmNGqyBRrnen2j8k7g@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] asus-wmi: Convert all attr-show to use sysfs_emit
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Aug 9, 2022 at 4:51 AM Luke D. Jones <luke@ljones.dev> wrote:
>
> This changes all *_show attributes in asus-wmi.c to use sysfs_emit()
> instead of the older method of writing to the output buffer manually.

This looks good to me,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

(Carry the tag with a new version of the series in this patch)

Hans, I guess this one can be applied so it will be less of a burden
on reviewing the rest.

> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 719223804c0e..78f1f3af1b12 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -942,7 +942,7 @@ static ssize_t charge_control_end_threshold_show(struct device *device,
>                                                  struct device_attribute *attr,
>                                                  char *buf)
>  {
> -       return sprintf(buf, "%d\n", charge_end_threshold);
> +       return sysfs_emit(buf, "%d\n", charge_end_threshold);
>  }
>
>  static DEVICE_ATTR_RW(charge_control_end_threshold);
> @@ -2032,7 +2032,7 @@ static ssize_t pwm1_show(struct device *dev,
>                 value = -1;
>         }
>
> -       return sprintf(buf, "%d\n", value);
> +       return sysfs_emit(buf, "%d\n", value);
>  }
>
>  static ssize_t pwm1_store(struct device *dev,
> @@ -2092,7 +2092,7 @@ static ssize_t fan1_input_show(struct device *dev,
>                 return -ENXIO;
>         }
>
> -       return sprintf(buf, "%d\n", value < 0 ? -1 : value*100);
> +       return sysfs_emit(buf, "%d\n", value < 0 ? -1 : value * 100);
>  }
>
>  static ssize_t pwm1_enable_show(struct device *dev,
> @@ -2110,7 +2110,7 @@ static ssize_t pwm1_enable_show(struct device *dev,
>          * in practice on X532FL at least (the bit is always 0) and there's
>          * also nothing in the DSDT to indicate that this behaviour exists.
>          */
> -       return sprintf(buf, "%d\n", asus->fan_pwm_mode);
> +       return sysfs_emit(buf, "%d\n", asus->fan_pwm_mode);
>  }
>
>  static ssize_t pwm1_enable_store(struct device *dev,
> @@ -2178,7 +2178,7 @@ static ssize_t fan1_label_show(struct device *dev,
>                                           struct device_attribute *attr,
>                                           char *buf)
>  {
> -       return sprintf(buf, "%s\n", ASUS_FAN_DESC);
> +       return sysfs_emit(buf, "%s\n", ASUS_FAN_DESC);
>  }
>
>  static ssize_t asus_hwmon_temp1(struct device *dev,
> @@ -2371,7 +2371,7 @@ static ssize_t fan_boost_mode_show(struct device *dev,
>  {
>         struct asus_wmi *asus = dev_get_drvdata(dev);
>
> -       return scnprintf(buf, PAGE_SIZE, "%d\n", asus->fan_boost_mode);
> +       return sysfs_emit(buf, "%d\n", asus->fan_boost_mode);
>  }
>
>  static ssize_t fan_boost_mode_store(struct device *dev,
> @@ -2924,7 +2924,7 @@ static ssize_t throttle_thermal_policy_show(struct device *dev,
>         struct asus_wmi *asus = dev_get_drvdata(dev);
>         u8 mode = asus->throttle_thermal_policy_mode;
>
> -       return scnprintf(buf, PAGE_SIZE, "%d\n", mode);
> +       return sysfs_emit(buf, "%d\n", mode);
>  }
>
>  static ssize_t throttle_thermal_policy_store(struct device *dev,
> --
> 2.37.1
>


-- 
With Best Regards,
Andy Shevchenko
