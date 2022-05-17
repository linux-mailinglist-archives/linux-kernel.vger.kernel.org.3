Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8214529665
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 03:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbiEQBAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 21:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiEQBAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 21:00:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2377944A18
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 18:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652749234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=378j+iYEEH5oqWnq5jjHkAR2MvwkVCfL/9+UoMi9JsE=;
        b=G6vD86Ku2xw9xiZgNRp1IjAjB1MZtBZlyOmkrOAFdrrAXKExmdGj0/lV7FL06uzd2AP7CF
        eizHFjetIr8+razIqKBl24ityif2l74Wtdt0TtmXyM/fFH2lQYZxiCLI2A8BxyOMhq1xM5
        OnzNb8tFsSzPVmfeoymX4oGcc5HIxA0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-she8Aj1rMx2PzkuuwKaiIA-1; Mon, 16 May 2022 21:00:33 -0400
X-MC-Unique: she8Aj1rMx2PzkuuwKaiIA-1
Received: by mail-lf1-f70.google.com with SMTP id bp17-20020a056512159100b00472631eb445so7179531lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 18:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=378j+iYEEH5oqWnq5jjHkAR2MvwkVCfL/9+UoMi9JsE=;
        b=kYI+a8v3SVWrewUhGki4GgNpYBrBvhA0bnSBfBeaULfHTzvulW2NIMd1Di6PJHFu1o
         JBNGtkAH8DMX2A4+saa2UHeVJCLon4KjgQdJtbBGOsBI5TPgXUPbyc7qaaTvwT60beJ0
         vK+ZsrMUMMu6AxCBtM5qmb2sMA3izDtpRRReKplnHy9XAHHm1e/U5zZJhHwr4zGxCtUx
         zNCKGKkA7JYgsOS327/PELhvTbAjDWrxcal8/znbjEl25XlhBz6iMEIUWraWAaN6WKpF
         DY4t3yU35ZtN4n/MCUu7gOz1uLFfWOSxd+A47LyJ1Mm3n7ci0QNQmLcNHkv6wIUnxIKy
         MvDw==
X-Gm-Message-State: AOAM5317aN8r8Ti60+gWZ+O941AbcxdhoyKcicHck/rhMC6mIM31nl0L
        CwW2uxgn7JozT8qviX2QydhUpbl0e+V/mPjywwmatyd1SgIn252f3a+sIVGjfEkUM7qWiw7kTa7
        3f6cMuc5VguHKbjUp2tgvXqvAwLBDehTS9Qckw4DK
X-Received: by 2002:a05:651c:89:b0:250:87c9:d4e6 with SMTP id 9-20020a05651c008900b0025087c9d4e6mr13082336ljq.315.1652749231443;
        Mon, 16 May 2022 18:00:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7EN/VoW/ucILliSKJpfc58p1g0pp+q4S3+BbXjx+b7PAbrtD/pWftV+zCozEdqTw8rhhpoAbfMu18Z4Yuu0o=
X-Received: by 2002:a05:651c:89:b0:250:87c9:d4e6 with SMTP id
 9-20020a05651c008900b0025087c9d4e6mr13082319ljq.315.1652749231249; Mon, 16
 May 2022 18:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220507071954.14455-1-jasowang@redhat.com> <875ymd3fd1.fsf@redhat.com>
 <CACGkMEvfkUpsY4LRTuH7w18DZdq+w3=Ef6b-0sG0XvzVUVKdzg@mail.gmail.com>
 <20220511160147.46cbf2fb.pasic@linux.ibm.com> <CACGkMEtaN6tZrwp3rsxu4Hn1Rev2P06X3BaR4X1cqDxnRdPCKg@mail.gmail.com>
 <20220516132006.29d28fbe.pasic@linux.ibm.com> <20220516102425-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220516102425-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 17 May 2022 09:00:20 +0800
Message-ID: <CACGkMEsgNuZE1hnmOBBrBnSk9iMXw+4NosmytNA-h8XULv0Bdg@mail.gmail.com>
Subject: Re: [PATCH V4 0/9] rework on the IRQ hardening of virtio
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
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
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 10:25 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, May 16, 2022 at 01:20:06PM +0200, Halil Pasic wrote:
> > On Thu, 12 May 2022 11:31:08 +0800
> > Jason Wang <jasowang@redhat.com> wrote:
> >
> > > > > It looks to me we need to use write_lock_irq()/write_unlock_irq() to
> > > > > do the synchronization.
> > > > >
> > > > > And we probably need to keep the
> > > > > read_lock_irqsave()/read_lock_irqrestore() logic since I can see the
> > > > > virtio_ccw_int_handler() to be called from process context (e.g from
> > > > > the io_subchannel_quiesce()).
> > > > >
> > > >
> > > > Sounds correct.
> > >
> > > As Cornelia and Vineeth pointed out, all the paths the vring_interrupt
> > > is called with irq disabled.
> > >
> > > So I will use spin_lock()/spin_unlock() in the next version.
> >
> > Can we do some sort of an assertion that if the kernel is built with
> > the corresponding debug features will make sure this assumption holds
> > (and warn if it does not)? That assertion would also document the fact.
>
> Lockdep will do this automatically if you get it wrong, just like it
> did here.
>
> > If an assertion is not possible, I think we should at least place a
> > strategic comment that documents our assumption.
>
> That can't hurt.

I will add some comments here.

Thanks

>
> > Regards,
> > Halil
> >
> > >
> > > Thanks
>

