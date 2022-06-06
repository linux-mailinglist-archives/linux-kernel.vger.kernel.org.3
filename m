Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47A953ECD8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiFFRQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 13:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiFFROv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 13:14:51 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0573262E4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 10:07:24 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id y187so13417421pgd.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 10:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YIdQbYWHfLjXxGn44OvU61+za8r6bpnRaPvLPgbwSgU=;
        b=d7YmcVSFvd0qsG5iifyuDVBz4NFkw4iyE3BzcogybyRoczqCB1GGiKP1MtlHVnBHnL
         usUyxfLkA6KgrcqOi/TYrJwxTo8Jle+llNrJ161DahsXr2zhJpu5g48/VLZRf1LO+Okd
         2SJtsl113xHSdN22ggIvYo8XAFNtDNc7hFEiVYwsBmST9xk06Wjbpi1y+0yCCkEmUIFi
         abINZaHnAur2rNUbbqKv0c8mUxZK1D8QMYNJqQsoibneqDvf0E8NgxgBmOPr6CTuM1P6
         T6B7NWTJNes2udl8qDR+xnwJIz7cgJsqow6amazTfzEzKiDcYfh8MBHCOZVVRRmtiobb
         XnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YIdQbYWHfLjXxGn44OvU61+za8r6bpnRaPvLPgbwSgU=;
        b=ftumwDGQZMW91r47sFPKI6vH4a/MzuhhuhKG7yJTaH1pdLggA8cPLPsi3qF4IgMRrg
         RNYygvsc7yXDUTTiyjBGX1xd3tJ6yT2uVS0u4PD0abQxgAfdROVDnKTo9aRwxnfj+uZj
         fSaRhVMDaG2L+3D0NPwFVtDXfLtBNtEsNNzGKOtGrqePTn0rbja3drcMjT/Lv/v6Nv0h
         qldWc6yFxiIEcMo81B8y4fI+hi0GXmQjZb+1y6O4TpNFiMQZdCO/2kW2pVrqSpg4U1u8
         mTXhG79EzjAJEO/N9zbUOQnMQK9i/K76tfmMWernnLM6NZaV512t3NCy8MbZpaoJ40Qp
         lXsw==
X-Gm-Message-State: AOAM531CVbQi0r1jhj+TK2aneqPYBCZqE1KDPImXYh97TS1js74BLInr
        qR6vV11BNg/RtX/WvvcNU5YsdQKjuIaYLAKnlV8=
X-Google-Smtp-Source: ABdhPJxWwbetIyfUiQ+jfXpvePbp8NR7jWj6iIZfNW6F+SYPoWR+epAJNLzqzIEBwB1Q2p261poeGXpGdLG0zhLNzGg=
X-Received: by 2002:aa7:94a6:0:b0:51b:ddb8:1fcf with SMTP id
 a6-20020aa794a6000000b0051bddb81fcfmr19463229pfl.23.1654535244411; Mon, 06
 Jun 2022 10:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
 <20220527122528.129445-1-aneesh.kumar@linux.ibm.com> <20220527122528.129445-8-aneesh.kumar@linux.ibm.com>
 <b102d5773bffd6391283773044f756e810c1f044.camel@intel.com>
 <046c373a-f30b-091d-47a1-e28bfb7e9394@linux.ibm.com> <9f6e60cc8be3cbde4871458c612c5c31d2a9e056.camel@intel.com>
 <a7d3829e-8bc5-d7a8-5e9e-a7943bb50740@linux.ibm.com> <65919df6b3302741780ff6fa69e497af06a9825e.camel@intel.com>
In-Reply-To: <65919df6b3302741780ff6fa69e497af06a9825e.camel@intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 6 Jun 2022 10:07:11 -0700
Message-ID: <CAHbLzkqUxCTgvO6iXN40JNa3a85oWW=+frYgd3vUhJu+9c=Cpg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 7/7] mm/demotion: Demote pages according to
 allocation fallback order
