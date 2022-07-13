Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40589572DCC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 07:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbiGMF7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 01:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiGMF72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 01:59:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9AD3541997
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657691965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mzD6kdHxiY7mtO/Z6JY7Tp5Pi+RySdvVPmDOY2LGqsM=;
        b=eoFQQJPS+Lf3vZo1LDu/2js+PT2/an07gcJF5gY9ulFG1RaPeYaf2M81RtZY+OEErBGLnS
        yTOqAN9txdq2PO2VDAFW+SnOKaSEIqUfsMfANGb9kyMxTAvRnUsMT2Aq8zdRFS38JVeInW
        qU7Dc4Q6CXXXuSiaKx9I9t1ChLYlTbs=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-YutpjvuLMPm-mKdVF4meog-1; Wed, 13 Jul 2022 01:59:23 -0400
X-MC-Unique: YutpjvuLMPm-mKdVF4meog-1
Received: by mail-pf1-f198.google.com with SMTP id f13-20020a056a001acd00b0052ab9ae76fbso3411773pfv.20
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mzD6kdHxiY7mtO/Z6JY7Tp5Pi+RySdvVPmDOY2LGqsM=;
        b=vmZJHv7u4bxoutvZaoe7t+lGgqHW4EqcFTdz0jEULdwOIbQSgd9V+toLRkEvP4K5GR
         pjpNNZ5UsTsYNaBQwSiDXPodmOqholzLQsCdhYXvz/0BWBmuRj47RbSlTXz2LX45iyFF
         lP6yJptpewuERL5SAxAmkZMyrfO+N2d0vqr6JAZ6AA9NMMFxPnVVVhO1TC07qKSL7Jpp
         Ypa2jlUcpzsUMqwLd4jG9jfh4onLOd7miaoCI/sY5C/3z5LpobMLElZ+LEHks7+fCknh
         BGgLtgQbv/nBi/4nn9sIQwIilJjjM5+fcc2KWK38RNUFF7ygcfbliPm3wSj5w3N2Iyga
         sYpA==
X-Gm-Message-State: AJIora8cxEEK1hncVuE0j2qON7SBD8Z233Bm4ok9PUWp9IrhfOL1ge1D
        loMj9+D46AQ4+Mg3VUflAIOa5HVERBbKTr0l3ezQ2+gelYKleYGl7Cmg4XNS+gaJxMBid9Bq3FB
        t9Hb7jCJ5gBqLAQ1MFo7lcOw4
X-Received: by 2002:a05:6a00:319c:b0:52a:ccb2:ee0b with SMTP id bj28-20020a056a00319c00b0052accb2ee0bmr1537214pfb.59.1657691962687;
        Tue, 12 Jul 2022 22:59:22 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uWhjXpvdfdtRhWbr1DHQCetvgqmrYhUYE0vPFHOhNUEsXrMGuKxs6K+M0pz7/rLa0NzPcRMQ==
X-Received: by 2002:a05:6a00:319c:b0:52a:ccb2:ee0b with SMTP id bj28-20020a056a00319c00b0052accb2ee0bmr1537192pfb.59.1657691962403;
        Tue, 12 Jul 2022 22:59:22 -0700 (PDT)
Received: from [10.72.12.200] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t123-20020a625f81000000b0052842527052sm7769513pfb.189.2022.07.12.22.59.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 22:59:21 -0700 (PDT)
Message-ID: <44610c2a-9fd1-8d15-a792-a96900e89424@redhat.com>
Date:   Wed, 13 Jul 2022 13:59:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/5] vduse: Use memcpy_{to,from}_page() in do_bounce()
Content-Language: en-US
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        xiaodong.liu@intel.com, maxime.coquelin@redhat.com,
        stefanha@redhat.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20220706050503.171-1-xieyongji@bytedance.com>
 <20220706050503.171-3-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220706050503.171-3-xieyongji@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/7/6 13:05, Xie Yongji 写道:
> kmap_atomic() is being deprecated in favor of kmap_local_page().
>
> The use of kmap_atomic() in do_bounce() is all thread local therefore
> kmap_local_page() is a sufficient replacement.
>
> Convert to kmap_local_page() but, instead of open coding it,
> use the helpers memcpy_to_page() and memcpy_from_page().
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/vdpa/vdpa_user/iova_domain.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
> index bca1f0b8850c..50d7c08d5450 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -138,18 +138,17 @@ static void do_bounce(phys_addr_t orig, void *addr, size_t size,
>   {
>   	unsigned long pfn = PFN_DOWN(orig);
>   	unsigned int offset = offset_in_page(orig);
> -	char *buffer;
> +	struct page *page;
>   	unsigned int sz = 0;
>   
>   	while (size) {
>   		sz = min_t(size_t, PAGE_SIZE - offset, size);
>   
> -		buffer = kmap_atomic(pfn_to_page(pfn));
> +		page = pfn_to_page(pfn);
>   		if (dir == DMA_TO_DEVICE)
> -			memcpy(addr, buffer + offset, sz);
> +			memcpy_from_page(addr, page, offset, sz);
>   		else
> -			memcpy(buffer + offset, addr, sz);
> -		kunmap_atomic(buffer);
> +			memcpy_to_page(page, offset, addr, sz);
>   
>   		size -= sz;
>   		pfn++;

