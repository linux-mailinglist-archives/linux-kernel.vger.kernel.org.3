Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7205A53FB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 20:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiH2SeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 14:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiH2SeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 14:34:02 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9B543320
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 11:33:59 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 2so11270470edx.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 11:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Fkp4zaIwMZjMIyVQn4yiLU//ygQY2c51dqyGIsJx2Ok=;
        b=KwaturyZhXQk3MvKgrOil8PVmlY2rUQ5XV3CcrcW62byA/YFZec8wItaqmqCH0h4mv
         /9zRBf+sXfucGOnZe5zpwoU4so2UOzPsW0+drMUp9Qtg6er8YNehFpHGn4JA8Sjc1g0q
         tiaCDIr8I9NQOmu5iYrbnhCWAw38SOHUbSt3o0MCYQUbR2YUDwqy2TlxnK++ry+HOyPG
         iWuIg2/v4PrxDNGVyZcIS6+WhKRfD5UCJS4AnuIe/RxZEDhzvQM4QsmS5/xp4VPi0IUg
         ypLD8rE3YAJFgaVhiJKBEC8tSVj6PO7XbHn6Tgbe24mE0qkaSI0klTaEWy+kXxLyWsYN
         kEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Fkp4zaIwMZjMIyVQn4yiLU//ygQY2c51dqyGIsJx2Ok=;
        b=IkFaGwVkFRAfg/rQdQ/VpFKObNV5raEzTB3S5VnU5+hhD3TiKwc0hJn7oMefxSG2fG
         YEFnFVtUin43E5+utveCF0RoJP/mk3epdhiJXZwsa5BPfjcBuMADwtOxJKlb6vz+FkaS
         /OpWRrYg99xsGX68Worr8sN+Iepj+kq4ogm2/yO7hxjXq0SS38+9Ke5xLo6L/TpFULit
         N4Q9YTQvfeoXdlC/sUmHRFFA6c1il3uDosMXdHo0bBKaujJoF8ql1YqktEJqcqln7pHQ
         bknWtrQlmsdx2d+5FNP2YxCyavipq1CjYFCYmGoDty+tymTDFNHC5POTpxmq79DqM5ax
         7vEg==
X-Gm-Message-State: ACgBeo1qMzQYEERHRnpXKvsdoYGVmOFFJYyRmZIYXdhCTJCsmiIMFz9A
        WXkDx6JSkeXxtbcegvP1RBrPJn+9Td6wTJmOMUyWOBxbLUY=
X-Google-Smtp-Source: AA6agR5UMB2tErNoFlt3ixcQJCGcD9U7QYjDWxZbOTAnBeHvpruypphUy4DIF5er0QADA8u8pPW3OvsaSTJqXE7X/nc=
X-Received: by 2002:a05:6402:1290:b0:448:181c:37ec with SMTP id
 w16-20020a056402129000b00448181c37ecmr10261363edv.191.1661798037363; Mon, 29
 Aug 2022 11:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220829024351.2415147-1-justinledford@google.com>
 <20220829132017.GA3039965@roeck-us.net> <CAHCvCEcGvrS=3p2Whj0Cmx9sx+aSzX2097LahQ=f3eRCCAN_bA@mail.gmail.com>
 <20220829161135.GB1320973@roeck-us.net> <CAHCvCEc27ozgr6pthRZ84FzJnhM+X705RJpW4z4SB-P9dV_aSg@mail.gmail.com>
 <19161199-3ab8-7ba6-0658-271f6f1e4ba4@roeck-us.net>
