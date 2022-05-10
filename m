Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F8352139A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240923AbiEJL03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239602AbiEJL0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:26:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC92823EB66
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652181744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D4785r27233Ml+uZtnZNjcNdrWzVl9UsExUsQlhNDXI=;
        b=BFSnH0VA88HR2FDpAVJYGfU7Z+R9ffqFf4QXfdw9sxPgHL600m5DMpcSed/mx/DvB97E8g
        FSdSBQeUxRrIV+NqnKQQtSHEjGpySHvrzeVILyfD1L46GR/RPy5ZtM/EAsaf4LWcwQ+Gqa
        pQzs3WXK9lKRLLbvIHeWpAbiLMpmKvA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-330-FaPo-ATVMbqH3r51BuAMvQ-1; Tue, 10 May 2022 07:22:22 -0400
X-MC-Unique: FaPo-ATVMbqH3r51BuAMvQ-1
Received: by mail-wm1-f70.google.com with SMTP id k5-20020a05600c0b4500b003941ca130f9so5163851wmr.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D4785r27233Ml+uZtnZNjcNdrWzVl9UsExUsQlhNDXI=;
        b=J/RwH6QgAj6TwoarBxnzD9uhRzI1Px7p70DV0xHfOcmiPRD3DE3CCt0XNnHG6zO65i
         JWA89A08zSYTi2qxHFKrH82V2yfedAoPpcRn7tghTn2XTL3ULciqN5Qeh1rf4Zw9Rfur
         FeCKCVVRa72AOzwQR/1PxlDQdU8dl7bzWxDqIffA3laXgU8aySAq1qDagvpvDW8KmHRC
         wno/RGrtjtTYJv2BqV+C0hbZtLd0Y4d7c9eAtjFefu7kq6JvLH+qd1f3kefsVKvMolMO
         l8qqA+hIo32n5zSlTbO/L3+GCK/E4V9dYXkVkJkxVv2dI41ew6LETBJoiBQ3EYUoy3kN
         w1aQ==
X-Gm-Message-State: AOAM533MGKRb31GsN8dev3LjNm8cqhMtwLCw7zL77/em3/zgM0a5Re3k
        XJKa8nO7YjvZgxe9nljanjWjAK/C/2m+9lT2CDT4nDIRqhKCxZjCPrzEmTsjyUA2/cGS22gdnxb
        9w56qbZCBFtzIest7Cq+PQAbi
X-Received: by 2002:a5d:5051:0:b0:20a:e005:cca3 with SMTP id h17-20020a5d5051000000b0020ae005cca3mr17795091wrt.560.1652181741631;
        Tue, 10 May 2022 04:22:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9tr6mSmtvQ50bZR7deuOD32uuBMCg9W5pDvp0BbCM1/ro5QrbdARz9/itKP70Q+2PP0bUsQ==
X-Received: by 2002:a5d:5051:0:b0:20a:e005:cca3 with SMTP id h17-20020a5d5051000000b0020ae005cca3mr17795072wrt.560.1652181741436;
        Tue, 10 May 2022 04:22:21 -0700 (PDT)
Received: from redhat.com ([2.55.130.230])
        by smtp.gmail.com with ESMTPSA id q9-20020adfea09000000b0020c5253d8desm13912558wrm.42.2022.05.10.04.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 04:22:20 -0700 (PDT)
Date:   Tue, 10 May 2022 07:22:17 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] virtio: fix virtio transitional ids
Message-ID: <20220510072157-mutt-send-email-mst@kernel.org>
References: <20220510102723.87666-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510102723.87666-1-mie@igel.co.jp>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 07:27:23PM +0900, Shunsuke Mie wrote:
> This commit fixes the transitional PCI device ID.
> 
> Fixes: d61914ea6ada ("virtio: update virtio id table, add transitional ids")
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>

Absolutely! I don't understand how I could have missed this.

Applied, thanks!

> ---
>  include/uapi/linux/virtio_ids.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
> index 80d76b75bccd..7aa2eb766205 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -73,12 +73,12 @@
>   * Virtio Transitional IDs
>   */
>  
> -#define VIRTIO_TRANS_ID_NET		1000 /* transitional virtio net */
> -#define VIRTIO_TRANS_ID_BLOCK		1001 /* transitional virtio block */
> -#define VIRTIO_TRANS_ID_BALLOON		1002 /* transitional virtio balloon */
> -#define VIRTIO_TRANS_ID_CONSOLE		1003 /* transitional virtio console */
> -#define VIRTIO_TRANS_ID_SCSI		1004 /* transitional virtio SCSI */
> -#define VIRTIO_TRANS_ID_RNG		1005 /* transitional virtio rng */
> -#define VIRTIO_TRANS_ID_9P		1009 /* transitional virtio 9p console */
> +#define VIRTIO_TRANS_ID_NET		0x1000 /* transitional virtio net */
> +#define VIRTIO_TRANS_ID_BLOCK		0x1001 /* transitional virtio block */
> +#define VIRTIO_TRANS_ID_BALLOON		0x1002 /* transitional virtio balloon */
> +#define VIRTIO_TRANS_ID_CONSOLE		0x1003 /* transitional virtio console */
> +#define VIRTIO_TRANS_ID_SCSI		0x1004 /* transitional virtio SCSI */
> +#define VIRTIO_TRANS_ID_RNG		0x1005 /* transitional virtio rng */
> +#define VIRTIO_TRANS_ID_9P		0x1009 /* transitional virtio 9p console */
>  
>  #endif /* _LINUX_VIRTIO_IDS_H */
> -- 
> 2.17.1

