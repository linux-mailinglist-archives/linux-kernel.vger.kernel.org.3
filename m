Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61F448E527
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 09:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbiANICN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 03:02:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46099 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229812AbiANICM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 03:02:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642147331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=klb0nnUjuvobPotelSx3DfHypMSRSFWqMkVcwCb1ESI=;
        b=PoqYoQXlFIWys5suqyfWfH3zPzUoXWBWJbZr9p/XNjHoBcBJurpp5fjcWfArv2QeuLQDkm
        YbhxT6vuLL6hoCCHgEtsxdG6sHEMgAVLI3IvYQaypGsXu8g1TKK+Pa45Dtlx6Q3JS9Lrq+
        T3xHCO8BB7SfiFova3Tjmo0OYgdGskk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-224-fBRNBjnAPUijwB6mONgK3w-1; Fri, 14 Jan 2022 03:02:10 -0500
X-MC-Unique: fBRNBjnAPUijwB6mONgK3w-1
Received: by mail-wm1-f72.google.com with SMTP id s190-20020a1ca9c7000000b00347c6c39d9aso5135164wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 00:02:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=klb0nnUjuvobPotelSx3DfHypMSRSFWqMkVcwCb1ESI=;
        b=aEdSjYmcRU6BMVChW6g0atrMwq+PkWNbEyEdAWoPw2ce2ACU42t2ioYHlcka7tVokN
         5gb1DHZSnERa42KzPqmYOKNo1IE6GTSHs3uoOd5H+iQyubwuuYTIbsN8G1rWa95QBY2w
         5NoU0ZXnOk7Cc6F2GhM7hNl2RgtKluw7WieNChRHm//JAW/JzVF8euEdt7HH+gOcpjub
         TyHzBhmLSElsZt+08UCQ+OkMfEag1PtlCSgXsEXaABU+bRmVHS1zkCwvQmb03y8tjEOn
         wOsaGDPYuvKRuIkl4icX4FrD7+1NdKCZW/MQPKiO1g4kq6t8R8ti7CkEXcm+MEl0q/6n
         taww==
X-Gm-Message-State: AOAM532fiygAOBNdW+MiJWO6OqWWcFrAFd0u1RQzB3yfIpxBTRqgkW3w
        JNdVw24nrmT0Dw6UaVsel3Df04vEC6jiWMNpdmKlJBoWCpT+Fn5Smt/C3inRxDEiS+gTT6tDjug
        PJW8x+GfCIhYTvllX8UecjOJX
X-Received: by 2002:a05:6000:188d:: with SMTP id a13mr7447584wri.297.1642147329115;
        Fri, 14 Jan 2022 00:02:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyjqJT5sGU0ZJyw8nvYxiwmgy2EIiuoaOLJLNLYx14PQLad/rO2oCWq7DkWPydBZBlnn2TR1Q==
X-Received: by 2002:a05:6000:188d:: with SMTP id a13mr7447566wri.297.1642147328909;
        Fri, 14 Jan 2022 00:02:08 -0800 (PST)
Received: from steredhat (host-95-238-125-214.retail.telecomitalia.it. [95.238.125.214])
        by smtp.gmail.com with ESMTPSA id o12sm5576911wrc.69.2022.01.14.00.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 00:02:08 -0800 (PST)
Date:   Fri, 14 Jan 2022 09:02:05 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH] vhost: cache avail index in vhost_enable_notify()
Message-ID: <20220114080205.ls4txgj7qbqmc3q5@steredhat>
References: <20220113145642.205388-1-sgarzare@redhat.com>
 <CACGkMEsqY5RHL=9=iny6xRVs_=EdACUCfX-Rmpq+itpdoT_rrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACGkMEsqY5RHL=9=iny6xRVs_=EdACUCfX-Rmpq+itpdoT_rrg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 02:18:01PM +0800, Jason Wang wrote:
>On Thu, Jan 13, 2022 at 10:57 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> In vhost_enable_notify() we enable the notifications and we read
>> the avail index to check if new buffers have become available in
>> the meantime. In this case, the device would go to re-read avail
>> index to access the descriptor.
>>
>> As we already do in other place, we can cache the value in `avail_idx`
>> and compare it with `last_avail_idx` to check if there are new
>> buffers available.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>Patch looks fine but I guess we won't get performance improvement
>since it doesn't save any userspace/VM memory access?

It should save the memory access when vhost_enable_notify() find 
something new in the VQ, so in this path:

     vhost_enable_notify() <- VM memory access for avail index
       == true

     vhost_disable_notify()
     ...

     vhost_get_vq_desc()   <- VM memory access for avail index
                              with the patch applied, this access is 
                              avoided since avail index is cached

In any case, I don't expect this to be a very common path, indeed we
usually use unlikely() for this path:

     if (unlikely(vhost_enable_notify(dev, vq))) {
         vhost_disable_notify(dev, vq);
         continue;
     }

So I don't expect a significant performance increase.

v1 coming with a better commit description.

Thanks,
Stefano

