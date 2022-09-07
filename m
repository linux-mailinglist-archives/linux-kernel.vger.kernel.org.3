Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F14E5AF9B5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 04:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiIGCKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 22:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiIGCKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 22:10:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E5D46228
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 19:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662516606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vx8aKJ5u7qXrqUODw8TKz6yxmbl8ogDCyc6Iz97sTBo=;
        b=LZLDIrQIh5TuK5gKFT2orXbBL+wv1/XbJcucX2/nrCTc1UBo1N10+dfEj4kjdQxnpwmJPl
        Zm0jtLUvgTow8xcKxAKAH4ft9OXuNVmYzS5kJpdkETBuCWmrdcy29XRy/haQ2iQvTqG6uY
        2IBnT7bc6PcRh6+/XNLmQbdEJ193nts=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-513-E9r6vMOgMoqJe7um0pjNhA-1; Tue, 06 Sep 2022 22:10:03 -0400
X-MC-Unique: E9r6vMOgMoqJe7um0pjNhA-1
Received: by mail-ua1-f72.google.com with SMTP id o43-20020ab0596e000000b0038421e4c7deso2375041uad.19
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 19:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Vx8aKJ5u7qXrqUODw8TKz6yxmbl8ogDCyc6Iz97sTBo=;
        b=eUqoB9Y3Suc/7Bfx0Ojr5/eC15M/Mp3gd+nq+NZ2E/J6zrgaLHHmVKqrY0y9KNRuv2
         40qiQ/lwG6ICV2cLPdF4KiriR21tfVmkMRTFd8Igt2Di1MAxoCnj+x4p/x2J+PF9I2pM
         eTjYQYx8PFF/EVYHhof1+CDZWoj9IOXQAjyYUt91HzaGz25qxyOjsFqhKCcWjg/o+Zgx
         5SoFZEQrnCDvwsnTHDZ9dCrtMsjHd8BfRZ/cFOcGtenrVVhSmW+QrwMsqAATq4VdSOpE
         7POdmTfcPrU6DfmgLOFG3XkZ+UaykaFSDCRyqozN1Fvhwq6gbT0as6211pPuSJ6Xp6lM
         1kNQ==
X-Gm-Message-State: ACgBeo0POoLSbG+EoqTSNt8FMdBh0oyE4aV85KN25yBz+Z/V2Wf4Tufw
        Ken3JUVmE8KA926SiLRfeqJb6+P6TE7AZtyqmiOOYyNaGglCxxsBDVP4ou1aRTGBFL8RTfdIog3
        lNGJ/Qy1DOjfrqgzrX2+MmUE/kIRCIP6AM62AXB4+
X-Received: by 2002:a1f:ac83:0:b0:388:9d97:b5a9 with SMTP id v125-20020a1fac83000000b003889d97b5a9mr372668vke.22.1662516603315;
        Tue, 06 Sep 2022 19:10:03 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6DWYAnQkaJlZ6pRhxUd2HGBY/TKQ5iRWCjE1i2eaVKcuP5Gfc+HkgyEEINqKrc6CvdYuEg6AAdXDtCql9/8Vk=
X-Received: by 2002:a1f:ac83:0:b0:388:9d97:b5a9 with SMTP id
 v125-20020a1fac83000000b003889d97b5a9mr372663vke.22.1662516603081; Tue, 06
 Sep 2022 19:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220905045341.66191-1-jasowang@redhat.com> <20220905031405-mutt-send-email-mst@kernel.org>
 <CACGkMEtjQ0Jfok-gcRW+kuinsua2X0TscyTNfBJoXHny0Yob+g@mail.gmail.com> <056ba905a2579903a372258383afdf6579767ad0.camel@redhat.com>
In-Reply-To: <056ba905a2579903a372258383afdf6579767ad0.camel@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 7 Sep 2022 10:09:52 +0800
Message-ID: <CACGkMEuiDqqOEKUWRN9LvQKv8Jz4mi3aSZMwbhUsJkZp=C-0RQ@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: add cond_resched() to the command waiting loop
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Gautam Dawar <gautam.dawar@xilinx.com>,
        davem <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022 at 6:56 PM Paolo Abeni <pabeni@redhat.com> wrote:
>
> On Mon, 2022-09-05 at 15:49 +0800, Jason Wang wrote:
> > On Mon, Sep 5, 2022 at 3:15 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Sep 05, 2022 at 12:53:41PM +0800, Jason Wang wrote:
> > > > Adding cond_resched() to the command waiting loop for a better
> > > > co-operation with the scheduler. This allows to give CPU a breath to
> > > > run other task(workqueue) instead of busy looping when preemption is
> > > > not allowed.
> > > >
> > > > What's more important. This is a must for some vDPA parent to work
> > > > since control virtqueue is emulated via a workqueue for those parents.
> > > >
> > > > Fixes: bda324fd037a ("vdpasim: control virtqueue support")
> > >
> > > That's a weird commit to fix. so it fixes the simulator?
> >
> > Yes, since the simulator is using a workqueue to handle control virtueue.
>
> Uhmm... touching a driver for a simulator's sake looks a little weird.

Simulator is not the only one that is using a workqueue (but should be
the first).

I can see  that the mlx5 vDPA driver is using a workqueue as well (see
mlx5_vdpa_kick_vq()).

And in the case of VDUSE, it needs to wait for the response from the
userspace, this means cond_resched() is probably a must for the case
like UP.

>
> Additionally, if the bug is vdpasim, I think it's better to try to
> solve it there, if possible.
>
> Looking at vdpasim_net_work() and vdpasim_blk_work() it looks like
> neither needs a process context, so perhaps you could rework it to run
> the work_fn() directly from vdpasim_kick_vq(), at least for the control
> virtqueue?

It's possible (but require some rework on the simulator core). But
considering we have other similar use cases, it looks better to solve
it in the virtio-net driver.

Additionally, this may have better behaviour when using for the buggy
hardware (e.g the control virtqueue takes too long to respond). We may
consider switching to use interrupt/sleep in the future (but not
suitable for -net).

Thanks

>
> Thanks!
>
> Paolo
>

