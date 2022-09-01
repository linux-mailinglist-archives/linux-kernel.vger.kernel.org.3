Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FD15AA342
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbiIAWoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbiIAWnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:43:50 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1000067CBE;
        Thu,  1 Sep 2022 15:43:49 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 76C1E5FD02;
        Fri,  2 Sep 2022 01:43:47 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1662072227;
        bh=tiivwTGQBmCxotgiy0V8eJaCuzD7tL79bR3lZGF2GrU=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=OyFLhiazQM0FRzeBxxUxs7FyRzcMBEjWiuHTjfnpZKiY0iizu1IyOiCbQAsoV8wSX
         L+Mfxfo+UM9DncvdoaLace1Gjvl3rDNVOvbqMSWdQu58pb2cyMeHs/9eJ70JqqmbpI
         UneJPZsC4S1rhAtM3yGGORhymI17rYg2lsK0fnpdqYdtJSKAo8SWJhYOoadRSjvdKk
         x7nIYWlZfX4Gz2TXpAm8uDzLobNw8wFIe5bIOM3UugVRebJKU6O/1jpIgz/CBw+T24
         DwRe9xMzuH8T+oBJPDpS8d2NThhfbPyj8o1ptkDRKO9BYSUyAanOTR48J4M6dIX7dI
         1PcsoxO1D1ocQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Fri,  2 Sep 2022 01:43:46 +0300 (MSK)
Date:   Fri, 2 Sep 2022 01:43:45 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Pavel Machek <pavel@ucw.cz>,
        Raphael Teysseyre <rteysseyre@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1] leds: trigger: pattern: notify userpace if pattern
 finished
Message-ID: <20220901224345.fy6xvbpdn4axtlks@Rockosov-MBP>
References: <20220824114927.79231-1-mmkurbanov@sberdevices.ru>
 <CAHp75VeQX_8niAu4uORW1YEfjxhLJFWsnm_JccECfAOAzAh32A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHp75VeQX_8niAu4uORW1YEfjxhLJFWsnm_JccECfAOAzAh32A@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/09/01 19:49:00 #20211246
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > +static int pattern_trig_add_pattern_ended(struct led_classdev *led_cdev)
> > +{
> > +       struct pattern_trig_data *data = led_get_trigger_data(led_cdev);
> > +       struct device *dev = led_cdev->dev;
> > +       int ret;
> > +
> > +       ret = device_create_file(dev, &dev_attr_pattern_ended);
> > +       if (ret) {
> > +               dev_err(dev,
> > +                       "Error creating pattern_ended (%pe)\n", ERR_PTR(ret));
> > +               return ret;
> > +       }
> > +
> > +       data->pattern_ended = sysfs_get_dirent(dev->kobj.sd, "pattern_ended");
> > +       if (!data->pattern_ended) {
> > +               dev_err(dev, "Error getting pattern_ended kernelfs\n");
> > +               device_remove_file(dev, &dev_attr_pattern_ended);
> > +               return -ENXIO;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static void pattern_trig_remove_pattern_ended(struct led_classdev *led_cdev)
> > +{
> > +       struct pattern_trig_data *data = led_get_trigger_data(led_cdev);
> > +
> > +       sysfs_put(data->pattern_ended);
> > +       device_remove_file(led_cdev->dev, &dev_attr_pattern_ended);
> > +}
> 
> I'm wondering if you can always have a file and instead provide a
> value there, so user space may use epoll() mechanism on that. It will
> simplify your code here.

Could you please explain what you mean? In the current implementation
userspace can use epoll() already.

-- 
Thank you,
Dmitry
