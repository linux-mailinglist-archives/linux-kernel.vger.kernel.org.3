Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC62572D8C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 07:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbiGMFoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 01:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiGMFoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 01:44:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABC9233401
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657691043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sogOu0Je2hI8kCeSkB7cNWVEmJuAsjifkkQViIo6h78=;
        b=b0Z0dSW1durBSaZ7SutJDvSrLd2jeQdNNfZr2Lrc2bUy1e2tWOhqDf+KT20jXgECb16xAa
        oKsg1+T+oQbG9xOezZ/ybDNRmQFrKqGyxQzxtug8+HMVo7A1pJrLrbVwAwterUzOUqWqdB
        mCmpiloUv0O4k/N7BFWUg8smfdeI5hU=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-PrLjoZApPq6WaZ8Mk-eqnw-1; Wed, 13 Jul 2022 01:44:02 -0400
X-MC-Unique: PrLjoZApPq6WaZ8Mk-eqnw-1
Received: by mail-pg1-f198.google.com with SMTP id v202-20020a6361d3000000b0041615ebed02so3307224pgb.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sogOu0Je2hI8kCeSkB7cNWVEmJuAsjifkkQViIo6h78=;
        b=SlUj5m7TtmU6oA7Eyh3h66H0BSkwkFJDbsmwP2cTub7vq+9ZOZysYScEyUjAj6Z8Qa
         6R+bLs058DWIyecGd3OS1G/myH4fA+xgj7IFeDDOd9ym7ViSiFQNby+vBBzz91Um//L0
         z+UUZfeLyG7oi3cc5o3A7LOnjobUCmbnZMrw09elubjrRIeIgxDybD+K870WyBoAgeyY
         E+LYlZDwDKJyG76g1V6V3DyNIuo67ARlWyXyjN//FyGHBKjhx/+qeJSNs1F5RKDKp5L2
         3W1FTcWwqXz/7mpxomyB3bdYOgZ8f0b/vnvg+wmXJYf8TXBexdcLDnCF5REFneXaSIvb
         savA==
X-Gm-Message-State: AJIora9UBoh4Q0nSmQvSrYrtJQGOQORa42U3tKH2AQUklFnu1r+0LTUt
        ZT3G+gfnLB2B5fIlDEyUZQjmuR7t8REtPQnabENY1UGSRKlQ6I3KS0mu4fchqQBNjrk4ZwhQQ/9
        Ieqbl5Eek1qbCnuI3Ky5k+1Z7
X-Received: by 2002:a05:6a00:c95:b0:52b:e4c:19d5 with SMTP id a21-20020a056a000c9500b0052b0e4c19d5mr575691pfv.50.1657691041131;
        Tue, 12 Jul 2022 22:44:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1syH+1nFx4fKmmG1nejbbinYoF6wkNNQaFi8/VZ2oi6PeG4TpUQIBxAubV7u0BXIAuFc5S89Q==
X-Received: by 2002:a05:6a00:c95:b0:52b:e4c:19d5 with SMTP id a21-20020a056a000c9500b0052b0e4c19d5mr575672pfv.50.1657691040884;
        Tue, 12 Jul 2022 22:44:00 -0700 (PDT)
Received: from [10.72.12.200] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b21-20020aa79515000000b0052ac5e304ccsm6121714pfp.194.2022.07.12.22.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 22:44:00 -0700 (PDT)
Message-ID: <1106133f-ebd4-f6a8-83ab-19e995bcdba6@redhat.com>
Date:   Wed, 13 Jul 2022 13:43:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/5] vduse: Remove unnecessary spin lock protection
Content-Language: en-US
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        xiaodong.liu@intel.com, maxime.coquelin@redhat.com,
        stefanha@redhat.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20220706050503.171-1-xieyongji@bytedance.com>
 <20220706050503.171-2-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220706050503.171-2-xieyongji@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/7/6 13:04, Xie Yongji 写道:
> Taking iotlb lock to access bounce page in page fault
> handler is meaningless since vduse_domain_free_bounce_pages()
> would only be called during file release.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>   drivers/vdpa/vdpa_user/iova_domain.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
> index 6daa3978d290..bca1f0b8850c 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -211,17 +211,14 @@ static struct page *
>   vduse_domain_get_bounce_page(struct vduse_iova_domain *domain, u64 iova)
>   {
>   	struct vduse_bounce_map *map;
> -	struct page *page = NULL;
> +	struct page *page;
>   
> -	spin_lock(&domain->iotlb_lock);
>   	map = &domain->bounce_maps[iova >> PAGE_SHIFT];
>   	if (!map->bounce_page)
> -		goto out;
> +		return NULL;


Interesting, I wonder why we don't serialize with 
vduse_domain_map_bounce_page() with iotlb_lock?

Thanks


>   
>   	page = map->bounce_page;
>   	get_page(page);
> -out:
> -	spin_unlock(&domain->iotlb_lock);
>   
>   	return page;
>   }

