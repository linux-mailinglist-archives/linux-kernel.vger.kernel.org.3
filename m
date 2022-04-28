Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E700512B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243438AbiD1GFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235749AbiD1GFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:05:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AB85954B5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651125753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/5SY8yHPHy/pd09osroiZ4JJ60QVRx9AaMSzsMSnZg0=;
        b=WHHpZtkekhdCq1meR41v48Iugb8KzXs38+cYdRBd6TQNVNCpqvWdKfR+uu60Z+m07k/U2p
        ny0p15N4UKFQD/5efghillQfExCxVltgXDn2AYaPp+Zhz8YhAHtb3sTUODH9ktebTPjVCy
        Wo4gcyL2ONlDiBv3U1nu/4dsBsLnpLY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-ROjyFHUPOb-dNRswOufZkA-1; Thu, 28 Apr 2022 02:02:29 -0400
X-MC-Unique: ROjyFHUPOb-dNRswOufZkA-1
Received: by mail-lj1-f199.google.com with SMTP id q7-20020a2e8747000000b0024f2d363986so874728ljj.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/5SY8yHPHy/pd09osroiZ4JJ60QVRx9AaMSzsMSnZg0=;
        b=kYVAfWsOl5flDrCB0XhxWx1v2NaFqAVkkaH1RVXgYCChEHhVxwJkIUugTiyDRZB7dO
         lPmHyBSYVMtl+/LrVOOoT5NLkb3rPYQKmfzq84ahs5vWhwsbdVjmrooKN+z+M/fHbKgG
         LKCpTKVgNrdnwoMO/O51gXPXEblQ/oELxTQoGsHqkn5aUajtCUjzHH4kYcq9ayZoctlC
         6SA4TlBwrKmywb4r5WKA/WdWVGHI4o1/EIiYsE6YZeYWbWJBEyfiDrU0Bjw3asBSlT9o
         RdYIEXJ0BxmTrqkCZyVhlReURSho817uQ5uMS3UtLdY1Rfj/XifCWtIXo4unwZGF3+D7
         rvIg==
X-Gm-Message-State: AOAM532ZjGYTkmEmwKLqACMwFVWWkwJQ4b1rgrcvUpZineIFYrHz3IdP
        8VbDo7ypqpKb/I7o2SxTDR9ppbZ6ZtgLf+RYffLgydda8IKbTGfSq3qScKAZKTSG7KvENN3r/Sa
        A1H1lmJcew5R5sBaQnIl4DvqJ+z0HvsGPzPp5LqUU
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id p21-20020a056512139500b00446d38279a5mr22536224lfa.210.1651125748104;
        Wed, 27 Apr 2022 23:02:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzp2288/pYYhrDOFWzIzoQhfpAS0zeFfu2hhkegIQPrVXhgtyHbnKjeiooiOiAvB8lDIDAJm5uK4StybvuAgbo=
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id
 p21-20020a056512139500b00446d38279a5mr22536206lfa.210.1651125747905; Wed, 27
 Apr 2022 23:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
 <20220425235134-mutt-send-email-mst@kernel.org> <20220425235415-mutt-send-email-mst@kernel.org>
 <87o80n7soq.fsf@redhat.com> <20220426124243-mutt-send-email-mst@kernel.org>
 <87ilqu7u6w.fsf@redhat.com> <20220428044315.3945e660.pasic@linux.ibm.com>
 <CACGkMEudDf=XXhV2tV+xZ586AnDyrQEotGAiSQZ4k1CTAWHZJQ@mail.gmail.com>
 <20220428012156-mutt-send-email-mst@kernel.org> <CACGkMEsd+WHp=LN0BnnDKfzv+nbS2hjgVC-tdemZWuPTc60HBQ@mail.gmail.com>
 <20220428015318-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220428015318-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 28 Apr 2022 14:02:16 +0800
Message-ID: <CACGkMEutdd=9c-2h5ijMkgUzEqNPtUCXAum7bm8W7a6m62i_Mg@mail.gmail.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 1:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Apr 28, 2022 at 01:51:59PM +0800, Jason Wang wrote:
> > On Thu, Apr 28, 2022 at 1:24 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Thu, Apr 28, 2022 at 11:04:41AM +0800, Jason Wang wrote:
> > > > > But my guess is that rwlock + some testing for the legacy indicator case
> > > > > just to double check if there is a heavy regression despite of our
> > > > > expectations to see none should do the trick.
> > > >
> > > > I suggest this, rwlock (for not airq) seems better than spinlock, but
> > > > at worst case it will cause cache line bouncing. But I wonder if it's
> > > > noticeable (anyhow it has been used for airq).
> > > >
> > > > Thanks
> > >
> > > Which existing rwlock does airq use right now? Can we take it to sync?
> >
> > It's the rwlock in airq_info, it has already been used in this patch.
> >
> >                 write_lock(&info->lock);
> >                 write_unlock(&info->lock);
> >
> > But the problem is, it looks to me there could be a case that airq is
> > not used, (virtio_ccw_int_hander()). That's why the patch use a
> > spinlock, it could be optimized with using a rwlock as well.
> >
> > Thanks
>
> Ah, right. So let's take that on the legacy path too and Halil promises
> to test to make sure performance isn't impacted too badly?

I think what you meant is using a dedicated rwlock instead of trying
to reuse one of the airq_info locks.

If this is true, it should be fine.

Thanks

>
> > >
> > > --
> > > MST
> > >
>

