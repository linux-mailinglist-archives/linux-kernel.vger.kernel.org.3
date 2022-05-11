Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFB6522EDE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbiEKI7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235806AbiEKI7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:59:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA2421238BA
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652259542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yoGeyphSepardEf41QcL1JLghov0W4AMX9bIl+aH1nM=;
        b=WRyseyoDqfKfH9LTuVI0tdnOZAT8B6X5UFmTK0KxsV1FxnMe3Uh7j1gnGlAQZYTO5sXyY/
        eUdXi57+WibhXd7UyuDNSvbwBY3gZbfngptZ1KtwpYg8dDtWjkPipr0tWVAmk48EPpbsYq
        6shUKbWmVCExGh1hZFRREgVozwXN/DY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-mWHAn0IWOc-qbViinQxNMA-1; Wed, 11 May 2022 04:58:58 -0400
X-MC-Unique: mWHAn0IWOc-qbViinQxNMA-1
Received: by mail-lf1-f70.google.com with SMTP id n3-20020ac242c3000000b00473d8af3a0cso548304lfl.21
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yoGeyphSepardEf41QcL1JLghov0W4AMX9bIl+aH1nM=;
        b=BPsWSZ2LfAOXi0y3ehOo2S4ydSSsBA0q/FEwQnTd0TLVItYHq7klChqSCOtwwd1jyN
         heTZF4qGtXBM5821yS1T6bTdYWQq9GlSfYxpZ9NunYsWCKZgCrqKz/F/Dvyz7yCdk5+C
         XxzwnxGZSkwyoEmDTDmsnJRRLcxgkJQ6g6MgB5rw/L4mDNYiMwfD1THtCMY93yvCA3m7
         sYsZrqngg7bQn9F3ZFP5RGDgK/Pg6NRMOU1oSfeblLgv2H5yW3DpdOmkh6/WFqTeJwhf
         IPLB0e7BQscgAJAhSf8oLlFiwKMglGEP40EPqa3vhzCv23d7zOxgtKPQqQ6O/zZiMEuK
         9psw==
X-Gm-Message-State: AOAM530i8H3DNy8bXcpwox80ZDN3EtjMYdKO3RLh2B9QKF5ZTyf5cLyd
        dvo9bcwMgfRMPUyauHoMEYD6iup5pGdPjxzGaFDqNnhpiCI8HvXOjzEDOGiPV5VrEQwIxXGjpNP
        LbFpT/HKVwetk5qLaW8zgAT7AxD7vv9Rx2Jf4NiLI
X-Received: by 2002:ac2:4e14:0:b0:474:1f4d:9b86 with SMTP id e20-20020ac24e14000000b004741f4d9b86mr12432602lfr.257.1652259536940;
        Wed, 11 May 2022 01:58:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhoUKK046Hk4wwh632lBSQIvz0Gb2nt3PwbE+4jQq+SUbuyBn9aimQzYyODOcHcNl99FU4YVjonRabwAYO/Xg=
X-Received: by 2002:ac2:4e14:0:b0:474:1f4d:9b86 with SMTP id
 e20-20020ac24e14000000b004741f4d9b86mr12432585lfr.257.1652259536769; Wed, 11
 May 2022 01:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220507071954.14455-1-jasowang@redhat.com> <20220507071954.14455-7-jasowang@redhat.com>
 <20220510072451-mutt-send-email-mst@kernel.org> <CACGkMEvWFyEqeeXYEmbU4TWtnj9Ku6J7jLK_7MueuFvpR7FiGg@mail.gmail.com>
 <87r150bi0d.fsf@redhat.com>
In-Reply-To: <87r150bi0d.fsf@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 11 May 2022 16:58:45 +0800
Message-ID: <CACGkMEtPk9P4KhJ5wTOLj9CZoKDx9-X_5uLRVBag692x4s9SrA@mail.gmail.com>
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
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
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

On Wed, May 11, 2022 at 4:17 PM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Wed, May 11 2022, Jason Wang <jasowang@redhat.com> wrote:
>
> > On Tue, May 10, 2022 at 7:28 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >>
> >> On Sat, May 07, 2022 at 03:19:51PM +0800, Jason Wang wrote:
> >> > @@ -1106,6 +1130,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> >> >                       vcdev->err = -EIO;
> >> >       }
> >> >       virtio_ccw_check_activity(vcdev, activity);
> >> > +     read_lock_irqsave(&vcdev->irq_lock, flags);
> >> >       for_each_set_bit(i, indicators(vcdev),
> >> >                        sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
> >> >               /* The bit clear must happen before the vring kick. */
> >>
> >> Cornelia sent a lockdep trace on this.
> >>
> >> Basically I think this gets the irqsave/restore logic wrong.
> >> It attempts to disable irqs in the handler (which is an interrupt
> >> anyway).
> >
> > The reason I use irqsave/restore is that it can be called from process
> > context (if I was not wrong), e.g from io_subchannel_quiesce().
>
> io_subchannel_quiesce() should disable interrupts, though? Otherwise, it
> would be a bug.

Right, it was protected by a spin_lock_irq(), but I can see other
cdev->handler() in e.g device_fsm.c, the irq status is not obvious, do
they have the same assumption which IRQ is disabled?

Thanks

>

