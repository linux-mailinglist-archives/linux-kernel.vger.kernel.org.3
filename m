Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C505ACD0F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbiIEHua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236559AbiIEHuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:50:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F271EACD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662364214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SMj8mXrJ0Q/Mmrlyt4DK6FLz8HLyNr19Sl/fz3gGSnk=;
        b=JTxbRPsxtBt9/QiWwqSh/eDlc5tjrF6boW02uJkaNn/U+JTkaH8LgaT3qI73JhZ7GktvnG
        EQtFZsiW2nqGBBmfpSewlBpa39dWGvcL2Fvshq+HZ5gDKrkTiCcy2iXISSvNd6oVCUl6Zx
        y5+6K8WFtHox9375WKwSWT1StjkPEes=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-261-1XVbeg6JP5So6HDRoX5NjA-1; Mon, 05 Sep 2022 03:49:44 -0400
X-MC-Unique: 1XVbeg6JP5So6HDRoX5NjA-1
Received: by mail-ua1-f72.google.com with SMTP id 95-20020a9f23e8000000b0038caa7cd5c1so1525590uao.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 00:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=SMj8mXrJ0Q/Mmrlyt4DK6FLz8HLyNr19Sl/fz3gGSnk=;
        b=htql/lgP6nOo2YHcaWjOfJZ1pZOdNO8urY0n1TN/zg++JsU64TrYv0Xn9hYiiVizJr
         cf2dUN3SVwYWh0LQAMRQkF+O43DJ+f3ag8uP7eIXJlHfDFTBV33klzEpZdj9oG0LhQcv
         jzq58n6CwP9llJAAvgJJhot2saXjUMPNQNG0zFieE9Gw3YXbzxS9hxEA3PiYC0gyP2FR
         /OjUF0PYYfdEpPr/7jCccE9wWShsz36LGWJocr7W9oaSG+G8dTP76N92WJx07lui4Amp
         ZbklkyoqReTkqPz5YhF6iNOPGpKX5wEiKIbi55UxPLpBsBmNixS2e/lLfatTx9aewpIS
         4wSQ==
X-Gm-Message-State: ACgBeo1D1gSUcV7c69iEpHZFsudKx/7kNmz+deLR0qJuZ98kmbY7u2dp
        CaSG7eNHEhJWMAPhiFnRD5UIgjx/VsWNgRUVOVsYqXjfsLcAtjUZ7WFJqfKuInPbes4mhnUe5b5
        b87lu67bZOhjx3xl/wvvkfjWpgZS0WrTsOGSE7gCY
X-Received: by 2002:ab0:1473:0:b0:396:d89d:3a87 with SMTP id c48-20020ab01473000000b00396d89d3a87mr14112631uae.73.1662364183859;
        Mon, 05 Sep 2022 00:49:43 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7Ri0CX6EFp7VbOu8dXi4Lj61EowOLZEkc0m0LHhlVZdChmPQxGb8nAeVrQg+nUqe/tT1QyJocHziPlwgCF6Xg=
X-Received: by 2002:ab0:1473:0:b0:396:d89d:3a87 with SMTP id
 c48-20020ab01473000000b00396d89d3a87mr14112626uae.73.1662364183662; Mon, 05
 Sep 2022 00:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220905045341.66191-1-jasowang@redhat.com> <20220905031405-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220905031405-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 5 Sep 2022 15:49:32 +0800
Message-ID: <CACGkMEtjQ0Jfok-gcRW+kuinsua2X0TscyTNfBJoXHny0Yob+g@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: add cond_resched() to the command waiting loop
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     davem <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Gautam Dawar <gautam.dawar@xilinx.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Mon, Sep 5, 2022 at 3:15 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Sep 05, 2022 at 12:53:41PM +0800, Jason Wang wrote:
> > Adding cond_resched() to the command waiting loop for a better
> > co-operation with the scheduler. This allows to give CPU a breath to
> > run other task(workqueue) instead of busy looping when preemption is
> > not allowed.
> >
> > What's more important. This is a must for some vDPA parent to work
> > since control virtqueue is emulated via a workqueue for those parents.
> >
> > Fixes: bda324fd037a ("vdpasim: control virtqueue support")
>
> That's a weird commit to fix. so it fixes the simulator?

Yes, since the simulator is using a workqueue to handle control virtueue.

>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/net/virtio_net.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index ece00b84e3a7..169368365d6a 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2000,8 +2000,10 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> >        * into the hypervisor, so the request should be handled immediately.
> >        */
> >       while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > -            !virtqueue_is_broken(vi->cvq))
> > +            !virtqueue_is_broken(vi->cvq)) {
> > +             cond_resched();
> >               cpu_relax();
> > +     }
>
> with cond_resched do we still need cpu_relax?

I think so, it's possible that cond_sched() just doesn't trigger scheduling.

Thanks

>
> >       return vi->ctrl->status == VIRTIO_NET_OK;
> >  }
> > --
> > 2.25.1
>

