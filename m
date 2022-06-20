Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52ABF551410
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239188AbiFTJS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240745AbiFTJSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:18:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BAF87665
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655716726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AXb8PQzSuHtcxtD5+f9CgGG707rMaJ28CjJj10Bwyow=;
        b=ZcXC0PK5whjZhKFwmb/kGKc2Nf3ZF9B8P/mVEFKH6UT5OoiJzpOaCkF+izH5xZfVO+Ictp
        4mwshLinZnaL6eKrd18QUW+eIIOsHxDC3RYUJfxq83EPfUKB3wSzbzZPgs0ejKTRkL2OBn
        N/Wb+V+qsROz3wp/40fapdZH8BShuhI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-ftgYs-WSOOqV6Gzu3LzhOA-1; Mon, 20 Jun 2022 05:18:42 -0400
X-MC-Unique: ftgYs-WSOOqV6Gzu3LzhOA-1
Received: by mail-lf1-f70.google.com with SMTP id h35-20020a0565123ca300b00479113319f9so5265623lfv.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:18:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AXb8PQzSuHtcxtD5+f9CgGG707rMaJ28CjJj10Bwyow=;
        b=pabUAf37WF65L/J1W3PdDJ9QJNiZsSc/dlhqAXyoWJlU+VgSCH7YUnq4+dLURpUwXL
         aUM2yRs8Hg5TSJl4BKLiYobIqIXj02r6l6fU//0MrrbfUQ79qhAg6xHsGeFnarZxjQA2
         eYULtIybbuE9hGEBdNxr/SglcOaw9ZsFYthO9hZaDIZgsb28/Ei9wXaApqPsDt8B3TUC
         Tbnadwhp1fms8SGjMQbfuN0QhJ1IrQ44V2PZGC7wGfjWVhqe5GEKQbaOJSm1tkiYuXL/
         63kfQ0pJHf+OoHWHxNjSCq7i0+v7//fl9gc9t6F2sg9KXdLaUYwT3HiK356LTKuEwa24
         Xp7A==
X-Gm-Message-State: AJIora9jlgp4fJnvMeVRmoLTkhFEJaZLFJbGhKxr9bkP5kfueqFiBYDk
        yQUCbxViu0Mco0niP6hrcHpWQ2pTzpTRyalgvQFA/GfHSzdw4bSKzlAtBT/8+xvmXlFEd5BhI1t
        nL/OJaT9KJ3YgoxzdZoQ+c9PlK5s7+YzE6F1wljmC
X-Received: by 2002:a2e:3a16:0:b0:255:7811:2827 with SMTP id h22-20020a2e3a16000000b0025578112827mr11190683lja.130.1655716720474;
        Mon, 20 Jun 2022 02:18:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tgaoFSoLISRFH9h+lSO0AXM25Aoq8+VJEqPR3rbJHlSQaKiS3xClDL7guWIBhuvU/zP5YTgnYDl5S5lhrRRnk=
X-Received: by 2002:a2e:3a16:0:b0:255:7811:2827 with SMTP id
 h22-20020a2e3a16000000b0025578112827mr11190676lja.130.1655716720289; Mon, 20
 Jun 2022 02:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220620051115.3142-1-jasowang@redhat.com> <20220620051115.3142-4-jasowang@redhat.com>
 <20220620050446-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220620050446-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 20 Jun 2022 17:18:29 +0800
Message-ID: <CACGkMEsEq3mu6unXx1VZuEFgDCotOc9v7fcwJG-kXEqs6hXYYg@mail.gmail.com>
Subject: Re: [PATCH 3/3] caif_virtio: fix the race between reset and netdev unregister
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        davem <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        erwan.yvin@stericsson.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 5:09 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Jun 20, 2022 at 01:11:15PM +0800, Jason Wang wrote:
> > We use to do the following steps during .remove():
>
> We currently do
>
>
> > static void cfv_remove(struct virtio_device *vdev)
> > {
> >       struct cfv_info *cfv = vdev->priv;
> >
> >       rtnl_lock();
> >       dev_close(cfv->ndev);
> >       rtnl_unlock();
> >
> >       tasklet_kill(&cfv->tx_release_tasklet);
> >       debugfs_remove_recursive(cfv->debugfs);
> >
> >       vringh_kiov_cleanup(&cfv->ctx.riov);
> >       virtio_reset_device(vdev);
> >       vdev->vringh_config->del_vrhs(cfv->vdev);
> >       cfv->vr_rx = NULL;
> >       vdev->config->del_vqs(cfv->vdev);
> >       unregister_netdev(cfv->ndev);
> > }
> > This is racy since device could be re-opened after dev_close() but
> > before unregister_netdevice():
> >
> > 1) RX vringh is cleaned before resetting the device, rx callbacks that
> >    is called after the vringh_kiov_cleanup() will result a UAF
> > 2) Network stack can still try to use TX virtqueue even if it has been
> >    deleted after dev_vqs()
> >
> > Fixing this by unregistering the network device first to make sure not
> > device access from both TX and RX side.
> >
> > Fixes: 0d2e1a2926b18 ("caif_virtio: Introduce caif over virtio")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/net/caif/caif_virtio.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/caif/caif_virtio.c b/drivers/net/caif/caif_virtio.c
> > index 66375bea2fcd..a29f9b2df5b1 100644
> > --- a/drivers/net/caif/caif_virtio.c
> > +++ b/drivers/net/caif/caif_virtio.c
> > @@ -752,9 +752,8 @@ static void cfv_remove(struct virtio_device *vdev)
> >  {
> >       struct cfv_info *cfv = vdev->priv;
> >
> > -     rtnl_lock();
> > -     dev_close(cfv->ndev);
> > -     rtnl_unlock();
> > +     /* Make sure NAPI/TX won't try to access the device */
> > +     unregister_netdev(cfv->ndev);
> >
> >       tasklet_kill(&cfv->tx_release_tasklet);
> >       debugfs_remove_recursive(cfv->debugfs);
> > @@ -764,7 +763,6 @@ static void cfv_remove(struct virtio_device *vdev)
> >       vdev->vringh_config->del_vrhs(cfv->vdev);
> >       cfv->vr_rx = NULL;
> >       vdev->config->del_vqs(cfv->vdev);
> > -     unregister_netdev(cfv->ndev);
> >  }
>
>
> This gives me pause, callbacks can now trigger after device
> has been unregistered. Are we sure this is safe?

It looks safe, for RX NAPI is disabled. For TX, tasklet is disabled
after tasklet_kill(). I can add a comment to explain this.

> Won't it be safer to just keep the rtnl_lock around
> the whole process?

It looks to me we rtnl_lock can't help in synchronizing with the
callbacks, anything I miss?

Thanks

>
> >  static struct virtio_device_id id_table[] = {
> > --
> > 2.25.1
>

