Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889C95A0177
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 20:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239274AbiHXSjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 14:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237759AbiHXSjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 14:39:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AE17A759
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 11:39:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6300D61783
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 18:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D47C433D6;
        Wed, 24 Aug 2022 18:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661366339;
        bh=6WIIhfjVkCvTJa4ixWHqJBYM6NhXSOMJM2g4EDM++PE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jwKQ9J0fMGJq76G+/qoOsN1iLuKbFwlsAKCve86un7ZXyxcQogKoV6Pd/hAlqAHbQ
         UvMVBYjLcu5r6vxaiC0mq+LqhffElWlCGqzd2vTdA8C+GngpDPA+wlL+PJz3FPKC9H
         zBL7oQlZtrrdKFjMUR7s1beyNZcAOb8PbajUglKg=
Date:   Wed, 24 Aug 2022 11:38:58 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Haiyue Wang <haiyue.wang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
        apopple@nvidia.com, linmiaohe@huawei.com, ying.huang@intel.com,
        songmuchun@bytedance.com, naoya.horiguchi@linux.dev,
        alex.sierra@amd.com, mike.kravetz@oracle.com,
        gerald.schaefer@linux.ibm.com,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH v7 1/2] mm: migration: fix the FOLL_GET failure on
 following huge page
Message-Id: <20220824113858.9f0a2200c4d4875a5f4da31c@linux-foundation.org>
In-Reply-To: <20220823135841.934465-2-haiyue.wang@intel.com>
References: <20220823135841.934465-1-haiyue.wang@intel.com>
        <20220823135841.934465-2-haiyue.wang@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2022 21:58:40 +0800 Haiyue Wang <haiyue.wang@intel.com> wrote:

> Not all huge page APIs support FOLL_GET option, so move_pages() syscall
> will fail to get the page node information for some huge pages.
> 
> Like x86 on linux 5.19 with 1GB huge page API follow_huge_pud(), it will
> return NULL page for FOLL_GET when calling move_pages() syscall with the
> NULL 'nodes' parameter, the 'status' parameter has '-2' error in array.
> 
> Note: follow_huge_pud() now supports FOLL_GET in linux 6.0.
>       Link: https://lore.kernel.org/all/20220714042420.1847125-3-naoya.horiguchi@linux.dev
> 
> But these huge page APIs don't support FOLL_GET:
>   1. follow_huge_pud() in arch/s390/mm/hugetlbpage.c
>   2. follow_huge_addr() in arch/ia64/mm/hugetlbpage.c
>      It will cause WARN_ON_ONCE for FOLL_GET.
>   3. follow_huge_pgd() in mm/hugetlb.c

What happened to the proposal to fix these three sites so this patch is
not needed?

> This is an temporary solution to mitigate the side effect of the race
> condition fix by calling follow_page() with FOLL_GET set for huge pages.
> 
> After supporting follow huge page by FOLL_GET is done, this fix can be
> reverted safely.

