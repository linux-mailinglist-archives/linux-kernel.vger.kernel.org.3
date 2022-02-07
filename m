Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662554ACA46
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 21:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241834AbiBGUST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 15:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243005AbiBGUMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 15:12:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D0FC0401E7
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 12:12:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BCBCB81677
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 20:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB706C004E1;
        Mon,  7 Feb 2022 20:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1644264768;
        bh=kXoXRf04u+w4CWyQZgTAB7nm472L2Icz48OR33YGQt8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LwVI5+jid1TeZjul4yCBJPvxgfx8VsNnt38y2pEtRcCcSlZB3sIht3ghVWL+On82x
         eRf/xbAuVah51N+riVadi+c6A/mKfFmMhopNVTB3MidzMPzdeI3BGk+UvpwjtnFssz
         IHZsh1c+0oPHQcsqE5wcgyAsR6itraheauIdSK/A=
Date:   Mon, 7 Feb 2022 12:12:47 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mm/memory_hotplug: remove obsolete comment of
 __add_pages
Message-Id: <20220207121247.736ac7240836934247678477@linux-foundation.org>
In-Reply-To: <21cec396-9d6a-03b7-716d-2a84c79eeb73@redhat.com>
References: <20220207133643.23427-1-linmiaohe@huawei.com>
        <20220207133643.23427-2-linmiaohe@huawei.com>
        <21cec396-9d6a-03b7-716d-2a84c79eeb73@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Mon, 7 Feb 2022 15:41:21 +0100 David Hildenbrand <david@redhat.com> wrote:

> On 07.02.22 14:36, Miaohe Lin wrote:
> > Since commit f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded
> > memory to zones until online"), there is no need to pass in the zone.
> > 
> > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> > ---
> >  mm/memory_hotplug.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index a4f69d399929..cbc67c27e0dd 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -296,10 +296,7 @@ struct page *pfn_to_online_page(unsigned long pfn)
> >  EXPORT_SYMBOL_GPL(pfn_to_online_page);
> >  
> >  /*
> > - * Reasonably generic function for adding memory.  It is
> > - * expected that archs that support memory hotplug will
> > - * call this function after deciding the zone to which to
> > - * add the new pages.
> > + * Reasonably generic function for adding memory.
> >   */
> >  int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
> >  		struct mhp_params *params)
> 
> I'd suggest just removing the comment completely.

Thanks, I made that change.

A better site for documentation is at add_memory().  Which, as a
full-on exported-to-modules API function, should really have some
docs...
