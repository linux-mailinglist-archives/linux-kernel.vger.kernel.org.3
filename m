Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC52A5AC592
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 19:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbiIDRGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 13:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiIDRGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 13:06:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEF22CDD2;
        Sun,  4 Sep 2022 10:05:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A4CC60FBD;
        Sun,  4 Sep 2022 17:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5011C433D6;
        Sun,  4 Sep 2022 17:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662311158;
        bh=CePVn9u7PkOpHXPo/gBA1OjwQOJGxP0zYwkHdGW41uo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uxN5TxU8ujKBqEzFDoKZ63rhjF/hhX5YVVv7ywXUq+YqTn6p7rS45KZ4PU54nnNvU
         wtylYt55FeNpYfiLOGCrXyEqtvJZCkKbGKn9q1DI3SfD1b8Ja/84lqirNrIUG76d67
         7hg7rcV9hO5hT6BDwI1s33oZERol1WNCaBLV1cu5+dc9PX2M3g4UFVDlMa2J8tOxpj
         5bcGTbcqsD6j6GrvtFaaPhZ+U+F5VsITykc8RtTcm2BuCKsrR9/mN8GmC9W+OuFOxa
         9iRQ1Ja435KVITO4s+rTF8IL/M+vmTBe+++RIXa2VBLupjDWo1lqS2lDDLQBkPxMBl
         cJF3BH7K3gvGw==
Date:   Sun, 4 Sep 2022 17:31:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>, kernel@axis.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Ranostay <mranostay@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: Use per-device lockdep class for mlock
Message-ID: <20220904173150.2d9cdfe4@jic23-huawei>
In-Reply-To: <CAHp75Vd2q13864ynhSCvPXAGH3fFeSrcQYWL3eMHm4HY8Ujqzg@mail.gmail.com>
References: <20220829091840.2791846-1-vincent.whitchurch@axis.com>
        <CAHp75Vd2q13864ynhSCvPXAGH3fFeSrcQYWL3eMHm4HY8Ujqzg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Aug 2022 13:27:54 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Aug 29, 2022 at 12:18 PM Vincent Whitchurch
> <vincent.whitchurch@axis.com> wrote:
> >
> > If an IIO driver uses callbacks from another IIO driver and calls
> > iio_channel_start_all_cb() from one of its buffer setup ops, then
> > lockdep complains due to the lock nesting, as in the below example with
> > lmp91000.
> >
> > Since the locks are being taken on different IIO devices, there is no
> > actual deadlock.  Fix the warning by telling lockdep to use a different
> > class for each iio_device.
> >
> >  ============================================
> >  WARNING: possible recursive locking detected
> >  --------------------------------------------
> >  python3/23 is trying to acquire lock:
> >  (&indio_dev->mlock){+.+.}-{3:3}, at: iio_update_buffers
> >
> >  but task is already holding lock:
> >  (&indio_dev->mlock){+.+.}-{3:3}, at: enable_store
> >
> >  other info that might help us debug this:
> >   Possible unsafe locking scenario:
> >
> >         CPU0
> >         ----
> >    lock(&indio_dev->mlock);
> >    lock(&indio_dev->mlock);
> >
> >   *** DEADLOCK ***
> >
> >   May be due to missing lock nesting notation
> >
> >  5 locks held by python3/23:
> >   #0: (sb_writers#5){.+.+}-{0:0}, at: ksys_write
> >   #1: (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter
> >   #2: (kn->active#14){.+.+}-{0:0}, at: kernfs_fop_write_iter
> >   #3: (&indio_dev->mlock){+.+.}-{3:3}, at: enable_store
> >   #4: (&iio_dev_opaque->info_exist_lock){+.+.}-{3:3}, at: iio_update_buffers
> >
> >  Call Trace:
> >   __mutex_lock
> >   iio_update_buffers
> >   iio_channel_start_all_cb
> >   lmp91000_buffer_postenable
> >   __iio_update_buffers
> >   enable_store  
> 
> 
> This looks much better than the previous version, thanks!
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> > Fixes: 67e17300dc1d76 ("iio: potentiostat: add LMP91000 support")
> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Given we only have one known effected driver (and that has other issues),
I'm going to take this the slow route and queue it up for next merge window.

Applied to the togreg branch of iio.git and pushed out as testing for
0-day to poke at it.

Thanks,

Jonathan

> > ---
> >
> > Notes:
> >     v2:
> >     - Use a different lockdep class for each iio_device, instead of using
> >       mutex_lock_nested.
> >     - Add fixes tag pointing to first IIO driver which used this API.
> >     - Trim call stack in commit message.
> >
> >  drivers/iio/industrialio-core.c | 5 +++++
> >  include/linux/iio/iio-opaque.h  | 2 ++
> >  2 files changed, 7 insertions(+)
> >
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index 0f4dbda3b9d3..921d8e8643a2 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -1621,6 +1621,8 @@ static void iio_dev_release(struct device *device)
> >
> >         iio_device_detach_buffers(indio_dev);
> >
> > +       lockdep_unregister_key(&iio_dev_opaque->mlock_key);
> > +
> >         ida_free(&iio_ida, iio_dev_opaque->id);
> >         kfree(iio_dev_opaque);
> >  }
> > @@ -1680,6 +1682,9 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
> >         INIT_LIST_HEAD(&iio_dev_opaque->buffer_list);
> >         INIT_LIST_HEAD(&iio_dev_opaque->ioctl_handlers);
> >
> > +       lockdep_register_key(&iio_dev_opaque->mlock_key);
> > +       lockdep_set_class(&indio_dev->mlock, &iio_dev_opaque->mlock_key);
> > +
> >         return indio_dev;
> >  }
> >  EXPORT_SYMBOL(iio_device_alloc);
> > diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
> > index 6b3586b3f952..d1f8b30a7c8b 100644
> > --- a/include/linux/iio/iio-opaque.h
> > +++ b/include/linux/iio/iio-opaque.h
> > @@ -11,6 +11,7 @@
> >   *                             checked by device drivers but should be considered
> >   *                             read-only as this is a core internal bit
> >   * @driver_module:             used to make it harder to undercut users
> > + * @mlock_key:                 lockdep class for iio_dev lock
> >   * @info_exist_lock:           lock to prevent use during removal
> >   * @trig_readonly:             mark the current trigger immutable
> >   * @event_interface:           event chrdevs associated with interrupt lines
> > @@ -42,6 +43,7 @@ struct iio_dev_opaque {
> >         int                             currentmode;
> >         int                             id;
> >         struct module                   *driver_module;
> > +       struct lock_class_key           mlock_key;
> >         struct mutex                    info_exist_lock;
> >         bool                            trig_readonly;
> >         struct iio_event_interface      *event_interface;
> > --
> > 2.34.1
> >  
> 
> 

