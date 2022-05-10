Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9A052127D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239977AbiEJKsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbiEJKs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:48:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18FF28F1DB
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:44:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CD35617B1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544FBC385C6;
        Tue, 10 May 2022 10:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652179472;
        bh=HPlLSWADt6C9GL1GBd7Vat0uR30Gl4GAB1gf2UsAytY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=irh/0GvbJAMWtYq3cBWneVEISuY6z9KhJ9sm6cIdXLxa4Wh2vZ2agIDYa1U1ZDNOe
         5ktpcHyjhOq6AcffXJA07VrPVfML7tNF6kV8243zimvdzp6JDLTjhrZw7kW3OEhAlb
         uMkIfp/dF9IsrTHgeJwQyLlia4A+HoD9pUtTmB1L3rZjdkgXKHvTkaR71c0bivCxQH
         vhoeoBeTOVzj2S5Hxk0nmtciBoVUod5pt+DBDR0/WV9U0DXaAaavKhrkqfhVNCtBzF
         NSg0H2Go8P59h1z8yQPUGLObQOHqz8Oc4PAhxihLRtpzfX4AAe0Xg8XdMCM2+tUfzQ
         sVMDs4/N1t2Kw==
From:   SeongJae Park <sj@kernel.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon@lists.linux.dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH v9 15/69] damon: Convert __damon_va_three_regions to use the VMA iterator
Date:   Tue, 10 May 2022 10:44:28 +0000
Message-Id: <20220510104428.152064-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220504011215.661968-1-Liam.Howlett@oracle.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 May 2022 01:12:26 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> This rather specialised walk can use the VMA iterator.  If this proves to
> be too slow, we can write a custom routine to find the two largest gaps,
> but it will be somewhat complicated, so let's see if we need it first.
> 
> Update the kunit test case to use the maple tree.  This also fixes an
> issue with the kunit testcase not adding the last VMA to the list.
> 
> Fixes: 17ccae8bb5c9 (mm/damon: add kunit tests)
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/vaddr-test.h | 37 +++++++++++-------------------
>  mm/damon/vaddr.c      | 53 ++++++++++++++++++++++---------------------
>  2 files changed, 40 insertions(+), 50 deletions(-)
> 
> diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
> index 5431da4fe9d4..dbf2b8759607 100644
> --- a/mm/damon/vaddr-test.h
> +++ b/mm/damon/vaddr-test.h
> @@ -13,34 +13,21 @@
>  #define _DAMON_VADDR_TEST_H
>  
>  #include <kunit/test.h>
> +#include "../../mm/internal.h"

V9 maple tree patchset has moved the definition of vma_mas_store() from
internal.h to mmap.c, so inclusion of internal.h wouldn't needed here, right?

If we end up moving the definitions back to internal.h, because this file is
under mm/damon/, we can also use shorter include path, "../internal.h".


Thanks,
SJ

[...]
