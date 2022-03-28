Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280A84EA1E6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237603AbiC1Uty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345990AbiC1UsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:48:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35A456A017
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 13:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648500317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LnKa6nTnZjVyLapB3u+K+tVTv5yyqsbvt80uXn7tlqE=;
        b=gyQv/AiZ0N8h3MNrVbQXTzadeTBTyZFwlEZjvA/MqKlIl4iCezJrU8plIxkVvQaxLkp22G
        lRargrdEeYim/0PcBQrGy4Au61PBzmifjBIoRC0aghEz6bNkpaDiCJD7H3+htJnJzTimzG
        NE8s4nZKsnMz429hwXBaMT9DrjyXky8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-Vwd9AbrgOT-C12bqMmwThQ-1; Mon, 28 Mar 2022 16:45:15 -0400
X-MC-Unique: Vwd9AbrgOT-C12bqMmwThQ-1
Received: by mail-wm1-f70.google.com with SMTP id v2-20020a05600c214200b0038c7c02deceso206217wml.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 13:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LnKa6nTnZjVyLapB3u+K+tVTv5yyqsbvt80uXn7tlqE=;
        b=XKy0R16f6luRxP9V6OiM+oIDCOibdw9HqzpwP0fUN7qxpYGqzURzHSMhjov7IDYAqM
         gzguZRQGcZoD0Ch2kowz6CRzfvvWJQfTztay+yf2JNuZQoX+raQGYKXWG3XK3SpK1A5b
         T+3+aHe/FgZnZslPZGtG6FQYiR/OVsNZdVb9k5h+QckYliKdG74FV+HivjUu3aR1grS3
         0Lee0JWyi+ygXyWz+t0l6tQXqHuaTHjEsU3aU2rBYljLXMJB/38syRloVrEPucZDf1tr
         y/NG3KGgHoaDNXPxk5nBGnN7sYrx6Mifvq+Ym7HEZ/5Cuzcr40kfBDCbsLxPENq/iVyw
         5JSw==
X-Gm-Message-State: AOAM5302sa1iSQez/Pl9KMzCj5ZP5CJ2zPRF+3oEoIVvCuY9rVpEv9GN
        0s8A7j6rKyhQ7/H6ZDVygzIJ5j1gHtvhVqjHrMnMu67pHz6RGFu7qcu+kyZ8hm9G9NwCSXwVz6V
        HIu7dzcdSTdGrZQaRVbwKHpB0
X-Received: by 2002:adf:ed50:0:b0:203:da73:e0fd with SMTP id u16-20020adfed50000000b00203da73e0fdmr26662472wro.516.1648500313607;
        Mon, 28 Mar 2022 13:45:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw074Uoe8XwVEA8gx6KrACZhH+gFVcy6Xz6Ap01CnGtcLywUMvECryjGZs5gVgeUc2Qy60EGg==
X-Received: by 2002:adf:ed50:0:b0:203:da73:e0fd with SMTP id u16-20020adfed50000000b00203da73e0fdmr26662453wro.516.1648500313409;
        Mon, 28 Mar 2022 13:45:13 -0700 (PDT)
Received: from redhat.com ([2.52.9.207])
        by smtp.gmail.com with ESMTPSA id z3-20020a1cf403000000b0037d1f4a2201sm431912wma.21.2022.03.28.13.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 13:45:12 -0700 (PDT)
Date:   Mon, 28 Mar 2022 16:45:08 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     cgel.zte@gmail.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] virito-pci-modern: Remove useless DMA-32 fallback
 configuration
Message-ID: <20220328164435-mutt-send-email-mst@kernel.org>
References: <20220318005858.2141967-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318005858.2141967-1-chi.minghao@zte.com.cn>
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Typo in subj, and pls make subject match actual file name (_ not -).


On Fri, Mar 18, 2022 at 12:58:58AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> As stated in [1], dma_set_mask() with a 64-bit mask will never fail if
> dev->dma_mask is non-NULL.
> So, if it fails, the 32 bits case will also fail for the same reason.
> 
> Simplify code and remove some dead code accordingly.
> 
> [1]: https://lkml.org/lkml/2021/6/7/398
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/virtio/virtio_pci_modern_dev.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index e8b3ff2b9fbc..dff0b15a239d 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -255,9 +255,6 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
>  	}
>  
>  	err = dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(64));
> -	if (err)
> -		err = dma_set_mask_and_coherent(&pci_dev->dev,
> -						DMA_BIT_MASK(32));
>  	if (err)
>  		dev_warn(&pci_dev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
>  
> -- 
> 2.25.1

