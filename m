Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849D94EA8C3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 09:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiC2HwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 03:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbiC2HwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:52:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DAFC209A62
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 00:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648540232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HHYas20bFA+kNgMHaxoIQKsMvNcafn9rtG/cGQWeJ9M=;
        b=Zo6ty+hOTEmURP+TdqUWLsb1KPMTt145QDnODGBMpnjZoeL+84/AqGBEEYXTDlvn4vnvXF
        rnoe63XGY5LZKAy4jCBHO7y/oosPZ8bqksCTRWgIfWUXijEzU+y4V6LJYc67D1biJcIT96
        i60pe1FvIcP4KSDeAICIC4UcUvPBn10=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-FI236TXxP1C4Ehj5DcEIwg-1; Tue, 29 Mar 2022 03:50:31 -0400
X-MC-Unique: FI236TXxP1C4Ehj5DcEIwg-1
Received: by mail-qk1-f199.google.com with SMTP id w200-20020a3762d1000000b0067d2149318dso10011527qkb.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 00:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HHYas20bFA+kNgMHaxoIQKsMvNcafn9rtG/cGQWeJ9M=;
        b=SL1hP/PzkGsYmxtJ7C+fH2hswIMtQsFbX4bFlZzNVGKAtGFrNm2MroAxhvbpL0fMD5
         qQuXXnKtlzJf4Di9XLqLFYf8YZ4Oc101aqaATpIdCFAD0EUVR/rwHmwzy8/j0Ky/I7Ig
         C+W5oOh4NgGsc3bvpxpXNurEhGnzWn28ABj7hIh5auQyLiSPurBOfwgcwUhP5zWppsop
         j4ui6fIX++iXnucz09YQH9oYsIk0CxF4GKuPihMkmmaMz2Z5Z0M/6ymTfqpdsT5Edu4m
         I6XOtdvCSYDpy/nqBS4Fg5aDO0n4JDtt1/eUCJQ5PmbFEkK+IfUu6M4NfljSJUcZ919w
         iooQ==
X-Gm-Message-State: AOAM5323CSNcof4s3d1TIqW+QWEfrRszCEwf6TP+pS2HfmaEVeNQfXIn
        WC4DkbCmBcMduZ3EACYqlpNwFSU+09wtD04/vN423Vp1Yjft2PLGx1lSj5ivrNM70e/0hqf8OJM
        m8uKdVe7G4kiAhpoIstR4fQhg
X-Received: by 2002:a05:6214:4016:b0:441:28a4:52ff with SMTP id kd22-20020a056214401600b0044128a452ffmr24894022qvb.74.1648540230485;
        Tue, 29 Mar 2022 00:50:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBn1dkAlRDwy4hsXt41FSpdVAAm3YfVvYIpXoTpkqSVyseUq6Uo9uoTaE6ItLGVv55uUz6aA==
X-Received: by 2002:a05:6214:4016:b0:441:28a4:52ff with SMTP id kd22-20020a056214401600b0044128a452ffmr24894016qvb.74.1648540230285;
        Tue, 29 Mar 2022 00:50:30 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-67.retail.telecomitalia.it. [79.46.200.67])
        by smtp.gmail.com with ESMTPSA id x19-20020a05620a14b300b0067e09a47e39sm8843107qkj.34.2022.03.29.00.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 00:50:29 -0700 (PDT)
Date:   Tue, 29 Mar 2022 09:50:24 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] virtio_ring: add unlikely annotation for free descs
 check
Message-ID: <20220329075024.eoajm5ufrcfytug4@sgarzare-redhat>
References: <20220328105817.1028065-1-xianting.tian@linux.alibaba.com>
 <20220328105817.1028065-2-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220328105817.1028065-2-xianting.tian@linux.alibaba.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 06:58:17PM +0800, Xianting Tian wrote:
>The 'if (vq->vq.num_free < descs_used)' check will almost always be false.
>
>Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>---
> drivers/virtio/virtio_ring.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>index d597fc0874ec..ab6d5f0cb579 100644
>--- a/drivers/virtio/virtio_ring.c
>+++ b/drivers/virtio/virtio_ring.c
>@@ -525,7 +525,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> 		descs_used = total_sg;
> 	}
>
>-	if (vq->vq.num_free < descs_used) {
>+	if (unlikely(vq->vq.num_free < descs_used)) {
> 		pr_debug("Can't add buf len %i - avail = %i\n",
> 			 descs_used, vq->vq.num_free);
> 		/* FIXME: for historical reasons, we force a notify here if
>-- 
>2.17.1
>

