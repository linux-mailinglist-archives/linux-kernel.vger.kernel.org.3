Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3DA55139D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240397AbiFTJC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240405AbiFTJCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:02:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2ED3612D21
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655715763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jAde9gW+1E+Bg88jRc4YpK5LYKa9XhMsApgmKpLZr1g=;
        b=Tdd7BxZZfW5yArsvATx+vCCa4AoWjD1a4FmPhUc9ovMybfpqoiWYOSgLmFro8onNBmAhiR
        4zklpyS222AMQn+G0fHyzuAWkLGMg0eGsUI05EfMZwVWA/VF82GQdMKpv/HOslcdCixRWw
        DUZOo7IZOsXoyhITj4Bnen7nS1WtQpQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-ULf2eY2oP9u5SmsdentuEg-1; Mon, 20 Jun 2022 05:02:41 -0400
X-MC-Unique: ULf2eY2oP9u5SmsdentuEg-1
Received: by mail-ed1-f71.google.com with SMTP id y18-20020a056402441200b0043564cdf765so5860536eda.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jAde9gW+1E+Bg88jRc4YpK5LYKa9XhMsApgmKpLZr1g=;
        b=P1GaGVqAYCOfOy0vtuvk435CM/X3HVousBgjq/yyySLVgU//5M6Veacvr5tKDA2iaV
         pJp1MqiNYvflBNz9KFw47uwucAoEpQQnxoejSagqvOG0+lF+GG5uenabnhXslyaBaNBJ
         /OOZ6ft+thpsu+UkQEnWEdnuQt4Xls4nWZF717D3N3f47iwaJvdQPxn6fhmiAnNCaHXA
         hiIcugnsTVT5YtmhXoqt3Vv58veLtGuK5bFVHF6PqWwBVjMbTAfDjfLwH/73qRjkpc2r
         NtrNCWc+PkJ7ks0TRfSio6VYn6fzvyVAMWBX8b7t5dpMtdU6w7Pa7qTeJ3gFBjSeE/bk
         9+kw==
X-Gm-Message-State: AJIora/NNKS9hiQYyG3H8ROEUliclwJqkSQLYKO5n5RzfaJ+Ef1uVJNs
        2Iok6+ta4gxRjVPLuexxtOXlMxxL52gwD7FJdQXkZLYlZxqvSbkJ4zhv20CacTwySInZfodhZ23
        Thq6Ji1m5eRM9zxv6Wf18fsGv
X-Received: by 2002:a50:fe0c:0:b0:435:510a:9f1f with SMTP id f12-20020a50fe0c000000b00435510a9f1fmr23840080edt.297.1655715760476;
        Mon, 20 Jun 2022 02:02:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vR73OReUjUkvQTJsfAwPok8qnZD3rOMArwZSq2BbKzkF2vuaTPU20W5RxJwXNZeljCKNGQDw==
X-Received: by 2002:a50:fe0c:0:b0:435:510a:9f1f with SMTP id f12-20020a50fe0c000000b00435510a9f1fmr23840060edt.297.1655715760310;
        Mon, 20 Jun 2022 02:02:40 -0700 (PDT)
Received: from redhat.com ([2.52.146.221])
        by smtp.gmail.com with ESMTPSA id b5-20020a056402138500b00431962fe5d4sm9680017edv.77.2022.06.20.02.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 02:02:39 -0700 (PDT)
Date:   Mon, 20 Jun 2022 05:02:34 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org, erwan.yvin@stericsson.com
Subject: Re: [PATCH 1/3] caif_virtio: remove virtqueue_disable_cb() in probe
Message-ID: <20220620050044-mutt-send-email-mst@kernel.org>
References: <20220620051115.3142-1-jasowang@redhat.com>
 <20220620051115.3142-2-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620051115.3142-2-jasowang@redhat.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 01:11:13PM +0800, Jason Wang wrote:
> This disabling is a just a hint with best effort, there's no guarantee
> that device doesn't send notification. The driver should survive with
> that, so let's remove it.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

I guess, but frankly this change feels gratituous, and just might
uncover latent bugs. Which would be fine if we were out to
find and fix them, but given this was compile-tested only,
I'm not sure that's the case.


> ---
>  drivers/net/caif/caif_virtio.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/caif/caif_virtio.c b/drivers/net/caif/caif_virtio.c
> index 5458f57177a0..c677ded81133 100644
> --- a/drivers/net/caif/caif_virtio.c
> +++ b/drivers/net/caif/caif_virtio.c
> @@ -705,9 +705,6 @@ static int cfv_probe(struct virtio_device *vdev)
>  	netdev->needed_headroom = cfv->tx_hr;
>  	netdev->needed_tailroom = cfv->tx_tr;
>  
> -	/* Disable buffer release interrupts unless we have stopped TX queues */
> -	virtqueue_disable_cb(cfv->vq_tx);
> -
>  	netdev->mtu = cfv->mtu - cfv->tx_tr;
>  	vdev->priv = cfv;
>  
> -- 
> 2.25.1

