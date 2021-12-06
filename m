Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11AC4696F0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244424AbhLFN2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:28:11 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:50370 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241389AbhLFN2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:28:10 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 42A081FD34;
        Mon,  6 Dec 2021 13:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638797081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OsJpugZkIxlDMOGsFKVTdzYlQKPvibTQJW7zZ8AbbHg=;
        b=hqMHgMDE1Ioxj4vSVtoNzXs6ePkc24zeePGiC3Xdj4ASedrDZYrM/CiUlbZDZgWuuI2apW
        nankjPJIPDhrVMN4M1aRleZ6DKEV+9u5OcYb0RD4KaqqV211OkUKM4YYk22yBwWdQjvbnF
        l1icbQYi/ZkrBlqZtHNlNqAIvMrDyGc=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0D214A3B88;
        Mon,  6 Dec 2021 13:24:41 +0000 (UTC)
Date:   Mon, 6 Dec 2021 14:24:40 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, shakeelb@google.com,
        shy828301@gmail.com, guro@fb.com, vbabka@suse.cz,
        vdavydov.dev@gmail.com, raquini@redhat.com
Subject: Re: [RFC PATCH 2/2] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
Message-ID: <Ya4PGJZL8tSb/Prj@dhcp22.suse.cz>
References: <20211206033338.743270-1-npache@redhat.com>
 <20211206033338.743270-3-npache@redhat.com>
 <Ya3WcYKcej8XEI0W@dhcp22.suse.cz>
 <d9d14beb-ee20-7ebb-e007-fbf58fb28535@redhat.com>
 <24b4455c-aff9-ca9f-e29f-350833e7a0d1@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24b4455c-aff9-ca9f-e29f-350833e7a0d1@virtuozzo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06-12-21 16:19:12, Kirill Tkhai wrote:
> On 06.12.2021 13:45, David Hildenbrand wrote:
> >> This doesn't seen complete. Slab shrinkers are used in the reclaim
> >> context. Previously offline nodes could be onlined later and this would
> >> lead to NULL ptr because there is no hook to allocate new shrinker
> >> infos. This would be also really impractical because this would have to
> >> update all existing memcgs...
> > 
> > Instead of going through the trouble of updating...
> > 
> > ...  maybe just keep for_each_node() and check if the target node is
> > offline. If it's offline, just allocate from the first online node.
> > After all, we're not using __GFP_THISNODE, so there are no guarantees
> > either way ...
> 
> Hm, can't we add shrinker maps allocation to __try_online_node() in addition
> to this patch? 

Either that or through hotplug notifier (which would be a better
solution). But allocating a new shrinker map for each memcg would have
to be done as has been mentioned earlier.

-- 
Michal Hocko
SUSE Labs
