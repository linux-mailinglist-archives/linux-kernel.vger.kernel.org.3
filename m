Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CBF54C8BD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346566AbiFOMlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345411AbiFOMls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:41:48 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB866443ED
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:41:46 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-31336535373so59798617b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QHgieiOKZ/wvnEvuqX0qx+h2/lnNPdAfqngWGeSTFso=;
        b=AZ5HHdMYDUZYtETLhuVAfOffdnqudnMhIQvp/7LxLCy4pjphZpM998KxqCDJkhNj4W
         LnCLmkE9svCTcJfPbTDCFNDXsqiIt11u49RA2IpYZIxxtiJ5mY8LcLd0UfBfqu0sWf0g
         0IjziU5y/m2u4VpeuISURE+aVoGgESHQxIvGBSmpFrspL+P0VQKDetz5jdFQl2msr9Pa
         PXoFfPGbFlSelA9HQthqMqEpuxFd49mHzcZUXfVcmR0w71xOCQtM8p4YbZ9EvMUMz1NN
         W+w84YRHL0etOx2TZdr2tQt80uorUrjdqyyViNvjSMacipJV/WPs1eu51QWYd/8EuHgZ
         oZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QHgieiOKZ/wvnEvuqX0qx+h2/lnNPdAfqngWGeSTFso=;
        b=tsZEJ/ADjjbwtYZ9es4kYqebKfbAbH08SJ+gtBqr2RC8DC0nWPZ6OVK6eCiHaDT2jS
         LYHZ9O99lE0j1Ulg7Z0VlSgRwB+swhZmeEKbjZP41YDcseXVw1zUFObjqxpkPBb5yN/1
         UV5vX2+cxeWpkNuD7goXvYhZRBP7l9lyxTSkinfrZcpXnu07O/7vvTGIN9M2Xl+U0l3r
         UQf5UialTZavYfIEuhr+gvfAFhm/yKzeF6hDZoY4rysX+o+Xrq7vyqiVwdvHfLZmRypb
         R+XaxLHHQHPKFbAVQX00JgGa9UvvrcuD74fajG4QidRUMB8jYLex84djtgOvVhdBQJB4
         /avQ==
X-Gm-Message-State: AJIora8VoyhIuVtIAlnNLspdQ7a0Wq6qRwHyUiYBGmS5JZ2e9/WoIVOU
        l8Vut+d0xiH3itr/0ghT+3/SEkLKCx+qvMmFl6w=
X-Google-Smtp-Source: AGRyM1s45RQ0Y4I0G26oLyYm+tQiv1OEUJj2o5JC2EuVK7WJB4wsiKXlq7ozeWbNxYm2SdkfOTO0x4KdG6JuTp198lU=
X-Received: by 2002:a0d:e446:0:b0:316:624c:c74e with SMTP id
 n67-20020a0de446000000b00316624cc74emr5119990ywe.389.1655296906006; Wed, 15
 Jun 2022 05:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220612105937.30862-1-wuchi.zero@gmail.com> <20220613111404.5253fe6ac69f5fd145dd437c@linux-foundation.org>
 <CA+tQmHDFMJq1DH7Kmzp13vxvZoiKzRokt_TeF0w5Eboi6VaaJQ@mail.gmail.com> <20220614105334.ec0227452f8639c7515f97aa@linux-foundation.org>
In-Reply-To: <20220614105334.ec0227452f8639c7515f97aa@linux-foundation.org>
From:   chi wu <wuchi.zero@gmail.com>
Date:   Wed, 15 Jun 2022 20:41:34 +0800
Message-ID: <CA+tQmHDTGNY_mVF82smqka5AJJrHcKG6og2zfNgn=-dJEgaNHQ@mail.gmail.com>
Subject: Re: [PATCH] lib/genalloc: Set chunk size to real size which gen_pool managed.
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     alexs@kernel.org, sjhuang@iluvatar.ai, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> =E4=BA=8E2022=E5=B9=B46=E6=9C=881=
5=E6=97=A5=E5=91=A8=E4=B8=89 01:53=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 14 Jun 2022 13:20:08 +0800 chi wu <wuchi.zero@gmail.com> wrote:
>
> > > If we're going to do this then gen_pool_add_owner() no longer needs i=
ts
> > > `size' argument.
> > >
> > >
> > Sorry, What point did I misunderstand=EF=BC=9F
>
> I mean we can now do this:
>
> --- a/lib/genalloc.c~lib-genalloc-set-chunk-size-to-real-size-which-gen_p=
ool-managed-fix
> +++ a/lib/genalloc.c
> @@ -181,13 +181,14 @@ EXPORT_SYMBOL(gen_pool_create);
>   *
>   * Returns 0 on success or a -ve errno on failure.
>   */
> -int gen_pool_add_owner(struct gen_pool *pool, unsigned long virt, phys_a=
ddr_t phys,
> -                size_t size, int nid, void *owner)
> +int gen_pool_add_owner(struct gen_pool *pool, unsigned long virt,
> +                      phys_addr_t phys, int nid, void *owner)
>  {
>         struct gen_pool_chunk *chunk;
>         unsigned long nbits =3D size >> pool->min_alloc_order;    [1]

The arg @size is in bytes of the memory chunk to add to pool,  we
really need that, [1] here we
get nbits by size. [2]  later we will alloc bitmap by nbits...   If we
remove the arg @size, we will
have no way to get the size of memory which we will manage.

>         unsigned long nbytes =3D sizeof(struct gen_pool_chunk) +
>                                 BITS_TO_LONGS(nbits) * sizeof(long);     =
 [1]
> +       size_t size;
>
>         chunk =3D vzalloc_node(nbytes, nid);
>         if (unlikely(chunk =3D=3D NULL))
> _
>

Thanks for Andrew's time
