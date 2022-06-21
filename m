Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A11552AAF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 08:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345513AbiFUGAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 02:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345490AbiFUGAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 02:00:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7352220E5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 23:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655791237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HpI8G7xwI35B9Nl13pX8pLeBi7qUikVCYP4oyWd8eYk=;
        b=CtGDBCOhL1IuW4imQ44ctR/6f3ha1ct1wv/k6vzPZD2aKJTDLzIFUrY4d+zqOQ9Y5qt2ln
        /7sCOFe5mAw7hYuQKPDXXwDjry0iIXd0YKFRbYJY3WsO97jSqjOqsHjR/NCmIlaki+eMBl
        jY3458KqkyezOFsEfBT4x6Qiczlp+gw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-hJR6aoIONWS6Q7O7zJxrAw-1; Tue, 21 Jun 2022 02:00:34 -0400
X-MC-Unique: hJR6aoIONWS6Q7O7zJxrAw-1
Received: by mail-wm1-f72.google.com with SMTP id m22-20020a7bcb96000000b0039c4f6ade4dso3908410wmi.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 23:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HpI8G7xwI35B9Nl13pX8pLeBi7qUikVCYP4oyWd8eYk=;
        b=69YX00m6L/sU1PjDlIDrGN6d22U40RdT9AwLwvlg/qRuTqP+j14u994ddy08itcoyW
         aS2ING2GrRygzjNDw32wDn37Io08snUR6Zjh4QphVvUwUwRf9cOghbayvfvSO9A2RfHe
         KxJ4ShtPZ5ZwrpVksAsn8s2x9XVL26HngqDervs83MdN2FI53ZmsBn8cvfQV6brcNs6b
         WzbLe6U+fhoUMP7m/f5o/bTYsLwLFX81hMgwoZv9pw8fcWSQgjVrwr+gCceGomHDB4GV
         ZxVAJNwngm2lK9gAKTrMCUd7SXHbRuyUHBYXvdLY6AxFtNvFmaQiUnt0mLTauyumexGI
         lTAw==
X-Gm-Message-State: AJIora+bxqqhy8Zoxb02zNBAzl3ttMdADF7hHRuEzlQnSFOvOPSf8R+Y
        5BWKtqaOc8bqP6+tMNEuN8T+VudDzAewsZpMR63PYdqJw284aa/lgY/tlJ6VvKdtylZBOsyMSWH
        3CRtr2ekPR6COuvEcDM4hujsf
X-Received: by 2002:adf:db48:0:b0:21b:9733:e134 with SMTP id f8-20020adfdb48000000b0021b9733e134mr1868392wrj.396.1655791233058;
        Mon, 20 Jun 2022 23:00:33 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ueVVv0nYzdNBCnl0LzuMmMaJJwbfPo6vYbVgN8zyrf0qI4HmI616IJk704Hm+OV6yGEEGYsQ==
X-Received: by 2002:adf:db48:0:b0:21b:9733:e134 with SMTP id f8-20020adfdb48000000b0021b9733e134mr1868373wrj.396.1655791232802;
        Mon, 20 Jun 2022 23:00:32 -0700 (PDT)
Received: from redhat.com ([2.53.15.87])
        by smtp.gmail.com with ESMTPSA id i27-20020a1c541b000000b0039c5ab7167dsm21126194wmb.48.2022.06.20.23.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 23:00:32 -0700 (PDT)
Date:   Tue, 21 Jun 2022 02:00:28 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        davem <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        erwan.yvin@stericsson.com
Subject: Re: [PATCH 3/3] caif_virtio: fix the race between reset and netdev
 unregister
Message-ID: <20220621020013-mutt-send-email-mst@kernel.org>
References: <20220620051115.3142-1-jasowang@redhat.com>
 <20220620051115.3142-4-jasowang@redhat.com>
 <20220620050446-mutt-send-email-mst@kernel.org>
 <CACGkMEsEq3mu6unXx1VZuEFgDCotOc9v7fcwJG-kXEqs6hXYYg@mail.gmail.com>
 <20220620061607-mutt-send-email-mst@kernel.org>
 <CACGkMEu7k2X6S0tSsuGOb-Ta+MzzYE5NzHgrhR2H1vgmcLqjCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEu7k2X6S0tSsuGOb-Ta+MzzYE5NzHgrhR2H1vgmcLqjCw@mail.gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 11:09:45AM +0800, Jason Wang wrote:
