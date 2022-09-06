Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65A85AE608
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239418AbiIFK42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239681AbiIFK4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:56:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2019913EB2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 03:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662461760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TWFTmiu/F1naD+YA2QN797Qhc0+oXAueZY77zxu/bOc=;
        b=VedJouYeT4C/RsTWW1+ht1gmktvy2aPfniEfrEw5co5lvrdt3GIEgw8MHdgrbQe5e9NAq4
        uzDp0HrtjT9mNI7CKbMoYTRlQ5p/EF9SENWppLErIKniX//aZL9aj+uN3Nj3Q6lTtYdUm2
        8i9DCSAH75YuWgPFSEtUKSJXAjVmzbA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-326-C3HuPP8YPWOHUcLqKvKuOg-1; Tue, 06 Sep 2022 06:55:57 -0400
X-MC-Unique: C3HuPP8YPWOHUcLqKvKuOg-1
Received: by mail-wm1-f72.google.com with SMTP id i7-20020a1c3b07000000b003a534ec2570so8619158wma.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 03:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=TWFTmiu/F1naD+YA2QN797Qhc0+oXAueZY77zxu/bOc=;
        b=ccf44BDpl5Xo92aPTbZp4GKkBnmUoEBHelZsz0Rpxuz97ALA3iC5vg5jF2TMrLnxIn
         10LldIbOw73iytUlZtkb9mg5EEzG+C13PT9M4Hj/dsOrQDxFhNso1RMzw6fPrlsZ1Ug9
         02NZihBDRcUrNBBf2lBYXqiFUUbVsqjTwgvzLHi3yOw1xwi1f5I5GBiIPtRdfD2FYGVh
         2smid/JbHwxYXno45kr6bTwfC53kNChO5nl4tJb6v6J229+QzHxkIw9HdQ7QEsBNVXxW
         ePBZZNNrKFD+FWFHz3uXUqq2qj/GySJKF4NHVttL1SD4v/FYCXszH0SqnSrX8h3+vng1
         Gg7w==
X-Gm-Message-State: ACgBeo3jWWXhjt/6kl1zf+XWMZ53n3VFd0mxLiKA4Ehsz4EeuEehV7B1
        CbpEP1uo1O9a7+KgLLAk7N3r/xg5UtEpJIzy0IO1tCdWlGxqBFnuHIMLPZDTozn0cnKlkvt7Y+6
        PW1LXDns2JGNs17yL88hsAqFH
X-Received: by 2002:a05:600c:3541:b0:3a6:28e4:c458 with SMTP id i1-20020a05600c354100b003a628e4c458mr13486801wmq.188.1662461756591;
        Tue, 06 Sep 2022 03:55:56 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4TTTKsUXeNjIwHC9u3J8/4vqYFGhNuEr/0Tvd/A8eYqEBmE6zDfGSyJavnhzHHsWabol3izA==
X-Received: by 2002:a05:600c:3541:b0:3a6:28e4:c458 with SMTP id i1-20020a05600c354100b003a628e4c458mr13486792wmq.188.1662461756355;
        Tue, 06 Sep 2022 03:55:56 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-112-72.dyn.eolo.it. [146.241.112.72])
        by smtp.gmail.com with ESMTPSA id e5-20020adfe7c5000000b0022862e037e3sm8611142wrn.38.2022.09.06.03.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 03:55:55 -0700 (PDT)
Message-ID: <056ba905a2579903a372258383afdf6579767ad0.camel@redhat.com>
Subject: Re: [PATCH net] virtio-net: add cond_resched() to the command
 waiting loop
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Gautam Dawar <gautam.dawar@xilinx.com>,
        davem <davem@davemloft.net>
Date:   Tue, 06 Sep 2022 12:55:54 +0200
In-Reply-To: <CACGkMEtjQ0Jfok-gcRW+kuinsua2X0TscyTNfBJoXHny0Yob+g@mail.gmail.com>
References: <20220905045341.66191-1-jasowang@redhat.com>
         <20220905031405-mutt-send-email-mst@kernel.org>
         <CACGkMEtjQ0Jfok-gcRW+kuinsua2X0TscyTNfBJoXHny0Yob+g@mail.gmail.com>
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

On Mon, 2022-09-05 at 15:49 +0800, Jason Wang wrote:
> On Mon, Sep 5, 2022 at 3:15 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > On Mon, Sep 05, 2022 at 12:53:41PM +0800, Jason Wang wrote:
> > > Adding cond_resched() to the command waiting loop for a better
> > > co-operation with the scheduler. This allows to give CPU a breath to
> > > run other task(workqueue) instead of busy looping when preemption is
> > > not allowed.
> > > 
> > > What's more important. This is a must for some vDPA parent to work
> > > since control virtqueue is emulated via a workqueue for those parents.
> > > 
> > > Fixes: bda324fd037a ("vdpasim: control virtqueue support")
> > 
> > That's a weird commit to fix. so it fixes the simulator?
> 
> Yes, since the simulator is using a workqueue to handle control virtueue.

Uhmm... touching a driver for a simulator's sake looks a little weird. 

Additionally, if the bug is vdpasim, I think it's better to try to
solve it there, if possible.

Looking at vdpasim_net_work() and vdpasim_blk_work() it looks like
neither needs a process context, so perhaps you could rework it to run
the work_fn() directly from vdpasim_kick_vq(), at least for the control
virtqueue?

Thanks!

Paolo

