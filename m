Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAB75AFD17
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiIGHH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiIGHH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:07:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97288607E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 00:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662534445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z/+HSxg5tcrvz/CJsTFm78OgI3pQS+e1F1DHw+MtS9w=;
        b=KXcRa1g3KPFgchF75CO46nQ68jxqnCWV4wsEnielsa9YzwdNlys9Gd2n6a7e1zPu5F0x43
        8W2ZFv86QK7cZJOqSw+QHFkH8MSLNkaAg3096ulKQF/HQMLWqgH1tRFfcUmlJIZ2LtmkXH
        3ATukdqg3/z/iw8QWTn847eI8kwKf3k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-624-XcqE4jytOJ2U3CwM5VxhRA-1; Wed, 07 Sep 2022 03:07:23 -0400
X-MC-Unique: XcqE4jytOJ2U3CwM5VxhRA-1
Received: by mail-wr1-f71.google.com with SMTP id b17-20020adfc751000000b00228732b437aso2567865wrh.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 00:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=z/+HSxg5tcrvz/CJsTFm78OgI3pQS+e1F1DHw+MtS9w=;
        b=DDo0aDFYTv747H+GP8jE1BN03r5fe24iDtli9q/gGfzpswpx5ko5mCNNDDNbOl97V0
         ZSgyaXyu9pFpdXkvMwzxEzgLFZoN4yEbxlYjO1kLnfoQqcZu/ITKSxcN2+D6+7hUCMvw
         7D2D0ZHUtbenQK1ngayOstLWIcFb0issdyJqBdv19fsPieMZXuMyovUMojHOoh2e4U3E
         xzQs3h0Xyht50owR8bQYO/E5hHrS94CEeKwgw2ImEDSkeCamgBt13e9puHFoWPUi9YkV
         gnUHG422Ar+yRji9MUU1dopWLDMo0VnG2h33Mm+3aHYeKXgbXavYYTRZwloT83l7FTH+
         PkOw==
X-Gm-Message-State: ACgBeo3fta08vGxN0SHTNu8HTnjQ0rA1gwRFUdLtRvlrWHfUDFoJb16f
        B0Bvl+n9XuUnJHMuQDjRof7EK49HU7bg9YeOEcweSWfpnULTUF6jWpH4szudfZjtv2pihwZkAxF
        o5bcVsKGeYAX82bnYiIjmsoa+
X-Received: by 2002:a05:6000:178e:b0:220:635f:eb13 with SMTP id e14-20020a056000178e00b00220635feb13mr1090932wrg.634.1662534442057;
        Wed, 07 Sep 2022 00:07:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR49NwluFNkfmL/l1sDW03NqaJvOQWjUhRUW2teBAjXK1WwZOvJMJQqIMKJkY8eq21o01mwfig==
X-Received: by 2002:a05:6000:178e:b0:220:635f:eb13 with SMTP id e14-20020a056000178e00b00220635feb13mr1090919wrg.634.1662534441847;
        Wed, 07 Sep 2022 00:07:21 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-112-72.dyn.eolo.it. [146.241.112.72])
        by smtp.gmail.com with ESMTPSA id ay19-20020a05600c1e1300b003a50924f1c0sm18241872wmb.18.2022.09.07.00.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 00:07:21 -0700 (PDT)
Message-ID: <c9180ac41b00543e3531a343afae8f5bdca64d8d.camel@redhat.com>
Subject: Re: [PATCH net] virtio-net: add cond_resched() to the command
 waiting loop
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Gautam Dawar <gautam.dawar@xilinx.com>,
        davem <davem@davemloft.net>
Date:   Wed, 07 Sep 2022 09:07:20 +0200
In-Reply-To: <CACGkMEuiDqqOEKUWRN9LvQKv8Jz4mi3aSZMwbhUsJkZp=C-0RQ@mail.gmail.com>
References: <20220905045341.66191-1-jasowang@redhat.com>
         <20220905031405-mutt-send-email-mst@kernel.org>
         <CACGkMEtjQ0Jfok-gcRW+kuinsua2X0TscyTNfBJoXHny0Yob+g@mail.gmail.com>
         <056ba905a2579903a372258383afdf6579767ad0.camel@redhat.com>
         <CACGkMEuiDqqOEKUWRN9LvQKv8Jz4mi3aSZMwbhUsJkZp=C-0RQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-09-07 at 10:09 +0800, Jason Wang wrote:
> On Tue, Sep 6, 2022 at 6:56 PM Paolo Abeni <pabeni@redhat.com> wrote:
> > 
> > On Mon, 2022-09-05 at 15:49 +0800, Jason Wang wrote:
> > > On Mon, Sep 5, 2022 at 3:15 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > 
> > > > On Mon, Sep 05, 2022 at 12:53:41PM +0800, Jason Wang wrote:
> > > > > Adding cond_resched() to the command waiting loop for a better
> > > > > co-operation with the scheduler. This allows to give CPU a breath to
> > > > > run other task(workqueue) instead of busy looping when preemption is
> > > > > not allowed.
> > > > > 
> > > > > What's more important. This is a must for some vDPA parent to work
> > > > > since control virtqueue is emulated via a workqueue for those parents.
> > > > > 
> > > > > Fixes: bda324fd037a ("vdpasim: control virtqueue support")
> > > > 
> > > > That's a weird commit to fix. so it fixes the simulator?
> > > 
> > > Yes, since the simulator is using a workqueue to handle control virtueue.
> > 
> > Uhmm... touching a driver for a simulator's sake looks a little weird.
> 
> Simulator is not the only one that is using a workqueue (but should be
> the first).
> 
> I can see  that the mlx5 vDPA driver is using a workqueue as well (see
> mlx5_vdpa_kick_vq()).
> 
> And in the case of VDUSE, it needs to wait for the response from the
> userspace, this means cond_resched() is probably a must for the case
> like UP.
> 
> > 
> > Additionally, if the bug is vdpasim, I think it's better to try to
> > solve it there, if possible.
> > 
> > Looking at vdpasim_net_work() and vdpasim_blk_work() it looks like
> > neither needs a process context, so perhaps you could rework it to run
> > the work_fn() directly from vdpasim_kick_vq(), at least for the control
> > virtqueue?
> 
> It's possible (but require some rework on the simulator core). But
> considering we have other similar use cases, it looks better to solve
> it in the virtio-net driver.

I see.

> Additionally, this may have better behaviour when using for the buggy
> hardware (e.g the control virtqueue takes too long to respond). We may
> consider switching to use interrupt/sleep in the future (but not
> suitable for -net).

Agreed. Possibly a timeout could be useful, too.

Cheers,

Paolo