> On Mon, Jun 20, 2022 at 6:18 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jun 20, 2022 at 05:18:29PM +0800, Jason Wang wrote:
> > > On Mon, Jun 20, 2022 at 5:09 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Jun 20, 2022 at 01:11:15PM +0800, Jason Wang wrote:
> > > > > We use to do the following steps during .remove():
> > > >
> > > > We currently do
> > > >
> > > >
> > > > > static void cfv_remove(struct virtio_device *vdev)
> > > > > {
> > > > >       struct cfv_info *cfv = vdev->priv;
> > > > >
> > > > >       rtnl_lock();
> > > > >       dev_close(cfv->ndev);
> > > > >       rtnl_unlock();
> > > > >
> > > > >       tasklet_kill(&cfv->tx_release_tasklet);
> > > > >       debugfs_remove_recursive(cfv->debugfs);
> > > > >
> > > > >       vringh_kiov_cleanup(&cfv->ctx.riov);
> > > > >       virtio_reset_device(vdev);
> > > > >       vdev->vringh_config->del_vrhs(cfv->vdev);
> > > > >       cfv->vr_rx = NULL;
> > > > >       vdev->config->del_vqs(cfv->vdev);
> > > > >       unregister_netdev(cfv->ndev);
> > > > > }
> > > > > This is racy since device could be re-opened after dev_close() but
> > > > > before unregister_netdevice():
> > > > >
> > > > > 1) RX vringh is cleaned before resetting the device, rx callbacks that
> > > > >    is called after the vringh_kiov_cleanup() will result a UAF
> > > > > 2) Network stack can still try to use TX virtqueue even if it has been
> > > > >    deleted after dev_vqs()
> > > > >
> > > > > Fixing this by unregistering the network device first to make sure not
> > > > > device access from both TX and RX side.
> > > > >
> > > > > Fixes: 0d2e1a2926b18 ("caif_virtio: Introduce caif over virtio")
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > ---
> > > > >  drivers/net/caif/caif_virtio.c | 6 ++----
> > > > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/caif/caif_virtio.c b/drivers/net/caif/caif_virtio.c
> > > > > index 66375bea2fcd..a29f9b2df5b1 100644
> > > > > --- a/drivers/net/caif/caif_virtio.c
> > > > > +++ b/drivers/net/caif/caif_virtio.c
> > > > > @@ -752,9 +752,8 @@ static void cfv_remove(struct virtio_device *vdev)
> > > > >  {
> > > > >       struct cfv_info *cfv = vdev->priv;
> > > > >
> > > > > -     rtnl_lock();
> > > > > -     dev_close(cfv->ndev);
> > > > > -     rtnl_unlock();
> > > > > +     /* Make sure NAPI/TX won't try to access the device */
> > > > > +     unregister_netdev(cfv->ndev);
> > > > >
> > > > >       tasklet_kill(&cfv->tx_release_tasklet);
> > > > >       debugfs_remove_recursive(cfv->debugfs);
> > > > > @@ -764,7 +763,6 @@ static void cfv_remove(struct virtio_device *vdev)
> > > > >       vdev->vringh_config->del_vrhs(cfv->vdev);
> > > > >       cfv->vr_rx = NULL;
> > > > >       vdev->config->del_vqs(cfv->vdev);
> > > > > -     unregister_netdev(cfv->ndev);
> > > > >  }
> > > >
> > > >
> > > > This gives me pause, callbacks can now trigger after device
> > > > has been unregistered. Are we sure this is safe?
> > >
> > > It looks safe, for RX NAPI is disabled. For TX, tasklet is disabled
> > > after tasklet_kill(). I can add a comment to explain this.
> >
> > that waits for outstanding tasklets but does it really prevent
> > future ones?
> 
> I think so, it tries to test and set TASKLET_STATE_SCHED which blocks
> the future scheduling of a tasklet.
> 
> Thanks

But then in the end it clears it, does it not?

> >
> > > > Won't it be safer to just keep the rtnl_lock around
> > > > the whole process?
> > >
> > > It looks to me we rtnl_lock can't help in synchronizing with the
> > > callbacks, anything I miss?
> > >
> > > Thanks
> >
> > good point.
> >
> >
> > > >
> > > > >  static struct virtio_device_id id_table[] = {
> > > > > --
> > > > > 2.25.1
> > > >
> >

