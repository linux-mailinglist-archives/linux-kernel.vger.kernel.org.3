Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4264522F68
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiEKJ2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235938AbiEKJ2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:28:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D39951053CC
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652261305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fnj3eCg7s0TS1ramQcFiuiKen3jow8jquS3FS71SHPU=;
        b=JVKo/laJclZuOYvJ0E/rKaF6sxuVu7hXeZC8ZG1pw/Utsvi7ihCMN6mL1V9S+gsgyxC+Tb
        lzPAbSI/YsKR2HvRB9/uwItAyqdLVjUR+qHX7ngAlGFHCBkSkQWsRp2QpEpp+zXHb9qteZ
        c7eALQCPG+zwLgUYAIXYnwi4gjEqYyg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-TxdCz70UOt6lystG6d0Z2w-1; Wed, 11 May 2022 05:28:24 -0400
X-MC-Unique: TxdCz70UOt6lystG6d0Z2w-1
Received: by mail-lf1-f69.google.com with SMTP id n3-20020ac242c3000000b00473d8af3a0cso576699lfl.21
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fnj3eCg7s0TS1ramQcFiuiKen3jow8jquS3FS71SHPU=;
        b=qsBvTRSwoCTp9quIr8XR0k2wd+U+hl9nGfKfnF+UunIQpWJmc/IgI8AfAbw9hrH+yA
         JBzV2ev07dWOvb6gPRPiid6kH5vhNJh1l2STkt2TPSNJIyU51soRYzty/82TSJ3DHecc
         nHhMpUifU9Q7UlQuvSZ+T87qR1DK9BLuIRBukdtHDolSwoUMTsZkwmLTweCVDeoIiV+1
         VN3TIl3p6YLJjEHuz3UeZFNq6maExp2u51T45JWr9DnhCH1hN3CHWNCCeGmMR79W6+KR
         g+WgoMH8QCsHHwaWFy+zEuCDn7nLdEW9vrhXudJbguCMk380mxD3AZmhF4/kgwMTQ4RG
         QQnw==
X-Gm-Message-State: AOAM533+1/C+V8eHF41cgpr9oyqYRITWJnn3nqpqAnwMJcPHDwqQV2os
        jA142F2ijfYlkOB1e79k+IyWREoM+jJYxwh9h56Ikcac73UfxEKlydih1ZPUj/QpnhziLIE/VFd
        F/da/ya7bk7LBRcy/Dnq/cG7S3qbLb/q3DKBFsMaB
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id p21-20020a056512139500b00446d38279a5mr18757583lfa.210.1652261303108;
        Wed, 11 May 2022 02:28:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziEsE0wruGYH+kUCMRRSImc8q7QCatle/uLfreXdxbIWtU4dwTUYlK/rx6iWNQiOJla5rpc0/Sn+mLSDLqQ1Y=
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id
 p21-20020a056512139500b00446d38279a5mr18757555lfa.210.1652261302901; Wed, 11
 May 2022 02:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220507071954.14455-1-jasowang@redhat.com> <20220507071954.14455-7-jasowang@redhat.com>
 <20220510072451-mutt-send-email-mst@kernel.org> <CACGkMEvWFyEqeeXYEmbU4TWtnj9Ku6J7jLK_7MueuFvpR7FiGg@mail.gmail.com>
 <87r150bi0d.fsf@redhat.com> <CACGkMEtPk9P4KhJ5wTOLj9CZoKDx9-X_5uLRVBag692x4s9SrA@mail.gmail.com>
 <87lev8bffh.fsf@redhat.com>
In-Reply-To: <87lev8bffh.fsf@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 11 May 2022 17:28:11 +0800
Message-ID: <CACGkMEviB6-SmJmbV3h2zhaTwnep=WQLdnHXRc6D+UUxRXijfg@mail.gmail.com>
Subject: Re: [PATCH V4 6/9] virtio-ccw: implement synchronize_cbs()
To:     Cornelia Huck <cohuck@redhat.com>
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
        Vineeth Vijayan <vneethv@linux.ibm.com>,
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

On Wed, May 11, 2022 at 5:13 PM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Wed, May 11 2022, Jason Wang <jasowang@redhat.com> wrote:
>
> > On Wed, May 11, 2022 at 4:17 PM Cornelia Huck <cohuck@redhat.com> wrote:
> >>
> >> On Wed, May 11 2022, Jason Wang <jasowang@redhat.com> wrote:
> >>
> >> > On Tue, May 10, 2022 at 7:28 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >> >>
> >> >> On Sat, May 07, 2022 at 03:19:51PM +0800, Jason Wang wrote:
> >> >> > @@ -1106,6 +1130,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> >> >> >                       vcdev->err = -EIO;
> >> >> >       }
> >> >> >       virtio_ccw_check_activity(vcdev, activity);
> >> >> > +     read_lock_irqsave(&vcdev->irq_lock, flags);
> >> >> >       for_each_set_bit(i, indicators(vcdev),
> >> >> >                        sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
> >> >> >               /* The bit clear must happen before the vring kick. */
> >> >>
> >> >> Cornelia sent a lockdep trace on this.
> >> >>
> >> >> Basically I think this gets the irqsave/restore logic wrong.
> >> >> It attempts to disable irqs in the handler (which is an interrupt
> >> >> anyway).
> >> >
> >> > The reason I use irqsave/restore is that it can be called from process
> >> > context (if I was not wrong), e.g from io_subchannel_quiesce().
> >>
> >> io_subchannel_quiesce() should disable interrupts, though? Otherwise, it
> >> would be a bug.
> >
> > Right, it was protected by a spin_lock_irq(), but I can see other
> > cdev->handler() in e.g device_fsm.c, the irq status is not obvious, do
> > they have the same assumption which IRQ is disabled?
>
> Yes, that should be the case for any invocations via the fsm as well.
>

Ok.

> It's been some time since I've worked on that part of the code, though,
> so let's cc: the s390 cio maintainers so that they can speak up if I'm
> wrong.

Ok, I will do that.

Thanks

>

