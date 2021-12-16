Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F709476B44
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 08:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbhLPH7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 02:59:42 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39958 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbhLPH7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 02:59:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DB8D61812
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 07:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8131CC36AE4;
        Thu, 16 Dec 2021 07:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639641581;
        bh=omnGAeU3p0/fbX8DlE1y1+PuwXB/KVJvrTZr3uD9Lso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=dCKxrF4SrDa/CL3bibQelTisj8hHKtuhvNXbQYFEomvk24sY96tvipt1jufeTUhdD
         VuVDlnSUDudswFVIo+uLJfWBgCSRGzeIgr7SUiX8qvhygBZCHYNj0hRTJn/kvIGB5r
         QR0UhL0c/soU/Uf8gnzif/AeR0gluUI+6TvnZKbskSzFRN5O7p28ev3xfmKCbd2Mow
         CdnwgQUqrj59YW362hkocGUncf9TUnr7ZcoixiilDV4zgpCwfrfJmj65KS6XiGhQIW
         HtdHgSSrog0ipjPRSmm/pPQMe97hbOYlKFy6BZs7g9ClqFZcQwLBjICFkI29o9Zf6X
         8rge9HKHTByPA==
From:   SeongJae Park <sj@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: Add access checking for hugetlb pages
Date:   Thu, 16 Dec 2021 07:59:36 +0000
Message-Id: <20211216075936.4598-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <c4caa17a-a071-b253-0362-6dddfa1a548f@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 09:23:13 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> Hi,
> 
> On 12/16/2021 1:16 AM, SeongJae Park wrote:
> > On Wed, 15 Dec 2021 23:23:25 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> > 
> >> The process's VMAs can be mapped by hugetlb page, but now the DAMON
> >> did not implement the access checking for hugetlb pte, so we can not
> >> get the actual access count like below if a process VMAs were mapped
> >> by hugetlb.
> >>
> >> damon_aggregated: target_id=18446614368406014464
> >> nr_regions=12 4194304-5476352: 0 545
[...]
> >>
> >> Thus this patch adds hugetlb access checking support, with this patch
> >> we can see below VMA mapped by hugetlb access count.
> >>
> >> damon_aggregated: target_id=18446613056935405824
> >> nr_regions=12 140296486649856-140296489914368: 1 3
[...]
> >> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> >> index 78ff2bc..ee116e5 100644
> >> --- a/mm/damon/vaddr.c
> >> +++ b/mm/damon/vaddr.c
> >> @@ -14,6 +14,7 @@
> >>   #include <linux/page_idle.h>
> >>   #include <linux/pagewalk.h>
> >>   #include <linux/sched/mm.h>
> >> +#include <linux/hugetlb.h>
> >>   
> >>   #include "prmtv-common.h"
> >>   
> >> @@ -386,8 +387,33 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
> >>   	return 0;
> >>   }
> >>   
> >> +#ifdef CONFIG_HUGETLB_PAGE
> >> +static int damon_mkold_hugetlb_entry(pte_t *pte, unsigned long hmask,
> >> +				     unsigned long addr, unsigned long end,
> >> +				     struct mm_walk *walk)
> >> +{
> >> +	struct hstate *h = hstate_vma(walk->vma);
> >> +	spinlock_t *ptl;
> >> +	pte_t entry;
> >> +
> >> +	ptl = huge_pte_lock(h, walk->mm, pte);
> >> +	entry = huge_ptep_get(pte);
> > 
> > Could we do above assignments in the variables definitions?
> 
> Since we need get the hugetlb pte under the pte lock, I still perfer to 
> declare the lock region explicitly in the code instead in the variables 
> definitions.

Ok, that makes sense.

[...]
> >> +#ifdef CONFIG_HUGETLB_PAGE
> >> +static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
> >> +				     unsigned long addr, unsigned long end,
> >> +				     struct mm_walk *walk)
> >> +{
> >> +	struct damon_young_walk_private *priv = walk->private;
> >> +	struct hstate *h = hstate_vma(walk->vma);
> >> +	struct page *page;
> >> +	spinlock_t *ptl;
> >> +	pte_t entry;
> >> +
> >> +	ptl = huge_pte_lock(h, walk->mm, pte);
> >> +	entry = huge_ptep_get(pte);
> > 
> > Could we do these assignments in the above variables definitions?
> 
> Ditto.

Again, agreed.

> 
> Thanks for your comments.

My pleaseure!


Thanks,
SJ
