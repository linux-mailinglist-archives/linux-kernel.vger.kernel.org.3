Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BC45A33A8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 04:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345208AbiH0B7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 21:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiH0B7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 21:59:16 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B437DAA3C
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 18:59:15 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661565553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XK9wonDbPQGsVKvv5YsvgEUKUZia25uBKsAM8rHUuWs=;
        b=CL1jVdEeK5ZxOoQyxCYK33HHFIIh/kddkVgeUZQVlgESI+bWcfNJ/m69DnseRy8yFXRDml
        +NiV/OYuahAkY1FuzsEs/K1oo7kNlOvuJIIQd5WawXuZS3Ao6qSZrYWxKbNfGTbspGfzAK
        nYhnLOhfgophZC02Uwp54k5bDHhdn7Y=
MIME-Version: 1.0
Subject: Re: [PATCH 10/10] hugetlb: make hugetlb selects SYSFS if !SYSCTL
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20220826092422.39591-11-linmiaohe@huawei.com>
Date:   Sat, 27 Aug 2022 09:59:09 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1BAFF85D-F7F5-4DD1-ABEF-2FF621DE34E8@linux.dev>
References: <20220826092422.39591-1-linmiaohe@huawei.com>
 <20220826092422.39591-11-linmiaohe@huawei.com>
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



> On Aug 26, 2022, at 17:24, Miaohe Lin <linmiaohe@huawei.com> wrote:
>=20
> If CONFIG_SYSFS and CONFIG_SYSCTL are both undefined, hugetlb doesn't =
work
> now as there's no way to set max huge pages. Make sure at least one of =
the
> above configs is defined to make hugetlb works as expected.

Right. I think the majority of the people are usually use /proc knob to
reserve HugeTLB pages than /sys fs. So I suggest to add a =E2=80=9Cdepends=
 on SYSCTL=E2=80=9D
item. What=E2=80=99s your thoughts?

Thanks.

>=20
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
> fs/Kconfig | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/Kconfig b/fs/Kconfig
> index a547307c1ae8..b266e7b5de85 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -235,6 +235,7 @@ config ARCH_SUPPORTS_HUGETLBFS
> config HUGETLBFS
> 	bool "HugeTLB file system support"
> 	depends on X86 || IA64 || SPARC64 || ARCH_SUPPORTS_HUGETLBFS || =
BROKEN
> +	select SYSFS if !SYSCTL
> 	help
> 	  hugetlbfs is a filesystem backing for HugeTLB pages, based on
> 	  ramfs. For architectures that support it, say Y here and read
> --=20
> 2.23.0
>=20
>=20

