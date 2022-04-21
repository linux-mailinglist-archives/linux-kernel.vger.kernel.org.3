Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA895098C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385630AbiDUHMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385605AbiDUHMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:12:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A957E13F31
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650525002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=63ViWfLlmaj/DhjRP9oFB/1KLHxLMeQrGcqkKvT3aeA=;
        b=QcxqVShYQymURTOj3Hw/XPcWdNd3zsKfvzCfVN7fZA6cf5LBfoieZ9DsVjMf5JHZoq+Ozr
        CRsLRk/pU+wtzp1PL+3RFBhtagBHOdhGYu+v50nlQU7ShWlUp7fev2Jq/MlulPpnE0zVUl
        vDrB6JWpeUqj5EPTR3iaow9zNVqoJUM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-368-l4XnEuEXOKCO4ZpfkwJbVg-1; Thu, 21 Apr 2022 03:10:01 -0400
X-MC-Unique: l4XnEuEXOKCO4ZpfkwJbVg-1
Received: by mail-wr1-f71.google.com with SMTP id i64-20020adf90c6000000b00203f2b5e090so824471wri.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=63ViWfLlmaj/DhjRP9oFB/1KLHxLMeQrGcqkKvT3aeA=;
        b=XeUuiwgOE4SBpn7vQWuHhoO17OUaFAODQwvm5qSlDSm8d2Ayb93PylBwh2C3lmgnvX
         BrG9OG90JDfM5jsmHZFqYYKpJFbv/KyNIAkDhgugIAeeQP3f9vGqw04QVQ9kLCR10j+X
         pLABQ/HgvwSvRV3b/IUrX/pGBdcA+2jQyq/cbcL0I4xhsPQ0l/GFzZ6D3BccghueL8ur
         TDd7K/azqFiWylTI43cOOIV52v5xyAqNqDti70yikM9NKYl7vYjiRDkTjMmqj0mWBWf2
         tfcs6AKrfiGnrW88sDy2Q4EpvqI2QT+eGnR/XKeHQUPaOdTjGbRjqGXhc6JnPalo9ueL
         uWBA==
X-Gm-Message-State: AOAM5305BM0lWine7Um6OQZ58+nLWO6GYZwAejP+v+GrGRyOfU83DwVH
        6A+m2r4M8OErhNYwT8B8EdQc/skklbu0zT9cv2ars/9A3YL+aeJTX1eh54IpqcpdKmA5oRmOe12
        IH+T/5MxvFZnvQKV4bKfglqXD
X-Received: by 2002:a05:600c:34c5:b0:38f:fbcb:e4d with SMTP id d5-20020a05600c34c500b0038ffbcb0e4dmr7147572wmq.174.1650524999947;
        Thu, 21 Apr 2022 00:09:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXav5e1L/ckc2V1R7UYJ+Xe1T+TSkgXnebYAZ2ub09jZihdAfDOzhB8LCRP40IxAf8HiDmag==
X-Received: by 2002:a05:600c:34c5:b0:38f:fbcb:e4d with SMTP id d5-20020a05600c34c500b0038ffbcb0e4dmr7147555wmq.174.1650524999717;
        Thu, 21 Apr 2022 00:09:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:de00:711b:76af:b335:9b70? (p200300cbc702de00711b76afb3359b70.dip0.t-ipconnect.de. [2003:cb:c702:de00:711b:76af:b335:9b70])
        by smtp.gmail.com with ESMTPSA id v2-20020adf8b42000000b0020aa790a258sm1628401wra.8.2022.04.21.00.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 00:09:59 -0700 (PDT)
Message-ID: <d46accec-28f7-d678-b475-c4402bba8211@redhat.com>
Date:   Thu, 21 Apr 2022 09:09:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 3/3] memblock tests: remove extra column of spaces in
 block comment
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>, outreachy@lists.linux.dev
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1650452552.git.remckee0@gmail.com>
 <663c930475c3c0a32965024c1094d3288629a3af.1650452552.git.remckee0@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <663c930475c3c0a32965024c1094d3288629a3af.1650452552.git.remckee0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.04.22 13:19, Rebecca Mckeever wrote:
> Remove extra space at the beginning of each line in block comment
> for consistency and to conform to Linux kernel coding style.
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>  tools/testing/memblock/tests/basic_api.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
> index 834d8705ff8a..05448a25f1f9 100644
> --- a/tools/testing/memblock/tests/basic_api.c
> +++ b/tools/testing/memblock/tests/basic_api.c
> @@ -303,12 +303,12 @@ static int memblock_add_checks(void)
>  	return 0;
>  }
>  
> - /*
> -  * A simple test that marks a memory block of a specified base address
> -  * and size as reserved and to the collection of reserved memory regions
> -  * (memblock.reserved). Expect to create a new entry. The region counter
> -  * and total memory size are updated.
> -  */
> +/*
> + * A simple test that marks a memory block of a specified base address
> + * and size as reserved and to the collection of reserved memory regions
> + * (memblock.reserved). Expect to create a new entry. The region counter
> + * and total memory size are updated.
> + */
>  static int memblock_reserve_simple_check(void)
>  {
>  	struct memblock_region *rgn;

I'd pull this patch to the front, so you don't end up modifying a wrong
style in patch #2. You could also just squash this patch into patch #2
and mention it in the patch description.

-- 
Thanks,

David / dhildenb

