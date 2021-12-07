Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C7646B89A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 11:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbhLGKSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:18:47 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44590 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234933AbhLGKSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:18:45 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BDF9421B3E;
        Tue,  7 Dec 2021 10:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638872114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fmiDXA5yzuOQ3TCOggxW4h5cLqZY2pHWb0txkt/F/pc=;
        b=IqW/fQHgB6cUG7JdfpLS9iXvR+Oo1okV83ZgupHdvpn+I+hcJpKHI6aU7od55aKm5f943N
        WV+Lz1y4Cyl/phAHHe7GPybOaW8UpTgXZy274rmRPmQxWRQd3m2FzMGDlLTCQJxIzMhWkC
        hEgoxQ5Obmjc4x9qiXaBff6qKdJHDXI=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7BAE5A3B8B;
        Tue,  7 Dec 2021 10:15:14 +0000 (UTC)
Date:   Tue, 7 Dec 2021 11:15:13 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Nico Pache <npache@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Roman Gushchin <guro@fb.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, raquini@redhat.com
Subject: Re: [RFC PATCH 2/2] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
Message-ID: <Ya80MSTbKmsTfXjf@dhcp22.suse.cz>
References: <Ya3yZWkj2wGRWDMz@dhcp22.suse.cz>
 <51c65635-1dae-6ba4-daf9-db9df0ec35d8@redhat.com>
 <Ya4K0+XCmv3NBmwQ@dhcp22.suse.cz>
 <05157de4-e5df-11fc-fc46-8a9f79d0ddb4@redhat.com>
 <Ya4Y07Iu2ygj5zwZ@dhcp22.suse.cz>
 <d4f281e6-1999-a3de-b879-c6ca6a25ae67@redhat.com>
 <Ya4cUQpLJHnm3jyK@dhcp22.suse.cz>
 <f2c695f0-9621-a7be-82c3-8850dc8ca3e3@suse.cz>
 <Ya4kBASzAJ32UBfT@dhcp22.suse.cz>
 <CAHbLzkpnvqDCKjf7cmZDcVROAkh_Vzu3HXRJgkZsqp+xVokRZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkpnvqDCKjf7cmZDcVROAkh_Vzu3HXRJgkZsqp+xVokRZA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06-12-21 10:26:32, Yang Shi wrote:
[...]
> But IMHO actually the memory usage should be not that bad for memcg
> heavy usecases since there should be not too many "never onlined"
> nodes for such workloads?

Hardware with very sparse nodes topology are really scarce. More likely
on ppc (LPARs) but even then we are talking about really low number of
nodes. At least this is my experience.

So while the memory wasting is possible it doesn't seem to be a really
pressing problem. I would be more careful about a code which scales with
MAX_NUMNODES because that can be really large.
-- 
Michal Hocko
SUSE Labs
