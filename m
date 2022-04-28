Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F0B512B60
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243603AbiD1GUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243605AbiD1GUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:20:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06345532F6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651126648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qQhGtA47NR84b2kaV85amh4Sebyf9NryuvTIfdPeXpA=;
        b=K5bDmTSnZ2E7/XoLjkYPUmvrHp26LDs6R9AhgQLl0RtKnWBF//b8TvJL1CH3tGjIk0AVZD
        Rms3e2W+f2nbyz3lVCHlreXSVaK1nqxDfmdwPk93XrFq2CD2JU5uvvoVVSNgT60M17MlQa
        tmFJlTjqHN7Godo9EYWpQLmg2mu6XyM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-XkX60JfoPbq7ZWGKLkHP3w-1; Thu, 28 Apr 2022 02:17:26 -0400
X-MC-Unique: XkX60JfoPbq7ZWGKLkHP3w-1
Received: by mail-wm1-f71.google.com with SMTP id h65-20020a1c2144000000b0038e9ce3b29cso3912528wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qQhGtA47NR84b2kaV85amh4Sebyf9NryuvTIfdPeXpA=;
        b=Et1B4BrukHVXi8TRl+ACbjNxx9k4PO+ihT6Ps/cd+E15qL+ccSR1ONRNi9EWV6daQx
         3IuCAThS6AyJ3CTyirqDZxTOm+LdLM3nfcjNgPki4egHOE8MpFPjdxVIvtnN4aVYUf7M
         14duMB7fUNph1KhLgqCUZuSrnshP6wn4zQwSlxXmaHSF9nESoLvsHy312aApuPt0kCV/
         l1iq71nUNtRilaXVCALndSJjkfnxqAZpZeHH4ZY8LCMAqt5By45ib2QvdGGxtOaojdMb
         VmqEVclIQ+SVuLDjWn1LonHtWnMmOwsON3cYNad6qwtgbTdzBxUUnd1bT99Kj7XQWjZN
         rylg==
X-Gm-Message-State: AOAM5333NErQm/wcZ0iJXAc+BDX74MG6CVEyaVTzi1xzOyO+NZJGs4G9
        6Mu30PdKewxhUcEkh1RQn2uKGRnBDBhA0lEo+0n2v3yagpLDmocA9lx4Sj40QWL75E7P+KeKeFy
        MGEnKH9u2b+eEFqhEH89IjLsO
X-Received: by 2002:a05:600c:1d9b:b0:393:ffc8:a09b with SMTP id p27-20020a05600c1d9b00b00393ffc8a09bmr6976969wms.40.1651126645654;
        Wed, 27 Apr 2022 23:17:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySt1PmpZpkFkGjb2r3Cu8qgqSGEsGjgTv5m05qjUwHnRW5foby32blg2uMdYADJxt6WCMk5A==
X-Received: by 2002:a05:600c:1d9b:b0:393:ffc8:a09b with SMTP id p27-20020a05600c1d9b00b00393ffc8a09bmr6976935wms.40.1651126645390;
        Wed, 27 Apr 2022 23:17:25 -0700 (PDT)
Received: from redhat.com ([2.53.18.16])
        by smtp.gmail.com with ESMTPSA id o2-20020a5d6482000000b0020a96536fcdsm16391780wri.57.2022.04.27.23.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 23:17:24 -0700 (PDT)
Date:   Thu, 28 Apr 2022 02:17:19 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
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
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <20220428021658-mutt-send-email-mst@kernel.org>
References: <20220425235415-mutt-send-email-mst@kernel.org>
 <87o80n7soq.fsf@redhat.com>
 <20220426124243-mutt-send-email-mst@kernel.org>
 <87ilqu7u6w.fsf@redhat.com>
 <20220428044315.3945e660.pasic@linux.ibm.com>
 <CACGkMEudDf=XXhV2tV+xZ586AnDyrQEotGAiSQZ4k1CTAWHZJQ@mail.gmail.com>
 <20220428012156-mutt-send-email-mst@kernel.org>
 <CACGkMEsd+WHp=LN0BnnDKfzv+nbS2hjgVC-tdemZWuPTc60HBQ@mail.gmail.com>
 <20220428015318-mutt-send-email-mst@kernel.org>
 <CACGkMEutdd=9c-2h5ijMkgUzEqNPtUCXAum7bm8W7a6m62i_Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEutdd=9c-2h5ijMkgUzEqNPtUCXAum7bm8W7a6m62i_Mg@mail.gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 02:02:16PM +0800, Jason Wang wrote:
> On Thu, Apr 28, 2022 at 1:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Apr 28, 2022 at 01:51:59PM +0800, Jason Wang wrote:
> > > On Thu, Apr 28, 2022 at 1:24 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Thu, Apr 28, 2022 at 11:04:41AM +0800, Jason Wang wrote:
> > > > > > But my guess is that rwlock + some testing for the legacy indicator case
> > > > > > just to double check if there is a heavy regression despite of our
> > > > > > expectations to see none should do the trick.
> > > > >
> > > > > I suggest this, rwlock (for not airq) seems better than spinlock, but
> > > > > at worst case it will cause cache line bouncing. But I wonder if it's
> > > > > noticeable (anyhow it has been used for airq).
> > > > >
> > > > > Thanks
> > > >
> > > > Which existing rwlock does airq use right now? Can we take it to sync?
> > >
> > > It's the rwlock in airq_info, it has already been used in this patch.
> > >
> > >                 write_lock(&info->lock);
> > >                 write_unlock(&info->lock);
> > >
> > > But the problem is, it looks to me there could be a case that airq is
> > > not used, (virtio_ccw_int_hander()). That's why the patch use a
> > > spinlock, it could be optimized with using a rwlock as well.
> > >
> > > Thanks
> >
> > Ah, right. So let's take that on the legacy path too and Halil promises
> > to test to make sure performance isn't impacted too badly?
> 
> I think what you meant is using a dedicated rwlock instead of trying
> to reuse one of the airq_info locks.
> 
> If this is true, it should be fine.
> 
> Thanks

yes

> >
> > > >
> > > > --
> > > > MST
> > > >
> >

