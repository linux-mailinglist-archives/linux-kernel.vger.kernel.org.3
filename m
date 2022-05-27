Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC76535EA9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245587AbiE0KuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242000AbiE0KuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:50:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65F1912B02B
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653648607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l2Lh+gpGDkrHKWoEv+QKFc0qknv05ZH2I5oLoT3BQ3w=;
        b=ez9AvT1B4NZ/MUDoOykLozkTNl8FJXcGC15qzLS0DRTXuXdkh63SwQEPnVC0UWwRtiA3sC
        2hxEopK8rrOzSipx/hZOzvb/vrd6hHPHXKOFv7/uc0fl5/eBb83K2zzHvMBs3A0eDTi5ga
        WXKypaY0X0DhTZWNPXoeAi2l7lEuYk8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-387-yJuHBR7mOgqLnyaEAAbrJA-1; Fri, 27 May 2022 06:50:06 -0400
X-MC-Unique: yJuHBR7mOgqLnyaEAAbrJA-1
Received: by mail-wm1-f72.google.com with SMTP id m10-20020a05600c3b0a00b003948b870a8dso4645661wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l2Lh+gpGDkrHKWoEv+QKFc0qknv05ZH2I5oLoT3BQ3w=;
        b=21pkoYYB/muzoYit4Gw5n8kXYv7l2mADQpdW3waaLaVrB2sUDVml8hxh+tjw2y5v6w
         jT2Stvbta9SwBnaI8ClfWSCbmN/eGU1dOQRgpclh5BAw4W6FY1hHGMn3RjhPVIp0QXdO
         7/25fdFsZmqeHkFt/mEjl6hi+QPucmu9CILI65iZK3SKv2UCB8NHQMRj0WQv7SMqiRZ9
         3wHgv8ZeupPM8GU/LmDE5IapUu24hcqveoSHY3d3S4xZX193ZEtVtporng0C1X36AAqV
         1g2cPe0BWopWveWSWK9Orp4WuaGJ4/lJUpgQIk2V5jXM4QVCup5AfFP+iADm8jO4RgWh
         zONA==
X-Gm-Message-State: AOAM530eDaNmYr8B29pc0t46sx+cNdgFsRest8w2OC/zri66xqVqqJji
        lClN/ejOLCnOzuYqs8f6vlVDb/Y0yohcOA4WiTtX3OTepAUJb8JD+hiwzB7wJRB6K/V8k5W/M7O
        gJzOqtZ/X+8WH7RpkWzijucsl
X-Received: by 2002:adf:d1e7:0:b0:20f:dd30:489b with SMTP id g7-20020adfd1e7000000b0020fdd30489bmr19682800wrd.94.1653648605107;
        Fri, 27 May 2022 03:50:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyS7mTUl4muodaOxpb3A92/00mQUnf2JML65CurJrTdcEaXMLxZDQNgec7W8o6+Bm+X58NZew==
X-Received: by 2002:adf:d1e7:0:b0:20f:dd30:489b with SMTP id g7-20020adfd1e7000000b0020fdd30489bmr19682778wrd.94.1653648604834;
        Fri, 27 May 2022 03:50:04 -0700 (PDT)
Received: from redhat.com ([2.55.130.213])
        by smtp.gmail.com with ESMTPSA id r2-20020a7bc082000000b00397402ae674sm1828344wmh.11.2022.05.27.03.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 03:50:04 -0700 (PDT)
Date:   Fri, 27 May 2022 06:50:00 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, paulmck@kernel.org, maz@kernel.org,
        pasic@linux.ibm.com, cohuck@redhat.com, eperezma@redhat.com,
        lulu@redhat.com, sgarzare@redhat.com, xuanzhuo@linux.alibaba.com,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH V6 9/9] virtio: use WARN_ON() to warning illegal status
 value
Message-ID: <20220527064118-mutt-send-email-mst@kernel.org>
References: <20220527060120.20964-1-jasowang@redhat.com>
 <20220527060120.20964-10-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527060120.20964-10-jasowang@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At a minimum, I don't see why it's part of the series. Host can always
crash the guest if it wants to ...
The point of BUG_ON is device or driver is already corrupted so we
should not try to drive it.  If you still want this in pls come up with
a better commit log explaining the why.

On Fri, May 27, 2022 at 02:01:20PM +0800, Jason Wang wrote:
> We used to use BUG_ON() in virtio_device_ready() to detect illegal

not really, BUG_ON just crashes the kernel.  we detect by checking
status.

> status value, this seems sub-optimal since the value is under the
> control of the device. Switch to use WARN_ON() instead.

some people use crash on warn so ...

> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
> Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Jason Wang <jasowang@redhat.com>

> ---
>  include/linux/virtio_config.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index d4edfd7d91bb..9a36051ceb76 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -255,7 +255,7 @@ void virtio_device_ready(struct virtio_device *dev)
>  {
>  	unsigned status = dev->config->get_status(dev);
>  
> -	BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> +	WARN_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
>  

we lose debuggability as guest will try to continue.
if we are doing this let us print a helpful message and dump a lot of
state right here.

>  	/*
>  	 * The virtio_synchronize_cbs() makes sure vring_interrupt()
> -- 
> 2.25.1

