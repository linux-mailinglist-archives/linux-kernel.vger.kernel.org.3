Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44F1597DEF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 07:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243347AbiHRFMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 01:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243193AbiHRFMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 01:12:49 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A21AE9DD
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 22:12:48 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660799566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1H/Ao22P33oing/Qaeq1/GC8WXjUGxwENWzd8EeEcsM=;
        b=Sd9c3kJn7CqtzqbRWmqhBKnIFKtY3RKsEAjS/QEQMToPN1fUk8Nay9ytM9R2jRqBGiEg1V
        6+KFaqefLlFTupEdQ745+8OB/empqPBY7MLQwkQ3/eiKBwoW2EgJ8Ke3aXOQogB8sdciC7
        2uY1YWwpRKhUu/EC6UdHtF1xKdEPJHY=
MIME-Version: 1.0
Subject: Re: [PATCH] mm/damon: Validate if the pmd entry is present before
 accessing
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <ad3f36ca-5027-45a5-cd48-dc32bf968c9d@linux.alibaba.com>
Date:   Thu, 18 Aug 2022 13:12:16 +0800
Cc:     sj@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, Linux MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8C1A5089-2830-407D-8FF3-2F0F92984645@linux.dev>
References: <2838b6737bc259cf575ff11fd1c4b7fdb340fa73.1660717122.git.baolin.wang@linux.alibaba.com>
 <5173E308-2403-4667-9162-865CF7F11838@linux.dev>
 <ceaa1e54-e79a-86c7-cf35-d4159088f0f3@linux.alibaba.com>
 <6F99AE03-3C74-4E5B-87E1-6F3232BEEBB5@linux.dev>
 <ad3f36ca-5027-45a5-cd48-dc32bf968c9d@linux.alibaba.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 18, 2022, at 13:07, Baolin Wang <baolin.wang@linux.alibaba.com> =
wrote:
>=20
>=20
>=20
> On 8/18/2022 11:39 AM, Muchun Song wrote:
>>> On Aug 18, 2022, at 10:57, Baolin Wang =
<baolin.wang@linux.alibaba.com> wrote:
>>>=20
>>>=20
>>>=20
>>> =E5=9C=A8 8/18/2022 10:41 AM, Muchun Song =E5=86=99=E9=81=93:
>>>>> On Aug 17, 2022, at 14:21, Baolin Wang =
<baolin.wang@linux.alibaba.com> wrote:
>>>>>=20
>>>>> The pmd_huge() is used to validate if the pmd entry is mapped by a =
huge
>>>>> page, also including the case of non-present (migration or =
hwpoisoned)
>>>>> pmd entry on arm64 or x86 architectures. Thus we should validate =
if it
>>>>> is present before making the pmd entry old or getting young state,
>>>>> otherwise we can not get the correct corresponding page.
>>>>>=20
>>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>> ---
>>>>> mm/damon/vaddr.c | 10 ++++++++++
>>>>> 1 file changed, 10 insertions(+)
>>>>>=20
>>>>> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
>>>>> index 3c7b9d6..1d16c6c 100644
>>>>> --- a/mm/damon/vaddr.c
>>>>> +++ b/mm/damon/vaddr.c
>>>>> @@ -304,6 +304,11 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, =
unsigned long addr,
>>>>>=20
>>>>> 	if (pmd_huge(*pmd)) {
>>>>> 		ptl =3D pmd_lock(walk->mm, pmd);
>>>>> +		if (!pmd_present(*pmd)) {
>>>> Unluckily, we should use pte_present here. See commit =
c9d398fa23788. We can use
>>>> huge_ptep_get() to get a hugetlb pte, so it=E2=80=99s better to put =
the check after
>>>> pmd_huge.
>>>=20
>>> IMO this is not the case for hugetlb, and the hugetlb case will be =
handled by damon_mkold_hugetlb_entry(), which already used pte_present() =
for hugetlb case.
>> Well, I thought it is hugetlb related since I saw the usage of =
pmd_huge. If it is THP case, why
>> not use pmd_trans_huge?
>=20
> IIUC, it can not guarantee the pmd is present if pmd_trans_huge() =
returns true on all architectures, at least on X86, we still need =
pmd_present() validation. So changing to pmd_trans_huge() does not make =
code simpler from my side, and I prefer to keep this patch.

I am not suggesting you change it to pmd_trans_huge() in this patch, I =
am just expressing
my curious. At least, it is a little confusing to me.


>=20
> Maybe we can send another cleanup patch to replace pmd_huge() with =
pmd_trans_huge() for THP case to make code more readable? How do you =
think? Thanks.

Yep, make sense to me.

Thanks.

>=20
>>>=20
>>>> Cc Mike to make sure I am not missing something.
>>>> Muchun,
>>>> Thanks.
>>>>> +			spin_unlock(ptl);
>>>>> +			return 0;
>>>>> +		}
>>>>> +
>>>>> 		if (pmd_huge(*pmd)) {
>>>>> 			damon_pmdp_mkold(pmd, walk->mm, addr);
>>>>> 			spin_unlock(ptl);
>>>>> @@ -431,6 +436,11 @@ static int damon_young_pmd_entry(pmd_t *pmd, =
unsigned long addr,
>>>>> #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>>> 	if (pmd_huge(*pmd)) {
>>>>> 		ptl =3D pmd_lock(walk->mm, pmd);
>>>>> +		if (!pmd_present(*pmd)) {
>>>>> +			spin_unlock(ptl);
>>>>> +			return 0;
>>>>> +		}
>>>>> +
>>>>> 		if (!pmd_huge(*pmd)) {
>>>>> 			spin_unlock(ptl);
>>>>> 			goto regular_page;
>>>>> --=20
>>>>> 1.8.3.1

