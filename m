Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66508512B2B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 07:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243431AbiD1F7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 01:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243393AbiD1F6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 01:58:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C5527C798
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 22:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651125320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zgRDxje8lznBc9+MD1tXV7m51++4qJtjj5+PFYkzgUw=;
        b=ZKeTWDSuUlG3rRl2WcGUhk1VBZeJ2xMvob0JVOdnsWIseZmlCtHWcAPgM4Xdzbw5cJPFV+
        08Q/Xb4JEORKV3FgMTw3tiXCljABre5eXpwNdAPYoUsLI90xnxy1N8v9zfdaXSF2VVeykn
        dZN81kLUJt1InpbYQfzlDrXhhCWDTqI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-ZBpi3B9yMfuPHWHELz4yeg-1; Thu, 28 Apr 2022 01:55:18 -0400
X-MC-Unique: ZBpi3B9yMfuPHWHELz4yeg-1
Received: by mail-wr1-f72.google.com with SMTP id j21-20020adfa555000000b0020adb9ac14fso1511699wrb.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 22:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zgRDxje8lznBc9+MD1tXV7m51++4qJtjj5+PFYkzgUw=;
        b=DZqHo/XCDeZ49vpuOS4w4XtdLwYoxIrEJMkuhYHWEjl2Xo1MmftpojaLCygKnmcObj
         TTpvVnrl5E3G7JpeL64w2rjt1nAvQYo7FaTW16tgiofyFA+Pw89/Q65bkpxdcoaBGbJR
         mCWodzkLbp2ih1v8ZVpBwawjEz4930ue3gbGq87BniZqcEdGlga7N/BMfOs/lGAcMSYF
         Q6vd5PEprhZPpIR0VZisgJat7rQV/D9ULk+pq1UMpSi9PQ3joWkYmr42Yy3Bh6POCtfa
         TWa5otTJF4KRNCXYJXwLypS7vrz8NaBpjwENt/TdtA+39QOAeLSVnIs1r8/aK4cyGzOS
         nRTQ==
X-Gm-Message-State: AOAM5329qFv37ERKK6k9HvqelBD2gqku1xexAi7MikTsqJ4WvUYrW86x
        o9TACC7ZclY6Ee5pjrkM/ndVKLA5K5/hUfXORrY424MGp3UrpBzdxUpQBZwkFf6Dupsj6BTXLH1
        WEpRrN5ywL0MiAxWWNlTFZWAA
X-Received: by 2002:a7b:c5d0:0:b0:389:fe85:3d79 with SMTP id n16-20020a7bc5d0000000b00389fe853d79mr38726723wmk.77.1651125317366;
        Wed, 27 Apr 2022 22:55:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQWgQ7NzqEU9cQw2Mx4ZanfKZ/GYh96JpvrJZ3jPrVl9wOjeb9azjXMZoITgzaDPdWoxaVSA==
X-Received: by 2002:a7b:c5d0:0:b0:389:fe85:3d79 with SMTP id n16-20020a7bc5d0000000b00389fe853d79mr38726696wmk.77.1651125317023;
        Wed, 27 Apr 2022 22:55:17 -0700 (PDT)
Received: from redhat.com ([2.53.18.16])
        by smtp.gmail.com with ESMTPSA id f1-20020a1c6a01000000b0038c9f6a3634sm2997790wmc.7.2022.04.27.22.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 22:55:16 -0700 (PDT)
Date:   Thu, 28 Apr 2022 01:55:12 -0400
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
Message-ID: <20220428015318-mutt-send-email-mst@kernel.org>
References: <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
 <20220425235134-mutt-send-email-mst@kernel.org>
 <20220425235415-mutt-send-email-mst@kernel.org>
 <87o80n7soq.fsf@redhat.com>
 <20220426124243-mutt-send-email-mst@kernel.org>
 <87ilqu7u6w.fsf@redhat.com>
 <20220428044315.3945e660.pasic@linux.ibm.com>
 <CACGkMEudDf=XXhV2tV+xZ586AnDyrQEotGAiSQZ4k1CTAWHZJQ@mail.gmail.com>
 <20220428012156-mutt-send-email-mst@kernel.org>
 <CACGkMEsd+WHp=LN0BnnDKfzv+nbS2hjgVC-tdemZWuPTc60HBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEsd+WHp=LN0BnnDKfzv+nbS2hjgVC-tdemZWuPTc60HBQ@mail.gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 01:51:59PM +0800, Jason Wang wrote:
> On Thu, Apr 28, 2022 at 1:24 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Apr 28, 2022 at 11:04:41AM +0800, Jason Wang wrote:
> > > > But my guess is that rwlock + some testing for the legacy indicator case
> > > > just to double check if there is a heavy regression despite of our
> > > > expectations to see none should do the trick.
> > >
> > > I suggest this, rwlock (for not airq) seems better than spinlock, but
> > > at worst case it will cause cache line bouncing. But I wonder if it's
> > > noticeable (anyhow it has been used for airq).
> > >
> > > Thanks
> >
> > Which existing rwlock does airq use right now? Can we take it to sync?
> 
> It's the rwlock in airq_info, it has already been used in this patch.
> 
>                 write_lock(&info->lock);
>                 write_unlock(&info->lock);
> 
> But the problem is, it looks to me there could be a case that airq is
> not used, (virtio_ccw_int_hander()). That's why the patch use a
> spinlock, it could be optimized with using a rwlock as well.
> 
> Thanks

Ah, right. So let's take that on the legacy path too and Halil promises
to test to make sure performance isn't impacted too badly?

> >
> > --
> > MST
> >

