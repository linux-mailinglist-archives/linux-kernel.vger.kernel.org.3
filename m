Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136655AA061
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiIATtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbiIATtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:49:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574E09CCDC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 12:49:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B47AB825DC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 19:49:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B39C433D6;
        Thu,  1 Sep 2022 19:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1662061774;
        bh=dg+ppRmkii5agmo19wFs2/RQZz+ZaDfIvg57CDdj8ok=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GLJWpoiIXh0uhBMuWBX6kmylUDxLAOU3NwISOFteCLQqVRHeChODXilCN9pJ9w5al
         t/EY5KiXLLvkuClEHs1FsGmXKt+EpIbeJadCwnV1i+bMgc0gwhapul4qNu3ADoeQEB
         xjmfN3OQG/n74smWZociDjoWUOUJJRAFsfbIwRHI=
Date:   Thu, 1 Sep 2022 12:49:33 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     mike.kravetz@oracle.com, songmuchun@bytedance.com,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/hugetlb: fix races when looking up a CONT-PTE/PMD
 size hugetlb page
Message-Id: <20220901124933.57ccd5f7c8dd8611ab667c3c@linux-foundation.org>
In-Reply-To: <635f43bdd85ac2615a58405da82b4d33c6e5eb05.1662017562.git.baolin.wang@linux.alibaba.com>
References: <635f43bdd85ac2615a58405da82b4d33c6e5eb05.1662017562.git.baolin.wang@linux.alibaba.com>
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

On Thu,  1 Sep 2022 18:41:31 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> On some architectures (like ARM64), it can support CONT-PTE/PMD size
> hugetlb, which means it can support not only PMD/PUD size hugetlb
> (2M and 1G), but also CONT-PTE/PMD size(64K and 32M) if a 4K page size
> specified.
> 
> So when looking up a CONT-PTE size hugetlb page by follow_page(), it
> will use pte_offset_map_lock() to get the pte entry lock for the CONT-PTE
> size hugetlb in follow_page_pte(). However this pte entry lock is incorrect
> for the CONT-PTE size hugetlb, since we should use huge_pte_lock() to
> get the correct lock, which is mm->page_table_lock.
> 
> That means the pte entry of the CONT-PTE size hugetlb under current
> pte lock is unstable in follow_page_pte(), we can continue to migrate
> or poison the pte entry of the CONT-PTE size hugetlb, which can cause
> some potential race issues, even though they are under the 'pte lock'.
> 
> For example, suppose thread A is trying to look up a CONT-PTE size
> hugetlb page by move_pages() syscall under the lock, however antoher
> thread B can migrate the CONT-PTE hugetlb page at the same time, which
> will cause thread A to get an incorrect page, if thread A also wants to
> do page migration, then data inconsistency error occurs.
> 
> Moreover we have the same issue for CONT-PMD size hugetlb in
> follow_huge_pmd().
> 
> To fix above issues, rename the follow_huge_pmd() as follow_huge_pmd_pte()
> to handle PMD and PTE level size hugetlb, which uses huge_pte_lock() to
> get the correct pte entry lock to make the pte entry stable.
> 
> Cc: <stable@vger.kernel.org>

Are we able to think of a Fixes: for this?

> Mike, please fold this patch into your series. Thanks.

As this is cc:stable I'll be looking to get this into mainline during
this -rc cycle, so it shouldn't be part of a for-next-rc patch series.

