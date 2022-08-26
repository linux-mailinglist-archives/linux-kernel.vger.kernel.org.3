Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7194F5A1F22
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 04:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244906AbiHZCxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 22:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238683AbiHZCxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 22:53:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D03CD507
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 19:53:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4F0B61E0F
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D998C433C1;
        Fri, 26 Aug 2022 02:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661482394;
        bh=5hL+Qohca2z4LHdl33S7reOO2QkPfuDoatK2OM7n0As=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d50KXlpEz6oFuZgcXJQCIN9nTaOW3jW5BZL/mPuVC8asneQndzzdBiBd9DGOupESS
         yLZdBpQiLn7nddRZ9MyPfNsUt/mMMZ6YO8V5mcU3ETE14MorNMCIP2sRhfEEkHesTc
         7gyRp/hg3vBWJjmJRRzLTZGC9WbuAAGPDHGegx3I=
Date:   Thu, 25 Aug 2022 19:53:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Haiyue Wang <haiyue.wang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, david@redhat.com, apopple@nvidia.com,
        linmiaohe@huawei.com, ying.huang@intel.com,
        songmuchun@bytedance.com, naoya.horiguchi@linux.dev,
        alex.sierra@amd.com, mike.kravetz@oracle.com,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v7 1/2] mm: migration: fix the FOLL_GET failure on
 following huge page
Message-Id: <20220825195312.8490c2c9c0a1c54f43851cfc@linux-foundation.org>
In-Reply-To: <20220825143917.32175f7d@thinkpad>
References: <20220823135841.934465-1-haiyue.wang@intel.com>
        <20220823135841.934465-2-haiyue.wang@intel.com>
        <20220824113858.9f0a2200c4d4875a5f4da31c@linux-foundation.org>
        <20220825143917.32175f7d@thinkpad>
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

On Thu, 25 Aug 2022 14:39:17 +0200 Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:

> On Wed, 24 Aug 2022 11:38:58 -0700
> Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > On Tue, 23 Aug 2022 21:58:40 +0800 Haiyue Wang <haiyue.wang@intel.com> wrote:
> > 
> > > Not all huge page APIs support FOLL_GET option, so move_pages() syscall
> > > will fail to get the page node information for some huge pages.
> > > 
> > > Like x86 on linux 5.19 with 1GB huge page API follow_huge_pud(), it will
> > > return NULL page for FOLL_GET when calling move_pages() syscall with the
> > > NULL 'nodes' parameter, the 'status' parameter has '-2' error in array.
> > > 
> > > Note: follow_huge_pud() now supports FOLL_GET in linux 6.0.
> > >       Link: https://lore.kernel.org/all/20220714042420.1847125-3-naoya.horiguchi@linux.dev
> > > 
> > > But these huge page APIs don't support FOLL_GET:
> > >   1. follow_huge_pud() in arch/s390/mm/hugetlbpage.c
> > >   2. follow_huge_addr() in arch/ia64/mm/hugetlbpage.c
> > >      It will cause WARN_ON_ONCE for FOLL_GET.
> > >   3. follow_huge_pgd() in mm/hugetlb.c
> > 
> > What happened to the proposal to fix these three sites so this patch is
> > not needed?
> 
> For s390, you can add my patch from
> https://lore.kernel.org/linux-mm/20220818135717.609eef8a@thinkpad/
> to this series.
> 

Thanks, I added that.

