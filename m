Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814855908F0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 01:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbiHKXHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 19:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236178AbiHKXHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 19:07:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9390B5C9D6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 16:07:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F2BD6154D
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 23:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62743C433C1;
        Thu, 11 Aug 2022 23:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660259260;
        bh=uM4mQsMaPWfe6CzcW2yFRtNpfqcoQtL3+z1lPfRtD5w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QdEHM1RinZmbemO81xNuEoh7PM0Hi0bocvUh+C+YJhr8TaI46JS5CdILRxXHsfE+G
         gT7llHfMC7Wkq2+vAjlePIe9ztcJ92n1Ez4Dh0DCO5A97WW/FpUILCVqFhzkN4PIHT
         /rqxoJA1LfnyKaTNtk6Bsv2Q4NFV+L/virFaSYBk=
Date:   Thu, 11 Aug 2022 16:07:39 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kairui Song <kasong@tencent.com>
Cc:     Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm/util: reduce stack usage of folio_mapcount
Message-Id: <20220811160739.ea6b0f9c2912317c49287cda@linux-foundation.org>
In-Reply-To: <20220801173155.92008-1-ryncsn@gmail.com>
References: <20220801173155.92008-1-ryncsn@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  2 Aug 2022 01:31:55 +0800 Kairui Song <ryncsn@gmail.com> wrote:

> From: Kairui Song <kasong@tencent.com>
> 
> folio_entire_mapcount will call PageHeadHuge which is a function call,
> and blocks the compiler from recognizing this redundant load.

Did you mean folio_test_hugetlb() rather than folio_entire_mapcount()?


> After rearranging the code, stack usage is dropped from 32 to 24, and
> the function size is smaller (tested on GCC 12):
> 
> Before:
> Stack usage:
> mm/util.c:845:5:folio_mapcount  32      static
> Size:
> 0000000000000ea0 00000000000000c7 T folio_mapcount
> 
> After:
> Stack usage:
> mm/util.c:845:5:folio_mapcount  24      static
> Size:
> 0000000000000ea0 00000000000000b0 T folio_mapcount
> 
> ...
>
> @@ -850,10 +850,10 @@ int folio_mapcount(struct folio *folio)
>  		return atomic_read(&folio->_mapcount) + 1;
>  
>  	compound = folio_entire_mapcount(folio);
> -	nr = folio_nr_pages(folio);
>  	if (folio_test_hugetlb(folio))
>  		return compound;
>  	ret = compound;
> +	nr = folio_nr_pages(folio);
>  	for (i = 0; i < nr; i++)
>  		ret += atomic_read(&folio_page(folio, i)->_mapcount) + 1;
>  	/* File pages has compound_mapcount included in _mapcount */
> -- 
> 2.35.2
