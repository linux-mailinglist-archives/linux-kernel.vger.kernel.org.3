Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DAB525BA2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377369AbiEMGhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236494AbiEMGhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:37:09 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56864606F7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:37:08 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id y27so3753548vkl.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OinVFhkgVxz8G6r3WLh+5ytD4Oovn7TM4M9+J0/PGsM=;
        b=sUHlLm+z2dE3XMIFfMyb0yhLzLwh3dENmJkGV/c3cLLymCaIEPVpL0WNlKX+OpLMZb
         3nNAqXzsoFqzV9t1Lsy5rny1SiRpZiG+kNJ9yRXk2g8AceJJn7F00Vb1x3jY4TX4SSO0
         zCNp0fAitWKMHWxV3xeu/z5MVwViDcAk5mSHPEj0HaI/okftzDmS7c3hx69TEZyoFp9f
         hIcJKPflhQUjtszBL0c2QxKVZ3FkeP017ZYdQK/PpZWwfTt4bm7J++FKeMDREp2O7KhT
         ypE4fmu2X2o8VElW5D8b5pIPGSQZZ5UpokHrJERtn0a9hdaiZ+fBpb+PqMqWculxWhaD
         u7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OinVFhkgVxz8G6r3WLh+5ytD4Oovn7TM4M9+J0/PGsM=;
        b=4Q96eeD5O/+dVpT4Grt8xS77l/FCeC0eT+Z0QZINan+GJRb5Cbb8sDlpq1SLysvMQZ
         eQGn5SRHB43Sw7KRPmCkZiPSpZjj3ND7o8WPt1C4/Khb/VCKsUxfJMcAViL2GVIx0WwF
         uy3Sx0cGiiA5huy64ViGY7oodEV8hubyfuZUuPKuOvutMBx/owN7ifmUxkTjhBGrSVrA
         VV7a1vYVAjz8ZwaZIZF3EvdCzrDWcVj/ZQ+gkAjsYy+Ki/zwK+A71jxWUFrfH06sscmk
         nBt0plL9nXauybzY6yrRnj92A5oj9uA6JFBlq9rG+jHLKWnDdfmQNTRp0lnzTdsg3nWZ
         U2uw==
X-Gm-Message-State: AOAM533YP3KbvAkSNqvFBxoRtn53YAeEVMIuJnStMfOQTF3slDaq2bjk
        pbaOZnD2EGz0lnyfLA3P7M1KArD8UTKSvrBydlCJZQ==
X-Google-Smtp-Source: ABdhPJxbsPRoVd0/nr3aQ/+OAjoXsgkhute2b1VdD+5S6CsOP9/aAEoZKUA/2AVBQUoMpp5mkWqRsBUK7uuGKpsjSbo=
X-Received: by 2002:a05:6122:2386:b0:352:5a79:5a43 with SMTP id
 bu6-20020a056122238600b003525a795a43mr1570390vkb.23.1652423827326; Thu, 12
 May 2022 23:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u-DGLcKRVDnChN9ZhxPkfxQvz9Sb93kVoX_4J2oiJSkUw@mail.gmail.com>
 <69f2d063a15f8c4afb4688af7b7890f32af55391.camel@intel.com>
In-Reply-To: <69f2d063a15f8c4afb4688af7b7890f32af55391.camel@intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Thu, 12 May 2022 23:36:56 -0700
Message-ID: <CAAPL-u9endrWf_aOnPENDPdvT-2-YhCAeJ7ONGckGnXErTLOfQ@mail.gmail.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v2)
To:     "ying.huang@intel.com" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim C Chen <tim.c.chen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Feng Tang <feng.tang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Brice Goglin <brice.goglin@gmail.com>,
        Hesham Almatary <hesham.almatary@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 8:25 PM ying.huang@intel.com
<ying.huang@intel.com> wrote:
>
> On Wed, 2022-05-11 at 23:22 -0700, Wei Xu wrote:
> >
> > Memory Allocation for Demotion
> > ==============================
> >
> > To allocate a new page as the demotion target for a page, the kernel
> > calls the allocation function (__alloc_pages_nodemask) with the
> > source page node as the preferred node and the union of all lower
> > tier nodes as the allowed nodemask.  The actual target node selection
> > then follows the allocation fallback order that the kernel has
> > already defined.
> >
> > The pseudo code looks like:
> >
> >     targets = NODE_MASK_NONE;
> >     src_nid = page_to_nid(page);
> >     src_tier = node_tier_map[src_nid];
> >     for (i = src_tier + 1; i < MAX_MEMORY_TIERS; i++)
> >             nodes_or(targets, targets, memory_tiers[i]);
> >     new_page = __alloc_pages_nodemask(gfp, order, src_nid, targets);
> >
> > The memopolicy of cpuset, vma and owner task of the source page can
> > be set to refine the demotion target nodemask, e.g. to prevent
> > demotion or select a particular allowed node as the demotion target.
>
> Consider a system with 3 tiers, if we want to demote some pages from
> tier 0, the desired behavior is,
>
> - Allocate pages from tier 1
> - If there's no enough free pages in tier 1, wakeup kswapd of tier 1 so
> demote some pages from tier 1 to tier 2
> - If there's still no enough free pages in tier 1, allocate pages from
> tier 2.
>
> In this way, tier 0 will have the hottest pages, while tier 1 will have
> the coldest pages.

When we are already in the allocation path for the demotion of a page
from tier 0, I think we'd better not block this allocation to wait for
kswapd to demote pages from tier 1 to tier 2. Instead, we should
directly allocate from tier 2.  Meanwhile, this demotion can wakeup
kswapd to demote from tier 1 to tier 2 in the background.

> With your proposed method, the demoting from tier 0 behavior is,
>
> - Allocate pages from tier 1
> - If there's no enough free pages in tier 1, allocate pages in tier 2
>
> The kswapd of tier 1 will not be waken up until there's no enough free
> pages in tier 2.  In quite long time, there's no much hot/cold
> differentiation between tier 1 and tier 2.

This is true with the current allocation code. But I think we can make
some changes for demotion allocations. For example, we can add a
GFP_DEMOTE flag and update the allocation function to wake up kswapd
when this flag is set and we need to fall back to another node.

> This isn't hard to be fixed, just call __alloc_pages_nodemask() for each
> tier one by one considering page allocation fallback order.

That would have worked, except that there is an example earlier, in
which it is actually preferred for some nodes to demote to their tier
+ 2, not tier +1.

More specifically, the example is:

                 20
   Node 0 (DRAM) -- Node 1 (DRAM)
    |   |           |    |
    |   | 30    120 |    |
    |   v           v    | 100
100 |  Node 2 (PMEM)     |
    |    |               |
    |    | 100           |
     \   v               v
      -> Node 3 (Large Mem)

Node distances:
node   0    1    2    3
   0  10   20   30  100
   1  20   10  120  100
   2  30  120   10  100
   3 100  100  100   10

3 memory tiers are defined:
tier 0: 0-1
tier 1: 2
tier 2: 3

The demotion fallback order is:
node 0: 2, 3
node 1: 3, 2
node 2: 3
node 3: empty

Note that even though node 3 is in tier 2 and node 2 is in tier 1,
node 1 (tier 0) still prefers node 3 as its first demotion target, not
node 2.
