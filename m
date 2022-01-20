Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47907494959
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 09:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359168AbiATIYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 03:24:25 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35740 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239758AbiATIYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:24:24 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CDB492170E;
        Thu, 20 Jan 2022 08:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642667062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9xN1A4lWeBuAThpXk0pGMox/x+1CE4rQvfPoSz5lPBo=;
        b=DQ1G29y8OoQl93S/EwONlm0kwcF3RB14EvOwLeJ7E8JIqTbV5Klh9zVLgEsmR8WKn9ijEs
        eektIwbI9bT8KDaDyJ33zSaFxpdPwVLgaGwvjFqSXYwwFMnL4EXFeLvYiEY3C480wYzb5y
        f39pYmWW5cBr4IQVQN6TwGYHszDZzKc=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6FA4CA3B85;
        Thu, 20 Jan 2022 08:24:19 +0000 (UTC)
Date:   Thu, 20 Jan 2022 09:24:22 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>
Subject: Re: [RESEND][PATCH v2] mm: don't call lru draining in the nested
 lru_cache_disable
Message-ID: <YekcNmBqcpO9BYWv@dhcp22.suse.cz>
References: <20211230193627.495145-1-minchan@kernel.org>
 <YeVzWlrojI1+buQx@dhcp22.suse.cz>
 <YedXhpwURNTkW1Z3@google.com>
 <YefX1t4owjlx/m5I@dhcp22.suse.cz>
 <YejkUlnnYeED1pC5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YejkUlnnYeED1pC5@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-01-22 20:25:54, Minchan Kim wrote:
> On Wed, Jan 19, 2022 at 10:20:22AM +0100, Michal Hocko wrote:
[...]
> > What does prevent you from calling lru_cache_{disable,enable} this way
> > with the existing implementation? AFAICS calls can be nested just fine.
> > Or am I missing something?
> 
> It just increases more IPI calls since we drain the lru cache
> both upper layer and lower layer. That's I'd like to avoid
> in this patch. Just disable lru cache one time for entire
> allocation path.

I do not follow. Once you call lru_cache_disable at the higher level
then no new pages are going to be added to the pcp caches. At the same
time existing caches are flushed so the inner lru_cache_disable will not
trigger any new IPIs.

-- 
Michal Hocko
SUSE Labs
