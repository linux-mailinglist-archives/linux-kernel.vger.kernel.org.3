Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7F75ACE11
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237921AbiIEIiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237881AbiIEIhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:37:46 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D34652448
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 01:36:29 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bj12so15504743ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 01:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1lu9MLQdmAJPl0QYqaa7yEFLZznS5vLoLep8F8T+FYw=;
        b=H2bDRiMbS14CyPl3fR01O9q0Bs05J8ffM4pBPPXnO0iZ3yRZ8Dzrj0HV1k4ibmFf7n
         yBAEJHRZ/46vEBkUVFSx5dDYgSYlqv33E5CeDufv7+g7hvfwHhx8TPOUKZJnnqGj72ef
         zgIcLtDTuTHWCxoZLnUKogo//rZxOQqcgwtsewRxJ6ktc8uq4qspEeRriPL0SXCC7TvC
         kvihgc1UYzBEt3AcOTp7/rIshiDqlimygk7z3YX3sWAjl3cFC6KjyhViS9/NdKTXAtLG
         CKlcAqpvUV4eo017epw2/GzNyKTh0Srgwa+Dr2Ul7MKXeHicg6pKWh/WYSUNUUE1cwce
         xA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1lu9MLQdmAJPl0QYqaa7yEFLZznS5vLoLep8F8T+FYw=;
        b=wtJ8JKnO3d7urPoGhY/JGLbiLfV1mElscS1lEyw5/xf6f8/UgHDykkGjDBWdumWx5v
         kOLc5qaFwVp51nT6e1FHv8qES84EgQJ6zjBrhyZ9k7KBrNx5toXQ+duOFvmuyYB8x1vO
         ufVZwSpsjXgALFBMaaf9SAo8hk+t1ZK8yqvgmLh684P/rRAmFahWYebfpTydp+X6Vkig
         H2FfMAg/KePczh8PQRfxoWoysOywtO/05Trk9bc0tK5GEGhK8cKzSB0xTg63x9K3D5Zw
         k8Pa6LckMKnEf9EbLtmUOM60T9usDLv8S0yqHf1uI4ZQAj72Y4tpdl3GrAGVWagq94Ob
         TZNQ==
X-Gm-Message-State: ACgBeo2My+vT0gRHe01AjWJRdZQqoOLNkIkh+uqWLmDE5Y18VWZOjxYI
        LgrsPE/OMPENObgjeTlZkToCVzzltQ3fO7SOhoijiQ==
X-Google-Smtp-Source: AA6agR4fz4Smdw2KZoVZGDuCurFKnu6Y8V/Lzw7j8rOztBCFb0LI8EO8Qw8PlC63R1Gfk3UWkQNqk27p7Mbm7n00OxU=
X-Received: by 2002:a17:907:782:b0:740:7120:c6e7 with SMTP id
 xd2-20020a170907078200b007407120c6e7mr30594417ejb.313.1662366987661; Mon, 05
 Sep 2022 01:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220902091535.3572333-1-raychi@google.com> <YxIX+jqWFfwAWYot@rowland.harvard.edu>
 <CAPBYUsApTYex027qBe-=EyUxDHb8MMQscX+2jqZ98zXxN-0tHA@mail.gmail.com> <YxI4ZViLkZOjN/Bh@rowland.harvard.edu>
In-Reply-To: <YxI4ZViLkZOjN/Bh@rowland.harvard.edu>
From:   Ray Chi <raychi@google.com>
Date:   Mon, 5 Sep 2022 16:36:16 +0800
Message-ID: <CAPBYUsCEjMSJ8P8ZM1_W+S1DOWFTOM0wJwi2fTukfxSGucYhnQ@mail.gmail.com>
Subject: Re: [Patch v2] usb: core: stop USB enumeration if too many retries
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        mathias.nyman@linux.intel.com,
        Albert Wang <albertccwang@google.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Puma Hsu <pumahsu@google.com>, linux-usb@vger.kernel.org,
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

On Sat, Sep 3, 2022 at 1:07 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Sat, Sep 03, 2022 at 12:08:04AM +0800, Ray Chi wrote:
> > On Fri, Sep 2, 2022 at 10:49 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Fri, Sep 02, 2022 at 05:15:35PM +0800, Ray Chi wrote:
> > > > If a broken accessory connected to a USB host, usbcore might
> > > > keep doing enumeration retries and it will take a long time to
> > > > cause system unstable.
> > > >
> > > > This patch provides a quirk to specific USB ports of the hub to
> > > > stop USB enumeration if needed.
> > >
> > > This seems very awkward.  Why not have a quirk that prevents USB
> > > enumeration completely, instead of after some number of retries?  After
> > > all, if the port is connected to a broken accessory, there's no reason
> > > to try enumerating it even once.
> > >
> > > For that matter, have you tried using the existing "disabled" port
> > > attribute instead of adding a new quirk?  Does it already solve your
> > > problem?
> > >
> >
> > Since we don't know if the connected accessory is normal or broken, doing port
> > initialization is necessary.
>
> I don't understand.  If you don't know whether the accessory is broken,
> how do you know whether to set the quirk?
>
> On the other hand, if you always set the quirk even before you know
> whether the accessory is broken, why make it a quirk at all?  Why not
> make it the normal behavior of the driver?
>

