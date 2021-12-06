Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A88469890
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343907AbhLFOYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:24:37 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:59246 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244891AbhLFOYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:24:35 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6F58F1FD54;
        Mon,  6 Dec 2021 14:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638800466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AU1DxmYfAhM8Rnmo8sN6ucgP0navAddPsgho6J/htyo=;
        b=VnKCwTuRMfprOOmZG4Fk4Bmu2C/b0yIKtekgS7lJU+W8noBnINV02QAh7//iJJo1sKpdNk
        7yQEx5wI+9VLUCZp2TcU1LEoiZslBDWbuyGugan2ztTjXtNOuc+E2jKHjeHPnq9xWWnqrK
        QUbW/CHBkuhBhJGpY613SlMNaOvA86o=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3E17FA3B81;
        Mon,  6 Dec 2021 14:21:06 +0000 (UTC)
Date:   Mon, 6 Dec 2021 15:21:05 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, shakeelb@google.com,
        ktkhai@virtuozzo.com, shy828301@gmail.com, guro@fb.com,
        vbabka@suse.cz, vdavydov.dev@gmail.com, raquini@redhat.com
Subject: Re: [RFC PATCH 2/2] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
Message-ID: <Ya4cUQpLJHnm3jyK@dhcp22.suse.cz>
References: <Ya3WcYKcej8XEI0W@dhcp22.suse.cz>
 <d9d14beb-ee20-7ebb-e007-fbf58fb28535@redhat.com>
 <Ya3r3C/OpnK7OBPt@dhcp22.suse.cz>
 <840cb3d0-61fe-b6cb-9918-69146ba06cf7@redhat.com>
 <Ya3yZWkj2wGRWDMz@dhcp22.suse.cz>
 <51c65635-1dae-6ba4-daf9-db9df0ec35d8@redhat.com>
 <Ya4K0+XCmv3NBmwQ@dhcp22.suse.cz>
 <05157de4-e5df-11fc-fc46-8a9f79d0ddb4@redhat.com>
 <Ya4Y07Iu2ygj5zwZ@dhcp22.suse.cz>
 <d4f281e6-1999-a3de-b879-c6ca6a25ae67@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4f281e6-1999-a3de-b879-c6ca6a25ae67@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06-12-21 15:08:10, David Hildenbrand wrote:
> 
> >> But there might be more missing. Onlining a new zone will get more
> >> expensive in setups with a lot of possible nodes (x86-64 shouldn't
> >> really be an issue in that regard).
> > 
> > Honestly, I am not really concerned by platforms with too many nodes
> > without any memory. If they want to shoot their feet then that's their
> > choice. We can optimize for those if they ever prove to be standar.
> >  
> >> If we want stable backports, we'll want something simple upfront.
> > 
> > For stable backports I would be fine by doing your NODE_DATA check in
> > the allocator. In upstream I think we should be aiming for a more robust
> > solution that is also easier to maintain further down the line. Even if
> > that is an investment at this momemnt because the initialization code is
> > a mess.
> > 
> 
> Agreed. I would be curious *why* we decided to dynamically allocate the
> pgdat. is this just a historical coincidence or was there real reason to
> not allocate it for all possible nodes during boot?

I don't know but if I was to guess the most likely explanation would be
that the numa init code was in a similar order as now and it was easier
to simply allocate a pgdat when a new one was onlined.
9af3c2dea3a3 ("[PATCH] pgdat allocation for new node add (call pgdat allocation)")
doesn't really tell much.
-- 
Michal Hocko
SUSE Labs
