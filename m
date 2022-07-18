Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B53C578449
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbiGRNu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbiGRNuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:50:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBF7C275DF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658152254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4BCVM5Y1TUNST7laSoOUsYzA69zl5+oV0vJFLfHEP9Y=;
        b=fdMsNyofurpv/4e4XmP9Nj2OZ4iD8sscH5CSBSkPXvOM3CWn2RJZHCHQ4pNwkqG84Oc63r
        AXX0bMDjVB3Pnv38ZtwMzBUO/ApPKGIB6wwmHH7qPneXLfIjwpRrhFWWsTSlZEHZ2xz9FL
        Ix8wY9TWJZbZAvzOyFFeKr5uyI1YTGo=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-UqlIkuKVN8at8N-nPuEgtA-1; Mon, 18 Jul 2022 09:50:52 -0400
X-MC-Unique: UqlIkuKVN8at8N-nPuEgtA-1
Received: by mail-ua1-f72.google.com with SMTP id 33-20020ab00424000000b003829f08fd3fso5694588uav.22
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4BCVM5Y1TUNST7laSoOUsYzA69zl5+oV0vJFLfHEP9Y=;
        b=v91HsLWNA81tyFPwSLYp/KM+LGA0PhLP8o+iEAyShsvRvVccrfZuAPp8DTaF6weIZs
         hYmDepc7X0+2nhU/meucb9gzSmhErBoe3sHkjoJZBXmm9+jKYy07KyqsSLU+56NPOuPk
         Ca/ew8yjCgJSvVyFUKvNUaZgjMZHu70sq3W/+qGvreJGP0DM5QGrXH2TYRAXIx/ACTFT
         fDzI8K8wueNq49mWZEK6yIEkZD1YX6/AxPZl/pnfmmBAoiy2KEXL9rIrWOrmsycWZ23B
         vwliHsMBj2zjgcT8JIRTc+3uAvkZJK8rbUJ9b8OjgebMX+4wtkhGPQL5xky1EBMVWT2d
         2lkw==
X-Gm-Message-State: AJIora8b+f50AMM8ivZNyOWK5GN2ZKhVyaaWZmZnBXDuIEB81lhjjz8H
        +SI59ZP/DzJr/RJfh/vO7fwy6G0+GPOvPC+sez16t/iDH8hAYzznCky2jwWgaUYxy7vc289snKS
        oLCoAx7xkBBbiwkLzWeKclqWJKIuGg5bQaJOLN5DC
X-Received: by 2002:a05:6102:346:b0:357:79f5:63ae with SMTP id e6-20020a056102034600b0035779f563aemr9672750vsa.40.1658152252226;
        Mon, 18 Jul 2022 06:50:52 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sgbUR94wPuXBZzUmzxCn3XWmRF1dK3R0CKv/4UZnqZBKYECuZ4sLNg43x33SuOCYvWn7NSHakhNpWzDy7YC6c=
X-Received: by 2002:a05:6102:346:b0:357:79f5:63ae with SMTP id
 e6-20020a056102034600b0035779f563aemr9672738vsa.40.1658152251972; Mon, 18 Jul
 2022 06:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220715125013.247085-1-mlombard@redhat.com> <5a469c5a.8b85.1821171d9de.Coremail.chen45464546@163.com>
In-Reply-To: <5a469c5a.8b85.1821171d9de.Coremail.chen45464546@163.com>
From:   Maurizio Lombardi <mlombard@redhat.com>
Date:   Mon, 18 Jul 2022 15:50:41 +0200
Message-ID: <CAFL455nnc04q8TohH+Qbv36Bo3=KKxMWr=diK_F5Ds5K-h5etw@mail.gmail.com>
Subject: Re: [PATCH V3] mm: prevent page_frag_alloc() from corrupting the memory
To:     Chen Lin <chen45464546@163.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

po 18. 7. 2022 v 15:14 odes=C3=ADlatel Chen Lin <chen45464546@163.com> naps=
al:
> ----------------------------------------
> If we can accept adding a branch to this process, why not add it at the b=
eginning like below?
> The below changes are also more in line with the definition of "page frag=
ment",
> which i mean the above changes may make the allocation of more than one p=
age successful.
>
> index 7a28f7d..9d09ea5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5551,6 +5551,8 @@ void *page_frag_alloc_align(struct page_frag_cache =
*nc,
>
>         offset =3D nc->offset - fragsz;
>         if (unlikely(offset < 0)) {
> +               if (unlikely(fragsz > PAGE_SIZE))
> +                       return NULL;
>                 page =3D virt_to_page(nc->va);
>
>                 if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
>

This will make *all* page_frag_alloc() calls with fragsz > PAGE_SIZE
fail, so it will
basically break all those drivers that are relying on the current behaviour=
.
With my patch it will return NULL only if the cache isn't big enough.

Maurizio.

