Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8815351EE0F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 16:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbiEHOiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 10:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiEHOis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 10:38:48 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0274A6389
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 07:34:57 -0700 (PDT)
Received: (qmail 98159 invoked by uid 1000); 8 May 2022 10:34:57 -0400
Date:   Sun, 8 May 2022 10:34:57 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Schspa Shi <schspa@gmail.com>
Cc:     Julia.Lawall@inria.fr, andreyknvl@gmail.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, jannh@google.com,
        jj251510319013@gmail.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        syzbot+dc7c3ca638e773db07f6@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] usb: gadget: fix race when gadget driver register via
 ioctl
Message-ID: <YnfVEcOWO63uIGs5@rowland.harvard.edu>
References: <CAMA88TrcHZH7vw8W4Jh+NCQJvpe3wQM-4k46MnDQC9agna4XJg@mail.gmail.com>
 <20220507160243.35304-1-schspa@gmail.com>
 <Ynay6XK+ZUWtvfbH@rowland.harvard.edu>
 <CAMA88Tr3pX4UjJ0ezSs9kFcKFY4HvyetHTTgFVc=O643SXE1sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMA88Tr3pX4UjJ0ezSs9kFcKFY4HvyetHTTgFVc=O643SXE1sQ@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 08, 2022 at 12:08:35PM +0800, Schspa Shi wrote:
> Alan Stern <stern@rowland.harvard.edu> writes:
> >
> > Are you sure that this patch will fix the problem found by syzbot?  That
> > is, are you sure that the problem really was caused by two threads
> > registering the same driver concurrently?
> >
> 
> Yes, from the console log from syzbot.
> T8324 alloced driver_private was released by T8326.

That is a smoking gun.

> > The fact that the error was "use after free" suggests that the problem
> > might be something else.  It looks like one of the threads was trying to
> > access the driver structure after the other thread had done something
> > that caused it to be deallocated, which suggests an error in reference
> > counting.
> >
> 
> The direct cause of this place is because of the refcount error, but the
> root cause is still caused by multiple registrations
> 
> Please refer to the following scenarios.
> 
>            T1                                  T2
> ------------------------------------------------------------------
> usb_gadget_register_driver_owner
>   driver_register                    driver_register
>     driver_find                       driver_find
>     bus_add_driver                    bus_add_driver
>       priv alloced                     <context switch>
>       drv->p = priv;
>       <schedule out>
>       kobject_init_and_add // refcount = 1;
>    //couldn't find an available UDC or it's busy
>    <context switch>
>                                        priv alloced
>                                        drv->priv = priv;
>                                        kobject_init_and_add
>                                          ---> refcount = 1 <------
>                                        // register success
>                                        <context switch>
> ===================== another ioctl/process ======================
>                                       driver_register
>                                        driver_find
>                                         k = kset_find_obj()
>                                          ---> refcount = 2 <------
>                                         <context out>
>    driver_unregister
>    // drv->p become T2's priv
>    ---> refcount = 1 <------
>    <context switch>
>                                         kobject_put(k)
>                                          ---> refcount = 0 <------
>                                         return priv->driver;
>                                         --------UAF here----------

It looks like you've got T2 calling driver_register and driver_find 
twice, but the overall idea is pretty clear.

> There will be UAF in this scenario.
> And all the logs reported by syzbot can be matched to this scenario.

And in any case it is obvious that the patch is necessary.  (Although I 
would have put the new state before the RUNNING state, to reflect the 
actual order in which the states occur.)

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern
