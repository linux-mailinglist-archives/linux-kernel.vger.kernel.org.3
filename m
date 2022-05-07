Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0AF51E850
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 17:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385886AbiEGPyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 11:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiEGPyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 11:54:33 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182EA6401;
        Sat,  7 May 2022 08:50:46 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id m11so10748994oib.11;
        Sat, 07 May 2022 08:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=41Mv+KsQAYVN8Us0Ti+umuHoMmg3u4PP5976C3vXHgk=;
        b=EaEM/ppYw3SGKRW1BXCaJNfnDqfRYjjzWgOuqJh22Bt3tZah8jcyQ1ubPU6pZG6VPy
         4cv2e3bzJr4G7OGX7A1qJiP1C3eVTsKJx6jXlmlaJZw7LPNak4EDuNS+Rro9/KAgHHdE
         IjZ48Lwaen5GFNu6O4alTJ8MwACBVKXe9cH38KDljQt1uqqQmDQB0fgDzq3SY0jfONJb
         rUzJ5nQltC7GMOzjYHLEbTsgpugPPny/CkZFmeQ0HU1xtnHwTv8990Zyfov6u/1a5bzg
         +SnZPAE28rVX7q5I8CGknTDT3nrw0iyDc13gmZEl0pmQZIH796PYBhs+rgJg255dRp7F
         6rWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=41Mv+KsQAYVN8Us0Ti+umuHoMmg3u4PP5976C3vXHgk=;
        b=VfAUoRYy0YeZ7TK/eztL8QXTLMO2gde0u9uOcIDeYvTxXtOWRfogQRD6bMsHnr0Yhx
         iZ9w6UWAUcfaxptBSzdFHzRVEnOteOqZAYwLTsacsiPirGIK2ekqVIe/jMNpKBGUHGzV
         VRQtQ+btwp10hQuwLRiuAOzJ/0rFy4psCKBpIYco8/++GgCyxocfyrRjf/Z72M5y/XM8
         RbEFkPjYfhFNO7i4m8IZxFXN7FrPrp5R3ddWX2CU1MS5BfO/q7Al+79t+RlfmdzL3Hgz
         BBaE0d5ohnZszu2fEq7y8fMUvjbxKB93G0b47l7LcuNrBZla2kAX0+A3WP4zzXbpKZe0
         Ti0A==
X-Gm-Message-State: AOAM531QHtfPFWwoVSCYcMspL/NBZl2PuY8Kezs6Iep7xI+sooe6GgTx
        ycU7efb8JGDlwLCfjCq2QAEcUESklO0RhQFtfFU=
X-Google-Smtp-Source: ABdhPJyNVLjlNojWMOmmF/fqfRoyr8hRC/qN3/sJWxy5USjdyZU30QBDROrUwhBOdpHE8rBU+YdxX+/vNkb/2bIhwS0=
X-Received: by 2002:a05:6808:13d2:b0:322:7571:79e with SMTP id
 d18-20020a05680813d200b003227571079emr4008626oiw.52.1651938645103; Sat, 07
 May 2022 08:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220507120851.29948-1-schspa@gmail.com> <YnaBwkhIxZ1wtIQX@kroah.com>
 <YnaLDxcaCGMmETuP@rowland.harvard.edu>
In-Reply-To: <YnaLDxcaCGMmETuP@rowland.harvard.edu>
From:   Schspa Shi <schspa@gmail.com>
Date:   Sat, 7 May 2022 23:50:32 +0800
Message-ID: <CAMA88TrcHZH7vw8W4Jh+NCQJvpe3wQM-4k46MnDQC9agna4XJg@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: fix race when gadget driver register via ioctl
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg KH <gregkh@linuxfoundation.org>, andreyknvl@gmail.com,
        balbi@kernel.org, jj251510319013@gmail.com, jannh@google.com,
        Julia.Lawall@inria.fr, linux-usb@vger.kernel.org,
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

Alan Stern <stern@rowland.harvard.edu> writes:

