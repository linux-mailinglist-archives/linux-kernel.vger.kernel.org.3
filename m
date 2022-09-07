Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77025AFDE9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiIGHrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiIGHrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:47:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA6EA7A8F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 00:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662536824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nsmvzDdU873IEoh1AjpLdUk0IkH22pk9o0ERO+Ke0Qs=;
        b=OaqBFTGE871PslXddGnEnYnLUuK0/M8zyYgmuSQRInea1FdXWYYiifSHNgt4Mls9KRMAvx
        qUmvt9z3FFheh39EH+S2O3+GImjGOkEosa9tAg8Us8/Q0s49mLW+ZqFDrXSv0J8bn5xUOV
        zgHMicCuZcD/rsMKaD61M3XIh8ztdRU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-346-NkyXR1TlOha4CNLR5_X1Bg-1; Wed, 07 Sep 2022 03:47:01 -0400
X-MC-Unique: NkyXR1TlOha4CNLR5_X1Bg-1
Received: by mail-ej1-f70.google.com with SMTP id hp14-20020a1709073e0e00b00741a2093c4aso4622219ejc.20
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 00:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=nsmvzDdU873IEoh1AjpLdUk0IkH22pk9o0ERO+Ke0Qs=;
        b=Qu0KXEFWMw6OmnwbiysdVcgWqfgk9YBVK4zoLqyE7Yx4VkU+j1+nBBsQ1eocLbdM3U
         5DuLqPbSqFIGMAin9Hz8jjj320pVc6B83yCVQOgmfUr1rba95s6fhGmokeJ39j6MiRny
         KyuWDl3yLULyDr+kSL6+D8yKrmTHCjEu7h02cWGVlui9h1Rjw4o+vwPQXqEbOpiS1KKe
         XM5wVJM7FNDsRvrZrBxaoXmecAZZ90J8XWcZDeeHSmPNQfAA6RNQTdV4rpFVG/lsk54d
         upzqX4+dpN0MfnP1D8Oc3y6SjP9TBPMkd0BFfw3DmUDZotdV4Ixf3gpVlmTaMdf1/oYV
         4duA==
X-Gm-Message-State: ACgBeo10BEp54qTjxvS8ijA7IXoI+EwUNn80ZO0Mb9BkyxhojfWIem1I
        ej3Qxt+2ecK4GoaDST0TfX4606qVm9HxJ/lxtHY3spwXzxVFkYk+dvqbyfe4mSrx4Wm9xITB5M2
        Te5ZrAPiP2nhgAh03iXSLrilh
X-Received: by 2002:a17:907:75ea:b0:73d:daa0:3cbe with SMTP id jz10-20020a17090775ea00b0073ddaa03cbemr1456175ejc.662.1662536820005;
        Wed, 07 Sep 2022 00:47:00 -0700 (PDT)
X-Google-Smtp-Source: AA6agR53nL8cnG0zY4L4+T4oecAyIfM8opFTzrBVui+uiS85jZRfT6dg9G8YzC/sl54kdM02S1/TMA==
X-Received: by 2002:a17:907:75ea:b0:73d:daa0:3cbe with SMTP id jz10-20020a17090775ea00b0073ddaa03cbemr1456158ejc.662.1662536819797;
        Wed, 07 Sep 2022 00:46:59 -0700 (PDT)
Received: from redhat.com ([2.52.135.118])
        by smtp.gmail.com with ESMTPSA id b9-20020a1709063ca900b0073c82539183sm8022689ejh.91.2022.09.07.00.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 00:46:59 -0700 (PDT)
Date:   Wed, 7 Sep 2022 03:46:55 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Gautam Dawar <gautam.dawar@xilinx.com>,
        davem <davem@davemloft.net>
Subject: Re: [PATCH net] virtio-net: add cond_resched() to the command
 waiting loop
Message-ID: <20220907034407-mutt-send-email-mst@kernel.org>
References: <20220905045341.66191-1-jasowang@redhat.com>
 <20220905031405-mutt-send-email-mst@kernel.org>
 <CACGkMEtjQ0Jfok-gcRW+kuinsua2X0TscyTNfBJoXHny0Yob+g@mail.gmail.com>
 <056ba905a2579903a372258383afdf6579767ad0.camel@redhat.com>
 <CACGkMEuiDqqOEKUWRN9LvQKv8Jz4mi3aSZMwbhUsJkZp=C-0RQ@mail.gmail.com>
 <c9180ac41b00543e3531a343afae8f5bdca64d8d.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9180ac41b00543e3531a343afae8f5bdca64d8d.camel@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 09:07:20AM +0200, Paolo Abeni wrote:
> On Wed, 2022-09-07 at 10:09 +0800, Jason Wang wrote:
> > On Tue, Sep 6, 2022 at 6:56 PM Paolo Abeni <pabeni@redhat.com> wrote:
> > > 
> > > On Mon, 2022-09-05 at 15:49 +0800, Jason Wang wrote:
> > > > On Mon, Sep 5, 2022 at 3:15 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > 
> > > > > On Mon, Sep 05, 2022 at 12:53:41PM +0800, Jason Wang wrote:
> > > > > > Adding cond_resched() to the command waiting loop for a better
> > > > > > co-operation with the scheduler. This allows to give CPU a breath to
> > > > > > run other task(workqueue) instead of busy looping when preemption is
> > > > > > not allowed.
> > > > > > 
> > > > > > What's more important. This is a must for some vDPA parent to work
> > > > > > since control virtqueue is emulated via a workqueue for those parents.
> > > > > > 
> > > > > > Fixes: bda324fd037a ("vdpasim: control virtqueue support")
> > > > > 
> > > > > That's a weird commit to fix. so it fixes the simulator?
> > > > 
> > > > Yes, since the simulator is using a workqueue to handle control virtueue.
> > > 
> > > Uhmm... touching a driver for a simulator's sake looks a little weird.
> > 
> > Simulator is not the only one that is using a workqueue (but should be
> > the first).
> > 
> > I can see  that the mlx5 vDPA driver is using a workqueue as well (see
> > mlx5_vdpa_kick_vq()).
> > 
> > And in the case of VDUSE, it needs to wait for the response from the
> > userspace, this means cond_resched() is probably a must for the case
> > like UP.
> > 
> > > 
> > > Additionally, if the bug is vdpasim, I think it's better to try to
> > > solve it there, if possible.
> > > 
> > > Looking at vdpasim_net_work() and vdpasim_blk_work() it looks like
> > > neither needs a process context, so perhaps you could rework it to run
> > > the work_fn() directly from vdpasim_kick_vq(), at least for the control
> > > virtqueue?
> > 
> > It's possible (but require some rework on the simulator core). But
> > considering we have other similar use cases, it looks better to solve
> > it in the virtio-net driver.
> 
> I see.
> 
> > Additionally, this may have better behaviour when using for the buggy
> > hardware (e.g the control virtqueue takes too long to respond). We may
> > consider switching to use interrupt/sleep in the future (but not
> > suitable for -net).
> 
> Agreed. Possibly a timeout could be useful, too.
> 
> Cheers,
> 
> Paolo


Hmm timeouts are kind of arbitrary.
regular drivers basically derive them from hardware
behaviour but with a generic driver like virtio it's harder.
I guess we could add timeout as a config field, have
device make a promise to the driver.

Making the wait interruptible seems more reasonable.

-- 
MST

