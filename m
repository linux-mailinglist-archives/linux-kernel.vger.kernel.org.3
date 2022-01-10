Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DC0489E2E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 18:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbiAJRQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 12:16:28 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57038 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238109AbiAJRQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:16:25 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 24C861F383;
        Mon, 10 Jan 2022 17:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641834984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oN2vqgjVFm/26Gh3w73e9Is5BclOGZvV0sUgskRJvn8=;
        b=shW1fHmBupnyKBH5DVkrV83LpzoNNgLvcuyeggybA63qr9NKSJpJWwmpvCPxaWx7RvzHrB
        Sd7DD0ODdHpzrn6+MT7V9uRPMxmr0ewF6ygl4bh7dH4ln6vj/7tszzIJl7CrE4Dk3SfF2v
        H4oEX2feIg8y3vpaqw/kslS6rWUgkBs=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DCC4BA3B87;
        Mon, 10 Jan 2022 17:16:23 +0000 (UTC)
Date:   Mon, 10 Jan 2022 18:16:23 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nico Pache <npache@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, raquini@redhat.com,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 1/1] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
Message-ID: <Ydxp5wMhnwM2vVX6@dhcp22.suse.cz>
References: <20211207224013.880775-1-npache@redhat.com>
 <20211207224013.880775-2-npache@redhat.com>
 <20211207154438.c1e49a3f0b5ebc9245aac61b@linux-foundation.org>
 <CAHbLzkoCds-WOoN5CKas4DThk8hU65pgtMcga10QEqEmKU2f5A@mail.gmail.com>
 <YdxoXhTqCmVrT0R5@optiplex-fbsd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdxoXhTqCmVrT0R5@optiplex-fbsd>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 10-01-22 12:09:50, Rafael Aquini wrote:
[...]
> > 3. From David, fix in node_zonelist().
> > https://lore.kernel.org/all/51c65635-1dae-6ba4-daf9-db9df0ec35d8@redhat.com/T/#u
> 
> It seems to me that (3) is the simplest and effective way to cope with this case

Did you have chance to look at http://lkml.kernel.org/r/20211214100732.26335-1-mhocko@kernel.org
-- 
Michal Hocko
SUSE Labs
