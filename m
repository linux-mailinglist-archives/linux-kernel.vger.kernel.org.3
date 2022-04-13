Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651F84FF5CB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 13:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbiDMLha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 07:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiDMLh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 07:37:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C092E237F8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:35:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7B2F71F38D;
        Wed, 13 Apr 2022 11:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649849704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fFqfiFiCx2hMGSLHkHBmN5BfJizyHy0EGQZ4MjVsO7g=;
        b=XtWQOfFS03MuJAoFKw1G6tY/N1VE3kpuCtr0LmuGD4fnq65kIvngZSl5T++LA3Mq3rRCYS
        a67zEvFqPSLazUTz+DgtckdMscYtdBliJwJZuDpE5232BPC3skv3uDE7PA4+yiP124+Cqr
        13h6mfA6/zXRPY9JdvtF2uuA7If9DBQ=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3C5E4A3B87;
        Wed, 13 Apr 2022 11:35:03 +0000 (UTC)
Date:   Wed, 13 Apr 2022 13:35:03 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Wu Yan <wu-yan@tcl.com>
Cc:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, tang.ding@tcl.com
Subject: Re: [PATCH] f2fs: avoid deadlock in gc thread under low memory
Message-ID: <Yla1Z8Ze0iJvXRFT@dhcp22.suse.cz>
References: <181ce21548da652d9a14eebc684fe75c@sslemail.net>
 <Ylab+Tz4d8kZYjef@dhcp22.suse.cz>
 <ff186d65-2103-b796-79b9-3eb4a3e04380@tcl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff186d65-2103-b796-79b9-3eb4a3e04380@tcl.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13-04-22 19:20:06, Wu Yan wrote:
> On 4/13/22 17:46, Michal Hocko wrote:
> > On Wed 13-04-22 16:44:32, Rokudo Yan wrote:
> > > There is a potential deadlock in gc thread may happen
> > > under low memory as below:
> > > 
> > > gc_thread_func
> > >   -f2fs_gc
> > >    -do_garbage_collect
> > >     -gc_data_segment
> > >      -move_data_block
> > >       -set_page_writeback(fio.encrypted_page);
> > >       -f2fs_submit_page_write
> > > as f2fs_submit_page_write try to do io merge when possible, so the
> > > encrypted_page is marked PG_writeback but may not submit to block
> > > layer immediately, if system enter low memory when gc thread try
> > > to move next data block, it may do direct reclaim and enter fs layer
> > > as below:
> > >     -move_data_block
> > >      -f2fs_grab_cache_page(index=?, for_write=false)
> > >       -grab_cache_page
> > >        -find_or_create_page
> > >         -pagecache_get_page
> > >          -__page_cache_alloc --  __GFP_FS is set
> > >           -alloc_pages_node
> > >            -__alloc_pages
> > >             -__alloc_pages_slowpath
> > >              -__alloc_pages_direct_reclaim
> > >               -__perform_reclaim
> > >                -try_to_free_pages
> > >                 -do_try_to_free_pages
> > >                  -shrink_zones
> > >                   -mem_cgroup_soft_limit_reclaim
> > >                    -mem_cgroup_soft_reclaim
> > >                     -mem_cgroup_shrink_node
> > >                      -shrink_node_memcg
> > >                       -shrink_list
> > >                        -shrink_inactive_list
> > >                         -shrink_page_list
> > >                          -wait_on_page_writeback -- the page is marked
> > >                         writeback during previous move_data_block call
> > 
> > This is a memcg reclaim path and you would have to have __GFP_ACCOUNT in
> > the gfp mask to hit it from the page allocator. I am not really familiar
> > with f2fs but I doubt it is using this flag.
> > 
> > On the other hand the memory is charged to a memcg when the newly
> > allocated page is added to the page cache. That wouldn't trigger the
> > soft reclaim path but that is not really necessary because even the
> > regular memcg reclaim would trigger wait_on_page_writeback for cgroup
> > v1.
> > 
> > Also are you sure that the mapping's gfp mask has __GFP_FS set for this
> > allocation? f2fs_iget uses GFP_NOFS like mask for some inode types.
> > 
> > All that being said, you will need to change the above call chain but it
> > would be worth double checking the dead lock is real.
> 
> Hi, Michal
> 
> 1. The issue is occur when do monkey test in Android Device with 4GB RAM +
> 3GB zram, and memory cgroup v1 enabled.
> 
> 2. full memory dump has caught when the issue occur and the dead lock has
> confirmed from dump. We can see the mapping->gfp_mask is 0x14200ca,
> so both __GFP_ACCOUNT(0x1000000) and __GFP_FS(0x80) set

This is rather surprising, I have to say because page cache is charged
explicitly (__filemap_add_folio). Are you testing with the upstream
kernel or could this be a non-upstream change possibly?

> crash-arm64> struct inode.i_mapping 0xFFFFFFDFD578EEA0
>   i_mapping = 0xffffffdfd578f028,
> crash-arm64> struct address_space.host,gfp_mask -x 0xffffffdfd578f028
>   host = 0xffffffdfd578eea0,
>   gfp_mask = 0x14200ca,

Anyway, if the __GFP_FS is set then the deadlock is possible even
without __GFP_ACCOUNT.
-- 
Michal Hocko
SUSE Labs
