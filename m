Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E3B5A0971
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236578AbiHYHD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbiHYHDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:03:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BEFA1D60
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661411032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Ffg639fyFav+yTERy7xieKmvjhwhKltTl/7JA3fe1o=;
        b=RflCKUJJm0slv4OFe1zBDy73bvHnU2M/hu/LdhYrGfQHfhmdcZOnDTEnfAZErkKUU4Qm5A
        nnCFIrxvtiOO13eW97accZNk7mn40ceFWYwmsEGhDEi5zvuc4EbzDeFLanZTayLZSazPOf
        8hwSnQ6FZ0X9pUZoMMIXKH61Uuzw4bQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-152-sWHdnmL1MZ-P4ASNY7l6Kw-1; Thu, 25 Aug 2022 03:03:51 -0400
X-MC-Unique: sWHdnmL1MZ-P4ASNY7l6Kw-1
Received: by mail-pj1-f70.google.com with SMTP id z8-20020a17090a014800b001fac4204c7eso2033362pje.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=+Ffg639fyFav+yTERy7xieKmvjhwhKltTl/7JA3fe1o=;
        b=aBU+kSDBpLUctsjQDhgVrwL3vAfA7V8cwCQJ+S1SFioIBdos9ASIdQKFg+8UTPy3Lu
         u3Si47tMWkvpoL7U9k7al+vz2kLAhBDqRYKG78XpwpjqX1OSMyAKX9ySrIkvKPd5YnU5
         uQBnTyBByh9WRw7dM+19ozDRLJ3COquyuB977P4wT1wwTPxznNxJqFqkKHQb5Pb4H2Sf
         3tCa/a5zAT3MwSt0M5hiSmgXa0zu0GdpGs6r42hdfRvcX8/b/DH3h1UOpWBB0+mktjaD
         KboiYtGpAyxLaBAQxPJe3nVxZAJBeBYQKl6PRCvaX2Vig22FW9i3vY2Zg1hXfQQv6qg8
         vXbg==
X-Gm-Message-State: ACgBeo1+B4mjR4vLdJxGj/IZjLlQuDzTH5Gmfla5FwIL+tXfSW93EYuk
        JK9wjREVeN+rU3obc+aG6/xG09Xd/aZBTfaTaMt8qf5LiRbNE6MgJ9P02VGhPQXFOKRTTTjC4Rd
        4tZmp+PpDnexeSWOUEYoESz3t
X-Received: by 2002:a17:903:120c:b0:170:aa42:dbba with SMTP id l12-20020a170903120c00b00170aa42dbbamr2638229plh.67.1661411029960;
        Thu, 25 Aug 2022 00:03:49 -0700 (PDT)
X-Google-Smtp-Source: AA6agR71A9+1ssM8l0gU1/rJujbzZ0dEmhpSI0OZl7bEsrI1ruifEdYAsxDq2H0vI9SqQdgeiSLCKg==
X-Received: by 2002:a17:903:120c:b0:170:aa42:dbba with SMTP id l12-20020a170903120c00b00170aa42dbbamr2638212plh.67.1661411029695;
        Thu, 25 Aug 2022 00:03:49 -0700 (PDT)
Received: from [10.72.12.107] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g11-20020a170902e38b00b001726ea1b716sm559783ple.237.2022.08.25.00.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 00:03:49 -0700 (PDT)
Message-ID: <06761c62-93b4-8eaa-370f-f26b7c5306ca@redhat.com>
Date:   Thu, 25 Aug 2022 15:03:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [RFC v2 2/7] vhost_test: batch used buffer
Content-Language: en-US
To:     Guo Zhi <qtxuning1999@sjtu.edu.cn>, eperezma@redhat.com,
        sgarzare@redhat.com, mst@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
References: <20220817135718.2553-1-qtxuning1999@sjtu.edu.cn>
 <20220817135718.2553-3-qtxuning1999@sjtu.edu.cn>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220817135718.2553-3-qtxuning1999@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/8/17 21:57, Guo Zhi 写道:
> Only add to used ring when a batch of buffer have all been used.  And if
> in order feature negotiated, only add the last used descriptor for a
> batch of buffer.
>
> Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
> ---
>   drivers/vhost/test.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
> index bc8e7fb1e635..57cdb3a3edf6 100644
> --- a/drivers/vhost/test.c
> +++ b/drivers/vhost/test.c
> @@ -43,6 +43,9 @@ struct vhost_test {
>   static void handle_vq(struct vhost_test *n)
>   {
>   	struct vhost_virtqueue *vq = &n->vqs[VHOST_TEST_VQ];
> +	struct vring_used_elem *heads = kmalloc(sizeof(*heads)
> +			* vq->num, GFP_KERNEL);


Though it's a test device, it would be better to try avoid memory 
allocation in the datapath.

And where is is freed?

Thanks


> +	int batch_idx = 0;
>   	unsigned out, in;
>   	int head;
>   	size_t len, total_len = 0;
> @@ -84,11 +87,14 @@ static void handle_vq(struct vhost_test *n)
>   			vq_err(vq, "Unexpected 0 len for TX\n");
>   			break;
>   		}
> -		vhost_add_used_and_signal(&n->dev, vq, head, 0);
> +		heads[batch_idx].id = cpu_to_vhost32(vq, head);
> +		heads[batch_idx++].len = cpu_to_vhost32(vq, len);
>   		total_len += len;
>   		if (unlikely(vhost_exceeds_weight(vq, 0, total_len)))
>   			break;
>   	}
> +	if (batch_idx)
> +		vhost_add_used_and_signal_n(&n->dev, vq, heads, batch_idx);
>   
>   	mutex_unlock(&vq->mutex);
>   }

