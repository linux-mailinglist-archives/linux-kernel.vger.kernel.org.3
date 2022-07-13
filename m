Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1708D573984
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbiGMPB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiGMPBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:01:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A4073ED5C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657724512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dhuEV8wUOrrbYN+eImzoY0DjP06EvLstMjKANkm4Hzw=;
        b=VceB4pot+GDR18rZBAS9zFs0oe0uThipNbL7qwu6HsQtgvmoRrv1wXe0waQ4AREFzfDOTQ
        8iYP1jvhO/e5i7cIhJC+tDu4azFceS9yr/pme0/D6C8mGXHrar+EEq50H7g6VeIFDVoH1d
        2rJ2hCJyUH34VrIgyopqV3ZHNQuDZMM=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-457-O7vhanKKNJ-e4aTpy2x9jA-1; Wed, 13 Jul 2022 11:01:50 -0400
X-MC-Unique: O7vhanKKNJ-e4aTpy2x9jA-1
Received: by mail-vk1-f197.google.com with SMTP id w12-20020a1f300c000000b00374862e7711so3538870vkw.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dhuEV8wUOrrbYN+eImzoY0DjP06EvLstMjKANkm4Hzw=;
        b=0lNntuzUHxwbnQ8pqVjST4IamUAIWuTeR+JEi/a2h30l0Gsj+AlIrsNcbfb2cFaUcH
         T4wiBS4QitSW7n9XVH7vN0R+lhP/pLtPPbX4Fxv4upJembiahe00hXFbIUOeWT0IOc2h
         4Gug4ghWe/MFHWGdrPRZjH1rzAj2Khq5p2WEwuuLiGDZhxdEXDpNh63q49AQkPSfI1VR
         aLIlFQJYI7DyE3VnenHCpZ5m+w/UJF8wjkhgYz/ieSp2mgsUnVXQU3ndLsUwMl7LbHvs
         v3qOJn7FmLYpurRTswrkN/6h4r1mw3AGSJIAZj9N90UkyA2jZzJL/M/tWvN4gkOjMZ2P
         TXYw==
X-Gm-Message-State: AJIora/Z7dgn+RtTtuQDXLnb31hbh7h3vaE6JSofAaPrrUUbTsmn0pg9
        Fq2TzIyBuV+NnqZT47btQPXKZPl43cAy2Fqf4hiU/fCN5plz2khZPEk91cUU7/5hIe53OFk72Vr
        /vmxc1V07ldayYryz6dmZCBepkbcMfmVTTG66UPIu
X-Received: by 2002:a1f:9194:0:b0:374:957c:72ec with SMTP id t142-20020a1f9194000000b00374957c72ecmr1443137vkd.31.1657724509967;
        Wed, 13 Jul 2022 08:01:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u4uXsxD32IGl4rEs3j/A/CnqOaVmQt8vJAYok/b9l/5loZAJB+HJlHjK1hc+xxAfzNXonAcUXWMn56HVzWElc=
X-Received: by 2002:a1f:9194:0:b0:374:957c:72ec with SMTP id
 t142-20020a1f9194000000b00374957c72ecmr1443109vkd.31.1657724509736; Wed, 13
 Jul 2022 08:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220713145854.147356-1-mlombard@redhat.com>
In-Reply-To: <20220713145854.147356-1-mlombard@redhat.com>
From:   Maurizio Lombardi <mlombard@redhat.com>
Date:   Wed, 13 Jul 2022 17:01:38 +0200
Message-ID: <CAFL455m0UAXwLd78Eh=Vq-H6sQTPdmGAOOt2rOM1XtRqsqH=bQ@mail.gmail.com>
Subject: Re: [PATCH] mm: prevent page_frag_alloc() from corrupting the memory
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        =?UTF-8?B?5oSa5qCR?= <chen45464546@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

st 13. 7. 2022 v 16:59 odes=C3=ADlatel Maurizio Lombardi
<mlombard@redhat.com> napsal:
>
> A number of drivers call page_frag_alloc() with a
> fragment's size > PAGE_SIZE.
> In low memory conditions, __page_frag_cache_refill() may fail the order 3
> cache allocation and fall back to order 0;
> In this case, the cache will be smaller than the fragment, causing
> memory corruptions.

Oops, I didn't modify the subject, I'm going to resend it.

Maurizio

>
> Prevent this from happening by checking if the newly allocated cache
> is large enough for the fragment; if not, the allocation will fail
> and page_frag_alloc() will return NULL.
>
> V2: do not free the cache page because this could make memory pressure
> even worse, just return NULL.
>
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>  mm/page_alloc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e008a3df0485..b1407254a826 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5617,6 +5617,8 @@ void *page_frag_alloc_align(struct page_frag_cache =
*nc,
>                 /* reset page count bias and offset to start of new frag =
*/
>                 nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
>                 offset =3D size - fragsz;
> +               if (unlikely(offset < 0))
> +                       return NULL;
>         }
>
>         nc->pagecnt_bias--;
> --
> 2.31.1
>

