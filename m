Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0927F5A3394
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 03:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345165AbiH0BrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 21:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiH0BrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 21:47:23 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025C4EA8A2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 18:47:21 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661564839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NH8AOWNO+r3zUi9PCSA6JOJZDOYEZSeALqyhYw+ro0o=;
        b=HFudeuhD98HlTqi6MSQlwC2+oYFpw1u3aYrJYAhVQwMw2WmV3FMyNq28GjJwvGYjKePsAY
        I42UN+ZAp+EWyrhxjK8lqRA0coQxh3Gk5LQ3m7Yc19KW00M3HclNwkt30GF394mbRBSeOZ
        u4R7d8WBsG5Rj1Gj0WQ7iONBRIcfK5o=
MIME-Version: 1.0
Subject: Re: [PATCH 03/10] hugetlb: Use LIST_HEAD() to define a list head
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20220826092422.39591-4-linmiaohe@huawei.com>
Date:   Sat, 27 Aug 2022 09:47:14 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>, mike.kravetz@oracle.com,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8D011A6F-F557-4519-852C-80BBDE53E630@linux.dev>
References: <20220826092422.39591-1-linmiaohe@huawei.com>
 <20220826092422.39591-4-linmiaohe@huawei.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 26, 2022, at 17:24, Miaohe Lin <linmiaohe@huawei.com> wrote:
>=20
> We can avoid unneeded WRITE_ONCE() overhead by using LIST_HEAD() to =
define
> a list head.

IIUC, the overhead doesn=E2=80=99t change. Right?

I=E2=80=99m fine with your changes.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

>=20
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
> mm/hugetlb.c | 7 ++-----
> 1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 24f580ddf130..b3e6592247a3 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -459,14 +459,12 @@ static int allocate_file_region_entries(struct =
resv_map *resv,
> 					int regions_needed)
> 	__must_hold(&resv->lock)
> {
> -	struct list_head allocated_regions;
> +	LIST_HEAD(allocated_regions);
> 	int to_allocate =3D 0, i =3D 0;
> 	struct file_region *trg =3D NULL, *rg =3D NULL;
>=20
> 	VM_BUG_ON(regions_needed < 0);
>=20
> -	INIT_LIST_HEAD(&allocated_regions);
> -
> 	/*
> 	 * Check for sufficient descriptors in the cache to accommodate
> 	 * the number of in progress add operations plus regions_needed.
> @@ -2352,7 +2350,7 @@ struct page *alloc_huge_page_vma(struct hstate =
*h, struct vm_area_struct *vma,
> static int gather_surplus_pages(struct hstate *h, long delta)
> 	__must_hold(&hugetlb_lock)
> {
> -	struct list_head surplus_list;
> +	LIST_HEAD(surplus_list);
> 	struct page *page, *tmp;
> 	int ret;
> 	long i;
> @@ -2367,7 +2365,6 @@ static int gather_surplus_pages(struct hstate =
*h, long delta)
> 	}
>=20
> 	allocated =3D 0;
> -	INIT_LIST_HEAD(&surplus_list);
>=20
> 	ret =3D -ENOMEM;
> retry:
> --=20
> 2.23.0
>=20
>=20

