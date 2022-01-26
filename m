Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A595749C756
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239835AbiAZKVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:21:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30006 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229517AbiAZKVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643192491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=92KZPMW0jptBf5RLKOdQ+QTWZRzIJi7nuYsRDKcCMjs=;
        b=ZbHqZPTOUYmjgagRLdyLsMCIaubt/2BH+Uf9bFK5PToTzqGxnfpj+XMgmXKTf46uAIcBiK
        sufJZLAzdqoMzEvPfGgZr2xIlLV7t6jPPMDr3XEcqHA8DF341qWQKwajPkWqH30yTYehnV
        mfZ9Xat9sjy6tTY8RRwh6UrouQU5Bh0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-6IxH_xyzO3i9QlhqNRa7gA-1; Wed, 26 Jan 2022 05:21:30 -0500
X-MC-Unique: 6IxH_xyzO3i9QlhqNRa7gA-1
Received: by mail-wr1-f69.google.com with SMTP id s25-20020adfa299000000b001d8d032255fso4073579wra.14
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 02:21:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=92KZPMW0jptBf5RLKOdQ+QTWZRzIJi7nuYsRDKcCMjs=;
        b=WT6Mmbk64F/osPiQhPbeUr2K5A+G/s12BreoBU+ay0CSWO+uMSZNR5G3xGPCdL2xgc
         Xob58EvqPnpAK06pOfqXNZR9iCAsMUIgCtGXz5YAVwLiRJ6FD6emOghYFf+q+01rOyPg
         Lg+jVs1mjUtp4u/MfHvklmx4JFNDaj2FoGMjq/MBwA6kJzV1Qe1OLAbQCqLxeEe09UwS
         6Oh/0b+KRNz+z0QLzH2GJdGKSVDb8sr/BBdepXvVF6mJdranf/GfZoAy+4A72zlD2nBX
         +hl1xmCxKPXvUXZjZK/V5UuCZkXrTdNvScGqC0dazFB5GcQPHhZ+KayeFQFYy1TKEb2v
         Rvdw==
X-Gm-Message-State: AOAM530DPGgUNRRSflV7EuLnhuX1tiCE4nnowNE61PuRGdKIKfP+msID
        Edgk1b8PCOeny3ptdBnXud2QEbHltkYdaYm8z/b5sWfBo4zpb+Be3olSVFsZTTV3xJqOEmuXzMv
        WxtkhSoAgrd5Ny+meBxXGGTtD
X-Received: by 2002:adf:df10:: with SMTP id y16mr16376806wrl.277.1643192489280;
        Wed, 26 Jan 2022 02:21:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwEni0z4gqz5DzLcFFRuOR+CO55fI2vlOCnRMsOgYr3M4kj1IKrM0qdWis6q87sAMbohDhY6Q==
X-Received: by 2002:adf:df10:: with SMTP id y16mr16376795wrl.277.1643192489086;
        Wed, 26 Jan 2022 02:21:29 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:2700:cdd8:dcb0:2a69:8783? (p200300cbc7092700cdd8dcb02a698783.dip0.t-ipconnect.de. [2003:cb:c709:2700:cdd8:dcb0:2a69:8783])
        by smtp.gmail.com with ESMTPSA id c14sm1073474wri.56.2022.01.26.02.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 02:21:28 -0800 (PST)
Message-ID: <4b1bf433-067b-ebfb-4603-2e31e1990f77@redhat.com>
Date:   Wed, 26 Jan 2022 11:21:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] mm/highmem: remove unnecessary done label
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220126092542.64659-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220126092542.64659-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.01.22 10:25, Miaohe Lin wrote:
> Remove unnecessary done label to simplify the code.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/highmem.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/highmem.c b/mm/highmem.c
> index 762679050c9a..0cc0c4da7ed9 100644
> --- a/mm/highmem.c
> +++ b/mm/highmem.c
> @@ -736,11 +736,11 @@ void *page_address(const struct page *page)
>  		list_for_each_entry(pam, &pas->lh, list) {
>  			if (pam->page == page) {
>  				ret = pam->virtual;
> -				goto done;
> +				break;
>  			}
>  		}
>  	}
> -done:
> +
>  	spin_unlock_irqrestore(&pas->lock, flags);
>  	return ret;
>  }
> @@ -773,13 +773,12 @@ void set_page_address(struct page *page, void *virtual)
>  		list_for_each_entry(pam, &pas->lh, list) {
>  			if (pam->page == page) {
>  				list_del(&pam->list);
> -				spin_unlock_irqrestore(&pas->lock, flags);
> -				goto done;
> +				break;
>  			}
>  		}
>  		spin_unlock_irqrestore(&pas->lock, flags);
>  	}
> -done:
> +
>  	return;
>  }
>  

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

