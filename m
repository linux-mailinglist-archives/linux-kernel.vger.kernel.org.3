Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFEC44A4015
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358150AbiAaKZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:25:20 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33454 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239964AbiAaKYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:24:52 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 46283210FF;
        Mon, 31 Jan 2022 10:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643624690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0hz3FVY2lD48V2ZTs1+H/0RTN7r8b6FNhKGlpEPpz9E=;
        b=i6Qyz0PTXKJ3XKNRimsaM9gR6PIQS+yhAtKrfdOLffZRt63ky/wDOUXpvLJsEXA217lcIS
        jAsuj/sR2a19yrcKUCNU7tJoepMREw9nkQ762UfdlPjCHsgaytbDrx9icLfWC/W8wf3bBB
        HLbCfi//fWOOk841kUiKI7xoS4K7qKs=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7D597A3B83;
        Mon, 31 Jan 2022 10:24:49 +0000 (UTC)
Date:   Mon, 31 Jan 2022 11:24:48 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memory_hotplug: build zonelist for managed_zone
Message-ID: <Yfe48O7eBWSe0LjK@dhcp22.suse.cz>
References: <20220127012023.18095-1-richard.weiyang@gmail.com>
 <YfJXoSVkQ3X5u44F@dhcp22.suse.cz>
 <20220129002628.2cwr35glahq5f5md@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129002628.2cwr35glahq5f5md@master>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 29-01-22 00:26:28, Wei Yang wrote:
> On Thu, Jan 27, 2022 at 09:28:17AM +0100, Michal Hocko wrote:
> >On Thu 27-01-22 01:20:23, Wei Yang wrote:
> >> During memory hotplug, when online/offline a zone, we need to rebuild
> >> the zonelist for all node. There are two checks to decide whether a zone
> >> would be added to zonelist:
> >> 
> >>   * one in online_pages/offline_pages to decide necessity
> >>   * one in build_zonerefs_node to do real add
> >> 
> >> Currently we use different criteria at these two places, which is
> >> different from the original behavior.
> >> 
> >> Originally during memory hotplug, zonelist is re-built when zone hasn't
> >> been populated. This in introduced in 'commit 6811378e7d8b ("[PATCH]
> >> wait_table and zonelist initializing for memory hotadd: update zonelists")'.
> >> And at that moment, build_zonelists_node() also use populated_zone() to
> >> decide whether the zone should be added to zonelist.
> >> 
> >> While in 'commit 6aa303defb74 ("mm, vmscan: only allocate and reclaim
> >> from zones with pages managed by the buddy allocator")',
> >> build_zonelists_node() changed to use managed_zone() to add zonelist.
> >> But we still use populated_zone() to decide the necessity.
> >> 
> >> This patch restore the original behavior by using the same criteria to
> >> add a zone in zonelist during memory hotplug.
> >
> >Why?
> >
> 
> In case we online a populated zone, but not managed. Then this zone will not
> be in zonelist. Right?

yeah. We can theoretically end up with a zone without any managed menory
on the zonelists. But my primary question is why do we need this change?
Does it fix any existing problem? Does it make the code easier to
read/understand? Does it improve performance? Every patch should have a
justification. Your changelog merely lists the history and then states
the new behavior without any explanation of why that is needed or
desired. See?
-- 
Michal Hocko
SUSE Labs