In-Reply-To: <19161199-3ab8-7ba6-0658-271f6f1e4ba4@roeck-us.net>
From:   Justin Ledford <justinledford@google.com>
Date:   Mon, 29 Aug 2022 11:33:45 -0700
Message-ID: <CAHCvCEc-Tt3WmQL-0jTNPe-twa784L65E8T86Lyz5CHD0rqVHw@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (max31790) add fanN_enable
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Aug 29, 2022 at 11:08 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 8/29/22 10:15, Justin Ledford wrote:
> > On Mon, Aug 29, 2022 at 9:11 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> On Mon, Aug 29, 2022 at 08:09:21AM -0700, Justin Ledford wrote:
> >>> The tach input isn't enabled in the device by default. So the only way
> >>> to start using the fan input sensors is to set the regulator mode
> >>> through the driver to RPM mode and then back to whatever mode you
> >>> actually want to use. The I2C interface to the device doesn't couple
> >>> the tach input to the regulator mode so I don't think it makes sense
> >>> for the driver to do this either.
> >>>
> >> Please don't top-post.
> >>
> >> The above does not answer my question why fan_config[] wound need to
> >> be updated repeatedly.
> >>
> >> Guenter
> >>
> >>> On Mon, Aug 29, 2022 at 6:20 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >>>>
> >>>> On Mon, Aug 29, 2022 at 02:43:51AM +0000, Justin Ledford wrote:
> >>>>> The MAX31790 has a tach input enable bit in each fan's configuration
> >>>>> register. This is only enabled by the driver if RPM mode is selected,
> >>>>> but the driver doesn't provide a way to independently enable tachometer
> >>>>> input regardless of the regulator mode.
> >>>>>
> >>>>> By adding the fanN_enable sysfs files, we can decouple the tach input
> >>>>> from the regulator mode. Also update the documentation.
> >>>>>
> >>>>> Signed-off-by: Justin Ledford <justinledford@google.com>
> >>>>> ---
> >>>>>   Documentation/hwmon/max31790.rst |  1 +
> >>>>>   drivers/hwmon/max31790.c         | 44 +++++++++++++++++++++++++++-----
> >>>>>   2 files changed, 38 insertions(+), 7 deletions(-)
> >>>>>
> >>>>> diff --git a/Documentation/hwmon/max31790.rst b/Documentation/hwmon/max31790.rst
> >>>>> index 7b097c3b9b90..33c5c7330efc 100644
> >>>>> --- a/Documentation/hwmon/max31790.rst
> >>>>> +++ b/Documentation/hwmon/max31790.rst
> >>>>> @@ -38,6 +38,7 @@ Sysfs entries
> >>>>>   fan[1-12]_input    RO  fan tachometer speed in RPM
> >>>>>   fan[1-12]_fault    RO  fan experienced fault
> >>>>>   fan[1-6]_target    RW  desired fan speed in RPM
> >>>>> +fan[1-6]_enable    RW  enable or disable the tachometer input
> >>>>>   pwm[1-6]_enable    RW  regulator mode, 0=disabled (duty cycle=0%), 1=manual mode, 2=rpm mode
> >>>>>   pwm[1-6]           RW  read: current pwm duty cycle,
> >>>>>                          write: target pwm duty cycle (0-255)
> >>>>> diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
> >>>>> index 7e9362f6dc29..3ae02be4b41e 100644
> >>>>> --- a/drivers/hwmon/max31790.c
> >>>>> +++ b/drivers/hwmon/max31790.c
> >>>>> @@ -118,6 +118,12 @@ static struct max31790_data *max31790_update_device(struct device *dev)
> >>>>>                                        goto abort;
> >>>>>                                data->target_count[i] = rv;
> >>>>>                        }
> >>>>> +
> >>>>> +                     rv = i2c_smbus_read_byte_data(client,
> >>>>> +                                     MAX31790_REG_FAN_CONFIG(i));
> >>>>> +                     if (rv < 0)
> >>>>> +                             goto abort;
> >>>>> +                     data->fan_config[i] = rv;
> >>>>
> >>>> Why is this needed ?
> >>>>
> >>>> Guenter
> >>>>
> >
> > This is needed in case the fan_config is changed outside the driver
> > with something like i2ctransfer, so that the driver reports the actual
> > state of the device, rather than the state at the time of the last
> > write originating from the driver.
> >
>
> That is not a concern or valid argument. With such an argument,
> not a single I2C (or, for that matter, any other) register would
> be cacheable, and much of the caching code in the kernel would
> not work. Anyone hacking around any driver in the system would
> be on their own. One could even argue that such hacking should
> be undone if possible because it may have severe and unexpected
> impact on any driver operation.
>
> Guenter
>
Thank you for the feedback, that makes sense. I will send an updated
patch with this chunk removed.
> >>>>>                }
> >>>>>
> >>>>>                data->last_updated = jiffies;
> >>>>> @@ -202,6 +208,9 @@ static int max31790_read_fan(struct device *dev, u32 attr, int channel,
> >>>>>                }
> >>>>>                mutex_unlock(&data->update_lock);
> >>>>>                return 0;
> >>>>> +     case hwmon_fan_enable:
> >>>>> +             *val = !!(data->fan_config[channel] & MAX31790_FAN_CFG_TACH_INPUT_EN);
> >>>>> +             return 0;
> >>>>>        default:
> >>>>>                return -EOPNOTSUPP;
> >>>>>        }
> >>>>> @@ -214,7 +223,7 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
> >>>>>        struct i2c_client *client = data->client;
> >>>>>        int target_count;
> >>>>>        int err = 0;
> >>>>> -     u8 bits;
> >>>>> +     u8 bits, fan_config;
> >>>>>        int sr;
> >>>>>
> >>>>>        mutex_lock(&data->update_lock);
> >>>>> @@ -243,6 +252,23 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
> >>>>>                                        MAX31790_REG_TARGET_COUNT(channel),
> >>>>>                                        data->target_count[channel]);
> >>>>>                break;
> >>>>> +     case hwmon_fan_enable:
> >>>>> +             fan_config = data->fan_config[channel];
> >>>>> +             if (val == 0) {
> >>>>> +                     fan_config &= ~MAX31790_FAN_CFG_TACH_INPUT_EN;
> >>>>> +             } else if (val == 1) {
> >>>>> +                     fan_config |= MAX31790_FAN_CFG_TACH_INPUT_EN;
> >>>>> +             } else {
> >>>>> +                     err = -EINVAL;
> >>>>> +                     break;
> >>>>> +             }
> >>>>> +             if (fan_config != data->fan_config[channel]) {
> >>>>> +                     err = i2c_smbus_write_byte_data(client, MAX31790_REG_FAN_CONFIG(channel),
> >>>>> +                                                     fan_config);
> >>>>> +                     if (!err)
> >>>>> +                             data->fan_config[channel] = fan_config;
> >>>>> +             }
> >>>>> +             break;
> >>>>>        default:
> >>>>>                err = -EOPNOTSUPP;
> >>>>>                break;
> >>>>> @@ -270,6 +296,10 @@ static umode_t max31790_fan_is_visible(const void *_data, u32 attr, int channel)
> >>>>>                    !(fan_config & MAX31790_FAN_CFG_TACH_INPUT))
> >>>>>                        return 0644;
> >>>>>                return 0;
> >>>>> +     case hwmon_fan_enable:
> >>>>> +             if (channel < NR_CHANNEL)
> >>>>> +                     return 0644;
> >>>>> +             return 0;
> >>>>>        default:
> >>>>>                return 0;
> >>>>>        }
> >>>>> @@ -423,12 +453,12 @@ static umode_t max31790_is_visible(const void *data,
> >>>>>
> >>>>>   static const struct hwmon_channel_info *max31790_info[] = {
> >>>>>        HWMON_CHANNEL_INFO(fan,
> >>>>> -                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
> >>>>> -                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
> >>>>> -                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
> >>>>> -                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
> >>>>> -                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
> >>>>> -                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
> >>>>> +                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
> >>>>> +                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
> >>>>> +                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
> >>>>> +                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
> >>>>> +                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
> >>>>> +                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
> >>>>>                           HWMON_F_INPUT | HWMON_F_FAULT,
> >>>>>                           HWMON_F_INPUT | HWMON_F_FAULT,
> >>>>>                           HWMON_F_INPUT | HWMON_F_FAULT,
> >>>>> --
> >>>>> 2.37.2.672.g94769d06f0-goog
> >>>>>
>
