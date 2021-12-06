Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED65469867
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343786AbhLFOSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:18:32 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58176 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343688AbhLFOSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:18:31 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7A3661FD2F;
        Mon,  6 Dec 2021 14:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638800102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XUY/UyOeKFEZfPRGMjkBZxE12vtUkgWPWiPVpNmMnWY=;
        b=Ilo/wDTNiUqj6PF8yzwZ3MC/vXXF1PEmwwVB6nIj5wQA4PaS7Tpc/qxpxIMCgv+NjaIMir
        EV5N7TqMpADOEzdvfch9hT4t/kQgKBTijU1Jh1Ywnc80neFrAWDFx3UD43J+tZfwXYuUdu
        SxVEh3mACOt0mAMOl6n+cgR7przCFy0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 39420A3B83;
        Mon,  6 Dec 2021 14:15:02 +0000 (UTC)
Date:   Mon, 6 Dec 2021 15:15:01 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, shakeelb@google.com,
        ktkhai@virtuozzo.com, shy828301@gmail.com, guro@fb.com,
        vbabka@suse.cz, vdavydov.dev@gmail.com, raquini@redhat.com
Subject: Re: [RFC PATCH 2/2] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
Message-ID: <Ya4a5bHjhF+57raT@dhcp22.suse.cz>
References: <20211206033338.743270-1-npache@redhat.com>
 <20211206033338.743270-3-npache@redhat.com>
 <Ya3WcYKcej8XEI0W@dhcp22.suse.cz>
 <d9d14beb-ee20-7ebb-e007-fbf58fb28535@redhat.com>
 <Ya3r3C/OpnK7OBPt@dhcp22.suse.cz>
 <840cb3d0-61fe-b6cb-9918-69146ba06cf7@redhat.com>
 <Ya3yZWkj2wGRWDMz@dhcp22.suse.cz>
 <51c65635-1dae-6ba4-daf9-db9df0ec35d8@redhat.com>
 <Ya4K0+XCmv3NBmwQ@dhcp22.suse.cz>
 <05157de4-e5df-11fc-fc46-8a9f79d0ddb4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05157de4-e5df-11fc-fc46-8a9f79d0ddb4@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06-12-21 14:47:13, David Hildenbrand wrote:
> On 06.12.21 14:06, Michal Hocko wrote:
[...]
> > This is certainly possible. But it a) adds a branch to the hotpath and
> > b) it doesn't solve any other potential dereference of garbage node.
> 
> I don't think a) is  a problem but it's easy to measure.

Let me just clarify on this one. This single particular branch will be
indeed hard to match to any performance changes. On a single call of the
allocator it is nothing. But it is a condition that will be executed by
each caller while it won't ever trigger in most systems and workloads.

In other words it will cause a lot of wasted cpu cycles long term. A
more expensive one time initialization is worth in order to have
allocator fast path lighter IMHO.
-- 
Michal Hocko
SUSE Labs
