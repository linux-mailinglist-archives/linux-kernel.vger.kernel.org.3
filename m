Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B17352D308
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 14:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbiESMvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 08:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238207AbiESMvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 08:51:42 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302C5A7E3D
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 05:51:37 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id bx33so6083470ljb.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 05:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CjkHcV5+Ioho362zefXIUQvEZKAf8ryw0kg/vJQRoBw=;
        b=pHcm6Zn8JtQcsyJIEhfVfTpEM9veM/L3Legy3fLTOJjPSdnhOxxBlNHbPDLVyGP9Py
         sth9Y4xz3cYuiv+tdzgFGuUrQSE5qS7hCI5/MWDJNLPGFKL95ogGoNVZmRq8zP7x7w4s
         W2MeOuT+G5jy/WJJ3hJ93+NyRU6++Mhggxmc9qa8FoVHvSxpEZZK2qHPLFkWMhLFVjJI
         pn54Kzmm6Vo3LW8aQMP6VVLVqDLEuGYdjNW8OJy3Ce84D6rhp2BO3/0yZSEu0gNZJw7X
         zBZ7q/VXqjIsr2+5rouv+tjZvUxV60gob292ca2b6V2Kdu83NooZxjN43iTzZgtcPCz4
         1SHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CjkHcV5+Ioho362zefXIUQvEZKAf8ryw0kg/vJQRoBw=;
        b=OTLidY1UomDdPOBdYnUUpW+74vk3ZbAyGBP52x10hkYx0zlq+i2x1T39uNBT9Z+GYw
         SRWgztAJj9T0p2QTuXoDfIMkaWI2xSOTetok/h/AavwpPulRpdnEWKh6mlUOygn222UC
         a0oDE3oT12zBRHV1VGgPBAcIfbl5mDSsxvvdnYVbbJ4Ta63DiNg6E+FYuHXnAeTyDj3R
         dMELQuWF/Gi5vj8RUSBy3duLmKfdXwN1aw40yxiTUdrOOBLAvyn2grsgUBWZJvP408ca
         jL9rS1z0bIe2ZR0gD9p2rq/eRyeBzItaZmsM2nsscOzu785XVXTPu6eGhf33khooQV3N
         V/6Q==
X-Gm-Message-State: AOAM532Qkp8gpjYuJtD+9mfN/jKFFqEoPpeAnVf9Sa6+2O60PHwuqzwa
        iGcKjTqLbBkCt4fptDxEf/qkxA0q7JTEMwYExTqZYg==
X-Google-Smtp-Source: ABdhPJzBvbMtCzkWAihuqbCRJjS6W2qhfHJhjAKRDRlycB6C6uM+cPLTwJGFaMASHcnRUfiMftpYCf+RMz4QGZqgdXo=
X-Received: by 2002:a05:651c:1684:b0:250:c5ec:bc32 with SMTP id
 bd4-20020a05651c168400b00250c5ecbc32mr2618495ljb.92.1652964694883; Thu, 19
 May 2022 05:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <Yc4RsFnaFfbCUeRy@rowland.harvard.edu> <0000000000007e5fdb05d4668af8@google.com>
 <Yc5rgUo8dyJKX98M@rowland.harvard.edu>
In-Reply-To: <Yc5rgUo8dyJKX98M@rowland.harvard.edu>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 19 May 2022 14:51:23 +0200
Message-ID: <CACT4Y+a1-h8hp6qayY7GFoKQv6oX2qwdwzsuwYp8_PVOs3h4Yg@mail.gmail.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Write in usb_hcd_poll_rh_status
 (2)
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+3ae6a2b06f131ab9849f@syzkaller.appspotmail.com>,
        andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Dec 2021 at 03:31, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> [Trimmed CC: list]
>
> On Thu, Dec 30, 2021 at 04:49:18PM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > KASAN: slab-out-of-bounds Write in usb_hcd_poll_rh_status
> ...
> > Tested on:
> >
> > commit:         eec4df26 Merge tag 's390-5.16-6' of git://git.kernel.o..
> > git tree: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
>
> I'm glad to see that the git tree is reported properly, but the commit
> label is too short.  The reproducer bug report had exactly the opposite
> problems!  It said:
>
> > syzbot has found a reproducer for the following issue on:
> >
> > HEAD commit:    eec4df26e24e Merge tag 's390-5.16-6' of git://git.kernel.o..
> > git tree:       upstream
>
> Andrey or Dmitry?  Can you guys unify these two outputs to make both
> lines correct always?

Hi Alan,

This got lost on the mailing list. Filed
https://github.com/google/syzkaller/issues/3147 to track this request.

Thanks

> Moving on...  Important lines from the console log:
>
> [   76.919138][ T4081] usb usb9: usbdev_do_ioctl: BULK
> [   76.924966][ T4081] usb usb9: usbfs: process 4081 (syz-executor189) did not claim interface 0 before use
> [   76.935186][ T4081] usb usb9: ep1 int-in, length 1, timeout 9
> [   76.941355][ T4099] usb usb9: opened by process 4099: syz-executor189
> [   76.942606][ T4087] usb usb9: usbdev_do_ioctl: BULK
> [   76.949968][    C1]
> ==================================================================
> [   76.950070][    C1] BUG: KASAN: slab-out-of-bounds in usb_hcd_poll_rh_status+0x376/0x780
> [   76.950102][    C1] Write of size 2 at addr ffff8880121ae230 by task syz-executor189/4087
>
> It's hard to tell what's really happening.  The suspicious part is the
> "length 1" combined with the "Write of size 2" -- but they refer to
> different processes!
>
> Maybe this diagnostic patch will help a little.
>
> Alan Stern
>
> #syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ eec4df26e24e
>
> Index: usb-devel/drivers/usb/core/devio.c
> ===================================================================
> --- usb-devel.orig/drivers/usb/core/devio.c
> +++ usb-devel/drivers/usb/core/devio.c
> @@ -109,7 +109,7 @@ struct async {
>         u8 bulk_status;
>  };
>
> -static bool usbfs_snoop;
> +static bool usbfs_snoop = true;
>  module_param(usbfs_snoop, bool, S_IRUGO | S_IWUSR);
>  MODULE_PARM_DESC(usbfs_snoop, "true to log all usbfs traffic");
>
> Index: usb-devel/drivers/usb/core/hcd.c
> ===================================================================
> --- usb-devel.orig/drivers/usb/core/hcd.c
> +++ usb-devel/drivers/usb/core/hcd.c
> @@ -809,8 +809,10 @@ static int rh_queue_status (struct usb_h
>         unsigned        len = 1 + (urb->dev->maxchild / 8);
>
>         spin_lock_irqsave (&hcd_root_hub_lock, flags);
> +       dev_info(hcd->self.controller, "rh_queue_status: len %d tblen %d\n",
> +                       len, urb->transfer_buffer_length);
>         if (hcd->status_urb || urb->transfer_buffer_length < len) {
> -               dev_dbg (hcd->self.controller, "not queuing rh status urb\n");
> +               dev_info(hcd->self.controller, "not queuing rh status urb\n");
>                 retval = -EINVAL;
>                 goto done;
>         }
>