> On Sat, May 07, 2022 at 04:27:14PM +0200, Greg KH wrote:
>> On Sat, May 07, 2022 at 08:08:51PM +0800, Schspa Shi wrote:
>> > The usb_gadget_register_driver doesn't have inside locks to protect the
>> > driver, and If there is two threads are registered at the same time via
>> > the ioctl syscall, the system will crash as syzbot reported.
>> >
>> > Call trace as:
>> >   driver_register+0x220/0x3a0 drivers/base/driver.c:171
>> >   usb_gadget_register_driver_owner+0xfb/0x1e0
>> >     drivers/usb/gadget/udc/core.c:1546
>> >   raw_ioctl_run drivers/usb/gadget/legacy/raw_gadget.c:513 [inline]
>> >   raw_ioctl+0x1883/0x2730 drivers/usb/gadget/legacy/raw_gadget.c:1220
>> >
>> > This routine allows two processes to register the same driver instance
>> > via ioctl syscall. which lead to a race condition.
>> >
>> > We can fix it by adding a driver_lock to avoid double register.
>> >
>> > Reported-by: syzbot+dc7c3ca638e773db07f6@syzkaller.appspotmail.com
>> > Link: https://lore.kernel.org/all/000000000000e66c2805de55b15a@google.com/
>> >
>> > Signed-off-by: Schspa Shi <schspa@gmail.com>
>> > ---
>> >  drivers/usb/gadget/legacy/raw_gadget.c | 8 ++++++++
>> >  1 file changed, 8 insertions(+)
>> >
>> > diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
>> > index b3be8db1ff63..d7ff9c2b5397 100644
>> > --- a/drivers/usb/gadget/legacy/raw_gadget.c
>> > +++ b/drivers/usb/gadget/legacy/raw_gadget.c
>> > @@ -155,7 +155,9 @@ struct raw_dev {
>> >    spinlock_t                      lock;
>> >
>> >    const char                      *udc_name;
>> > +  /* Protected by driver_lock for reentrant registration */
>> >    struct usb_gadget_driver        driver;
>> > +  struct mutex                    driver_lock;
>>
>> Why are you adding another lock here?  What's wrong with the existing
>> lock in this structure that requires an additional one?
>>
>> >
>> >    /* Reference to misc device: */
>> >    struct device                   *dev;
>> > @@ -188,6 +190,8 @@ static struct raw_dev *dev_new(void)
>> >    spin_lock_init(&dev->lock);
>> >    init_completion(&dev->ep0_done);
>> >    raw_event_queue_init(&dev->queue);
>> > +  mutex_init(&dev->driver_lock);
>> > +
>> >    return dev;
>> >  }
>> >
>> > @@ -398,7 +402,9 @@ static int raw_release(struct inode *inode, struct file *fd)
>> >    spin_unlock_irqrestore(&dev->lock, flags);
>> >
>> >    if (unregister) {
>> > +          mutex_lock(&dev->driver_lock);
>> >            ret = usb_gadget_unregister_driver(&dev->driver);
>> > +          mutex_unlock(&dev->driver_lock);
>> >            if (ret != 0)
>> >                    dev_err(dev->dev,
>> >                            "usb_gadget_unregister_driver() failed with %d\n",
>> > @@ -510,7 +516,9 @@ static int raw_ioctl_run(struct raw_dev *dev, unsigned long value)
>> >    }
>> >    spin_unlock_irqrestore(&dev->lock, flags);
>> >
>> > +  mutex_lock(&dev->driver_lock);
>> >    ret = usb_gadget_register_driver(&dev->driver);
>> > +  mutex_unlock(&dev->driver_lock);
>>
>> How can unregister race with register?
>>
>> What ioctl is causing this race?  What userspace program is doing this?
>> Only one userspace program should be accessing this at once, right?
>
> These questions are on the right track.
>
> The problem here is not insufficient locking.  The problem is that
> dev->state does not have a special state to indicate that the driver is
> being registered.
>
> Before calling usb_gadget_register_driver(), while still holding
> dev->lock, the code should change dev->state to STATE_DEV_REGISTERING.
> Then no race can occur, because the second thread to acquire the
> spinlock will see that dev->state is not equal to STATE_DEV_INITIALIZED.
>

Yes, it's a good suggestion, I will upload a new patch set to use this
method.

> Alan Stern

---
BRs

Schspa Shi
