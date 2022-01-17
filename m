Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B63449123A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 00:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243770AbiAQXOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 18:14:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36953 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234551AbiAQXOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 18:14:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642461239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=poL37lSy5yu+pXxIBkPJdf1QhhjhrG0y8WyJPB/Gac4=;
        b=cHoc6UPpucyNFfOPIEB/5koMaKlkBRvD7YHGYaBZ4CGfgaPdpjY6swRUkt0SAIWD+9OUzI
        Yz1vaOPfepoxcWTm1fvUOKdAVZFk4AvBszZ+oqy2LxBJpW8TyEym34r5RgHljcSs0lkPMz
        D821CiSRrU0vGVu4uhzJ6WSqrhxt4GI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-EwO5uzAKPfe0t08tf-qsig-1; Mon, 17 Jan 2022 18:13:58 -0500
X-MC-Unique: EwO5uzAKPfe0t08tf-qsig-1
Received: by mail-ed1-f69.google.com with SMTP id h11-20020a05640250cb00b003fa024f87c2so15327015edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 15:13:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=poL37lSy5yu+pXxIBkPJdf1QhhjhrG0y8WyJPB/Gac4=;
        b=UmSp2jWLmNQh6+Rk71IYhG5dWTDzgmUDDFH8u9bEPoLiKFEuR2F/WBYgyRlznprSK+
         +LfMd1Vgw8EeEujv7jy2tbfZq4oc/pvnRl8vpDHVvdkSd4AyWXB7sowT657EetovRAcm
         U2Rk/iCCG1IPl1He59H6q32GDmP/U0Wot+W9Y2SJB6kexso/Of4hnwIMlTqaSWJlQ5t8
         YSyyJuJiPpBcgUBIBk1dp59FfvO8GhDkKFPh01kNXh7osimVTfLae4pfSsTSlTT5Ei3u
         IF8E09AqnbNV3zHrriL260/RF59DdmHEfcLluSmq379JZ5YNS4HFNMCkQls0wTyjPpEt
         kkvg==
X-Gm-Message-State: AOAM5339tzx5UnTs+LdBRZ3F/yjuybFOk+jDQQE8GsesMs/cZAfS9Q7m
        N9TX/3/0KTEU6ICK18eZRl64/tzbZcpOFgPnGm0vghTGLxva5ofKE9pkbcrEHq0UBBwTlpGTwTj
        0GT9VuKhRejjbXKsnjm7G5V2r
X-Received: by 2002:a05:6402:154:: with SMTP id s20mr23541004edu.148.1642461236903;
        Mon, 17 Jan 2022 15:13:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzLNJ+H3FJlkh2+Vfrf2XL670LwjFEEh5msW25BJKoOSxrD9zY3tXrjLznoSEqqi27F14Jz0A==
X-Received: by 2002:a05:6402:154:: with SMTP id s20mr23540987edu.148.1642461236725;
        Mon, 17 Jan 2022 15:13:56 -0800 (PST)
Received: from redhat.com ([2.55.154.241])
        by smtp.gmail.com with ESMTPSA id p25sm6417354edw.75.2022.01.17.15.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 15:13:54 -0800 (PST)
Date:   Mon, 17 Jan 2022 18:13:49 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] virtio: acknowledge all features before access
Message-ID: <20220117181318-mutt-send-email-mst@kernel.org>
References: <20220114200744.150325-1-mst@redhat.com>
 <d6c4e521-1538-bbbf-30e6-f658a095b3ae@redhat.com>
 <20220117032429-mutt-send-email-mst@kernel.org>
 <87mtjuv8od.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mtjuv8od.fsf@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 01:38:42PM +0100, Cornelia Huck wrote:
> On Mon, Jan 17 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Jan 17, 2022 at 02:31:49PM +0800, Jason Wang wrote:
> >> 
> >> 在 2022/1/15 上午4:09, Michael S. Tsirkin 写道:
> >> > @@ -495,6 +494,10 @@ int virtio_device_restore(struct virtio_device *dev)
> >> >   	/* We have a driver! */
> >> >   	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER);
> >> > +	ret = dev->config->finalize_features(dev);
> >> > +	if (ret)
> >> > +		goto err;
> >> 
> >> 
> >> Is this part of code related?
> >> 
> >> Thanks
> >> 
> >
> > Yes. virtio_finalize_features no longer calls dev->config->finalize_features.
> >
> > I think the dev->config->finalize_features callback is actually
> > a misnomer now, it just sends the features to device,
> > finalize is FEATURES_OK. Renaming that is a bigger
> > patch though, and I'd like this one to be cherry-pickable
> > to stable.
> 
> Do we want to add a comment before the calls to ->finalize_features()
> (/* write features to device */) and adapt the comment in virtio_ring.h?
> Should still be stable-friendly, and giving the callback a better name
> can be a follow-up patch.


Sounds like a good idea. I can also document that near
virtio_finalize_features.

> >
> >> > +
> >> >   	ret = virtio_finalize_features(dev);
> >> >   	if (ret)
> >> >   		goto err;

