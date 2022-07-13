Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B4C572DC7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 07:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiGMF5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 01:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiGMF5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 01:57:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2999431233
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657691856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=boFEgVNblenrHqqVS1jnj2EIYdHHRnh1yN8Lis/KYmM=;
        b=ithWByiWa3G8piXnpKay9MC+AmX3p2ALeFlfOkqc8Y56mkKD0D9IkUBaBklAUftZUJc6qV
        GRtYvLXT9CpY3s0DpUmeY6Kh5F55TVzjx9RWHks0Vyqv+evBiVEGtlDn2pQdDYAWZSyowU
        POzPmX6B/831KWU7R84Xh7zcfRYxqd8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-272-owzbgF2wP06sAeml8LoNEA-1; Wed, 13 Jul 2022 01:57:28 -0400
X-MC-Unique: owzbgF2wP06sAeml8LoNEA-1
Received: by mail-wm1-f72.google.com with SMTP id z24-20020a1c4c18000000b003a2e963c399so507108wmf.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=boFEgVNblenrHqqVS1jnj2EIYdHHRnh1yN8Lis/KYmM=;
        b=K04drWmrZciWTAE7mR9N+li2CS+M/rMJxY4kBB5vpX2a1cYlhFuAjo9X8nhTN+75DL
         ECGvTU1fuqa7n0tdt1gwPLSL6OGSaBDqKXxUx8yXzjpHkwtDUZCKULtJAlB7na0A3rJK
         vhoQR6x53+o5zwnd9p+KKnEbxxfqslloCoiRtDXykCHh6Qxs6nGS3e21siK5BD12ALRQ
         8Vbn3PBYmOb2q3P+tQcXSXLM6uk67TLszZVswmBXeIlbAgQfBQTGW7zGOqP01NP1EFTg
         yJMX30A+AQwplrME/zb7c0DibmiHsngZ2CPmwYoFuvQcJsIwbdGEo+P+Lb+bCL6EHEwP
         mXmA==
X-Gm-Message-State: AJIora96J68yQf628gimCQHjb+1S8yTrEKhzLU9MFT1AGen3R2F1BPrz
        XdliOna/7UIDSLNMxKHF6aDGdiunbCXsBr7rs/JCSkaecCmr2QpyOk8G7iQEZesFuNya7ukhHDz
        F7h85i/iv/c6jn6vc+t4YkGU+
X-Received: by 2002:a1c:e90c:0:b0:3a0:4c68:f109 with SMTP id q12-20020a1ce90c000000b003a04c68f109mr1621690wmc.56.1657691847728;
        Tue, 12 Jul 2022 22:57:27 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uSytF+rvA1u+0E60+EIyQ2fAAbilzoYpgj7lzqFVhdTGbFXS0W78UwvlB3/qhIbzv2YWWIHw==
X-Received: by 2002:a1c:e90c:0:b0:3a0:4c68:f109 with SMTP id q12-20020a1ce90c000000b003a04c68f109mr1621674wmc.56.1657691847492;
        Tue, 12 Jul 2022 22:57:27 -0700 (PDT)
Received: from redhat.com ([2.52.24.42])
        by smtp.gmail.com with ESMTPSA id co1-20020a0560000a0100b0021cf31e1f7csm9833670wrb.102.2022.07.12.22.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 22:57:26 -0700 (PDT)
Date:   Wed, 13 Jul 2022 01:57:23 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     jasowang@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com,
        songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] vduse: Remove unnecessary spin lock protection
Message-ID: <20220713015352-mutt-send-email-mst@kernel.org>
References: <20220706050503.171-1-xieyongji@bytedance.com>
 <20220706050503.171-2-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706050503.171-2-xieyongji@bytedance.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 01:04:59PM +0800, Xie Yongji wrote:
> Taking iotlb lock to access bounce page in page fault
> handler is meaningless since vduse_domain_free_bounce_pages()
> would only be called during file release.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

vduse_domain_free_bounce_pages is not the
only one taking this lock. This commit log needs more
analysis documenting all points of access to bounce_maps
and why vduse_domain_get_bounce_page and file
release are the only two.

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
>  	struct vduse_bounce_map *map;
> -	struct page *page = NULL;
> +	struct page *page;
>  
> -	spin_lock(&domain->iotlb_lock);
>  	map = &domain->bounce_maps[iova >> PAGE_SHIFT];
>  	if (!map->bounce_page)
> -		goto out;
> +		return NULL;
>  
>  	page = map->bounce_page;
>  	get_page(page);
> -out:
> -	spin_unlock(&domain->iotlb_lock);
>  
>  	return page;
>  }
> -- 
> 2.20.1

