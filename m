Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15304597C52
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 05:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242742AbiHRDj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 23:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiHRDjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 23:39:54 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C255C910AC
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:39:52 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660793991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KUyb1pCJ/oDKXbqiOy+EBzbV0azHcNvfFJQrGl3ZoHw=;
        b=gIhBAaU7YmXiHcaDggk8vcGCT/7goON9W/+NsVTSgVmBy6E225FzyIxchhWQApf2XJrVie
        V21+ZScwyj2b3RR3WN4NscXIwuFvxme4sQB+4d7KVTA/NIfjk5omvZGiF0r+v2TUhS8TB8
        24xGn49o7Z9SXlFXOQRwLvA0orm9wXk=
MIME-Version: 1.0
Subject: Re: [PATCH] mm/damon: Validate if the pmd entry is present before
 accessing
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <ceaa1e54-e79a-86c7-cf35-d4159088f0f3@linux.alibaba.com>
Date:   Thu, 18 Aug 2022 11:39:04 +0800
Cc:     sj@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, Linux MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6F99AE03-3C74-4E5B-87E1-6F3232BEEBB5@linux.dev>
References: <2838b6737bc259cf575ff11fd1c4b7fdb340fa73.1660717122.git.baolin.wang@linux.alibaba.com>
 <5173E308-2403-4667-9162-865CF7F11838@linux.dev>
 <ceaa1e54-e79a-86c7-cf35-d4159088f0f3@linux.alibaba.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 18, 2022, at 10:57, Baolin Wang <baolin.wang@linux.alibaba.com> =
wrote:
>=20
>=20
>=20
> =E5=9C=A8 8/18/2022 10:41 AM, Muchun Song =E5=86=99=E9=81=93:
>>> On Aug 17, 2022, at 14:21, Baolin Wang =
<baolin.wang@linux.alibaba.com> wrote:
>>>=20
>>> The pmd_huge() is used to validate if the pmd entry is mapped by a =
huge
>>> page, also including the case of non-present (migration or =
hwpoisoned)
>>> pmd entry on arm64 or x86 architectures. Thus we should validate if =
it
>>> is present before making the pmd entry old or getting young state,
>>> otherwise we can not get the correct corresponding page.
>>>=20
>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> ---
>>> mm/damon/vaddr.c | 10 ++++++++++
>>> 1 file changed, 10 insertions(+)
>>>=20
>>> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
>>> index 3c7b9d6..1d16c6c 100644
>>> --- a/mm/damon/vaddr.c
>>> +++ b/mm/damon/vaddr.c
>>> @@ -304,6 +304,11 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, =
unsigned long addr,
>>>=20
>>> 	if (pmd_huge(*pmd)) {
>>> 		ptl =3D pmd_lock(walk->mm, pmd);
>>> +		if (!pmd_present(*pmd)) {
>> Unluckily, we should use pte_present here. See commit c9d398fa23788. =
We can use
>> huge_ptep_get() to get a hugetlb pte, so it=E2=80=99s better to put =
the check after
>> pmd_huge.
>=20
> IMO this is not the case for hugetlb, and the hugetlb case will be =
handled by damon_mkold_hugetlb_entry(), which already used pte_present() =
for hugetlb case.

Well, I thought it is hugetlb related since I saw the usage of pmd_huge. =
If it is THP case, why
not use pmd_trans_huge?

Thanks.

>=20
>> Cc Mike to make sure I am not missing something.
>> Muchun,
>> Thanks.
>>> +			spin_unlock(ptl);
>>> +			return 0;
>>> +		}
>>> +
>>> 		if (pmd_huge(*pmd)) {
>>> 			damon_pmdp_mkold(pmd, walk->mm, addr);
>>> 			spin_unlock(ptl);
>>> @@ -431,6 +436,11 @@ static int damon_young_pmd_entry(pmd_t *pmd, =
unsigned long addr,
>>> #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>> 	if (pmd_huge(*pmd)) {
>>> 		ptl =3D pmd_lock(walk->mm, pmd);
>>> +		if (!pmd_present(*pmd)) {
>>> +			spin_unlock(ptl);
>>> +			return 0;
>>> +		}
>>> +
>>> 		if (!pmd_huge(*pmd)) {
>>> 			spin_unlock(ptl);
>>> 			goto regular_page;
>>> --=20
>>> 1.8.3.1

