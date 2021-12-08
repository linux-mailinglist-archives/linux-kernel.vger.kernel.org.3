Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0466046CE8C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 08:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244583AbhLHH54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 02:57:56 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:38366 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhLHH5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 02:57:55 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4289A1FDFC;
        Wed,  8 Dec 2021 07:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638950062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7uzUKjoU+isYDo8PAXO470+rsJzNPdDtwPvqdFrtvD4=;
        b=CuovXBs+2XcXxJu3pz2b5FIR0XfMaH1v7T92OsbZJPG19RXknc4r1XM5lJnOwHNmli78V+
        NVvGvdDFZeEm+0IJtd80MdurmCghvRgr+TEzTgUSeA4wioa0GGYq9+OPzBtoemj65CpkqO
        j/mNivXMKkgW7JpAmE6cKTns+w5l1iI=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 10129A3B93;
        Wed,  8 Dec 2021 07:54:22 +0000 (UTC)
Date:   Wed, 8 Dec 2021 08:54:21 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Nico Pache <npache@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        shakeelb@google.com, ktkhai@virtuozzo.com, shy828301@gmail.com,
        guro@fb.com, vbabka@suse.cz, vdavydov.dev@gmail.com,
        raquini@redhat.com, david@redhat.com
Subject: Re: [PATCH v2 1/1] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
Message-ID: <YbBkrSILgxuu2SEX@dhcp22.suse.cz>
References: <20211207224013.880775-1-npache@redhat.com>
 <20211207224013.880775-2-npache@redhat.com>
 <20211207154438.c1e49a3f0b5ebc9245aac61b@linux-foundation.org>
 <4c4b4db2-27b9-6001-5bae-ccc500695b42@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c4b4db2-27b9-6001-5bae-ccc500695b42@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-12-21 19:40:33, Nico Pache wrote:
> 
> 
> On 12/7/21 18:44, Andrew Morton wrote:
> > On Tue,  7 Dec 2021 17:40:13 -0500 Nico Pache <npache@redhat.com> wrote:
> > 
> >> We have run into a panic caused by a shrinker allocation being attempted
> >> on an offlined node.
> >>
> >> Our crash analysis has determined that the issue originates from trying
> >> to allocate pages on an offlined node in expand_one_shrinker_info. This
> >> function makes the incorrect assumption that we can allocate on any node.
> >> To correct this we make sure the node is online before tempting an
> >> allocation. If it is not online choose the closest node.
> > 
> > This isn't fully accurate, is it?  We could allocate on a node which is
> > presently offline but which was previously onlined, by testing
> > NODE_DATA(nid).
> 
> Thanks for the review! I took your changes below into consideration for my V3.
> 
> My knowledge of offlined/onlined nodes is quite limited but after looking into
> it it doesnt seem like anything clears the state of NODE_DATA(nid) after a
> try_offline_node is attempted. So theoretically the panic we saw would not
> happen. What is the expected behavior of trying to allocate a page on a offline
> node?

To fall back (in the zonelist order) into the other node. If
__GFP_THISNODE is specified then simply fail the allocation.
-- 
Michal Hocko
SUSE Labs
