Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B804E7940
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 17:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376971AbiCYQug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 12:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376956AbiCYQue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:50:34 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95FF53E23
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:48:59 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4AA1668B05; Fri, 25 Mar 2022 17:48:56 +0100 (CET)
Date:   Fri, 25 Mar 2022 17:48:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Baoquan He <bhe@redhat.com>,
        John Donnelly <john.p.donnelly@oracle.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma/pool: do not complain if DMA pool is not allocated
Message-ID: <20220325164856.GA16800@lst.de>
References: <20220325122559.14251-1-mhocko@kernel.org> <Yj28gjonUa9+0yae@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yj28gjonUa9+0yae@dhcp22.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 01:58:42PM +0100, Michal Hocko wrote:
> Dang, I have just realized that I have misread the boot log and it has
> turned out that a674e48c5443 is covering my situation because the
> allocation failure message says:
>
> Node 0 DMA free:0kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:636kB managed:0kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB

As in your report is from a kernel that does not have a674e48c5443
yet?

> 
> I thought there are only few pages in the managed by the DMA zone. This
> is still theoretically possible so I think __GFP_NOWARN makes sense here
> but it would require to change the patch description.
> 
> Is this really worth it?

In general I think for kernels where we need the pool and can't allocate
it, a warning is very useful.  We just shouldn't spew it when there is
no need for the pool to start with.
