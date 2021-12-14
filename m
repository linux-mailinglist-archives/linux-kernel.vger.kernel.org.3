Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C6B47407B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 11:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbhLNKdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 05:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbhLNKdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 05:33:42 -0500
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F33CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 02:33:42 -0800 (PST)
Received: by gentwo.de (Postfix, from userid 1001)
        id 34805B006DD; Tue, 14 Dec 2021 11:33:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 32228B005DA;
        Tue, 14 Dec 2021 11:33:41 +0100 (CET)
Date:   Tue, 14 Dec 2021 11:33:41 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.org>
X-X-Sender: cl@gentwo.de
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Nico Pache <npache@redhat.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 2/4] mm: handle uninitialized numa nodes gracefully
In-Reply-To: <20211214100732.26335-3-mhocko@kernel.org>
Message-ID: <alpine.DEB.2.22.394.2112141131180.370323@gentwo.de>
References: <YbHfBgPQMkjtuHYF@dhcp22.suse.cz> <20211214100732.26335-1-mhocko@kernel.org> <20211214100732.26335-3-mhocko@kernel.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2021, Michal Hocko wrote:

> This patch takes a different approach (following a lead of [3]) and it
> pre allocates pgdat for all possible nodes in an arch indipendent code
> - free_area_init. All uninitialized nodes are treated as memoryless
> nodes. node_state of the node is not changed because that would lead to
> other side effects - e.g. sysfs representation of such a node and from
> past discussions [4] it is known that some tools might have problems
> digesting that.

Would it be possible to define a pgdat statically and place it in read
only memory? Populate with values that ensure that the page allocator
does not blow up but does a defined fallback.

Point the pgdat for all nodes not online to that readonly pgdat?

Maybe that would save some memory. When the node comes online then a real
pgdat could be allocated.

