Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5484A594B17
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 02:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355059AbiHPALY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 20:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356303AbiHPACO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 20:02:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9576B169441
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 13:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660595025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JE0Q6qMpxU/bQzzBknDStkFAFzBJZfD5zR8g9OCHMSI=;
        b=NzxOWTjgZVqJNFlC6E1hEnC9LmEG9vi9FAwu/8rPY+ctTyySyME23EqpAWieAXuspHL+f0
        Sr7ffbaJKAerl3rLAtmlh8lxI03NmfuUZ4l5oS+aaIaJ7ZxOTil/D/kMT3OMtlNgjPRwEe
        tTCerh9g581OyeEHU8c7RrZvFqc+5Ng=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-557-DHeQQtEjMaWXHuOTMxnNMg-1; Mon, 15 Aug 2022 16:23:44 -0400
X-MC-Unique: DHeQQtEjMaWXHuOTMxnNMg-1
Received: by mail-wm1-f70.google.com with SMTP id v64-20020a1cac43000000b003a4bea31b4dso9138764wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 13:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=JE0Q6qMpxU/bQzzBknDStkFAFzBJZfD5zR8g9OCHMSI=;
        b=LT0pzS0X2q1soXy7GKG/i3gwfkzUsCBMrmeXol33bzDMuC6qfhebawCZhz/6LyAQaH
         hap1kZh00KLOVditcKKW/5fOlx1JUJN0HNFj/XWSIMVTwzC6zsHPDcew6JzlBklQ8FJx
         yxdGVx/Zb36T2I7G/CaMZ+Xq0KXt/ddIHkQ8GwsW0SE33ivbvogB8f+ZyxisRgIsyc4u
         0OafkijnD5mZsm5gMN7tBmLXNYoVo0AzzlMVaFCmMmV56ekBYjIYffjEInXBAjF0/HeC
         QYD1aydmlfNtV+yHE7q/Ra1jivEX19tT3vBS8X/wU++r/fLUTKxhMbGUmswnEuD+P8U4
         NMYw==
X-Gm-Message-State: ACgBeo1Ysb87E0puL4CAUOL9QAk3zZNYdZY83XFJ2qVpb5Oe2LaY1EPb
        Gz3Py9GMX7np24tyEiJn3sVKZHX6bZIsLfksPrm9NTz/jf+ANwddeh/1pUsXXd0dv3yjVj5yc2V
        jgSObUOWx8WEZPLXPuDEszBdM
X-Received: by 2002:a5d:4e8a:0:b0:21f:610:6866 with SMTP id e10-20020a5d4e8a000000b0021f06106866mr9096415wru.606.1660595023126;
        Mon, 15 Aug 2022 13:23:43 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7IfUg8VlT0QelieqjpdY/1IqFRJvHRfVUrvuXEvsvjfab5OMeU50JMDQtT5vAViip/7RKHpQ==
X-Received: by 2002:a5d:4e8a:0:b0:21f:610:6866 with SMTP id e10-20020a5d4e8a000000b0021f06106866mr9096407wru.606.1660595022832;
        Mon, 15 Aug 2022 13:23:42 -0700 (PDT)
Received: from redhat.com ([2.55.43.215])
        by smtp.gmail.com with ESMTPSA id t125-20020a1c4683000000b003a5e3015a96sm9238127wma.15.2022.08.15.13.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 13:23:41 -0700 (PDT)
Date:   Mon, 15 Aug 2022 16:23:37 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Hulk Robot <hulkci@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3] Bluetooth: virtio_bt: fix device removal
Message-ID: <20220815162219-mutt-send-email-mst@kernel.org>
References: <20220811094542.268519-1-mst@redhat.com>
 <CABBYNZLeszHHi2TVcQsOtPWs1u=s8gjOVAhL+Q=O-ThgpxvpOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZLeszHHi2TVcQsOtPWs1u=s8gjOVAhL+Q=O-ThgpxvpOw@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 11:07:05AM -0700, Luiz Augusto von Dentz wrote:
