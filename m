Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B058646CA54
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 02:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243086AbhLHB5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 20:57:17 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:59510 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238582AbhLHB5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:57:15 -0500
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 794F7CE1F7F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 01:53:43 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7648E60E98;
        Wed,  8 Dec 2021 01:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1638928421;
        bh=JIUtT1nVOZt+ipMUhsyNal3eL3AADWDbcDFza2JgQ1E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s28Ei0baHx4OEp0c39KZjIW9kd2jRsYd1nuE6p2uhpPyY875Rwmt9gMGHFip4PsiZ
         wFxXFKRDJHz6nC1Ji/OhNvM8x3SGPQx2ZhscHslyJz2U5VGHJ9XZ1pEEZak6wzegbq
         Dda9bx9PYaFxkUcgSPhSfFVBvvBPfiscQJsbbtmc=
Date:   Tue, 7 Dec 2021 17:53:38 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nico Pache <npache@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, mhocko@suse.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        shakeelb@google.com, ktkhai@virtuozzo.com, shy828301@gmail.com,
        guro@fb.com, vbabka@suse.cz, vdavydov.dev@gmail.com,
        raquini@redhat.com, david@redhat.com
Subject: Re: [PATCH v2 1/1] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
Message-Id: <20211207175338.229c52144a67fc1a76b5840c@linux-foundation.org>
In-Reply-To: <a1c3e952-866d-e3b4-1479-8f04e963bf11@redhat.com>
References: <20211207224013.880775-1-npache@redhat.com>
        <20211207224013.880775-2-npache@redhat.com>
        <Ya/vaGdKHm6Zy3ML@casper.infradead.org>
        <a1c3e952-866d-e3b4-1479-8f04e963bf11@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2021 19:25:25 -0500 Nico Pache <npache@redhat.com> wrote:

> 
> 
> On 12/7/21 18:34, Matthew Wilcox wrote:
> > On Tue, Dec 07, 2021 at 05:40:13PM -0500, Nico Pache wrote:
> >> +++ b/mm/vmscan.c
> >> @@ -222,13 +222,16 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
> >>  	int size = map_size + defer_size;
> >>  
> >>  	for_each_node(nid) {
> >> +		int tmp = nid;
> >>  		pn = memcg->nodeinfo[nid];
> >>  		old = shrinker_info_protected(memcg, nid);
> >>  		/* Not yet online memcg */
> >>  		if (!old)
> >>  			return 0;
> >>  
> >> -		new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, nid);
> >> +		if(!node_online(nid))
> >> +			tmp = numa_mem_id();
> >> +		new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, tmp);
> >>  		if (!new)
> > 
> > Why should this be fixed here and not in, say, kvmalloc_node()?
> 
> according to Michal, the caller should be responsible for making sure it is
> allocating on a correct node. This avoids adding branches to hot-paths and
> wasting cycles. Im not opposed to moving it to kvmalloc_node, but it may result
> in masking other issues from other callers.
> > 

Yes, kvmalloc_node(nid) should allocate on `nid', or should fail.

A new kvmalloc_try_node() or whatever would express this idea.
