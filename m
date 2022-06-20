Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF2C5513A1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240259AbiFTJCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240235AbiFTJCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:02:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A54B10FEF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655715735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3oC8M92pTSBQLwsvQ/DdmAywS1769N+d4WC6nyEqgEw=;
        b=SaDb4BYigxmV1S54vDWdMxBLO6wwkVkctKN+4K8RWbZaMBya3nWmG0wMTVbwO7T7p2I/q8
        Fze7oIkrUinudSZtnQ/aVxGvRlkAeqHrhbwU1b4GjJ8kxxVjbR/dipKo+8V6s2A5PsrTtz
        PNYADF+s4Kyc8yuDVzCVYYEmuyI/pKA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408-reXMxR8yOsi5TV-2PUwQEw-1; Mon, 20 Jun 2022 05:02:14 -0400
X-MC-Unique: reXMxR8yOsi5TV-2PUwQEw-1
Received: by mail-qv1-f70.google.com with SMTP id x18-20020a0ce252000000b004703cbb92ebso3980083qvl.21
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3oC8M92pTSBQLwsvQ/DdmAywS1769N+d4WC6nyEqgEw=;
        b=kvyV49GbZBsabQj690iVnUGPoti98OCGu6rEfGmmXGJ7SXkgvGmb0hJUqgBSkXhZoC
         fcxxbd24kp+s/rDWT69cUQM/thiXIcy18ViGAEOPjpVsuPNO681KNJurg3F9F63WryXV
         +LcivwIPm7PxDpQA9D/FcGfEoga4nnWe2sH0zZT5CwEQe4bPo6LdruqK38vU6LUVWHFQ
         qTE9Z7g7wkiM02nPqxZN+uTVwX30jv4TqaTTEhPUdS4g9cCdpoUsT5zdY4FHp77w0Q+p
         8WTy8FxNj8xJxNfcbIYThX0q7Q502uNL3uFrVx7LQkqGCNnm6/v83Bcb8jnrpLgKV13h
         /HfQ==
X-Gm-Message-State: AJIora/iCjnAnOSkvJQ8wVdCSHOj4YkhPcSVypVEBGu8uXCp1aB6rcBt
        Xbc6h9KWmcPduENTjpNx006IE2J5vTUGlYde0hnFbFhR0sg9dcKlwib54RYdf+gjgeLcikEumfh
        qF7l+PjmS0Jkt1tMTGVZheSz+JL5hNMbrWahUCPJa
X-Received: by 2002:ac8:598f:0:b0:305:8f8:2069 with SMTP id e15-20020ac8598f000000b0030508f82069mr19115184qte.370.1655715733824;
        Mon, 20 Jun 2022 02:02:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tAa9U4CMoq7Ys+i1Ho3m8PkG1+MHDe/RYYehVChHlW7eVEdAjvqQbtH1gRqyfvYJX1s9ZZ5T+KklLeqjZc2fc=
X-Received: by 2002:ac8:598f:0:b0:305:8f8:2069 with SMTP id
 e15-20020ac8598f000000b0030508f82069mr19115161qte.370.1655715733601; Mon, 20
 Jun 2022 02:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220616132725.50599-1-elic@nvidia.com> <20220616132725.50599-4-elic@nvidia.com>
 <CACGkMEsc+MCsRq6aA1vLXE3OJ0buX-0g73qaz72Px-ismfMKLA@mail.gmail.com>
In-Reply-To: <CACGkMEsc+MCsRq6aA1vLXE3OJ0buX-0g73qaz72Px-ismfMKLA@mail.gmail.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Mon, 20 Jun 2022 11:01:37 +0200
Message-ID: <CAJaqyWdnuX0KLu7j3M4ovtW=N5kFObgaU3z2hu4xoRXY5Fk+aQ@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] vdpa/mlx5: Disable VLAN support to support live migration
To:     Jason Wang <jasowang@redhat.com>
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

On Mon, Jun 20, 2022 at 10:48 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Thu, Jun 16, 2022 at 9:28 PM Eli Cohen <elic@nvidia.com> wrote:
> >
> > Current qemu code does not support live migration for devices supporting
> > VLAN. Disable it.
>
> This looks like a bug that we need to fix in Qemu.
>

Not a but, but a lack of a feature :). Each cvq command needs new code
to inject it at the destination, and only set mac cmd is implemented
at the moment. Only to start simple.

Thanks!

> Thanks
>
> >
> > Note: this patch is provided just to enable testing with current qemu.
> >
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index 34bd81cb697c..1568cfdf07e6 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -2172,7 +2172,6 @@ static u64 get_supported_features(struct mlx5_core_dev *mdev)
> >         mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_MQ);
> >         mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_STATUS);
> >         mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_MTU);
> > -       mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_CTRL_VLAN);
> >
> >         return mlx_vdpa_features;
> >  }
> > --
> > 2.35.1
> >
>

