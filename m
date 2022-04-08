Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF534F9134
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbiDHIzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbiDHIy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:54:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC4AE3693B6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 01:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649407967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xCLh2noLYHvoYJ5n2RIW5aWBr/p7U0RqG8wHzDGzBW4=;
        b=EdGaSpR13V/XnI3kDUVZ67+/kDVapEJmyBPHPk4Klzd0mF2MF3OMgoQJyfqc+NRyHg0MJB
        7Ps3zdhhrBHr52iPLKVO3nlwnQU/UEDdfJ4tHeT5f+Gii1zjQ/K67JGQ5T5DCV0uyoYElz
        Ez+sJ9qe+EC+VJNzNIMPsot5KD+0390=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-355-u151QTY-NXqv3xvkf4MaEw-1; Fri, 08 Apr 2022 04:52:46 -0400
X-MC-Unique: u151QTY-NXqv3xvkf4MaEw-1
Received: by mail-wr1-f69.google.com with SMTP id i64-20020adf90c6000000b00203f2b5e090so2021056wri.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 01:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=xCLh2noLYHvoYJ5n2RIW5aWBr/p7U0RqG8wHzDGzBW4=;
        b=YwkgBozRbDU69BG1rgC9X9KlmouJ4CzfLDlLvbfZTPCIV6W2JrzsRaAK7JAbwzezOy
         EQm69uI9GY1lt1OHg7ZgiX7bbeAgdZtA08jdUatEix07klRV1PVtCIBvEei7uJIeUGzV
         ++/rsRwJj0DeONBDosvMkgqzYVas5xe8VVMlgyhC+7ptRDqMyZ3CK4zitxv9GuQd+BG6
         Q6z1W5In38r4DvfW2VAvNy3mydftkS5LwQ97XsQZSGhK78CypX0RYfqdEp0CETCV8CAP
         1VFPbT7TRcECheVon7KN0non0rlRXQ8xeYwM8d9yiThZfWJ1o2XAsOyhFt6fKkt8T+LA
         2WPA==
X-Gm-Message-State: AOAM5315W9TZnaEf+MXfwa5pvsQEoeUA+LfZRRxAjC1KwbIQaWiB2E06
        SFPfi9hw6OsuKneZaHGRZ5ojDs1mlkw6TNHXIletBSKATtmEdIBdWH1cqfLl+St8+F4E2qdM0Nw
        TQg/rFG7Ha++76DOY9ylcA1Gp
X-Received: by 2002:adf:fdd0:0:b0:206:15b0:4478 with SMTP id i16-20020adffdd0000000b0020615b04478mr13626445wrs.266.1649407965376;
        Fri, 08 Apr 2022 01:52:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRqLFg7VzPUGFyZuzQrHaarDUcRgbWlUwak6IE3xfZBRbBHIjt56yN5nEb4kTyWJCpQKJlwg==
X-Received: by 2002:adf:fdd0:0:b0:206:15b0:4478 with SMTP id i16-20020adffdd0000000b0020615b04478mr13626428wrs.266.1649407965097;
        Fri, 08 Apr 2022 01:52:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:fd00:612:f12b:a4a2:26b0? (p200300cbc704fd000612f12ba4a226b0.dip0.t-ipconnect.de. [2003:cb:c704:fd00:612:f12b:a4a2:26b0])
        by smtp.gmail.com with ESMTPSA id y15-20020a056000168f00b002057a9f9f5csm23224387wrd.31.2022.04.08.01.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 01:52:44 -0700 (PDT)
Message-ID: <05ba9f7c-f124-2696-2673-3d7e6763c8c1@redhat.com>
Date:   Fri, 8 Apr 2022 10:52:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 2/3] mm/memory-failure.c: minor cleanup for
 HWPoisonHandlable
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com
Cc:     shy828301@gmail.com, mike.kravetz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220407130352.15618-1-linmiaohe@huawei.com>
 <20220407130352.15618-3-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220407130352.15618-3-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.04.22 15:03, Miaohe Lin wrote:
> The local variable movable can be removed by returning true directly. Also
> fix typo 'mirgate'. No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/memory-failure.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 2e97302d62e4..bd563f47630c 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1180,13 +1180,11 @@ void ClearPageHWPoisonTakenOff(struct page *page)
>   */
>  static inline bool HWPoisonHandlable(struct page *page, unsigned long flags)
>  {
> -	bool movable = false;
> -
> -	/* Soft offline could mirgate non-LRU movable pages */
> +	/* Soft offline could migrate non-LRU movable pages */
>  	if ((flags & MF_SOFT_OFFLINE) && __PageMovable(page))
> -		movable = true;
> +		return true;
>  
> -	return movable || PageLRU(page) || is_free_buddy_page(page);
> +	return PageLRU(page) || is_free_buddy_page(page);
>  }
>  
>  static int __get_hwpoison_page(struct page *page, unsigned long flags)

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

