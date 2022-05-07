Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2913051E842
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 17:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385751AbiEGPrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 11:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiEGPrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 11:47:51 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792512ED66;
        Sat,  7 May 2022 08:43:53 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 88-20020a9d0ee1000000b005d0ae4e126fso6982687otj.5;
        Sat, 07 May 2022 08:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2hvTqYp3Vz8Ca80b3V7APOxJqJQJXmTRQa6QXcfz5js=;
        b=dwxji6ZpVZ7Y9GMHDIJA5ma8j2vg+MjD71ndkaRB69ti5zskIKEA/+Zq50N2ox2G+E
         QwnEpYkq65wXEz88VnKfbYFiF/8tyK8UidnyBG2wcS99HdmXWtIYXfMZwZ+0B9NfA4l/
         +NnkTRXpY7GIjILlQW1aSSp4gF6XVZrFc4a5syDj036FPAd1BJWo12HUTuAVpuyxMhSZ
         DCHCXfBAn4wffJ66q/7wRxb/JA/Z5fnfr7fm1WEFY/GXWmcfd7O+jvQgJNMVpXdjQzvP
         WzlwQ/h3Eo82Qlao8IiGzltFN6Cxatm33QPZkQkYqCsrXOOyudb2gHfE+v+xxzksSTMH
         F3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2hvTqYp3Vz8Ca80b3V7APOxJqJQJXmTRQa6QXcfz5js=;
        b=rE7xwIClVEJIg0Vsd2E382MB16R7uWaDjka4osUWp769uyn07wzsVekDQ/GRZIMi6O
         fJd9Schs18up9Exa5rXbKABj5cnEdkLgrGkQXq19w1fvr2e5yiJlsm9kRHpPRbpZ8nzX
         N4Pk7Ccj3Znvm2Y389fT9rGzcdDKmNgh39v0x4tUqZO6XnEt7jlX5g6o+SI/uUkbclG/
         bz0dqpmYlEtgt37QOaNePQKe6YsowG0G+lXgCoZ/rBlYSaPx/480q3ePVvZSpr4MX/3c
         ZGJIy6FStraqQ3rL8oOxV6Sg0dCE0uA+4CtMJoPdugXhV7jPa7r67L8BaOOpy8Qfn5Kz
         pE2Q==
X-Gm-Message-State: AOAM5312IO7cqZc4b2dI1AUH8WyleoqfCVTbNPvKZEiQ+PmJETI994qf
        G8R79yU/oinyEl1IrVRU71ew8YiVFFhvR9YTips=
X-Google-Smtp-Source: ABdhPJze7EvghBHQNU61QOJc09E+Ek+eP9fC/OW1c0vw3A4XKg3DamFJUyR12K/t/Qc+zqDx1CmjVCh6kqOFBHjOQoM=
X-Received: by 2002:a05:6830:1183:b0:606:698:717e with SMTP id
 u3-20020a056830118300b006060698717emr2942155otq.309.1651938232783; Sat, 07
 May 2022 08:43:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220507120851.29948-1-schspa@gmail.com> <YnaBwkhIxZ1wtIQX@kroah.com>
In-Reply-To: <YnaBwkhIxZ1wtIQX@kroah.com>
From:   Schspa Shi <schspa@gmail.com>
Date:   Sat, 7 May 2022 23:43:41 +0800
Message-ID: <CAMA88TpXqRj+nhH8ty_FJqoe_yE12GvCHkL5aC+YPjHBB6=RAg@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: fix race when gadget driver register via ioctl
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     andreyknvl@gmail.com, balbi@kernel.org, jj251510319013@gmail.com,
        stern@rowland.harvard.edu, jannh@google.com, Julia.Lawall@inria.fr,
        linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzbot+dc7c3ca638e773db07f6@syzkaller.appspotmail.com
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

Greg KH <gregkh@linuxfoundation.org> writes:

> On Sat, May 07, 2022 at 08:08:51PM +0800, Schspa Shi wrote:
>> The usb_gadget_register_driver doesn't have inside locks to protect the
>> driver, and If there is two threads are registered at the same time via
>> the ioctl syscall, the system will crash as syzbot reported.
>>
>> Call trace as:
>>   driver_register+0x220/0x3a0 drivers/base/driver.c:171
>>   usb_gadget_register_driver_owner+0xfb/0x1e0
>>     drivers/usb/gadget/udc/core.c:1546
>>   raw_ioctl_run drivers/usb/gadget/legacy/raw_gadget.c:513 [inline]
>>   raw_ioctl+0x1883/0x2730 drivers/usb/gadget/legacy/raw_gadget.c:1220
>>
>> This routine allows two processes to register the same driver instance
>> via ioctl syscall. which lead to a race condition.
>>
>> We can fix it by adding a driver_lock to avoid double register.
>>
>> Reported-by: syzbot+dc7c3ca638e773db07f6@syzkaller.appspotmail.com
>> Link: https://lore.kernel.org/all/000000000000e66c2805de55b15a@google.com/
>>
>> Signed-off-by: Schspa Shi <schspa@gmail.com>
>> ---
>>  drivers/usb/gadget/legacy/raw_gadget.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
>> index b3be8db1ff63..d7ff9c2b5397 100644
>> --- a/drivers/usb/gadget/legacy/raw_gadget.c
>> +++ b/drivers/usb/gadget/legacy/raw_gadget.c
>> @@ -155,7 +155,9 @@ struct raw_dev {
>>      spinlock_t                      lock;
>>
>>      const char                      *udc_name;
>> +    /* Protected by driver_lock for reentrant registration */
>>      struct usb_gadget_driver        driver;
>> +    struct mutex                    driver_lock;
>
> Why are you adding another lock here?  What's wrong with the existing
> lock in this structure that requires an additional one?
>

We can't use the existing lock, because it's a spinlock, and can't call
usb_gadget_register_driver() in its critical section, it will hold
"udc_lock" which is a mutex_lock. Moreover, a deeper, it will call
driver_register(), which can't be called by atomic context too.

>> +    mutex_lock(&dev->driver_lock);
>>      ret = usb_gadget_register_driver(&dev->driver);
>> +    mutex_unlock(&dev->driver_lock);
>
> How can unregister race with register?
>
I'm sorry for the confused race explanation, it's not unregister race
with register, this lock around usb_gadget_unregister_driver() can be
I will remove this lock in a new patchset if no other change needs to
be made.

> What ioctl is causing this race?  What userspace program is doing this?
> Only one userspace program should be accessing this at once, right?
>
> confused,

It's because of two processes calling to register the same driver
instance, which causes the race condition.

The ioctl is USB_RAW_IOCTL_RUN, which can be called from userspace
multi times or we should add protection to ioctl calls to avoid multi
time device register?

In this usb gadget, the driver property should be passed from
USB_RAW_IOCTL_INIT ioctl, which leave here a device_register by
userspace.

For more details about this race.

      Process 0                      Process 1
  USB_RAW_IOCTL_INIT
  USB_RAW_IOCTL_RUN              USB_RAW_IOCTL_RUN
    usb_gadget_register_driver    usb_gadget_register_driver
      driver_register              driver_register

>
> greg k-h

---
BRs

Schspa Shi
