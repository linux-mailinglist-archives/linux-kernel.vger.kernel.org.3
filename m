Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A508A4B6351
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 07:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbiBOGP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 01:15:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbiBOGP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 01:15:57 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A6DF7478
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 22:15:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C68231F38C;
        Tue, 15 Feb 2022 06:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644905746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=stFWmG4RHx6dwdwOXJa8oE098JQwQAuQshDHre0cRNc=;
        b=geMBC9iAkPgkBwprFvlcXzXqOf+Icc2NyqYQrvyxtDHhsQHoSJniDV5oagjfEqDJvExOLI
        Tx+y6csiVbbQmp5bVQmpAZoZYsTEZBQZ5HupWrx57fnS8ra57PDF0OfUNMDij8YYnsB5vD
        4wpMxFm1ZPjg1LaWJ1QTcBo74kBeR3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644905746;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=stFWmG4RHx6dwdwOXJa8oE098JQwQAuQshDHre0cRNc=;
        b=b7g3DwVeNv0v/1M/Bb+kiBX1/nj/5ApQ5iRP/EYj0CdYYtIgRBQgyw7o+49q6tWbPXNNRU
        p5qFztb91iL7U6Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 45B1013BD2;
        Tue, 15 Feb 2022 06:15:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wgA+DRJFC2J4KgAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 15 Feb 2022 06:15:46 +0000
Date:   Tue, 15 Feb 2022 07:15:44 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org,
        jhubbard@nvidia.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ziy@nvidia.com, mgorman@suse.de
Subject: Re: [PATCH] mm/pages_alloc.c: Don't create ZONE_MOVABLE beyond the
 end of a node
Message-ID: <YgtFEOqgN7yXCGMC@localhost.localdomain>
References: <20220215025831.2113067-1-apopple@nvidia.com>
 <7b752e06-f345-cbb2-d05c-57e5fc5d8e5a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b752e06-f345-cbb2-d05c-57e5fc5d8e5a@arm.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 10:17:09AM +0530, Anshuman Khandual wrote:
> Hi Alistair,
> 
> On 2/15/22 8:28 AM, Alistair Popple wrote:
> > ZONE_MOVABLE uses the remaining memory in each node. It's starting pfn
> > is also aligned to MAX_ORDER_NR_PAGES. It is possible for the remaining
> > memory in a node to be less than MAX_ORDER_NR_PAGES, meaning there is
> > not enough room for ZONE_MOVABLE on that node.

CC Mel as he wrote that back then.

I was curious about the commit that introduced that, and I found
[1] and [2].
I guess [2] was eventually dismissed in favor of [1] as a whole, but in
there the commit message said:

"This patch rounds the start of ZONE_MOVABLE in each node to a
MAX_ORDER_NR_PAGES boundary. If the rounding pushes the start of ZONE_MOVABLE
above the end of the node then the zone will contain no memory and will not
be used at runtime"

I might be missing something, but it just rounds up the value, but does
not check if it falls beyond node's boundaries.


[1] commit 2a1e274acf0b1c192face19a4be7c12d4503eaaf "Create the
ZONE_MOVABLE zone"
[2] https://marc.info/?l=linux-mm&m=117743777129526&w=2

 

-- 
Oscar Salvador
SUSE Labs
