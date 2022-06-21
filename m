Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EFF5529A8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 05:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344747AbiFUDLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 23:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343763AbiFUDLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 23:11:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 227641A3B6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 20:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655781061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EdpCZK5YFtstuCi2QX+uYzJSDoVANaPvA4APSBU2SK0=;
        b=C+4KzIN7ykQRgWnGxyh+Nd2KUEEN+O0iv43NfnbN9SgguynI9ts0NpTtI/o/QY80EtTNkM
        5nkcQfs+60MUSyMkdjCaynf2ZurmcgLCFm+k2UNbszUxpgDNE4AAmq8/9lF/pVLloSB3qF
        X4IYGIczqJxUDjVSW13X3P7PLCr5dR8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-HLXdUdqGMfeu7NnUbxknJg-1; Mon, 20 Jun 2022 23:10:59 -0400
X-MC-Unique: HLXdUdqGMfeu7NnUbxknJg-1
Received: by mail-lf1-f71.google.com with SMTP id cf10-20020a056512280a00b0047f5a295656so3718464lfb.15
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 20:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EdpCZK5YFtstuCi2QX+uYzJSDoVANaPvA4APSBU2SK0=;
        b=nbZXsgniPbbDKlffZtQaTqMTYKij0O8T6erEriZ5J5tbJ5aFdHZBx5wzMv7zvc5gNK
         z2lkq+yIayJAdnMDBWFsGmdTv/++Rwf+kEIzGbmyxCedtvmggBNsEE5j3TgeyJS107iT
         55YjTZIDDxUpuO2jrWv/7UNTaj2kNEiJfyZzA5tKwAYqylwU4REZEu/VOWhiVNu/gKlk
         T8app9OGO/R/SX8Quh4BGcfC36It8D/Wr+W9FNFt16KPIF8fo2F/wuxKTqFT3igVu84o
         K79gsOtBqT9VnIFXZyxUg9Lt2axfiWb1PufVR3kyu6Ly4TOn3OTK0vfpPQsZHKgkzJHW
         CLOw==
X-Gm-Message-State: AJIora9qnTwVvudfa+HyiL5E7IPd3LjnIsH8vORySbAxaVgZSzkVauT8
        U2gp/xfD1hFRzjsW0rpYl3OSSe+/YcwQimItNezla4b9xHdKXU7teJ4mtG28eg3sYWzeNbC9dj2
        wYROfd72BxjHbG88SnHFABEjuT3VSuEjA72OriwuZ
X-Received: by 2002:a05:6512:304d:b0:47d:c236:566f with SMTP id b13-20020a056512304d00b0047dc236566fmr15182891lfb.641.1655781057883;
        Mon, 20 Jun 2022 20:10:57 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sDlyveDd4kkO7R/2wVYhsz9VSHaScartSDvQ7pU3gjvhEpwg2QMiSarFPEK8dLL2Rno1Exik4lPxtAh7+7x9A=
X-Received: by 2002:a05:6512:304d:b0:47d:c236:566f with SMTP id
 b13-20020a056512304d00b0047dc236566fmr15182886lfb.641.1655781057700; Mon, 20
 Jun 2022 20:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220620051115.3142-1-jasowang@redhat.com> <20220620051115.3142-2-jasowang@redhat.com>
 <20220620050044-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220620050044-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 21 Jun 2022 11:10:46 +0800
Message-ID: <CACGkMEsd3r043LYSfC7ntNon-VktWOoDsFvRxMxJSSojJ_GRrg@mail.gmail.com>
Subject: Re: [PATCH 1/3] caif_virtio: remove virtqueue_disable_cb() in probe
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        davem <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        erwan.yvin@stericsson.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 5:02 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Jun 20, 2022 at 01:11:13PM +0800, Jason Wang wrote:
> > This disabling is a just a hint with best effort, there's no guarantee
> > that device doesn't send notification. The driver should survive with
> > that, so let's remove it.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> I guess, but frankly this change feels gratituous, and just might
> uncover latent bugs. Which would be fine if we were out to
> find and fix them, but given this was compile-tested only,
> I'm not sure that's the case.

Ok, let me drop this from the next version (no way to test).

Thanks

>
>
> > ---
> >  drivers/net/caif/caif_virtio.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/net/caif/caif_virtio.c b/drivers/net/caif/caif_virtio.c
> > index 5458f57177a0..c677ded81133 100644
> > --- a/drivers/net/caif/caif_virtio.c
> > +++ b/drivers/net/caif/caif_virtio.c
> > @@ -705,9 +705,6 @@ static int cfv_probe(struct virtio_device *vdev)
> >       netdev->needed_headroom = cfv->tx_hr;
> >       netdev->needed_tailroom = cfv->tx_tr;
> >
> > -     /* Disable buffer release interrupts unless we have stopped TX queues */
> > -     virtqueue_disable_cb(cfv->vq_tx);
> > -
> >       netdev->mtu = cfv->mtu - cfv->tx_tr;
> >       vdev->priv = cfv;
> >
> > --
> > 2.25.1
>

