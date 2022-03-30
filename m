Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196594EB9E1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 07:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242759AbiC3FL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 01:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238349AbiC3FLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 01:11:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 644D19681C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 22:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648616973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eeYUD3XUajeRCNs/Vt/JYditXRCKbb5+uzBVBz/FB5c=;
        b=ZAG+WCEkw7kfmeQTywAr/yeGpGkijngbLDw++aAMUDx1kKEUZwSsvfQIQXYExzX46fFOmN
        UeCUzmYlnDYdOUDgpc4MMkJ8IWyJGppALOPm0HY0F7THQSsbLhBFW0EszpAlnwG/ZrG8MF
        xC/0H/l+//0UTnQLebfhsFwzhz2GDzs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-yMe8Dnm-OXSy5lWFsjfVng-1; Wed, 30 Mar 2022 01:09:31 -0400
X-MC-Unique: yMe8Dnm-OXSy5lWFsjfVng-1
Received: by mail-wm1-f70.google.com with SMTP id c62-20020a1c3541000000b003815245c642so559379wma.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 22:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eeYUD3XUajeRCNs/Vt/JYditXRCKbb5+uzBVBz/FB5c=;
        b=xl23I5HeE0bZJqH2PvIIztf5H83C8e82AXT05Ya/piYdDEF1zua00yoQ8e8glqY05b
         G/Gl6g2QEmgLn/EbTuiQYLYOOX3o9/KrnUUUbM7UgJw/2V7MqnX0CovgqUkDI05TnkX1
         SZcOz4CjGXjf6Z+AK0IqwZbOMqrrVzPyAijHpkj/xNJswWgUh8+nGq9gjXhoId00L0oL
         15w0yfO3ljRHBlVL8FendE9jadzSmUE9pQVaz+gPMidryuqnhG/a2tJBfTu69X+o2C4W
         +00B1rifoQcnGgSrAlE72Wdk0nGPndIjni5N/EKokk5aQCSU1Y3Aff2m6E9nmkmPnfi+
         BTUg==
X-Gm-Message-State: AOAM530pt20GS8YNXqDhsa6svWG4iXmh5/U277DNaLNRPOPRSGm1n+2U
        7gGefUsl7/4PRWCVQJPFmzqr3mP0lwJXkEHp0vq2Y5PGJPqFP2EJ7ZApzApKHYXrUZ9rYWBVtow
        kPIAm00KeZ/q7hwkXux1UI7GS
X-Received: by 2002:adf:908e:0:b0:1e7:bea7:3486 with SMTP id i14-20020adf908e000000b001e7bea73486mr33607451wri.401.1648616970764;
        Tue, 29 Mar 2022 22:09:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgm9skh/llpKb0wahMYt3d2fhdEpF8cYwvjfeh9spYqrd2U2SWbZElaXEnLNn1Y8P45g2Flg==
X-Received: by 2002:adf:908e:0:b0:1e7:bea7:3486 with SMTP id i14-20020adf908e000000b001e7bea73486mr33607435wri.401.1648616970488;
        Tue, 29 Mar 2022 22:09:30 -0700 (PDT)
Received: from redhat.com ([2.52.9.207])
        by smtp.gmail.com with ESMTPSA id az26-20020adfe19a000000b00204154a1d1fsm16140858wrb.88.2022.03.29.22.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 22:09:29 -0700 (PDT)
Date:   Wed, 30 Mar 2022 01:09:24 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Keir Fraser <keirf@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re:
Message-ID: <20220330010646-mutt-send-email-mst@kernel.org>
References: <20220325060659-mutt-send-email-mst@kernel.org>
 <CACGkMEu4mRfNbJXJtAFzhyd55fD7phUDKnVtYW0aqRnQmT_bYw@mail.gmail.com>
 <20220328015757-mutt-send-email-mst@kernel.org>
 <CACGkMEu+fax6YYwhfbc1yoSxv6o1FTQyrOheVTmUfqGvmbAEfA@mail.gmail.com>
 <20220328062452-mutt-send-email-mst@kernel.org>
 <87fsn1f96e.ffs@tglx>
 <20220329100859-mutt-send-email-mst@kernel.org>
 <87v8vweie2.ffs@tglx>
 <20220329175426-mutt-send-email-mst@kernel.org>
 <CACGkMEv2j2cJkSFfxTmaRxJ+SH6actSCZsALjvvDUPgg0h-KeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEv2j2cJkSFfxTmaRxJ+SH6actSCZsALjvvDUPgg0h-KeA@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 10:38:06AM +0800, Jason Wang wrote:
> On Wed, Mar 30, 2022 at 6:04 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Mar 29, 2022 at 08:13:57PM +0200, Thomas Gleixner wrote:
> > > On Tue, Mar 29 2022 at 10:37, Michael S. Tsirkin wrote:
> > > > On Tue, Mar 29, 2022 at 10:35:21AM +0200, Thomas Gleixner wrote:
> > > > We are trying to fix the driver since at the moment it does not
> > > > have the dev->ok flag at all.
> > > >
> > > > And I suspect virtio is not alone in that.
> > > > So it would have been nice if there was a standard flag
> > > > replacing the driver-specific dev->ok above, and ideally
> > > > would also handle the case of an interrupt triggering
> > > > too early by deferring the interrupt until the flag is set.
> > > >
> > > > And in fact, it does kind of exist: IRQF_NO_AUTOEN, and you would call
> > > > enable_irq instead of dev->ok = true, except
> > > > - it doesn't work with affinity managed IRQs
> > > > - it does not work with shared IRQs
> > > >
> > > > So using dev->ok as you propose above seems better at this point.
> > >
> > > Unless there is a big enough amount of drivers which could make use of a
> > > generic mechanism for that.
> > >
> > > >> If any driver does this in the wrong order, then the driver is
> > > >> broken.
> > > >
> > > > I agree, however:
> > > > $ git grep synchronize_irq `git grep -l request_irq drivers/net/`|wc -l
> > > > 113
> > > > $ git grep -l request_irq drivers/net/|wc -l
> > > > 397
> > > >
> > > > I suspect there are more drivers which in theory need the
> > > > synchronize_irq dance but in practice do not execute it.
> > >
> > > That really depends on when the driver requests the interrupt, when
> > > it actually enables the interrupt in the device itself
> >
> > This last point does not matter since we are talking about protecting
> > against buggy/malicious devices. They can inject the interrupt anyway
> > even if driver did not configure it.
> >
> > > and how the
> > > interrupt service routine works.
> > >
> > > So just doing that grep dance does not tell much. You really have to do
> > > a case by case analysis.
> > >
> > > Thanks,
> > >
> > >         tglx
> >
> >
> > I agree. In fact, at least for network the standard approach is to
> > request interrupts in the open call, virtio net is unusual
> > in doing it in probe. We should consider changing that.
> > Jason?
> 
> This probably works only for virtio-net and it looks like not trivial
> since we don't have a specific core API to request interrupts.
> 
> Thanks

We'll need a new API, for sure. E.g.  find vqs with no
callback on probe, and then virtio_request_vq_callbacks separately.

The existing API that specifies callbacks during find vqs
can be used by other drivers.

> >
> > --
> > MST
> >

