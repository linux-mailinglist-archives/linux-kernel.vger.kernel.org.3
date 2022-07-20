Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DCF57B0B5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 08:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238287AbiGTGC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 02:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238271AbiGTGC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 02:02:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5F3E6112A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 23:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658296974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5qSlOOqa9pjYDS1sew6GhfkwCDtmx0x/6i+h3cZ9Bmk=;
        b=TjBOamF3xn83AsePUk9TlX2TdNCUgHAuzYTU3robmAo8xDvsIrV/SpiUf9B+xjHMhnfPEN
        W7N9AJadcmd3z9iKHKAO+U+CjtIArEyo83Sit2uSNS11K/HzD6q9VRPJ8elWkCw31sNEdl
        CH1WpAlwsGmTUkFCHdpOaHF0YcLMUOU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-gt0XeBqsP-yJbI_-oW5K-g-1; Wed, 20 Jul 2022 02:02:53 -0400
X-MC-Unique: gt0XeBqsP-yJbI_-oW5K-g-1
Received: by mail-lj1-f199.google.com with SMTP id t7-20020a2e9d07000000b0025dc0e59778so1184017lji.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 23:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5qSlOOqa9pjYDS1sew6GhfkwCDtmx0x/6i+h3cZ9Bmk=;
        b=dkrqKVSTznw+D48bLmlOIE/lzjOXOLxes4UY/UPwVhJ8qlUclYbLqMKpRN0j6e3Y8G
         q4UVal4O24eawB5qmW2P+zuS6/QM2BhC21Kf1AA+/tqHjz4YFSyXYNQWRFrXlvsNyEsU
         vT6XzaRLAoU6lWx5T/UXlNSL9EZYOsb+XE6hQ0mdozGx0a+PvNcI1GuAbygJHJKXJi7r
         nKFEbX2QTccWS8Yolgw6HGBHzlr7rPtyRYW7s3C7UXBhUrWM6UroxUmDRh05z1dr2Y54
         3Z5etoO3pl4n2sDuEcH8v34hukcE3lNg5iOwPTh+9zhi6v8mQZEnbW/HnLzW180KpC+8
         Hagw==
X-Gm-Message-State: AJIora8zGS35mKwM+b/4T/sMvrvfTWNJ3XlD3rqehU8YzNnAjsNeqjIC
        21vQfwSmaMY9/CfU9z3qLqyVxkPGzk/xg+m32zJ5F4QPmT7gOazC2DXcBPz89eDuA7PcWRTxQA3
        GIybilxM2k7Iif3v9fg3z8VU8ziGDKZFPBFuD53lQ
X-Received: by 2002:a2e:1451:0:b0:25d:7899:eddc with SMTP id 17-20020a2e1451000000b0025d7899eddcmr15522168lju.251.1658296971816;
        Tue, 19 Jul 2022 23:02:51 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sCT3a+QjzGD1xM3FZeEHdTLeQ5Zd53UwxVpJR1nmyG+13WdVT95LePIzIgq7ki9IQVh+FaiaxUX+Nhr6op0l0=
X-Received: by 2002:a2e:1451:0:b0:25d:7899:eddc with SMTP id
 17-20020a2e1451000000b0025d7899eddcmr15522161lju.251.1658296971533; Tue, 19
 Jul 2022 23:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220720044144.90-1-xieyongji@bytedance.com> <20220720044144.90-2-xieyongji@bytedance.com>
In-Reply-To: <20220720044144.90-2-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 20 Jul 2022 14:02:40 +0800
Message-ID: <CACGkMEsx1QAkK0UHSmzj0=sm_RwY0PiG02gZa-Mff_Wsf022yQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] vduse: Remove unnecessary spin lock protection
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     mst <mst@redhat.com>, Liu Xiaodong <xiaodong.liu@intel.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 12:42 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> Now we use domain->iotlb_lock to protect two different
> variables: domain->bounce_maps->bounce_page and
> domain->iotlb. But for domain->bounce_maps->bounce_page,
> we actually don't need any synchronization between
> vduse_domain_get_bounce_page() and vduse_domain_free_bounce_pages()
> since vduse_domain_get_bounce_page() will only be called in
> page fault handler and vduse_domain_free_bounce_pages() will
> be called during file release.
>
> So let's remove the unnecessary spin lock protection in
> vduse_domain_get_bounce_page(). Then the usage of
> domain->iotlb_lock could be more clear: the lock will be
> only used to protect the domain->iotlb.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/vdpa_user/iova_domain.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
> index 6daa3978d290..bca1f0b8850c 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -211,17 +211,14 @@ static struct page *
>  vduse_domain_get_bounce_page(struct vduse_iova_domain *domain, u64 iova)
>  {
>         struct vduse_bounce_map *map;
> -       struct page *page = NULL;
> +       struct page *page;
>
> -       spin_lock(&domain->iotlb_lock);
>         map = &domain->bounce_maps[iova >> PAGE_SHIFT];
>         if (!map->bounce_page)
> -               goto out;
> +               return NULL;
>
>         page = map->bounce_page;
>         get_page(page);
> -out:
> -       spin_unlock(&domain->iotlb_lock);
>
>         return page;
>  }
> --
> 2.20.1
>

