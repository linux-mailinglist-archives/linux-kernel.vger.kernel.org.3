Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952A05A3415
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 04:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbiH0C4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 22:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiH0C4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 22:56:52 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41CCE9AA3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 19:56:51 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661569010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NcpFLSKaQAxTxdf0ghmhR9spotb00VoGyO0+l7yqmw4=;
        b=oQD3APUKMRgcT71zbhGfdRAoqHaJKOh1/u1UydwxeBjKTyX9UxnLKRcyzFw2U8Yw0/IZcI
        +tqLElxGM273NAeeaOFN7DPTzWcYTp3b6/VzXPrgydLq1Q1FpUejccrZuwV3p2HpxeRLiz
        a078oqnbN9o+eIAbrzuI1OK1zWQ/mfw=
MIME-Version: 1.0
Subject: Re: [PATCH 08/10] hugetlb: remove unneeded SetHPageVmemmapOptimized()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <e367da7d-7964-7531-3dcb-0ad7964ffdaa@huawei.com>
Date:   Sat, 27 Aug 2022 10:56:40 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <767650F7-25B2-4E14-B47C-C103500D31B9@linux.dev>
References: <20220826092422.39591-1-linmiaohe@huawei.com>
 <20220826092422.39591-9-linmiaohe@huawei.com>
 <A1ED2200-136D-477E-B1EC-E61E6B75931B@linux.dev>
 <e367da7d-7964-7531-3dcb-0ad7964ffdaa@huawei.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
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



> On Aug 27, 2022, at 10:18, Miaohe Lin <linmiaohe@huawei.com> wrote:
>=20
> On 2022/8/27 9:35, Muchun Song wrote:
>>=20
>>=20
>>> On Aug 26, 2022, at 17:24, Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>=20
>>> If code reaches here, it's guaranteed that HPageVmemmapOptimized is =
set
>>> for the hugetlb page (or VM_BUG_ON_PAGE() will complain about it). =
It's
>>=20
>> Hi Miaohe,
>>=20
>> Right.
>>=20
>>> unnecessary to set it again.
>>=20
>> No, I suppose you didn=E2=80=99t test this patch since it does not =
work. The
>> HPageVmemmapOptimized is cleared in the above code of line
>> (set_page_private(page, 0)). So NAck.
>=20
> Sorry, I missed that and thanks for pointing this out. Does this code =
deserves a
> comment like below?
>=20
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index d0617d64d718..3374c1d2b52e 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1522,6 +1522,10 @@ static void add_hugetlb_page(struct hstate *h, =
struct page *page,
>=20
>        set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
>        set_page_private(page, 0);
> +       /*
> +        * We have to set HPageVmemmapOptimized again as above
> +        * set_page_private(page, 0) cleared it.
> +        */
>        SetHPageVmemmapOptimized(page);

I=E2=80=99m fine with this comment.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>


>=20
>        /*
>=20
>=20
> Thanks,
> Miaohe Lin