> Hi Michael,
> 
> On Thu, Aug 11, 2022 at 2:46 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > Device removal is clearly out of virtio spec: it attempts to remove
> > unused buffers from a VQ before invoking device reset. To fix, make
> > open/close NOPs and do all cleanup/setup in probe/remove.
> >
> > NB: This is a hacky way to handle this - virtbt_{open,close} as NOP is
> > not really what a driver is supposed to be doing. These are transport
> > enable/disable callbacks from the BT core towards the driver. It maps to
> > a device being enabled/disabled by something like bluetoothd for
> > example. So if disabled, users expect that no resources/queues are in
> > use.  It does work with all other transports like USB, SDIO, UART etc.
> > There should be no buffer used if the device is powered off. We also
> > don’t have any USB URBs in-flight if the transport is not active.
> >
> > The way to implement a proper fix would be using vq reset if supported,
> > or even using a full device reset.
> >
> > The cost of the hack is a single skb wasted on an unused bt device.
> >
> > NB2: with this fix in place driver still suffers from a race condition
> > if an interrupt triggers while device is being reset.  To fix, in the
> > virtbt_close() callback we should deactivate all interrupts.  To be
> > fixed.
> >
> > squashed fixup: bluetooth: virtio_bt: fix an error code in probe()
> 
> Shouldn't the line above be a Fixes tag with the commit hash you are
> attempting to fix, other than that I'd be fine to apply these changes.

No - what I tried to say here is that I posted the original patch
and then Dan and Yang posted fixups, I squashed them in but
wanted to keep contribution.


> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Message-Id: <20220811080943.198245-1-mst@redhat.com>
> > ---
> >
> > changes from v2:
> >         tkeaked commit log to make lines shorter
> > changes from v1:
> >         fixed error handling
> >
> >  drivers/bluetooth/virtio_bt.c | 19 +++++++++++++++++--
> >  1 file changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
> > index 67c21263f9e0..f6d699fed139 100644
> > --- a/drivers/bluetooth/virtio_bt.c
> > +++ b/drivers/bluetooth/virtio_bt.c
> > @@ -50,8 +50,11 @@ static int virtbt_add_inbuf(struct virtio_bluetooth *vbt)
> >
> >  static int virtbt_open(struct hci_dev *hdev)
> >  {
> > -       struct virtio_bluetooth *vbt = hci_get_drvdata(hdev);
> > +       return 0;
> > +}
> >
> > +static int virtbt_open_vdev(struct virtio_bluetooth *vbt)
> > +{
> >         if (virtbt_add_inbuf(vbt) < 0)
> >                 return -EIO;
> >
> > @@ -61,7 +64,11 @@ static int virtbt_open(struct hci_dev *hdev)
> >
> >  static int virtbt_close(struct hci_dev *hdev)
> >  {
> > -       struct virtio_bluetooth *vbt = hci_get_drvdata(hdev);
> > +       return 0;
> > +}
> > +
> > +static int virtbt_close_vdev(struct virtio_bluetooth *vbt)
> > +{
> >         int i;
> >
> >         cancel_work_sync(&vbt->rx);
> > @@ -354,8 +361,15 @@ static int virtbt_probe(struct virtio_device *vdev)
> >                 goto failed;
> >         }
> >
> > +       virtio_device_ready(vdev);
> > +       err = virtbt_open_vdev(vbt);
> > +       if (err)
> > +               goto open_failed;
> > +
> >         return 0;
> >
> > +open_failed:
> > +       hci_free_dev(hdev);
> >  failed:
> >         vdev->config->del_vqs(vdev);
> >         return err;
> > @@ -368,6 +382,7 @@ static void virtbt_remove(struct virtio_device *vdev)
> >
> >         hci_unregister_dev(hdev);
> >         virtio_reset_device(vdev);
> > +       virtbt_close_vdev(vbt);
> >
> >         hci_free_dev(hdev);
> >         vbt->hdev = NULL;
> > --
> > MST
> >
> 
> 
> -- 
> Luiz Augusto von Dentz

