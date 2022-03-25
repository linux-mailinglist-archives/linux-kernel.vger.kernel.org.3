Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADA84E796B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 17:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377076AbiCYQ4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 12:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377064AbiCYQ41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:56:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F518E5412
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:54:34 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2C24F210EF;
        Fri, 25 Mar 2022 16:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648227273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zeVrtVyAK7v5KJnvBMeeYBqAbke4hvV/2TV/CFi2Fyo=;
        b=ZWcfv6fhSzG9V01DcbjPSVu1jSsXsfkHbGDcMsuW6tKQ0tTkx7WHta4XWtRVh9eqh3CzKo
        dcacjT7rqYbFS7nOV4NGo8p96EUGBr7g1uAzadN0Jyrhcg8c04Ano+vfr1LrdiwrvOrfI8
        2Xo6BYPKjUVIytLpSiLhI9GEmxYDVPM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id ED61BA3B94;
        Fri, 25 Mar 2022 16:54:32 +0000 (UTC)
Date:   Fri, 25 Mar 2022 17:54:32 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        John Donnelly <john.p.donnelly@oracle.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma/pool: do not complain if DMA pool is not allocated
Message-ID: <Yj3zyLs4f+ba6UqF@dhcp22.suse.cz>
References: <20220325122559.14251-1-mhocko@kernel.org>
 <Yj28gjonUa9+0yae@dhcp22.suse.cz>
 <20220325164856.GA16800@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325164856.GA16800@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 25-03-22 17:48:56, Christoph Hellwig wrote:
> On Fri, Mar 25, 2022 at 01:58:42PM +0100, Michal Hocko wrote:
> > Dang, I have just realized that I have misread the boot log and it has
> > turned out that a674e48c5443 is covering my situation because the
> > allocation failure message says:
> >
> > Node 0 DMA free:0kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:636kB managed:0kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> 
> As in your report is from a kernel that does not have a674e48c5443
> yet?

yes. I just mixed up the early boot messages and thought that DMA zone
ended up with a single page. That message was saying something else
though.
 
> > I thought there are only few pages in the managed by the DMA zone. This
> > is still theoretically possible so I think __GFP_NOWARN makes sense here
> > but it would require to change the patch description.
> > 
> > Is this really worth it?
> 
> In general I think for kernels where we need the pool and can't allocate
> it, a warning is very useful.  We just shouldn't spew it when there is
> no need for the pool to start with.

Well, do we have any way to find that out during early boot?

-- 
Michal Hocko
SUSE Labs