Since our device has a watchdog mechanism, when the device connects to
a broken accessory, the kernel panic will happen. This problem didn't happen
in all USB Hosts, so I want to use the quirk to fix this problem for those hosts
with a watchdog mechanism.

> > > > +              * Some USB hosts can't take a long time to keep doing enumeration
> > > > +              * retry. After doing half of the retries, we would turn off the port
> > > > +              * power to stop enumeration if the quirk is set.
> > >
> > > What made you decide that half of the retries was the right place to
> > > stop?  Why not do all the retries?
> >
> > Since some normal devices will be timeout in the first attempt, I set
> > the condition to half
> > of the retries. All the retries will take 12*timeout seconds. It is
> > too long so that a watchdog
> > timeout problem may happen.
>
> Why not set CONFIG_USB_FEW_INIT_RETRIES instead?
>

https://source.android.com/docs/core/architecture/kernel/android-common
According to Android Common Kernel, I can't only add this config to one project.
In addition, it can't stop enumeration so that the timeout problem
still happens.

> > > If the quirk prevented enumeration completely then this function
> > > wouldn't be needed.
> >
> > The enumeration is still needed as above.
> >
> > >
> > > > +
> > > >  /* Check if a port is power on */
> > > >  int usb_port_is_power_on(struct usb_hub *hub, unsigned int portstatus)
> > > >  {
> > > > @@ -4855,6 +4879,11 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
> > > >                                       buf->bMaxPacketSize0;
> > > >                       kfree(buf);
> > > >
> > > > +                     if (r < 0 && (port_dev->quirks & USB_PORT_QUIRK_STOP_ENUM)) {
> > >
> > > How come this line tests the quirk but doesn't call
> > > hub_port_stop_enumerate()?
> >
> > Since the quirk is used to stop enumeration and reduce the total time.
> > If the port has the quirk, I think the port doesn't need to do
> > set_address after the port gets
> > failures in the new scheme. It will add 2 attempts * timeout (defined
> > in hc_driver) seconds.
>
> I still can't tell what you're trying to accomplish.  You need to do a
> much better job of explaining the point of this.  For instance, you
> might describe in detail a situation where the quirk is needed,
> explaining what sort of behavior of the system would lead you to set the
> quirk, and why.
>

There is a kernel panic when the device connects to the broken accessory.
I tried to modify the initial_descriptor_timeout. When the accessory is not
working, the total time is 6.5s (get descriptor retry) + 5*2 seconds
(set address of xhci timeout).
The time is so long to cause kernel panic for the device. This is why I want to
stop enumeration instead reducing the retries or timeout.

[16433.648337] usb 2-1: reset full-speed USB device number 2 using
xhci-hcd-exynos
[16435.311614] usb 2-1: device descriptor read/64, error -110
[16437.103767] usb 2-1: device descriptor read/64, error -110
[16437.339768] usb 2-1: reset full-speed USB device number 2 using
xhci-hcd-exynos
[16439.023868] usb 2-1: device descriptor read/64, error -110
[16440.815597] usb 2-1: device descriptor read/64, error -110
[16441.051575] usb 2-1: reset full-speed USB device number 2 using
xhci-hcd-exynos
[16446.063656] xhci-hcd-exynos xhci-hcd-exynos.4.auto: Timeout while
waiting for setup device command
[16446.953961] Kernel panic - not syncing: PM suspend timeout
[16446.978122] Workqueue: events_unbound async_run_entry_fn.cfi_jt
[16446.978136] Call trace:
[16446.978150]  __switch_to+0x260/0x4dc
[16446.978165]  __schedule+0x6c4/0xabc
[16446.978181]  schedule+0x12c/0x24c
[16446.978195]  schedule_timeout+0x48/0x138
[16446.978210]  wait_for_common+0x148/0x310
[16446.978238]  xhci_setup_device+0x470/0xe30
[16446.978250]  xhci_address_device+0x18/0x28
[16446.978340]  hub_port_init+0x5a0/0xfec
[16446.978356]  usb_reset_and_verify_device+0x710/0xb8c
[16446.978370]  usb_port_resume+0x5a8/0x780
[16446.978393]  usb_generic_driver_resume+0x28/0x60
[16446.978413]  usb_resume_both+0x16c/0x474
[16446.978436]  usb_dev_resume+0x2c/0x84
[16446.978446]  dpm_run_callback+0x50/0x250
[16446.978459]  device_resume+0x250/0x2f8
[16446.978473]  async_resume+0x28/0x12c
[16446.978492]  async_run_entry_fn+0x6c/0x3dc
[16446.978516]  process_one_work+0x24c/0x5bc
[16446.978530]  worker_thread+0x3e8/0xa50
[16446.978547]  kthread+0x150/0x1b4
[16446.978563]  ret_from_fork+0x10/0x30

> Alan Stern

Thanks,
Ray
