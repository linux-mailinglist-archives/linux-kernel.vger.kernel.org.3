Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1AE516505
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 17:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345744AbiEAPtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 11:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348325AbiEAPtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 11:49:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759A63982A
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 08:45:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 42D981F38C;
        Sun,  1 May 2022 15:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651419929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p+gtPqfy5WIC1zoHOvr2YphsBKsJaGJ3kjOeDbSsvpc=;
        b=ubR2MLEcbPaiGJazPJsjvW107/aV7nzPN7x0ZvTvK84hB0UUAhzKUHYcyZ6s0cvQzoX6Rb
        j3jeRTlPKTG/HeWYBxii2tcVwmz+F/AJIEc3SmVYYleSMKlEgFo2LwMlutJzx3rJChwyn8
        2BgSkVlHCH6+1ClOht+5rj/bEQX7j4k=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 537F02C141;
        Sun,  1 May 2022 15:45:28 +0000 (UTC)
Date:   Sun, 1 May 2022 17:45:25 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] MM: discard __GFP_ATOMIC
Message-ID: <Ym6rFVuPE8tAb8LQ@dhcp22.suse.cz>
References: <163712397076.13692.4727608274002939094@noble.neil.brown.name>
 <YZvItUOgTgD11etC@dhcp22.suse.cz>
 <163764199967.7248.2528204111227925210@noble.neil.brown.name>
 <YZzvcjRYTL+XEHHz@dhcp22.suse.cz>
 <20220430113028.9daeebeedf679aa384da5945@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220430113028.9daeebeedf679aa384da5945@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 30-04-22 11:30:28, Andrew Morton wrote:
> Folks,
> 
> Discussion seemed to meander then peter out.  What's the thinking on
> this patch now?  

I like the simplification. This requires a deeper review. I cannot
promise anything before LSFMM ends and who knows what my inbox will look
like afterwards. In general I think we have just too many levels of
memory reserves access and most people have no clue how to use them
properly.

-- 
Michal Hocko
SUSE Labs
