Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E683D551440
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240577AbiFTJZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240242AbiFTJZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:25:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F2A61180E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655717145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Km8BdY6syMUyW+TQs1owXDRqFBk5bezOw4dqCatn4M=;
        b=QPyW1bTwZNiPYwjZYPEUkr5va66oXBogQ+v5A6/UdOhu8BDzJ0P6Yx+Ax/MO5NLFBFlFUu
        grDYkCx+ud9O0K9ugWu+eMbva8ZlvpywH5W4A+djEAyWYvrgNf2t1WuWT2a7S4xpFbTHse
        Ee9drGWsNYSouZKxmSZj8QLq5rr4nds=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-gbGxgXiVOxCKrmk1MelFgQ-1; Mon, 20 Jun 2022 05:25:41 -0400
X-MC-Unique: gbGxgXiVOxCKrmk1MelFgQ-1
Received: by mail-lf1-f72.google.com with SMTP id f32-20020a0565123b2000b004791bf1af10so5233090lfv.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Km8BdY6syMUyW+TQs1owXDRqFBk5bezOw4dqCatn4M=;
        b=mIT3nRCJJ1dRhAgs78EsiBLR7QWZHNYXivjBGYDcqQFE5/gazCezJ8JiHXm4zziUzP
         WoiyRNDpDWbQdS9gdrthkqPDcNKo5ve+kY//Sz3kU0tWv+uKaQIkqtShTM+Q+QLlQQMs
         d3Nr+xhDMUtN0BYDqmt2QYHe5oMRQgsbegy6GKNRi0Q7qeSbJnfpME8/cKJkpA+DuRvP
         lVPuwvL05+5Ey+Q/pOTFIOJDcIDLcLpoMLWGOFvsRtCheIfLCv1lDV0qcasJd4HhLE1e
         I+Df8WXE9o6hkE0fPYO2nsr5Sd0AOuSGYTYSTox1+wTWYqA/i+Pg36tMjHsSP4wds20W
         u30A==
X-Gm-Message-State: AJIora9II0NwM37LGl/lQi9Cn2B3Dwx2zWHtbn0PvnVdOKjfGV+Cq+im
        lGnPWwIjbBuZjsqwm08fz8ROlOFJx4k4vdhUnHvDfrBmSrER5ZCfNZ7qV+mMNPp1X1kqOsosPvQ
        RS6ylPzSYeRJRHMQrucAyww5hbg2TW7v8Xu5Ni3Ad
X-Received: by 2002:a2e:b014:0:b0:25a:6d17:c3c8 with SMTP id y20-20020a2eb014000000b0025a6d17c3c8mr2735617ljk.487.1655717139625;
        Mon, 20 Jun 2022 02:25:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vBEi+n5krzXVaf2jd3wQPENci1goWGuntoOCdnba+ClrpW4vgwcFjgUeRTTbnzYI/3wnTN7jcATEGI3PJbBpg=
X-Received: by 2002:a2e:b014:0:b0:25a:6d17:c3c8 with SMTP id
 y20-20020a2eb014000000b0025a6d17c3c8mr2735606ljk.487.1655717139443; Mon, 20
 Jun 2022 02:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220616132725.50599-1-elic@nvidia.com> <20220616132725.50599-4-elic@nvidia.com>
 <CACGkMEsc+MCsRq6aA1vLXE3OJ0buX-0g73qaz72Px-ismfMKLA@mail.gmail.com> <CAJaqyWdnuX0KLu7j3M4ovtW=N5kFObgaU3z2hu4xoRXY5Fk+aQ@mail.gmail.com>
In-Reply-To: <CAJaqyWdnuX0KLu7j3M4ovtW=N5kFObgaU3z2hu4xoRXY5Fk+aQ@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 20 Jun 2022 17:25:28 +0800
Message-ID: <CACGkMEsKzS==HQC8C-Pf+7T7rcsg0cHjXEw2tmhFrjjUCQy6UA@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] vdpa/mlx5: Disable VLAN support to support live migration
To:     Eugenio Perez Martin <eperezma@redhat.com>
Cc:     Eli Cohen <elic@nvidia.com>, mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Parav Pandit <parav@nvidia.com>
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

On Mon, Jun 20, 2022 at 5:02 PM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Mon, Jun 20, 2022 at 10:48 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Thu, Jun 16, 2022 at 9:28 PM Eli Cohen <elic@nvidia.com> wrote:
> > >
> > > Current qemu code does not support live migration for devices supporting
> > > VLAN. Disable it.
> >
> > This looks like a bug that we need to fix in Qemu.
> >
>
> Not a but, but a lack of a feature :). Each cvq command needs new code
> to inject it at the destination, and only set mac cmd is implemented
> at the moment. Only to start simple.

I think we don't need this in the formal patch? (Anyhow we could
disable ctrl vlan vic command line)

Thanks

>
> Thanks!
>
> > Thanks
> >
> > >
> > > Note: this patch is provided just to enable testing with current qemu.
> > >
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > ---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index 34bd81cb697c..1568cfdf07e6 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -2172,7 +2172,6 @@ static u64 get_supported_features(struct mlx5_core_dev *mdev)
> > >         mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_MQ);
> > >         mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_STATUS);
> > >         mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_MTU);
> > > -       mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_CTRL_VLAN);
> > >
> > >         return mlx_vdpa_features;
> > >  }
> > > --
> > > 2.35.1
> > >
> >
>

