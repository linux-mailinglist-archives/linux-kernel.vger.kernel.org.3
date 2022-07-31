Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AA4585F3A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 16:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237093AbiGaORO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 10:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiGaORL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 10:17:11 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 91482DEC9
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 07:17:09 -0700 (PDT)
Received: (qmail 544533 invoked by uid 1000); 31 Jul 2022 10:17:08 -0400
Date:   Sun, 31 Jul 2022 10:17:08 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alexey Klimov <klimov.linux@gmail.com>,
        Oliver Neukum <oneukum@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        USB list <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        atishp@rivosinc.com, atishp@atishpatra.org,
        Yury Norov <yury.norov@gmail.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Aaron Tomlin <atomlin@redhat.com>
Subject: Re: [PATCH v5] watchdog: add driver for StreamLabs USB watchdog
 device
Message-ID: <YuaO5Gx84zonjq7X@rowland.harvard.edu>
References: <20220725030605.1808710-1-klimov.linux@gmail.com>
 <Yt5Zn9cXDe9/F9RJ@kroah.com>
 <CALW4P+Kd_XdvzGfA=Cmtu0c=kEHfhp2pph2Wh0Sa8Fm8GxDRTA@mail.gmail.com>
 <7770401d-fe3d-bda4-a2e2-55cd004a2d07@suse.com>
 <CALW4P++5ahRdK6WvghPgpPcTuoJyezU_=s6MG2nn4OBRWZYGXQ@mail.gmail.com>
 <20220731082055.GA4008925@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220731082055.GA4008925@roeck-us.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2022 at 01:20:55AM -0700, Guenter Roeck wrote:
> On Sun, Jul 31, 2022 at 03:34:16AM +0100, Alexey Klimov wrote:
> > On Tue, Jul 26, 2022 at 8:48 AM Oliver Neukum <oneukum@suse.com> wrote:
> > >
> > > On 26.07.22 02:21, Alexey Klimov wrote:
> > > > On Mon, Jul 25, 2022 at 9:51 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >>
> > > >> On Mon, Jul 25, 2022 at 04:06:05AM +0100, Alexey Klimov wrote:
> > > >
> > > > [..]
> > > >
> > > >> Anyway, driver looks good to me, nice work!
> > > >>
> > > >> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > >
> > > > Thanks, Greg. If you don't mind I'll use your tag in next version
> > > > after making changes suggested by Guenter since there will be no
> > > > significant functional changes. If code will change a lot, then the
> > > > process (Documentation/process/submitting-patches.rst) will require me
> > > > to drop the tag.
> > >
> > > Hi,
> > >
> > > while thinking about this a question arose. How does this
> > > device react to a USB reset? A watchdog that can be disabled
> > > by a simple reset does not like very reliable to me.
> > > Do you need to implement pre/post_reset() ?
> > 
> > You're right. Upon reset the watchdog is disabled even if it was active before.
> > Adding empty ->pre_reset() and ->post_reset() helps to avoid that, but
> > looking at Documentation and other drivers it seems that I need to do:
> > in pre_reset():
> > mutex_lock() to block any other I/O to the usb device;
> > __usb_streamlabs_wdt_cmd(STOP) to stop the watchdog;
> > and do not unlock the mutex;
> > 
> > in post_reset():
> > if (watchdog_active())
> >         __usb_streamlabs_wdt_cmd(START);
> > mutex_unlock() to allow other's I/O to the usb deivce.
> > 
> > Seems right?
> > 
> Not necessarily. Is other code doing something similar ?
> Using a mutex like this creates the risk for hung tasks.

Are mutexes intended to be used in situations where one function 
acquires the lock, then returns, and then a different function releases 
the lock?  I'm not sure about this.

Perhaps a good old semaphore would be more appropriate.  But it's clear 
that I/O to the device does need to be mutually exclusive with resets, 
one way or another.

Alan Stern
