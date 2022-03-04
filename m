Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147C64CD972
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240831AbiCDQtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240819AbiCDQs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:48:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B39FB199D6A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646412489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NXHJzGIO2DpN/950dP0XzRsezt/Kr2kOdiCXWPNUhtA=;
        b=jEQU5Ia4q6Lwo+Phgf20/VVT4/zWZC55Df3nSp+ASeFyVdXqHZtTWzUtjhRuRT8sArfzZi
        rIvilCTmxmOlNVbaAKn/t/rR+4QoYdM4WuWx/PVBgW2YHKu0dNVgEbwWafnvh+20kD7ma5
        FahfknBb4GzaE0hPrXjeSn4+rjy4DGA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-OcPtPjQiNEKv68NrUBW2sQ-1; Fri, 04 Mar 2022 11:48:08 -0500
X-MC-Unique: OcPtPjQiNEKv68NrUBW2sQ-1
Received: by mail-wr1-f69.google.com with SMTP id c5-20020adffb05000000b001edbbefe96dso3543135wrr.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 08:48:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NXHJzGIO2DpN/950dP0XzRsezt/Kr2kOdiCXWPNUhtA=;
        b=lXipB1QCLD2RVzEcxE6vSuUN5wi4IDrh1qBu/XBYCBdHLSKTJnnZ1FQfewohf2xIra
         Drkn58uizsGOZlJtuR/G7rMNvaxK/gmYsTpDQnkr5cIEe/LBBFbqBNjQp8neUBcCZpNl
         ELCWgJt5PmoCVWReOFjxw9xLGJjyHSRncZbMbKUU9IaiN1gSyDN9bkXJ7UAPMDRffm49
         6WtiSOaWEVvob9Arb7nJECbZf2Jfm/hNjYNwnAHYtCSFnotV6t1uHdGoRBeHJauQt3nt
         9qKAte9RGFg/5iQTKCTDF9ArKFUj5NxxF4t2ZBhzoJX9zwm4XYauqJ1DQYtEd2xBlzbc
         Io+g==
X-Gm-Message-State: AOAM531sYD1HOF+6K/C6S/mJToYtFIOK9ZLDNLC2T2uZGavS9k1wZlbh
        wtKyUawEzcYznBYO/kDK/IrJi8Q9Q+QcnzIkLEikYjLegI29AyGzLC+yiy/uxt50uctZzeCbmGa
        v/S1VpQHkWlzqwaDMnoaR4LKM
X-Received: by 2002:a5d:4485:0:b0:1ef:d619:4de2 with SMTP id j5-20020a5d4485000000b001efd6194de2mr18533930wrq.88.1646412486245;
        Fri, 04 Mar 2022 08:48:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw1LHmfxoByV3G55D7/RSII3aDqbhXifikAKYkjpTRjhuQFLuDvl21okW72hfANNpBtEJwK+g==
X-Received: by 2002:a5d:4485:0:b0:1ef:d619:4de2 with SMTP id j5-20020a5d4485000000b001efd6194de2mr18533913wrq.88.1646412485973;
        Fri, 04 Mar 2022 08:48:05 -0800 (PST)
Received: from redhat.com ([2.52.16.157])
        by smtp.gmail.com with ESMTPSA id y12-20020adff14c000000b001f04d1959easm4999809wro.13.2022.03.04.08.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 08:48:05 -0800 (PST)
Date:   Fri, 4 Mar 2022 11:48:01 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     jasowang@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, stable@vger.kernel.org,
        syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <20220304114718-mutt-send-email-mst@kernel.org>
References: <20220302075421.2131221-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302075421.2131221-1-lee.jones@linaro.org>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 07:54:21AM +0000, Lee Jones wrote:
> vhost_vsock_handle_tx_kick() already holds the mutex during its call
> to vhost_get_vq_desc().  All we have to do is take the same lock
> during virtqueue clean-up and we mitigate the reported issues.
> 
> Link: https://syzkaller.appspot.com/bug?extid=279432d30d825e63ba00
> 
> Cc: <stable@vger.kernel.org>
> Reported-by: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

OK so please post series with this and the warning
cleaned up comments and commit logs explaining that
this is just to make debugging easier in case
we have issues in the future, it's not a bugfix.

> ---
>  drivers/vhost/vhost.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 59edb5a1ffe28..bbaff6a5e21b8 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -693,6 +693,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
>  	int i;
>  
>  	for (i = 0; i < dev->nvqs; ++i) {
> +		mutex_lock(&dev->vqs[i]->mutex);
>  		if (dev->vqs[i]->error_ctx)
>  			eventfd_ctx_put(dev->vqs[i]->error_ctx);
>  		if (dev->vqs[i]->kick)
> @@ -700,6 +701,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
>  		if (dev->vqs[i]->call_ctx.ctx)
>  			eventfd_ctx_put(dev->vqs[i]->call_ctx.ctx);
>  		vhost_vq_reset(dev, dev->vqs[i]);
> +		mutex_unlock(&dev->vqs[i]->mutex);
>  	}
>  	vhost_dev_free_iovecs(dev);
>  	if (dev->log_ctx)
> -- 
> 2.35.1.574.g5d30c73bfb-goog

