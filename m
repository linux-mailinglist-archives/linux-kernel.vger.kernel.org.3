Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8462D53A606
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 15:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240364AbiFANiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 09:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353290AbiFANiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:38:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 403CA5F269
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 06:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654090682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IvrCNRXCazmiTGI84GoccDVofe1EBkASPxviHdEDhYI=;
        b=E8pjv/GI7apjAmcy3qrZjsGn9QpyI7PQRkJCQI8CPgsUp/NbjXctLZ1DTPLo5OU8k5DEAa
        oPGCAkEld3ij0nbxCdYtaupbaB9dn0lJ7N0pqvZ3p78r7J/1mfY1MIwABJj13BT+oWILFB
        mCp4NkavLXIuvlGe43FFNiuXI379C4w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-bm0OqgH6PSeSzQXPs2kzpA-1; Wed, 01 Jun 2022 09:37:58 -0400
X-MC-Unique: bm0OqgH6PSeSzQXPs2kzpA-1
Received: by mail-wm1-f70.google.com with SMTP id i30-20020a1c541e000000b0039c1bf9739fso917861wmb.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 06:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=IvrCNRXCazmiTGI84GoccDVofe1EBkASPxviHdEDhYI=;
        b=5bV0WTAkE2FKr20r52XMPE2IRif3DtXOGzKanVA5USDBnOAHxPJkFPIkB0sLpFAjum
         XuQC77JJP+9oIAO4IhJeeNyGK3uUC2e+1l2ii9pzH+pVOyoazPRIm5ark8jY0faHO2kp
         w/WntNvzLqTkrp5/nQi1zzmcJOlPCpU6N9uGvgoglUlAlIqvMDb/cFqvsEOKZB+x3BRw
         ro/r5KXNRRvFCpGp7+IOpJ/GjKOzfqeo742fJEXYs0LKrsmJ8NGe5iCIkL8tNku3a4fd
         1Cfa0BnwqXZbwG3lk+LAGVj9xW/XhYWWEfo2/ws2mNbgBdkiMWEBQjbCal3vXR5pklZF
         c0NA==
X-Gm-Message-State: AOAM533g5v+sZ1Fkvf2VD6W+UTSpgtjIeERwPGN7btfxIkwApSFGlgqb
        biBi9u1cRA8uX5h8OE6pHgKhRxGYrqr/vZwV+UlSQIFYJdh/tilEj+qlMZCvGgg9Amd9mETHKud
        BawsUAmECRjVtTUmJ3LZ58mZZ
X-Received: by 2002:adf:e58c:0:b0:210:2f76:93fc with SMTP id l12-20020adfe58c000000b002102f7693fcmr14439937wrm.573.1654090677778;
        Wed, 01 Jun 2022 06:37:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPJjny9EEpZxgvOYA+JuC+sAEWEALch9FLpvGi6zxKd3fa5TGpUJ/JOOocoNyN+CRX8eso4A==
X-Received: by 2002:adf:e58c:0:b0:210:2f76:93fc with SMTP id l12-20020adfe58c000000b002102f7693fcmr14439921wrm.573.1654090677480;
        Wed, 01 Jun 2022 06:37:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:2600:951d:63df:c091:3b45? (p200300cbc7052600951d63dfc0913b45.dip0.t-ipconnect.de. [2003:cb:c705:2600:951d:63df:c091:3b45])
        by smtp.gmail.com with ESMTPSA id z2-20020adff1c2000000b0020c5253d8dcsm1536613wro.40.2022.06.01.06.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 06:37:56 -0700 (PDT)
Message-ID: <d5f4c444-032d-81f6-c7b8-6e1627aaf7f7@redhat.com>
Date:   Wed, 1 Jun 2022 15:37:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/4] mm/shmem: return -EINVAL for addr not PAGE_SIZE
 aligned
Content-Language: en-US
To:     Chen Wandun <chenwandun@huawei.com>, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220601124417.2872001-1-chenwandun@huawei.com>
 <20220601124417.2872001-3-chenwandun@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220601124417.2872001-3-chenwandun@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.06.22 14:44, Chen Wandun wrote:
> If addr is not PAGE_SIZE aligned, return -EINVAL directly.

Why is this one to be treated in a special way compared to all of the
other related checks?

> Besides, use macro offset_in_page to check addr is not
> PAGE_SIZE aligned case.

Using offset_in_page() LGTM.

> 
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
> ---
>  mm/shmem.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 80c361c3d82c..1136dd7da9e5 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2143,8 +2143,8 @@ unsigned long shmem_get_unmapped_area(struct file *file,
>  		return addr;
>  	if (IS_ERR_VALUE(addr))
>  		return addr;
> -	if (addr & ~PAGE_MASK)
> -		return addr;
> +	if (offset_in_page(addr))
> +		return -EINVAL;
>  	if (addr > TASK_SIZE - len)
>  		return addr;
>  
> @@ -2197,7 +2197,7 @@ unsigned long shmem_get_unmapped_area(struct file *file,
>  	inflated_addr = get_area(NULL, uaddr, inflated_len, 0, flags);
>  	if (IS_ERR_VALUE(inflated_addr))
>  		return addr;
> -	if (inflated_addr & ~PAGE_MASK)
> +	if (offset_in_page(inflated_addr))
>  		return addr;
>  
>  	inflated_offset = inflated_addr & (HPAGE_PMD_SIZE-1);


-- 
Thanks,

David / dhildenb

