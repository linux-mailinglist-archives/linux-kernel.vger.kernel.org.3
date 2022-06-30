Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E23561258
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 08:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbiF3GPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 02:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiF3GPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 02:15:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8395D17A96
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 23:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656569749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LIyFvGXQvIKAI2Jhy0fL/iiZlXHvPxpCNakI+DBgKxw=;
        b=Oj5hDNo457W+uKz6jL4UmZ4Tfm2xgjOWQhPjbwYKStXi+Bd8ABZLFiHBxS5muFhfDYE0TM
        1T2FFAA25TLAz6zQbug5N4ZuRFH48/7owz4IX5nvAAPUPn1cNkzQ15jBjTZQV0Ej79qTAl
        UrwGkh3GdWJZyZmV9l0qcwMB87wXv4Q=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-498-JPJNM5mFM_GCxKw2801UxA-1; Thu, 30 Jun 2022 02:15:46 -0400
X-MC-Unique: JPJNM5mFM_GCxKw2801UxA-1
Received: by mail-lj1-f198.google.com with SMTP id u23-20020a2ea177000000b0025baf70f8a9so2394783ljl.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 23:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LIyFvGXQvIKAI2Jhy0fL/iiZlXHvPxpCNakI+DBgKxw=;
        b=xlBdqhdbQQ3qoAFAljWNtkCzKNNyxV+Zuz0SpHnwJtXryrhIpFqswf17PgwDjOBVpj
         b14LxQ3sqgczQlPkzSc3kE9xW2K6ojN1iM/wdyaS7rfdWtA5TdstoaDfZmd26Xe5l+4s
         Rkh2SMJkdbdifzSBDMuh25N7GhK0s0eCRkPQPRtxiTxKdRoXx6tr5UUKH1NRJHTNBH42
         43zJUXHmERS6PsBXSS3RIr1lFHIcs0Z17db1pFndpxOL7B/VWNtxxtxzlvpyHMPdeUVY
         XOgJ5txApJny8EQmgX5Rfy4YbQ+aM3msi8lOXhJLFl0iv7mGiUD61BS+P6YGRsI3vZXU
         zWIQ==
X-Gm-Message-State: AJIora+wROJekfHagCrO0sRCuwG1okMfGSYbQGEw7/Px9AE2ZbbOdhLa
        IN94WwA9/QwZXnroGNWeDyGWc6g4+FN7buy1lvkJ1qm4Z5HBnPKuJwpf+RRlJcjWciJW/Iulnug
        o4HlfumDnBzM+y6LJ979HinxszBDEQHGl9ZtiZNyT
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id y15-20020a0565123f0f00b0047f6f890326mr4399320lfa.124.1656569745187;
        Wed, 29 Jun 2022 23:15:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v9F/GK133FdytfbR7+VKwUYTi9oxNuF4wHt+M3JrgxraaO6yUp+b9CrmJzoGnM9JrETOQ19IVwMr6oaFTKAMk=
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id
 y15-20020a0565123f0f00b0047f6f890326mr4399309lfa.124.1656569745030; Wed, 29
 Jun 2022 23:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220630020805.74658-1-jasowang@redhat.com> <20220629195123.610eed9f@kernel.org>
 <CACGkMEs216-WJCSE7mwSHx+zmaNDJa9HCjhnRMWOpZrhJcauNg@mail.gmail.com>
In-Reply-To: <CACGkMEs216-WJCSE7mwSHx+zmaNDJa9HCjhnRMWOpZrhJcauNg@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 30 Jun 2022 14:15:34 +0800
Message-ID: <CACGkMEuLnBR+e08juTO3mA9fj=r8-QL_iioP3-rjLH9L-fXhrQ@mail.gmail.com>
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

On Thu, Jun 30, 2022 at 2:07 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Thu, Jun 30, 2022 at 10:51 AM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Thu, 30 Jun 2022 10:08:04 +0800 Jason Wang wrote:
> > > +static void enable_refill_work(struct virtnet_info *vi)
> > > +{
> > > +     spin_lock(&vi->refill_lock);
> > > +     vi->refill_work_enabled = true;
> > > +     spin_unlock(&vi->refill_lock);
> > > +}
> > > +
> > > +static void disable_refill_work(struct virtnet_info *vi)
> > > +{
> > > +     spin_lock(&vi->refill_lock);
> > > +     vi->refill_work_enabled = false;
> > > +     spin_unlock(&vi->refill_lock);
> > > +}
> > > +
> > >  static void virtqueue_napi_schedule(struct napi_struct *napi,
> > >                                   struct virtqueue *vq)
> > >  {
> > > @@ -1527,8 +1547,12 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
> > >       }
> > >
> > >       if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
> > > -             if (!try_fill_recv(vi, rq, GFP_ATOMIC))
> > > -                     schedule_delayed_work(&vi->refill, 0);
> > > +             if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
> > > +                     spin_lock(&vi->refill_lock);
> > > +                     if (vi->refill_work_enabled)
> > > +                             schedule_delayed_work(&vi->refill, 0);
> > > +                     spin_unlock(&vi->refill_lock);
> >
> > Are you sure you can use the basic spin_lock() flavor in all cases?
> > Isn't the disable/enable called from a different context than this
> > thing here?
>
> This function will only be called in bh so it's safe.

Ok, so it looks like we should use the bh variant in close. Otherwise
we may have a deadlock. Will fix it.

Thanks

>
> >
> > The entire delayed work construct seems a little risky because the work
> > may go to sleep after disabling napi, causing large latency spikes.
>
> Yes, but it only happens on OOM.
>
> > I guess you must have a good reason no to simply reschedule the NAPI
> > and keep retrying with GFP_ATOMIC...
>
> Less pressure on the memory allocator on OOM probably, but it looks
> like an independent issue that might be optimized in the future.
>
> >
> > Please add the target tree name to the subject.
>
> Ok
>
> Thanks
>
> >

