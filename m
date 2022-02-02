Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47A14A7241
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344531AbiBBNxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:53:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40266 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229529AbiBBNxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:53:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643809987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dzs3pmpsecqWwS28UKT/9n4YfyBZy50vlVYoCws6yUE=;
        b=Z1C4nylYj5BpS6MbkJffKjGwySKJMVJOh5lLnQiJWrOXZChxc47Famx5vV+MgjD3zsVyto
        N4CJzzOaTuCG2r1gifAanXvsRzcqLhoSKSG18TvjVfqhy9C8CGSH9TKS8aHcIRRtvKKZes
        enEth73mhdZb6K/nJf/NjpaZsoRU180=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-UsMlXa4kP4Cv0P2VlZU6vA-1; Wed, 02 Feb 2022 08:53:06 -0500
X-MC-Unique: UsMlXa4kP4Cv0P2VlZU6vA-1
Received: by mail-qv1-f72.google.com with SMTP id iw14-20020a0562140f2e00b004204be8b6baso18804924qvb.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 05:53:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dzs3pmpsecqWwS28UKT/9n4YfyBZy50vlVYoCws6yUE=;
        b=qQT9I1UBa5+72Bjk81jf/eaFBVIeAf04C8gogizek7G/z//8/HcydXOcOSb2I6Oi1Z
         U46EYEf2OVrqGrs4bni2X36OZQr1Lx8fltydi2J+XrtEt1Zh5fXQLI2Cs8X1bJX9BHF9
         coTCPgJmg+4vUixmnRvEqZUI+aJk6OCDBJIPAnulNzoVGzLYrzXHm483br+5SmicmZk3
         rEQCr/Em3o52eBF4P3sVYqEKXP4aTy0JMzoFHiIbutMh8eG36BJJNxFuDXuPEnQyxUj6
         jsnBwstyhexVV4Vc7ccrzZu0jXSXb5va0eFT6XJald8s/kj56I2V18EZ1P2ukisG47Kr
         26Nw==
X-Gm-Message-State: AOAM5309ylEzJEHeFaxhpzyvrn4g4EwG+jop4FmBnUWQRm+smhlZF7Ka
        JzRd5uTH9bHe38DwJl/BcK/DF/I7n+Q5FBWr/BgOcpPURRIc7vOW9kw/Pn8nxORJ+zdYx75jjRh
        r5T4Pl/RCcwvIA7DZmT2k6cBe
X-Received: by 2002:ad4:5dc4:: with SMTP id m4mr26516022qvh.17.1643809985997;
        Wed, 02 Feb 2022 05:53:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy97PB6hOF6XRVh0laZSCO/T0ng/aOceXJMUfGN81RQHfwOdZhjN5x8YkGsaZRSWfCtenz6QA==
X-Received: by 2002:ad4:5dc4:: with SMTP id m4mr26516006qvh.17.1643809985739;
        Wed, 02 Feb 2022 05:53:05 -0800 (PST)
Received: from steredhat (host-95-238-125-214.retail.telecomitalia.it. [95.238.125.214])
        by smtp.gmail.com with ESMTPSA id c14sm10955065qtc.31.2022.02.02.05.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 05:53:05 -0800 (PST)
Date:   Wed, 2 Feb 2022 14:53:00 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v3] vhost: cache avail index in vhost_enable_notify()
Message-ID: <20220202135300.5b366wk35ysqehgm@steredhat>
References: <20220128094129.40809-1-sgarzare@redhat.com>
 <Yfpnlv2GudpPFwok@stefanha-x1.localdomain>
 <20220202062340-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220202062340-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 06:24:05AM -0500, Michael S. Tsirkin wrote:
>On Wed, Feb 02, 2022 at 11:14:30AM +0000, Stefan Hajnoczi wrote:
>> On Fri, Jan 28, 2022 at 10:41:29AM +0100, Stefano Garzarella wrote:
>> > In vhost_enable_notify() we enable the notifications and we read
>> > the avail index to check if new buffers have become available in
>> > the meantime.
>> >
>> > We do not update the cached avail index value, so when the device
>> > will call vhost_get_vq_desc(), it will find the old value in the
>> > cache and it will read the avail index again.
>> >
>> > It would be better to refresh the cache every time we read avail
>> > index, so let's change vhost_enable_notify() caching the value in
>> > `avail_idx` and compare it with `last_avail_idx` to check if there
>> > are new buffers available.
>> >
>> > We don't expect a significant performance boost because
>> > the above path is not very common, indeed vhost_enable_notify()
>> > is often called with unlikely(), expecting that avail index has
>> > not been updated.
>> >
>> > We ran virtio-test/vhost-test and noticed minimal improvement as
>> > expected. To stress the patch more, we modified vhost_test.ko to
>> > call vhost_enable_notify()/vhost_disable_notify() on every cycle
>> > when calling vhost_get_vq_desc(); in this case we observed a more
>> > evident improvement, with a reduction of the test execution time
>> > of about 3.7%.
>> >
>> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> > ---
>> > v3
>> > - reworded commit description [Stefan]
>> > ---
>> >  drivers/vhost/vhost.c | 3 ++-
>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> > index 59edb5a1ffe2..07363dff559e 100644
>> > --- a/drivers/vhost/vhost.c
>> > +++ b/drivers/vhost/vhost.c
>> > @@ -2543,8 +2543,9 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>> >  		       &vq->avail->idx, r);
>> >  		return false;
>> >  	}
>> > +	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
>> >
>> > -	return vhost16_to_cpu(vq, avail_idx) != vq->avail_idx;
>> > +	return vq->avail_idx != vq->last_avail_idx;
>> >  }
>> >  EXPORT_SYMBOL_GPL(vhost_enable_notify);
>>
>> This changes behavior (fixes a bug?): previously the function returned
>> false when called with avail buffers still pending (vq->last_avail_idx <
>> vq->avail_idx). Now it returns true because we compare against
>> vq->last_avail_idx and I think that's reasonable.

Good catch!

>>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>
>I don't see the behaviour change... could you explain the
>scanario in more detail pls?

IIUC the behavior is different only when the device calls 
vhost_enable_notify() with pending buffers (vq->avail_idx != 
vq->last_avail_idx).

Let's suppose that driver has not added new available buffers, so value 
in cache (vq->avail_idx) is equal to the one we read back from the 
guest, but the device has not consumed all available buffers 
(vq->avail_idx != vq->last_avail_idx).

Now if the device call vhost_enable_notify(), before this patch it 
returned false, because there are no new buffers added (even if there 
are some pending), with this patch it returns true, because there are 
still some pending buffers (vq->avail_idx != vq->last_avail_idx).

IIUC the right behavior should be the one with the patch applied.
However this difference would be seen only if we call 
vhost_enable_notify() when vq->avail_idx != vq->last_avail_idx and 
checking vhost-net, vhost-scsi and vhost-vsock, we use the return value 
of vhost_enable_notify() only when there are not available buffers, so 
vq->avail_idx == vq->last_avail_idx.

So I think Stefan is right, but we should never experience the buggy 
scenario.

it seems that we used to check vq->last_avail_idx but we changed it 
since commit 8dd014adfea6 ("vhost-net: mergeable buffers support"), 
honestly I don't understand if it was intended or not.

Do you see any reason?

Thanks,
Stefano

