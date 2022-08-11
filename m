Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF64E58F921
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 10:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbiHKIeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 04:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbiHKId6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:33:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D8B8A7DE
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:33:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 257175C43C;
        Thu, 11 Aug 2022 08:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660206836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tidMnH8DkBKPELtNOqmK2muDDw/3JnV0nNhtTH1JuMw=;
        b=uAGQ0eH6AxTSZTu3tTxDh2JAAzGO3sfkjPwob35q44mBNm0oaevJKmJmgFTHEHaYBZ2BwH
        LBQaAnR+3TsCuzRwwWcUZPfbWJepb6YbzvfvJESSoUkriay5zk7R7VLjjaay7t2qzfNHnd
        tUFNF+feSDsmNUQPFqM91wzjpwZqwaU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0987A13A9B;
        Thu, 11 Aug 2022 08:33:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EQoGO/O+9GKeVQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 11 Aug 2022 08:33:55 +0000
Date:   Thu, 11 Aug 2022 10:33:55 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        John Donnelly <john.p.donnelly@oracle.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma/pool: do not complain if DMA pool is not allocated
Message-ID: <YvS+8wLU093QWQCL@dhcp22.suse.cz>
References: <20220325122559.14251-1-mhocko@kernel.org>
 <Yj28gjonUa9+0yae@dhcp22.suse.cz>
 <20220325164856.GA16800@lst.de>
 <Yj3zyLs4f+ba6UqF@dhcp22.suse.cz>
 <YupFSpXOrcfXJNya@dhcp22.suse.cz>
 <20220811072817.GB13886@lst.de>
 <YvS727RgUrpR4ueT@dhcp22.suse.cz>
 <20220811082132.GA17685@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811082132.GA17685@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11-08-22 10:21:32, Christoph Hellwig wrote:
> On Thu, Aug 11, 2022 at 10:20:43AM +0200, Michal Hocko wrote:
> > Meminfo part says
> > Node 0 DMA free:160kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15996kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> > 
> > So the zone has 15MB of managed memory (by the page allocator), yet only
> > 160kB is free early boot during the allocation. So it is mostly consumed
> > by somebody. I haven't really checked by whom.
> > 
> > Does that exaplain the above better?
> 
> Yes.  I'm really curious who eats up all the GFP_DMA memory early during
> boot, though.

Sorry, no idea and I do not have direct access to the machine. I can try
to dig out more but, honestly, I am not sure I will find time for that.
My main motivation was to reduce a shouting warning for something that
doesn't indicate any real problem as this has been second (maybe third)
time somebody has been complaining/asking about it.

I do get your point that the sizing is probably wrong and I agree this
is something that can be tuned better but I would rather vote for a
useful warning when the explicit request fails rather than being to
eager and warn when it is not really clear this is a problem in the
first place. In both cases admin cannot really do much other than
report. For the early boot we can only tell, this is not an immediate
problem, just ignore. For the later we know the device and see whether
we can do something about that.

Just my 2c

-- 
Michal Hocko
SUSE Labs
