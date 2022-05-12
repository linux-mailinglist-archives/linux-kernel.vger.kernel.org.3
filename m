Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F004524370
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 05:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344203AbiELDbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 23:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343673AbiELDb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 23:31:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E28F55348
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 20:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652326282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LUr5X5h8hRE0PnlgrOtChIFOYcrivzITnEPdm8C72JY=;
        b=RrIuWQOCCqMEpgnY58ReSZRpq9GjeoZQCIeiAU+SXwsfxrxWTiOX6QIwOQza/cry9KhOh3
        eOpPnSKTXOliSwJ6WEzZo7mcuwqNKWQHelktOIukJ7POO6eHAsvWJQJ7tSme30Xr7zIbgu
        JJxxUt150QOtRdHHPFGbIhyUxJ+vzQQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-Lff58nqIONaoAyOvYyoRKg-1; Wed, 11 May 2022 23:31:21 -0400
X-MC-Unique: Lff58nqIONaoAyOvYyoRKg-1
Received: by mail-lf1-f71.google.com with SMTP id e10-20020a05651236ca00b00474337bbe36so1637016lfs.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 20:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LUr5X5h8hRE0PnlgrOtChIFOYcrivzITnEPdm8C72JY=;
        b=6LJE2aVQwsRBPed7R5xOZOsx1lDs5vdDIsyFkXG/z83r1Xizm8seZaqZc51iP9h8dv
         SCdTQ0lWEm1H0sMycWRGEp/5ATz1eDr7wHWicNPNcRUIBEPB8ihE+wBVOtPWCIeXk8Fn
         vv5ikGJjL9yZrfoWKXLlkXLbTyQX3vRPm3DVbJU2pWVWBgETXe5xTIvInS2VCux/22I1
         id5EuyJVbXEQKxG/TZ/SWpDKOu0BcmoUkOMvl525JTP3gcRjCT1Sjo8dbfvBr59ruM3r
         8ki7C5d6EbsalHJNXwb2gbiWST3j1QI5llGFCRh+2lIZaihA2/SF0/qltANy8hmsIWPS
         OsVg==
X-Gm-Message-State: AOAM5326oLhCZ2KpQ398hxTDfPVOmBDfp5scLKf/gdLKh7H3vW/lF3N5
        MgZOVO109OIOKcCVqWeLgYQmKHBQ0pF9JapWeTmq6BUODrZDXyc5xp8/RT96U2OKrJIvKttqE9h
        W7rciynPWJFGJ3MFGgWA5SU7jvB2i4ZzhCxjB8se0
X-Received: by 2002:a05:6512:a91:b0:473:bb9e:fc80 with SMTP id m17-20020a0565120a9100b00473bb9efc80mr22777068lfu.471.1652326280138;
        Wed, 11 May 2022 20:31:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxL74hmVi0c35qfwJAdBbA1TQkUse++PX5SHOyzwIoFsRXFU5MORZIllAgA+C0om00e9hUfHj6Tj80AAcL5ffE=
X-Received: by 2002:a05:6512:a91:b0:473:bb9e:fc80 with SMTP id
 m17-20020a0565120a9100b00473bb9efc80mr22777045lfu.471.1652326279972; Wed, 11
 May 2022 20:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220507071954.14455-1-jasowang@redhat.com> <875ymd3fd1.fsf@redhat.com>
 <CACGkMEvfkUpsY4LRTuH7w18DZdq+w3=Ef6b-0sG0XvzVUVKdzg@mail.gmail.com> <20220511160147.46cbf2fb.pasic@linux.ibm.com>
In-Reply-To: <20220511160147.46cbf2fb.pasic@linux.ibm.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 12 May 2022 11:31:08 +0800
Message-ID: <CACGkMEtaN6tZrwp3rsxu4Hn1Rev2P06X3BaR4X1cqDxnRdPCKg@mail.gmail.com>
Subject: Re: [PATCH V4 0/9] rework on the IRQ hardening of virtio
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Cornelia Huck <cohuck@redhat.com>, mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>, eperezma <eperezma@redhat.com>,
        Cindy Lu <lulu@redhat.com>,
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

On Wed, May 11, 2022 at 10:02 PM Halil Pasic <pasic@linux.ibm.com> wrote:
>
> On Wed, 11 May 2022 10:22:59 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
> > >        CPU0
> > >        ----
> > >   lock(&vcdev->irq_lock);
> > >   <Interrupt>
> > >     lock(&vcdev->irq_lock);
> > >
> > >  *** DEADLOCK ***
> >
> > It looks to me we need to use write_lock_irq()/write_unlock_irq() to
> > do the synchronization.
> >
> > And we probably need to keep the
> > read_lock_irqsave()/read_lock_irqrestore() logic since I can see the
> > virtio_ccw_int_handler() to be called from process context (e.g from
> > the io_subchannel_quiesce()).
> >
>
> Sounds correct.

As Cornelia and Vineeth pointed out, all the paths the vring_interrupt
is called with irq disabled.

So I will use spin_lock()/spin_unlock() in the next version.

Thanks

>
> Regards,
> Halil
>

