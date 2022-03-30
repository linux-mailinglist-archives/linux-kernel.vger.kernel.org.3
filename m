Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52E84EBA7A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 07:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243061AbiC3Fz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 01:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbiC3FzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 01:55:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BA99BCA9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 22:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648619614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SiJN+ilVZ4I67/S1tYHmk8OsCjr1KyukiifyvUBRqz8=;
        b=OmmVuw01qo/RwyeqZ1wmbH/BsW+h7i3ws2fJqV0UKzt11G6CJ6X6V2f/KWGANOYk0ZhLTs
        8LMHa/Dummpdi0y8mQRa6cmmA+Svv7FacoU7KHdUcWWEfNxEQA5r6ZT8YKIKbZbkIjnsY3
        c5suPLjqPZAYp1KkdysXTfTu963J//M=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-bmDtkvcoN1-CvsaS_2nDLQ-1; Wed, 30 Mar 2022 01:53:31 -0400
X-MC-Unique: bmDtkvcoN1-CvsaS_2nDLQ-1
Received: by mail-lf1-f71.google.com with SMTP id bt40-20020a056512262800b004481fbe2d29so6123764lfb.16
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 22:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SiJN+ilVZ4I67/S1tYHmk8OsCjr1KyukiifyvUBRqz8=;
        b=xJmNTWknF1TZjYmn/bLcUj1f6CtY+IiRy0leYLz6glgc2Zd4FBlBTtbC30UfCIUC5y
         9jwLWX+ft3jnCLNPLtJEA4XKgpkdlyCHzAaKHTh24NKVMddA7XpT86BDpM6IQgl0Bbnx
         KTo1UPcz4VO+GUrh3+1k4icSvUKahPaC239bmfPfaQhGz5qlotTtzJC+lEtkkCV3kyNt
         /MFYPd23N1nLJ97yR4Goy/qfwZJ8uNgIt511cHPK7VArkWzdbsyN7wbo6AA8bgUQBBM8
         lRd/yB9KnTpC8hW/uP3JHtvb4p1RU1uyGkJtbB5JyX/NLhwCDP4PvV6m21f/h0D5EDwE
         6jLg==
X-Gm-Message-State: AOAM532gIWFGuyyaAxpRRO0cl6uSMklO/7YzLv9LUwrVQn9qZDLGgn05
        y/6jyF3bmKZB12wG71FjF06zozb7Bect8vyLWHVjcDRp0L1qE5J19WJz7mmOBL/OgRGuYuSBQhq
        zWZqACtmWKSdg83cFumdEL8iOIodIQqvdDaSzHysx
X-Received: by 2002:a05:651c:b0c:b0:247:e4b7:d4a0 with SMTP id b12-20020a05651c0b0c00b00247e4b7d4a0mr5481706ljr.177.1648619610377;
        Tue, 29 Mar 2022 22:53:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJximUtRievmpSEKXGB135CLUMN3LHkErjpMQdk2DotSEFBtM7XBqy5ZoLLyIftc/DHz3FjQd+e/ovEu9mxXO+k=
X-Received: by 2002:a05:651c:b0c:b0:247:e4b7:d4a0 with SMTP id
 b12-20020a05651c0b0c00b00247e4b7d4a0mr5481696ljr.177.1648619610146; Tue, 29
 Mar 2022 22:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220325060659-mutt-send-email-mst@kernel.org>
 <CACGkMEu4mRfNbJXJtAFzhyd55fD7phUDKnVtYW0aqRnQmT_bYw@mail.gmail.com>
 <20220328015757-mutt-send-email-mst@kernel.org> <CACGkMEu+fax6YYwhfbc1yoSxv6o1FTQyrOheVTmUfqGvmbAEfA@mail.gmail.com>
 <20220328062452-mutt-send-email-mst@kernel.org> <87fsn1f96e.ffs@tglx>
 <20220329100859-mutt-send-email-mst@kernel.org> <87v8vweie2.ffs@tglx>
 <20220329175426-mutt-send-email-mst@kernel.org> <CACGkMEv2j2cJkSFfxTmaRxJ+SH6actSCZsALjvvDUPgg0h-KeA@mail.gmail.com>
 <20220330010646-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220330010646-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 30 Mar 2022 13:53:18 +0800
Message-ID: <CACGkMEuObEd7Gov2AH6Ch0VjAvn5=2MBcC2V3_FkriZULVfpcQ@mail.gmail.com>
Subject: Re:
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Keir Fraser <keirf@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 1:09 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Mar 30, 2022 at 10:38:06AM +0800, Jason Wang wrote:
> > On Wed, Mar 30, 2022 at 6:04 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Mar 29, 2022 at 08:13:57PM +0200, Thomas Gleixner wrote:
> > > > On Tue, Mar 29 2022 at 10:37, Michael S. Tsirkin wrote:
> > > > > On Tue, Mar 29, 2022 at 10:35:21AM +0200, Thomas Gleixner wrote:
> > > > > We are trying to fix the driver since at the moment it does not
> > > > > have the dev->ok flag at all.
> > > > >
> > > > > And I suspect virtio is not alone in that.
> > > > > So it would have been nice if there was a standard flag
> > > > > replacing the driver-specific dev->ok above, and ideally
> > > > > would also handle the case of an interrupt triggering
> > > > > too early by deferring the interrupt until the flag is set.
> > > > >
> > > > > And in fact, it does kind of exist: IRQF_NO_AUTOEN, and you would call
> > > > > enable_irq instead of dev->ok = true, except
> > > > > - it doesn't work with affinity managed IRQs
> > > > > - it does not work with shared IRQs
> > > > >
> > > > > So using dev->ok as you propose above seems better at this point.
> > > >
> > > > Unless there is a big enough amount of drivers which could make use of a
> > > > generic mechanism for that.
> > > >
> > > > >> If any driver does this in the wrong order, then the driver is
> > > > >> broken.
> > > > >
> > > > > I agree, however:
> > > > > $ git grep synchronize_irq `git grep -l request_irq drivers/net/`|wc -l
> > > > > 113
> > > > > $ git grep -l request_irq drivers/net/|wc -l
> > > > > 397
> > > > >
> > > > > I suspect there are more drivers which in theory need the
> > > > > synchronize_irq dance but in practice do not execute it.
> > > >
> > > > That really depends on when the driver requests the interrupt, when
> > > > it actually enables the interrupt in the device itself
> > >
> > > This last point does not matter since we are talking about protecting
> > > against buggy/malicious devices. They can inject the interrupt anyway
> > > even if driver did not configure it.
> > >
> > > > and how the
> > > > interrupt service routine works.
> > > >
> > > > So just doing that grep dance does not tell much. You really have to do
> > > > a case by case analysis.
> > > >
> > > > Thanks,
> > > >
> > > >         tglx
> > >
> > >
> > > I agree. In fact, at least for network the standard approach is to
> > > request interrupts in the open call, virtio net is unusual
> > > in doing it in probe. We should consider changing that.
> > > Jason?
> >
> > This probably works only for virtio-net and it looks like not trivial
> > since we don't have a specific core API to request interrupts.
> >
> > Thanks
>
> We'll need a new API, for sure. E.g.  find vqs with no
> callback on probe, and then virtio_request_vq_callbacks separately.
>
> The existing API that specifies callbacks during find vqs
> can be used by other drivers.

Ok, I will do it.

Thanks

>
> > >
> > > --
> > > MST
> > >
>

