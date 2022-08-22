Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623CE59BD8C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 12:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbiHVKYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 06:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbiHVKX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 06:23:58 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED661A04E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 03:23:56 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661163834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7sUWj0QoiwczPOrvqaGIflyD1LOaHPYP2EjnSJtpq/w=;
        b=Jwax0idhozUqW6l7DlaZf1w5Na9Q73xbYWIimnaE5rzOPSXVAI/cq6JQxPDfpadg0q4x3F
        RraeEczejdbaLmzxMh2/vHJoYdlLD7tr16JodQeXu7xX/NpAtXkq68oBCn1gujZmlsRoW5
        knxHLGSyF/q7EGJIAmhTs6B286U3N8o=
MIME-Version: 1.0
Subject: Re: [PATCH 4/6] mm: hugetlb_vmemmap: add missing smp_wmb() before
 set_pte_at()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <bfb89f55-a618-4b36-7075-654922a8ddaa@huawei.com>
Date:   Mon, 22 Aug 2022 18:23:27 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F8381885-8B9F-405B-A860-AFB8A675D5A7@linux.dev>
References: <20220816130553.31406-1-linmiaohe@huawei.com>
 <20220816130553.31406-5-linmiaohe@huawei.com>
 <CBD5F92C-1D62-4331-A214-5B6D08E35809@linux.dev>
 <bfb89f55-a618-4b36-7075-654922a8ddaa@huawei.com>
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



> On Aug 22, 2022, at 16:45, Miaohe Lin <linmiaohe@huawei.com> wrote:
>=20
> On 2022/8/20 16:12, Muchun Song wrote:
>>=20
>>=20
>>> On Aug 16, 2022, at 21:05, Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>=20
>>> The memory barrier smp_wmb() is needed to make sure that preceding =
stores
>>> to the page contents become visible before the below set_pte_at() =
write.
>>=20
>> I found another place where is a similar case. See =
kasan_populate_vmalloc_pte() in
>> mm/kasan/shadow.c.=20
>=20
> Thanks for your report.
>=20
>>=20
>> Should we fix it as well?
>=20
> I'm not familiar with kasan yet, but I think memory barrier is needed =
here or memory corrupt
> can't be detected until the contents are visible. smp_mb__after_atomic =
before set_pte_at should
> be enough? What's your opinion?

I didn=E2=80=99t see any atomic operation between set_pte_at() and =
memset(), I don=E2=80=99t think
smp_mb__after_atomic() is feasible if we really need to insert a =
barrier. I suggest
you to send a RFC patch to KASAN maintainers, they are more familiar =
with this than
us.

Thanks.

>=20
> Thanks,
> Miaohe Lin
>=20
>=20

