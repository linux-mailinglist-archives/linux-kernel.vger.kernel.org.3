Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E550561243
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 08:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbiF3GIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 02:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiF3GII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 02:08:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 329262E6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 23:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656569285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Huizft4b5megN+LHZsenyqxTACpN6BbdhFtJNkNbRWk=;
        b=NRVkQzMspbimpDQq1yeamJPQyYnQEnl6uDSEF1aEIaTNuoubkSOzqo0TLdk2Ro0dQy1omv
        zrtTRAuZe8M5kQyEKh0yPIhwASzaNq7OFtwmr782/2cCiBF7SHRQly8fuTmdbPJdTiAnY+
        VjBHZnHDbwKALlt6w0jpOBr/B34+QjU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-nk1da5_tNem3QOvl7mz7PA-1; Thu, 30 Jun 2022 02:08:03 -0400
X-MC-Unique: nk1da5_tNem3QOvl7mz7PA-1
Received: by mail-lj1-f198.google.com with SMTP id u23-20020a2ea177000000b0025baf70f8a9so2388150ljl.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 23:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Huizft4b5megN+LHZsenyqxTACpN6BbdhFtJNkNbRWk=;
        b=PGMUFGMBpNvT48gcrF/opzSSCB9G4eXupuOo5o0jsPql1nvGd7qltuzlwvGvQcjzUt
         Wb6p4nOJYGpd8klmJiiQiPE8EZbjfbqJjQQgVuYtKSmu9+F3lfcvi3Sz/DtnAFS+dZMK
         EnS0q8g99+0b4hT4krUr7faKkSBDyjboScnawEYp1cAfVlLsaBRiqno7FHjeiGmHU0Cl
         +YEDHi7h/+Ii0CMia0aUOEeLJttnVFZwnu1naku80yI8OG53qSMli3lWzvecDDKGR+Vm
         ihoXezmWnqyobucIflKt+xlC9sfZ6i09OiqizS6ldbQe88AfMbcBsfEGqAIDrnEWinjs
         4+DA==
X-Gm-Message-State: AJIora9YUypUdAg/tmKpkv7MEVz1mSyt4RV8zKsFOvC70PCH58GTTQ0u
        +j1tXnPDlYAA9QYY/2T/tybMbZl1kGKWZDnHzXMYmhFQDjb6Zk44vxdHalrn2Z8RjQiwbRuNWiU
        ZcAQmAlNelokWMF7YISXCe02rR3IIafC4inWtiSzt
X-Received: by 2002:ac2:51a5:0:b0:47f:79a1:5c02 with SMTP id f5-20020ac251a5000000b0047f79a15c02mr4454358lfk.575.1656569281442;
        Wed, 29 Jun 2022 23:08:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uSvw4QQdRBK/4iZ/CcyTLMfOSwTOHod2+FXhilsKg5Tz+kGG+P8P47yjnOyH8kpypV5rbVce7k78pE5S9GJ6I=
X-Received: by 2002:ac2:51a5:0:b0:47f:79a1:5c02 with SMTP id
 f5-20020ac251a5000000b0047f79a15c02mr4454336lfk.575.1656569281122; Wed, 29
 Jun 2022 23:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220630020805.74658-1-jasowang@redhat.com> <20220629195123.610eed9f@kernel.org>
In-Reply-To: <20220629195123.610eed9f@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 30 Jun 2022 14:07:50 +0800
Message-ID: <CACGkMEs216-WJCSE7mwSHx+zmaNDJa9HCjhnRMWOpZrhJcauNg@mail.gmail.com>
Subject: Re: [PATCH V2] virtio-net: fix the race between refill work and close
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     mst <mst@redhat.com>, davem <davem@davemloft.net>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 10:51 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 30 Jun 2022 10:08:04 +0800 Jason Wang wrote:
> > +static void enable_refill_work(struct virtnet_info *vi)
> > +{
> > +     spin_lock(&vi->refill_lock);
> > +     vi->refill_work_enabled = true;
> > +     spin_unlock(&vi->refill_lock);
> > +}
> > +
> > +static void disable_refill_work(struct virtnet_info *vi)
> > +{
> > +     spin_lock(&vi->refill_lock);
> > +     vi->refill_work_enabled = false;
> > +     spin_unlock(&vi->refill_lock);
> > +}
> > +
> >  static void virtqueue_napi_schedule(struct napi_struct *napi,
> >                                   struct virtqueue *vq)
> >  {
> > @@ -1527,8 +1547,12 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
> >       }
> >
> >       if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
> > -             if (!try_fill_recv(vi, rq, GFP_ATOMIC))
> > -                     schedule_delayed_work(&vi->refill, 0);
> > +             if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
> > +                     spin_lock(&vi->refill_lock);
> > +                     if (vi->refill_work_enabled)
> > +                             schedule_delayed_work(&vi->refill, 0);
> > +                     spin_unlock(&vi->refill_lock);
>
> Are you sure you can use the basic spin_lock() flavor in all cases?
> Isn't the disable/enable called from a different context than this
> thing here?

This function will only be called in bh so it's safe.

>
> The entire delayed work construct seems a little risky because the work
> may go to sleep after disabling napi, causing large latency spikes.

Yes, but it only happens on OOM.

> I guess you must have a good reason no to simply reschedule the NAPI
> and keep retrying with GFP_ATOMIC...

Less pressure on the memory allocator on OOM probably, but it looks
like an independent issue that might be optimized in the future.

>
> Please add the target tree name to the subject.

Ok

Thanks

>

