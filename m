Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AF658F84C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 09:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbiHKH1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 03:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbiHKH1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:27:32 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0174E923CD
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 00:27:32 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0105468AA6; Thu, 11 Aug 2022 09:27:26 +0200 (CEST)
Date:   Thu, 11 Aug 2022 09:27:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        John Donnelly <john.p.donnelly@oracle.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma/pool: do not complain if DMA pool is not allocated
Message-ID: <20220811072726.GA13886@lst.de>
References: <20220325122559.14251-1-mhocko@kernel.org> <Yj28gjonUa9+0yae@dhcp22.suse.cz> <20220325164856.GA16800@lst.de> <Yj3zyLs4f+ba6UqF@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yj3zyLs4f+ba6UqF@dhcp22.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 05:54:32PM +0100, Michal Hocko wrote:
> > > I thought there are only few pages in the managed by the DMA zone. This
> > > is still theoretically possible so I think __GFP_NOWARN makes sense here
> > > but it would require to change the patch description.
> > > 
> > > Is this really worth it?
> > 
> > In general I think for kernels where we need the pool and can't allocate
> > it, a warning is very useful.  We just shouldn't spew it when there is
> > no need for the pool to start with.
> 
> Well, do we have any way to find that out during early boot?

In general an architecture / configuration that selects
CONFIG_ZONE_DMA needs it.  We could try to reduce that dependency and/or
make it boot time configurable, but there's still plenty of device with
sub-32bit addessing limits around, so I'm not sure it would help much.
