Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCD752436B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 05:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245519AbiELD35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 23:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238977AbiELD3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 23:29:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DF38694A0
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 20:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652326192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oiuB6/1rpu58Tvln0nC0vsy2jP9iWIIb82ww3FDDrRc=;
        b=CzFUDnJDGhEZEOgBrhOo53SWe0HaEhTrRxeluhaBRNGllZj28Gad+zdyPdoiMeZBKB6OuP
        lLx/nvg6HV3XtowELRx8UFJt4sOJiwuRUURx4hgdrDu3R7vm7kwkGWjw+oH8H1AvFBJ+pi
        QhUJ8ImLePAsxdSNSU3jVmRW5R/eOaA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446-4pvC43NQOcGaElhv1usf_Q-1; Wed, 11 May 2022 23:29:51 -0400
X-MC-Unique: 4pvC43NQOcGaElhv1usf_Q-1
Received: by mail-lf1-f71.google.com with SMTP id bq15-20020a056512150f00b00473a2e132a5so1632385lfb.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 20:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oiuB6/1rpu58Tvln0nC0vsy2jP9iWIIb82ww3FDDrRc=;
        b=h3oB0kMhy5+ZZpbTQr7rRyInXBJYp0ZRTIqb5vpepAjP7ymMs0TT37qH9+Pwftj3fC
         uoMvMe6L4ubz0/dMvUuaQ9aqj9jddYgbSTvyTFMzsQMaj3/ganX9WUEbMRarX4uNu0VV
         XdZuVmhyvRfDwCDJTMVuTZNHlN30h3gT/rGvyxKWGBYjG9psFCM3f+fTUoPp+v2oKHXW
         S1Cf5AnZEWd3Z5cwlFE9TZIpJLInE+qeHGdafwj9i2fPOLPlZE8nSeym11UjEs9ENzMx
         r4wGDScCbIgjc117NqUHlgky0UeV0oQzkKKElP+ItVdoq7eXtnl2hxshj7euJ3kJYMdF
         Yrgw==
X-Gm-Message-State: AOAM5320ox6w5o9wN5M0SHqKbZAXsQMtCIoae9lp7AAYy3eIrDU2H5qo
        5EtI8AGfD3q9Bouc/2X5JQzWAqPdfOp8bfulBcO2Nj69f14ADkn12QX3khICUk0ZYMLESNljQ6a
        768uwJUGoiKAp9EZmIOkTYgBtJSDC7Cfkppfk/Jlx
X-Received: by 2002:a05:651c:89:b0:250:87c9:d4e6 with SMTP id 9-20020a05651c008900b0025087c9d4e6mr19554530ljq.315.1652326189666;
        Wed, 11 May 2022 20:29:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvGZl7k97bjA3gCsBTaYT9EmgeyM3io1yNju3NEal0LqRm3HelICd4QB0dYrDMJ/jB6zAA972jJiPUWWm1pPU=
X-Received: by 2002:a05:651c:89:b0:250:87c9:d4e6 with SMTP id
 9-20020a05651c008900b0025087c9d4e6mr19554516ljq.315.1652326189448; Wed, 11
 May 2022 20:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220507071954.14455-1-jasowang@redhat.com> <20220507071954.14455-7-jasowang@redhat.com>
 <20220510072451-mutt-send-email-mst@kernel.org> <CACGkMEvWFyEqeeXYEmbU4TWtnj9Ku6J7jLK_7MueuFvpR7FiGg@mail.gmail.com>
 <87r150bi0d.fsf@redhat.com> <CACGkMEtPk9P4KhJ5wTOLj9CZoKDx9-X_5uLRVBag692x4s9SrA@mail.gmail.com>
 <87lev8bffh.fsf@redhat.com> <CACGkMEviB6-SmJmbV3h2zhaTwnep=WQLdnHXRc6D+UUxRXijfg@mail.gmail.com>
 <YnvNmtPgip5knLHP@tuxmaker.boeblingen.de.ibm.com>
In-Reply-To: <YnvNmtPgip5knLHP@tuxmaker.boeblingen.de.ibm.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 12 May 2022 11:29:38 +0800
Message-ID: <CACGkMEuMXMTcV7TF7qje5z2H6sXqShcWRRMVatFh5yneDfPwgA@mail.gmail.com>
Subject: Re: [PATCH V4 6/9] virtio-ccw: implement synchronize_cbs()
To:     Vineeth Vijayan <vneethv@linux.ibm.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 10:52 PM Vineeth Vijayan <vneethv@linux.ibm.com> wrote:
>
> On Wed, May 11, 2022 at 05:28:11PM +0800, Jason Wang wrote:
> > On Wed, May 11, 2022 at 5:13 PM Cornelia Huck <cohuck@redhat.com> wrote:
> > >
> > > On Wed, May 11 2022, Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > > On Wed, May 11, 2022 at 4:17 PM Cornelia Huck <cohuck@redhat.com> wrote:
> > > >>
> > > >> On Wed, May 11 2022, Jason Wang <jasowang@redhat.com> wrote:
> > > >>
> > > >> > On Tue, May 10, 2022 at 7:28 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >> >>
> > > >> >> On Sat, May 07, 2022 at 03:19:51PM +0800, Jason Wang wrote:
> > > >> >> > @@ -1106,6 +1130,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> > > >> >> >                       vcdev->err = -EIO;
> > > >> >> >       }
> > > >> >> >       virtio_ccw_check_activity(vcdev, activity);
> > > >> >> > +     read_lock_irqsave(&vcdev->irq_lock, flags);
> > > >> >> >       for_each_set_bit(i, indicators(vcdev),
> > > >> >> >                        sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
> > > >> >> >               /* The bit clear must happen before the vring kick. */
> > > >> >>
> > > >> >> Cornelia sent a lockdep trace on this.
> > > >> >>
> > > >> >> Basically I think this gets the irqsave/restore logic wrong.
> > > >> >> It attempts to disable irqs in the handler (which is an interrupt
> > > >> >> anyway).
> > > >> >
> > > >> > The reason I use irqsave/restore is that it can be called from process
> > > >> > context (if I was not wrong), e.g from io_subchannel_quiesce().
> > > >>
> > > >> io_subchannel_quiesce() should disable interrupts, though? Otherwise, it
> > > >> would be a bug.
> > > >
> > > > Right, it was protected by a spin_lock_irq(), but I can see other
> > > > cdev->handler() in e.g device_fsm.c, the irq status is not obvious, do
> > > > they have the same assumption which IRQ is disabled?
> > >
> > > Yes, that should be the case for any invocations via the fsm as well.
> > >
> >
> > Ok.
> >
> > > It's been some time since I've worked on that part of the code, though,
> > > so let's cc: the s390 cio maintainers so that they can speak up if I'm
> > > wrong.
> >
> > Ok, I will do that.
> >
> > Thanks
> >
> > >
> Thank you Corny to looking in to this. I agree, the cdev->handler is
> called with lock held. And as you mentioned, in the fsm these handler
> invocations are done with IRQ disabled, which will otherwise end up in a
> deadlock.
> thanks.
>

Thanks a lot for the confirmation, I will use
spin_lock()/spin_unlock() in the next version.

