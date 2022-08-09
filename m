Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE07658D53A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240515AbiHIIQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240734AbiHIIPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:15:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D83B630E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 01:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660032953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i/7QmR2udLKWU2FTMqK09JxCCe/ubs98ULH8N/JxdBc=;
        b=XifCaS0SbLOYUuOpq+xWwg4lfjiVGIfkc+wg5xEPw8mjbe0Wsfzyo0mVJMBhGJi9JdVr5O
        sXYeyvzYS7kd8UwE96tgDjLwIslXCTZVuuIQLtdZwh9uUG4h6lQQr8q1/EZe+9B/4sTKXX
        g3rtZ4lGxdn48cmoXZolhTJkupFxwu4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-398-EPuRbwbYPHOR4jCl7CZRSA-1; Tue, 09 Aug 2022 04:15:52 -0400
X-MC-Unique: EPuRbwbYPHOR4jCl7CZRSA-1
Received: by mail-wm1-f71.google.com with SMTP id 9-20020a1c0209000000b003a53ae8015bso2512403wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 01:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=i/7QmR2udLKWU2FTMqK09JxCCe/ubs98ULH8N/JxdBc=;
        b=ERT+epwGheZP7KsDI3r19Im6Dw3Kd2duenD2s97+5S8uAOryR2P9EJ76CP5o0HC0np
         SXABjZHl5ICbzP71CiOqAu8s60XBnDZ5Xqy9FeTe4FbkeilTQAdRkPn0Ba+LXTqeGLJl
         oQYd1sNDSMdgIV2ta4W4sx7BsVbL2Z3dsNE/VF1uh2gM1ttjMqsB/9FGO8CJMv7mWPyG
         FXivIovVifc4u/Nu4xNb99Ut0EkzqFpfRfSrFOQklIjTH+CKVRpZWkqwUFTWL/T2a7XS
         rLd+r0VVePQwbvJz+CALYrBQxViRDltUlGOlDODJumRgQ4SgYYblGSsI1pn07JjMsBE9
         Nx9g==
X-Gm-Message-State: ACgBeo3irAmU+XdTFbH19Nwozs3TJZK4a7gUFio1an3ckSTciIUZHcnv
        DpN2CMIaEmr87EKoL3R4WQtCnMetDB7eDfemISuVgikQeYOgMD3nLG/PXKeVfJ64g/tmSjzsRep
        vqAz49HSLtrKnpkiLcTc58AZa
X-Received: by 2002:a05:6000:711:b0:220:63a5:954c with SMTP id bs17-20020a056000071100b0022063a5954cmr13265926wrb.667.1660032951173;
        Tue, 09 Aug 2022 01:15:51 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4RkwnzP+5IczJUCC+Wv0NDQRP6KkwukKaB7wh492u+icviVRyiUTFwWQT25QDFtg2eUkbyDA==
X-Received: by 2002:a05:6000:711:b0:220:63a5:954c with SMTP id bs17-20020a056000071100b0022063a5954cmr13265917wrb.667.1660032950929;
        Tue, 09 Aug 2022 01:15:50 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f15:c300:d2ce:1fb5:2460:179a? (p200300d82f15c300d2ce1fb52460179a.dip0.t-ipconnect.de. [2003:d8:2f15:c300:d2ce:1fb5:2460:179a])
        by smtp.gmail.com with ESMTPSA id a5-20020adffb85000000b0021e45afa7b0sm12800466wrr.109.2022.08.09.01.15.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 01:15:50 -0700 (PDT)
Message-ID: <6504c796-513a-3785-22a8-a933de37bf96@redhat.com>
Date:   Tue, 9 Aug 2022 10:15:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mm: re-allow pinning of zero pfns (again)
Content-Language: en-US
To:     Alex Williamson <alex.williamson@redhat.com>, alex.sierra@amd.com,
        akpm@linux-foundation.org
Cc:     hch@lst.de, Felix.Kuehling@amd.com, apopple@nvidia.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <166002010021.381133.11357879752637949308.stgit@omen>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <166002010021.381133.11357879752637949308.stgit@omen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.08.22 06:42, Alex Williamson wrote:
> The below referenced commit makes the same error as 1c563432588d ("mm: fix
> is_pinnable_page against a cma page"), re-interpreting the logic to exclude
> pinning of the zero page, which breaks device assignment with vfio.
> 
> Link: https://lore.kernel.org/all/165490039431.944052.12458624139225785964.stgit@omen
> Fixes: f25cbb7a95a2 ("mm: add zone device coherent type memory support")
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  include/linux/mm.h |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 18e01474cf6b..772279ed7010 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1544,9 +1544,8 @@ static inline bool is_longterm_pinnable_page(struct page *page)
>  	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
>  		return false;
>  #endif
> -	return !(is_device_coherent_page(page) ||
> -		 is_zone_movable_page(page) ||
> -		 is_zero_pfn(page_to_pfn(page)));
> +	return !(is_device_coherent_page(page) || is_zone_movable_page(page)) ||
> +	       is_zero_pfn(page_to_pfn(page));
>  }
>  #else
>  static inline bool is_longterm_pinnable_page(struct page *page)


:/ I guess the code was moved just at the time the old code was still in
place, and when rebasing, the diff in the code was ignored.

Reviewed-by: David Hildenbrand <david@redhat.com>


I have patches in the works that will properly break COW here to get
anon pages instead of pinning the shared zeropage, which is questionable
in COW mappings.

-- 
Thanks,

David / dhildenb

