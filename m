Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C19E51EB5B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 06:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiEHEMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 00:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiEHEMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 00:12:36 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8892F65C5;
        Sat,  7 May 2022 21:08:47 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id q8so11910010oif.13;
        Sat, 07 May 2022 21:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T4C7pw2UqFNMIYwxozglWAGOAmcOcvlLh88gU1vpfoA=;
        b=jYENx5k2/qpGwDiw/lT7nx5Vxbl/bxsdC3SUNpWhVAOJwT1rcBU2P2Y8EsEEoWSbyE
         bohhgpf5LV1RVt+Db1UwUB+jMk40kiStPW4xKb7VI+n1I7/9lBkqr5o2pezJi0ekgHsH
         AVuq96MwNRdQ1JaM4SO5M2h3pf33h1yYuhKSa3svF7so7mK4i+CLNAcy9yUG7xetDyf/
         KJ58yQwx61ucKMqBGrcSo86SyU2xVSc3ySBWkKkc4A5Ce28BeWXXI8Ji00r9DFaTn2CD
         60WzgujUB5WOPQpepeDC2Re6JWJkcB6YfGZGZj4J871XlMMt6Vs/PbOefLRoPSqkTu9/
         CNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T4C7pw2UqFNMIYwxozglWAGOAmcOcvlLh88gU1vpfoA=;
        b=aP8b/cDeLRAo6uI3VVhRGqdk4LtykT4utWxt1GAUNaB1ngwGT7HeC4dC6HG1tz/L4R
         t3TEOfzLCN5RQKfsv0gAAFk3C3WS+dKhWn/MaEmXUgpVqgGWw4pSrqzyyqvceb+B0WzY
         dVn6AhSgnKWzeOs19fJFZvUEUKx7ehJ8GE5vjU3Vml76kEzgaitbx3UcElcr6tLAQPL3
         51p75xisFuVvXllNVAdmUhtOA7mBbU2kwI9S7HTAxVDUip8KnefyzLF6pMxhQ4YE64Pi
         mD1xfzZRE1HwnBC6QYnw/dDGqDDlEshu45w5CpDNpDi6BWesAk3ZsX2aze+hjVXnHO7u
         J9ZA==
X-Gm-Message-State: AOAM530eBcSquoe6sVVOg4q9NeVfjiX7uHmdS8AZFIVPuLEYKq3kIk/O
        kSrGFLValL47JYLTBpw5H0Nz2Kv83q1ljqZrnj0=
X-Google-Smtp-Source: ABdhPJw05UPTsJo+Ci3YzMlQVxqtTKjNkx4I8254ZAZoF2yVSHxs4fL/QTKuKbbMBYUrJUnzFEQsV9O0lENjSSXNhKw=
X-Received: by 2002:a05:6808:bd4:b0:326:c2e8:2d1e with SMTP id
 o20-20020a0568080bd400b00326c2e82d1emr182033oik.52.1651982926664; Sat, 07 May
 2022 21:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAMA88TrcHZH7vw8W4Jh+NCQJvpe3wQM-4k46MnDQC9agna4XJg@mail.gmail.com>
 <20220507160243.35304-1-schspa@gmail.com> <Ynay6XK+ZUWtvfbH@rowland.harvard.edu>
In-Reply-To: <Ynay6XK+ZUWtvfbH@rowland.harvard.edu>
From:   Schspa Shi <schspa@gmail.com>
Date:   Sun, 8 May 2022 12:08:35 +0800
Message-ID: <CAMA88Tr3pX4UjJ0ezSs9kFcKFY4HvyetHTTgFVc=O643SXE1sQ@mail.gmail.com>
Subject: Re: [PATCH v2] usb: gadget: fix race when gadget driver register via ioctl
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Julia.Lawall@inria.fr, andreyknvl@gmail.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, jannh@google.com,
        jj251510319013@gmail.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
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

Alan Stern <stern@rowland.harvard.edu> writes:

> On Sun, May 08, 2022 at 12:02:43AM +0800, Schspa Shi wrote:
>> The usb_gadget_register_driver can be called multi time by to
>> threads via USB_RAW_IOCTL_RUN ioctl syscall, which will lead
>> to multiple registrations.
>>
>> Call trace:
>>   driver_register+0x220/0x3a0 drivers/base/driver.c:171
>>   usb_gadget_register_driver_owner+0xfb/0x1e0
>>     drivers/usb/gadget/udc/core.c:1546
>>   raw_ioctl_run drivers/usb/gadget/legacy/raw_gadget.c:513 [inline]
>>   raw_ioctl+0x1883/0x2730 drivers/usb/gadget/legacy/raw_gadget.c:1220
>>   ioctl USB_RAW_IOCTL_RUN
>>
>> This routine allows two processes to register the same driver instance
>> via ioctl syscall. which lead to a race condition.
>>
>> We can fix it by adding a new STATE_DEV_REGISTERING device state to
>> avoid double register.
>
> Are you sure that this patch will fix the problem found by syzbot?  That
> is, are you sure that the problem really was caused by two threads
> registering the same driver concurrently?
>

Yes, from the console log from syzbot.
T8324 alloced driver_private was released by T8326.

> The fact that the error was "use after free" suggests that the problem
> might be something else.  It looks like one of the threads was trying to
> access the driver structure after the other thread had done something
> that caused it to be deallocated, which suggests an error in reference
> counting.
>

The direct cause of this place is because of the refcount error, but the
root cause is still caused by multiple registrations

Please refer to the following scenarios.

           T1                                  T2
------------------------------------------------------------------
usb_gadget_register_driver_owner
  driver_register                    driver_register
    driver_find                       driver_find
    bus_add_driver                    bus_add_driver
      priv alloced                     <context switch>
      drv->p = priv;
      <schedule out>
      kobject_init_and_add // refcount = 1;
   //couldn't find an available UDC or it's busy
   <context switch>
                                       priv alloced
                                       drv->priv = priv;
                                       kobject_init_and_add
                                         ---> refcount = 1 <------
                                       // register success
                                       <context switch>
===================== another ioctl/process ======================
                                      driver_register
                                       driver_find
                                        k = kset_find_obj()
                                         ---> refcount = 2 <------
                                        <context out>
   driver_unregister
   // drv->p become T2's priv
   ---> refcount = 1 <------
   <context switch>
                                        kobject_put(k)
                                         ---> refcount = 0 <------
                                        return priv->driver;
                                        --------UAF here----------

There will be UAF in this scenario.
And all the logs reported by syzbot can be matched to this scenario.

> Yes, this could be caused by two threads both registering the same
> driver.  But the evidence doesn't prove that this is what happened, as
> far as I can see.
>
> Alan Stern
>

BRs

Schspa Shi
