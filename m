Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0750595D8B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbiHPNlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbiHPNlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:41:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8629C75CC3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660657277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1UCrYFr0DcB0r8pAF7e2ByinvijBGvEey6g1DDxFix8=;
        b=CsfEe8vYFB5kHeW9TzU2ewNc6WlP+O5wNSXynJEz9o2HRZhF1/My45Qpplgjlmrhy4WAi5
        RgkKOaSle8BP87/u6Za6PQ2DAWaF9njLsV+cWzCNuKAzaBoMXRpmzG7A7N1cBuytlBU6Lp
        PW+FoSkurEkQijWqyzib2dW/ZxKJYWI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-556-_WRAgBiRMsWx2pfGzWCPUQ-1; Tue, 16 Aug 2022 09:41:16 -0400
X-MC-Unique: _WRAgBiRMsWx2pfGzWCPUQ-1
Received: by mail-wr1-f69.google.com with SMTP id d18-20020adf9b92000000b0022503144f4fso1369621wrc.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=1UCrYFr0DcB0r8pAF7e2ByinvijBGvEey6g1DDxFix8=;
        b=a3ifEpxWznZlx1pob+Os8MDboJr+RxAdioPJpI39/DGlCdtA1dM62TKozm3KHlt+M3
         Coq41uVbHFqa7IlQNOg4v+4/lU+LKAxgiC5ghNdU1bkCQt1X3WbNSraKr49Yf19VPcUL
         YVDjEz5PdCd/NsNDmAAlZfUxZktNBFg+89Ab5moqIY89VBuUB0xOrEgTmnJQSm91DnpK
         pj8SS2gWAtRlqcHp0/FsMmz3N9fK1vzG7CP3Ah0w0LenJp3VBdnXJUhJAs7DTUxebVep
         uPkR6FWTr1PiF/F4IzbnZbcftrQ4yTQoDo6i99YlVDdwt7KJd+kwG+djLLQVMOxWfoxk
         rYdw==
X-Gm-Message-State: ACgBeo2fLIgY7I0ja5l1TKTrsapuXeiu9GFOO5Va5+03EFvNy7m+nmTb
        fvXGbqR7jGIxJeTWMD8CzHwswfW0vX/Vc6DAeTv3eWTRl4m1ro+S/Gi1iT/73+LA7NeMT1AULib
        hfDiNcak6k05NtGXLdcsMre/B
X-Received: by 2002:a5d:5281:0:b0:224:fe40:798f with SMTP id c1-20020a5d5281000000b00224fe40798fmr6859126wrv.90.1660657275095;
        Tue, 16 Aug 2022 06:41:15 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5ZTvheSv0ssbv5tHt+swIqUffpectLQQ19ywUNmPTvA8oR25a/bCcOt24S9+Qd7ZYoOOBDOA==
X-Received: by 2002:a5d:5281:0:b0:224:fe40:798f with SMTP id c1-20020a5d5281000000b00224fe40798fmr6859117wrv.90.1660657274871;
        Tue, 16 Aug 2022 06:41:14 -0700 (PDT)
Received: from redhat.com ([2.55.43.215])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0ad500b003a53e6c5425sm12677021wmr.8.2022.08.16.06.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 06:41:14 -0700 (PDT)
Date:   Tue, 16 Aug 2022 09:41:11 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/virtio: fix repeated words in comments
Message-ID: <20220816094100-mutt-send-email-mst@kernel.org>
References: <20220816125959.23737-1-yuanjilin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816125959.23737-1-yuanjilin@cdjrlc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 08:59:59PM +0800, Jilin Yuan wrote:
>  Delete the redundant word 'the'.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>

send this kind of thing to trivial pls.

> ---
>  drivers/virtio/virtio_mmio.c           | 2 +-
>  drivers/virtio/virtio_pci_modern_dev.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index f9a36bc7ac27..f638142654e6 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -255,7 +255,7 @@ static void vm_set_status(struct virtio_device *vdev, u8 status)
>  
>  	/*
>  	 * Per memory-barriers.txt, wmb() is not needed to guarantee
> -	 * that the the cache coherent memory writes have completed
> +	 * that the cache coherent memory writes have completed
>  	 * before writing to the MMIO region.
>  	 */
>  	writel(status, vm_dev->base + VIRTIO_MMIO_STATUS);
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index a0fa14f28a7f..b790f30b2b56 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -469,7 +469,7 @@ void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
>  
>  	/*
>  	 * Per memory-barriers.txt, wmb() is not needed to guarantee
> -	 * that the the cache coherent memory writes have completed
> +	 * that the cache coherent memory writes have completed
>  	 * before writing to the MMIO region.
>  	 */
>  	vp_iowrite8(status, &cfg->device_status);
> -- 
> 2.36.1

