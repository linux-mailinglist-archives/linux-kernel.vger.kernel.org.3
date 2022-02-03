Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F154A80C0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 09:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349652AbiBCI5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 03:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiBCI5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 03:57:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BE8C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 00:57:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 580C7B83378
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 08:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CD7C340E4;
        Thu,  3 Feb 2022 08:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643878672;
        bh=0O4UQoD2ga6k8Fj8aX29klaeBEumEjofWg7hsdFfsM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kHAcnm6m+d9hh1HYDeWKJxuqlTL8N0UTPGjjxyOHFvOw+as96nNEr1IDN498AE04m
         KH8rBQarAamNG3Nj23bJHWgBfem4/xVw+2NmVxDO6ypA0MAARNJ6EmueTXmCeoJZ9x
         VLUheQVh6myRN6SVBhCxcqsST0ZVryAQUqN+hsC++XqsZlAky6D7ISbYTiUObqmTjx
         5wjDXMe7QQSLJyE6aYko1KPFxdK5yAw9ixt7BhhIkMf1i9mvC8K8AQx51OIqlsvPct
         4JvJvP7EqRV1GJiECRvfIEOXfnUK6wYguOEdBPMhqswBX2FZkZNeQN6/zTCR6NnX+g
         ZY9S0u0501uZQ==
Date:   Thu, 3 Feb 2022 10:57:43 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 07/70] Maple Tree: Add new data structure
Message-ID: <YfuZBwyK0CL0Io6X@kernel.org>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
 <20220202024137.2516438-8-Liam.Howlett@oracle.com>
 <Yfq7J9LU58FqNFVW@kernel.org>
 <20220203023836.bfu2mviijlkc2pgz@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203023836.bfu2mviijlkc2pgz@revolver>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 02:38:42AM +0000, Liam Howlett wrote:
> * Mike Rapoport <rppt@kernel.org> [220202 12:11]:
> > Hi Liam,
> > 
> > On Wed, Feb 02, 2022 at 02:41:56AM +0000, Liam Howlett wrote:
> > > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> > > 
> > > +The Maple Tree maintains a small memory footprint and was designed to use
> > > +modern processor cache efficiently.  The most important user of the Maple Tree
> > > +is the virtual memory area.
> > 
> > For me it sounds like VMA *is* the maple tree user. Maybe
> > 
> >   The most important usage of the Maple Tree is tracking of the virtual
> >   memory areas.
> > 
> 
> Thanks, I can see that now.  I'm not a fan of either of the ways this is
> written but yours is more clear.

Maybe you can come up with even better one :)
 
> > > diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> > > new file mode 100644
> > > index 000000000000..14ddeaa8f3e7
> > > --- /dev/null
> > > +++ b/include/linux/maple_tree.h
> > > @@ -0,0 +1,673 @@
> > > +/* SPDX-License-Identifier: GPL-2.0+ */
> > > +#ifndef _LINUX_MAPLE_TREE_H
> > > +#define _LINUX_MAPLE_TREE_H
> > > +/*
> > > + * Maple Tree - An RCU-safe adaptive tree for storing ranges
> > > + * Copyright (c) 2018 Oracle
> > 
> > 2018 - 2022?
> 
> Wait, what happened in 2019-2022?  Did I miss anything?

I'm really not a copyright expert, but from what I see the dates in
copyright notice use the year when the patches are posted or a range that
end in that year.
 
> > 
> > > + * Authors:     Liam R. Howlett <Liam.Howlett@Oracle.com>
> > > + *              Matthew Wilcox <willy@infradead.org>
> > > + */
> > > +
> > > +#include <linux/kernel.h>
> > > +#include <linux/rcupdate.h>
> > > +#include <linux/spinlock.h>
> > > +/* #define CONFIG_MAPLE_RCU_DISABLED */
> > > +/* #define CONFIG_DEBUG_MAPLE_TREE_VERBOSE */
> > > +
> > > +/*
> > > + * Allocated nodes are mutable until they have been inserted into the tree,
> > > + * at which time they cannot change their type until they have been removed
> > > + * from the tree and an RCU grace period has passed.
> > > + *
> > > + * Removed nodes have their ->parent set to point to themselves.  RCU readers
> > > + * check ->parent before relying on the value that they loaded from the
> > > + * slots array.  This lets us reuse the slots array for the RCU head.
> > > + *
> > > + * Nodes in the tree point to their parent unless bit 0 is set.
> > 
> > There are a lots of comments describing the maple tree internals here and
> > below. Did yaou consider adding a section "Implementation details" or
> > something like that to the maple_tree.rst and linking these comments there
> > with DOC: and some glue text?
> 
> I did.  I actually had it in there but moved it into the code in an
> effort to avoid the documentation from being a developer doc.  I'd like
> it to be a user document.  I also did not want the implementation
> details to be too far away from the code to avoid it being missed when
> the code changes.

There could be two documents: one for the users and another one with
implementation details ;-)

The implementation description can then include DOC: parts to keep that
documentation close to the code. But if you prefer to skip this part (like
most of us do) I'll understand :)

> > > +/*
> > > + * More complicated stores can cause two nodes to become one or tree and
> > 
> >                                                                   ^ three?
> 
> Yes, perhaps I typed my accent here :)

Or because it's all about trees :)
 

-- 
Sincerely yours,
Mike.
