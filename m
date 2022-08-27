Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325475A33E5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 04:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbiH0Cso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 22:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbiH0Csl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 22:48:41 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B76E86B7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 19:48:40 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661568518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pDNO5snsfzZ0QfiFLp+wtvtFYkVtacMwaYUOIIg95Vk=;
        b=k8ARJIaZnV00D1GHc+/8GObxNNbysxo1gwRwuiDJyVku0ekFoxwVX0fP3AOTbAZ+IbVFP7
        nOq8hBEKMMTTeANzIY7o9onqZKRHNLvvWBaKQubh009bQ4jnSo6lpeW8eS3tBmQwLwNIJ0
        UxDD6bCMc1n1/Y97tW4zXEnxzrufFmc=
MIME-Version: 1.0
Subject: Re: [PATCH 03/10] hugetlb: Use LIST_HEAD() to define a list head
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <bb05153c-29a9-b77e-0815-506309da6da0@huawei.com>
Date:   Sat, 27 Aug 2022 10:48:34 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>, mike.kravetz@oracle.com,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <83DBE074-0B63-4CB2-9BD2-65967977B69C@linux.dev>
References: <20220826092422.39591-1-linmiaohe@huawei.com>
 <20220826092422.39591-4-linmiaohe@huawei.com>
 <8D011A6F-F557-4519-852C-80BBDE53E630@linux.dev>
 <bb05153c-29a9-b77e-0815-506309da6da0@huawei.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 27, 2022, at 10:27, Miaohe Lin <linmiaohe@huawei.com> wrote:
>=20
> On 2022/8/27 9:47, Muchun Song wrote:
>>=20
>>=20
>>> On Aug 26, 2022, at 17:24, Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>=20
>>> We can avoid unneeded WRITE_ONCE() overhead by using LIST_HEAD() to =
define
>>> a list head.
>>=20
>> IIUC, the overhead doesn=E2=80=99t change. Right?
>=20
> I think the overhead is changed. LIST_HEAD is initialized without =
using WRITE_ONCE():

I think there is no special difference with "WRITE_ONCE(var, 0)" vs "var =
=3D 0=E2=80=9D in
assembly code. Both code of line will be compiled to a mov or movq =
instruction.
I didn=E2=80=99t confirm if the assembly code is different (I tend to =
think it is similar).
Just some analysis from me.

>=20
> #define LIST_HEAD_INIT(name) { &(name), &(name) }
>=20
> #define LIST_HEAD(name) \
> 	struct list_head name =3D LIST_HEAD_INIT(name)
>=20
> while INIT_LIST_HEAD has:
>=20
> static inline void INIT_LIST_HEAD(struct list_head *list)
> {
> 	WRITE_ONCE(list->next, list);
> 	WRITE_ONCE(list->prev, list);
> }
>=20
> Or am I miss something?
>=20
>>=20
>> I=E2=80=99m fine with your changes.
>>=20
>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>=20
> Many thanks for your review and comment. :)
>=20
> Thanks,
> Miaohe Lin
>=20

