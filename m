Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46312597BA9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 04:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbiHRCry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 22:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242559AbiHRCru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 22:47:50 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6323CA4B13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 19:47:49 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660790867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8cgTJV67VWUuGm2uD1nBwZtNeQZFKzsqmUITH2F1GjY=;
        b=dI8UsnSe8HNhSfv5Yf6Jbb50mb5mNmJ8qZ+kIdSJAkiBE02UzfqhEU9BeW3r3les3CQVHZ
        5X3iv47rVynKqAQy1BKoFrbaIYNOrEweDhD4ZW9uPPmsGy32dPogZdqjgslVuE3XnLAOV/
        p/WpWFDlGhUXzfqQG8NBWSGvhkY6aCw=
MIME-Version: 1.0
Subject: Re: [PATCH 4/6] mm: hugetlb_vmemmap: add missing smp_wmb() before
 set_pte_at()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <9c791de0-b702-1bbe-38a4-30e87d9d1b95@intel.com>
Date:   Thu, 18 Aug 2022 10:47:19 +0800
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <931536E2-3948-40AB-88A7-E36F67954AAA@linux.dev>
References: <20220816130553.31406-1-linmiaohe@huawei.com>
 <20220816130553.31406-5-linmiaohe@huawei.com>
 <D8C00BDA-160D-40CE-AFBD-9488F85E76CE@linux.dev>
 <ea67ab10-667e-f361-b80f-dafb13da4808@huawei.com>
 <0EAF1279-6A1C-41FA-9A32-414C36B3792A@linux.dev>
 <019c1272-9d01-9d51-91a0-2d656b25c318@intel.com>
 <18adbf89-473e-7ba6-9a2b-522e1592bdc6@huawei.com>
 <9c791de0-b702-1bbe-38a4-30e87d9d1b95@intel.com>
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
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



> On Aug 18, 2022, at 10:00, Yin, Fengwei <fengwei.yin@intel.com> wrote:
>=20
>=20
>=20
> On 8/18/2022 9:55 AM, Miaohe Lin wrote:
>>>>> 	/*
>>>>> 	 * The memory barrier inside __SetPageUptodate makes sure that
>>>>> 	 * preceding stores to the page contents become visible before
>>>>> 	 * the set_pte_at() write.
>>>>> 	 */
>>>>> 	__SetPageUptodate(page);
>>>> IIUC, the case here we should make sure others (CPUs) can see new =
page=E2=80=99s
>>>> contents after they have saw PG_uptodate is set. I think commit =
0ed361dec369
>>>> can tell us more details.
>>>>=20
>>>> I also looked at commit 52f37629fd3c to see why we need a barrier =
before
>>>> set_pte_at(), but I didn=E2=80=99t find any info to explain why. I =
guess we want
>>>> to make sure the order between the page=E2=80=99s contents and =
subsequent memory
>>>> accesses using the corresponding virtual address, do you agree with =
this?
>>> This is my understanding also. Thanks.
>> That's also my understanding. Thanks both.
> I have an unclear thing (not related with this patch directly): Who is =
response
> for the read barrier in the read side in this case?
>=20
> For SetPageUptodate, there are paring write/read memory barrier.
>=20

I have the same question. So I think the example proposed by Miaohe is a =
little
difference from the case (hugetlb_vmemmap) here.

>=20
> Regards
> Yin, Fengwei
>=20
>=20