To:     Ying Huang <ying.huang@intel.com>
Cc:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 5, 2022 at 10:27 PM Ying Huang <ying.huang@intel.com> wrote:
>
> On Mon, 2022-06-06 at 09:37 +0530, Aneesh Kumar K V wrote:
> > On 6/6/22 6:13 AM, Ying Huang wrote:
> > > On Fri, 2022-06-03 at 20:39 +0530, Aneesh Kumar K V wrote:
> > > > On 6/2/22 1:05 PM, Ying Huang wrote:
> > > > > On Fri, 2022-05-27 at 17:55 +0530, Aneesh Kumar K.V wrote:
> > > > > > From: Jagdish Gediya <jvgediya@linux.ibm.com>
> > > > > >
> > > > > > currently, a higher tier node can only be demoted to selected
> > > > > > nodes on the next lower tier as defined by the demotion path,
> > > > > > not any other node from any lower tier.  This strict, hard-coded
> > > > > > demotion order does not work in all use cases (e.g. some use cases
> > > > > > may want to allow cross-socket demotion to another node in the same
> > > > > > demotion tier as a fallback when the preferred demotion node is out
> > > > > > of space). This demotion order is also inconsistent with the page
> > > > > > allocation fallback order when all the nodes in a higher tier are
> > > > > > out of space: The page allocation can fall back to any node from any
> > > > > > lower tier, whereas the demotion order doesn't allow that currently.
> > > > > >
> > > > > > This patch adds support to get all the allowed demotion targets mask
> > > > > > for node, also demote_page_list() function is modified to utilize this
> > > > > > allowed node mask by filling it in migration_target_control structure
> > > > > > before passing it to migrate_pages().
> > > > >
> > > >
> > > > ...
> > > >
> > > > > >     * Take pages on @demote_list and attempt to demote them to
> > > > > >     * another node.  Pages which are not demoted are left on
> > > > > > @@ -1481,6 +1464,19 @@ static unsigned int demote_page_list(struct list_head *demote_pages,
> > > > > >    {
> > > > > >       int target_nid = next_demotion_node(pgdat->node_id);
> > > > > >       unsigned int nr_succeeded;
> > > > > > +     nodemask_t allowed_mask;
> > > > > > +
> > > > > > +     struct migration_target_control mtc = {
> > > > > > +             /*
> > > > > > +              * Allocate from 'node', or fail quickly and quietly.
> > > > > > +              * When this happens, 'page' will likely just be discarded
> > > > > > +              * instead of migrated.
> > > > > > +              */
> > > > > > +             .gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) | __GFP_NOWARN |
> > > > > > +                     __GFP_NOMEMALLOC | GFP_NOWAIT,
> > > > > > +             .nid = target_nid,
> > > > > > +             .nmask = &allowed_mask
> > > > > > +     };
> > > > >
> > > > > IMHO, we should try to allocate from preferred node firstly (which will
> > > > > kick kswapd of the preferred node if necessary).  If failed, we will
> > > > > fallback to all allowed node.
> > > > >
> > > > > As we discussed as follows,
> > > > >
> > > > > https://lore.kernel.org/lkml/69f2d063a15f8c4afb4688af7b7890f32af55391.camel@intel.com/
> > > > >
> > > > > That is, something like below,
> > > > >
> > > > > static struct page *alloc_demote_page(struct page *page, unsigned long node)
> > > > > {
> > > > >         struct page *page;
> > > > >         nodemask_t allowed_mask;
> > > > >         struct migration_target_control mtc = {
> > > > >                 /*
> > > > >                  * Allocate from 'node', or fail quickly and quietly.
> > > > >                  * When this happens, 'page' will likely just be discarded
> > > > >                  * instead of migrated.
> > > > >                  */
> > > > >                 .gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
> > > > >                             __GFP_THISNODE  | __GFP_NOWARN |
> > > > >                             __GFP_NOMEMALLOC | GFP_NOWAIT,
> > > > >                 .nid = node
> > > > >         };
> > > > >
> > > > >         page = alloc_migration_target(page, (unsigned long)&mtc);
> > > > >         if (page)
> > > > >                 return page;
> > > > >
> > > > >         mtc.gfp_mask &= ~__GFP_THISNODE;
> > > > >         mtc.nmask = &allowed_mask;
> > > > >
> > > > >         return alloc_migration_target(page, (unsigned long)&mtc);
> > > > > }
> > > >
> > > > I skipped doing this in v5 because I was not sure this is really what we
> > > > want.
> > >
> > > I think so.  And this is the original behavior.  We should keep the
> > > original behavior as much as possible, then make changes if necessary.
> > >
> >
> > That is the reason I split the new page allocation as a separate patch.
> > Previous discussion on this topic didn't conclude on whether we really
> > need to do the above or not
> > https://lore.kernel.org/lkml/CAAPL-u9endrWf_aOnPENDPdvT-2-YhCAeJ7ONGckGnXErTLOfQ@mail.gmail.com/
>
> Please check the later email in the thread you referenced.  Both Wei and
> me agree that the use case needs to be supported.  We just didn't reach
> concensus about how to implement it.  If you think Wei's solution is
> better (referenced as below), you can try to do that too.  Although I
> think my proposed implementation is much simpler.
>
> "
> This is true with the current allocation code. But I think we can make
> some changes for demotion allocations. For example, we can add a
> GFP_DEMOTE flag and update the allocation function to wake up kswapd
> when this flag is set and we need to fall back to another node.
> "

Sorry for chiming in late. Yes, I also agree doing harder on the
preferred node before fallback is a valid usecase. I think the "trying
with __GFP_THISNODE then retrying w/o it" should be good enough for
now since demotion is the only user and vmscan is the only callsite
for now. It won't be late to modify core page allocation function to
support this semantic when it gets broader use.

>
> > Based on the above I looked at avoiding GFP_THISNODE allocation. If you
> > have experiment results that suggest otherwise can you share? I could
> > summarize that in the commit message for better description of why
> > GFP_THISNODE enforcing is needed.
>
> Why?  GFP_THISNODE is just the first step.  We will fallback to
> allocation without it if necessary.
>
> Best Regards,
> Huang, Ying
>
> > > > I guess we can do this as part of the change that is going to
> > > > introduce the usage of memory policy for the allocation?
> > >
> > > Like the memory allocation policy, the default policy should be local
> > > preferred.  We shouldn't force users to use explicit memory policy for
> > > that.
> > >
> > > And the added code isn't complex.
> > >
> >
> > -aneesh
>
>
>
