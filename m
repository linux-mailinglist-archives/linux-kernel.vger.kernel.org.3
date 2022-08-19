Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8782E59938C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 05:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345147AbiHSDcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 23:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245697AbiHSDcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 23:32:03 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65288DFB57
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 20:32:01 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660879919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=46qkXQep0kHaH4uBtAQac2/RePFW9SnkUPGqcE2Tpy8=;
        b=F2pfX+3B5Xk/OqhgZeeIJlcrY7m0Dvt0dyZ6M28R7dLzOAs1UsNaBfjtnod0taOTFJO0IR
        rQrUdyySTnCJt4cspto5aSUKOYDpSjsN2PxxBD5E7CV21AlUh4juSukDlhiEVYIrGJz6V3
        kW8K65QkWaUOf7VcE2YN7Z3pSGN29Ow=
MIME-Version: 1.0
Subject: Re: [PATCH -next] bootmem: remove the vmemmap pages from kmemleak in
 free_bootmem_page
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20220818132104.2144770-1-liushixin2@huawei.com>
Date:   Fri, 19 Aug 2022 11:31:30 +0800
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Linux MM <linux-mm@kvack.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8EC06FE1-3963-4F22-83DF-48B3EFAA62CA@linux.dev>
References: <20220818132104.2144770-1-liushixin2@huawei.com>
To:     Liu Shixin <liushixin2@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 18, 2022, at 21:21, Liu Shixin <liushixin2@huawei.com> wrote:
>=20
> The vmemmap pages is marked by kmemleak when allocated from memblock.
> Remove it from kmemleak when free the page. Otherwise, when we reuse =
the
> page, kmemleak may report such an error and then stop working.
>=20
> kmemleak: Cannot insert 0xffff98fb6eab3d40 into the object search tree =
(overlaps existing)
> kmemleak: Kernel memory leak detector disabled
> kmemleak: Object 0xffff98fb6be00000 (size 335544320):
> kmemleak:   comm "swapper", pid 0, jiffies 4294892296
> kmemleak:   min_count =3D 0
> kmemleak:   count =3D 0
> kmemleak:   flags =3D 0x1
> kmemleak:   checksum =3D 0
> kmemleak:   backtrace:
>=20
> Fixes: f41f2ed43ca5 ("mm: hugetlb: free the vmemmap pages associated =
with each HugeTLB page")
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
> include/linux/bootmem_info.h | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/bootmem_info.h =
b/include/linux/bootmem_info.h
> index cc35d010fa94..899bc56948f7 100644
> --- a/include/linux/bootmem_info.h
> +++ b/include/linux/bootmem_info.h
> @@ -3,6 +3,7 @@
> #define __LINUX_BOOTMEM_INFO_H
>=20
> #include <linux/mm.h>
> +#include <linux/kmemleak.h>
>=20
> /*
>  * Types for free bootmem stored in page->lru.next. These have to be =
in
> @@ -38,9 +39,10 @@ static inline void free_bootmem_page(struct page =
*page)
> 	 */
> 	VM_BUG_ON_PAGE(page_ref_count(page) !=3D 2, page);

I am wondering if we should fix put_page_bootmem() instead of
free_bootmem_page() since there are some users of put_page_bootmem()
to free a page allocated from memblock which also can be reused
afterwards.

Thanks.

>=20
> -	if (magic =3D=3D SECTION_INFO || magic =3D=3D MIX_SECTION_INFO)
> +	if (magic =3D=3D SECTION_INFO || magic =3D=3D MIX_SECTION_INFO) =
{
> +		kmemleak_free_part(page_to_virt(page), PAGE_SIZE);
> 		put_page_bootmem(page);
> -	else
> +	} else
> 		VM_BUG_ON_PAGE(1, page);
> }
> #else
> --=20
> 2.25.1
>=20
>=20

