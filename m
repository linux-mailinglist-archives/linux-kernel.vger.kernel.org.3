Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21345AE12D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbiIFHfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbiIFHfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:35:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE96913DDE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 00:35:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B4B0C33756;
        Tue,  6 Sep 2022 07:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662449742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aMlGqlnQ04JpTCGyz8Bgtjox+j1YdblTUnCI6z5C09I=;
        b=S36G2qUkHSLI+DSrxUIL+5u1S7DL2CSRctUzbiZ6dItoP0G0FlBXlo726UDvA4+A5TZDrw
        SSjaksADSLg3ye7OpO7VEmP/2Ii7wx/1wSWkmuRch1EpnhUO8uaI4PDY1HFo1pjViV7sGk
        +blFRGsRK5MvybcM2UF6x5a7W9YSWds=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95BE113A7A;
        Tue,  6 Sep 2022 07:35:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6A6FIk74FmNLOQAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 06 Sep 2022 07:35:42 +0000
Date:   Tue, 6 Sep 2022 09:35:41 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] MM: discard __GFP_ATOMIC
Message-ID: <Yxb4TQ0WDa85uurY@dhcp22.suse.cz>
References: <163712397076.13692.4727608274002939094@noble.neil.brown.name>
 <YZvItUOgTgD11etC@dhcp22.suse.cz>
 <163764199967.7248.2528204111227925210@noble.neil.brown.name>
 <YZzvcjRYTL+XEHHz@dhcp22.suse.cz>
 <20220430113028.9daeebeedf679aa384da5945@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220430113028.9daeebeedf679aa384da5945@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 30-04-22 11:30:28, Andrew Morton wrote:

Sorry, this got lost in my inbox. Thanks Andrew for poking me.

> From: "NeilBrown" <neilb@suse.de>
> Subject: mm: discard __GFP_ATOMIC
> 
> __GFP_ATOMIC serves little purpose.  Its main effect is to set
> ALLOC_HARDER which adds a few little boosts to increase the chance of an
> allocation succeeding, one of which is to lower the water-mark at which it
> will succeed.
> 
> It is *always* paired with __GFP_HIGH which sets ALLOC_HIGH which also
> adjusts this watermark.  It is probable that other users of __GFP_HIGH
> should benefit from the other little bonuses that __GFP_ATOMIC gets.
> 
> __GFP_ATOMIC also gives a warning if used with __GFP_DIRECT_RECLAIM. 
> There is little point to this.  We already get a might_sleep() warning if
> __GFP_DIRECT_RECLAIM is set.
> 
> __GFP_ATOMIC allows the "watermark_boost" to be side-stepped.  It is
> probable that testing ALLOC_HARDER is a better fit here.
> 
> __GFP_ATOMIC is used by tegra-smmu.c to check if the allocation might
> sleep.  This should test __GFP_DIRECT_RECLAIM instead.
> 
> This patch:
>  - removes __GFP_ATOMIC
>  - causes __GFP_HIGH to set ALLOC_HARDER unless __GFP_NOMEMALLOC is set
>    (as well as ALLOC_HIGH).
>  - makes other adjustments as suggested by the above.
> 
> The net result is not change to GFP_ATOMIC allocations.  Other
> allocations that use __GFP_HIGH will benefit from a few different extra
> privileges.  This affects:
>   xen, dm, md, ntfs3
>   the vermillion frame buffer
>   hibernation
>   ksm
>   swap
> all of which likely produce more benefit than cost if these selected
> allocation are more likely to succeed quickly.

This is a good summary of the current usage and existing issues. It also
shows that the naming is tricky and allows people to make wrong calls
(tegra-smmu.c). I also thing that it is wrong to couple memory reserves
access to the reclaim constrains/expectations of the caller.

> Link: https://lkml.kernel.org/r/163712397076.13692.4727608274002939094@noble.neil.brown.name
> Signed-off-by: NeilBrown <neilb@suse.de>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Yes, I am all for dropping the gfp flag. One thing that is not really
entirely clear to me, though, is whether we still need 3 levels of
memory reserves access. Can we just drop ALLOC_HARDER? With this patch
applied it serves RT tasks and conflates it with __GFP_HIGH users
essentially. So why do we need that additional level of reserves?
-- 
Michal Hocko
SUSE Labs
