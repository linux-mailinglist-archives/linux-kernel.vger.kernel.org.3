Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CFA49AC4F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 07:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245140AbiAYGVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 01:21:05 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57124 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239023AbiAYGQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 01:16:54 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 86F9F212CA;
        Tue, 25 Jan 2022 06:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643091411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A0IYK4txmrAqE9dKMwPSEvnRaOWt5ESVwDa2uLogNA0=;
        b=AthH7C3PjONofgKMApmvZoKHcUA++pVPLCTmQ41SyCBT52DHx6YqBHedJ6KMSEd95lMUGg
        KSsgaj90jk6Mi8TXQ0LPQxORACRBbtcBrBHPsoub2Nh8pDFkSs4urJ4mLZUspHbiXTJIX1
        PPkcYWrVI8wo3L5TLA+zz6NeqGUpUvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643091411;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A0IYK4txmrAqE9dKMwPSEvnRaOWt5ESVwDa2uLogNA0=;
        b=/X8GJWsWh8oVBy5Jf8JY06e33U936gAWJ9OiT6dDmjH7mSwVGB9lhpNeNvC9W8eyw85YFc
        qyuUyblvlkP/70AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7481013D7C;
        Tue, 25 Jan 2022 06:16:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6FXfG9OV72FhdAAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 25 Jan 2022 06:16:51 +0000
MIME-Version: 1.0
Date:   Tue, 25 Jan 2022 07:16:51 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: page_alloc: avoid merging non-fallbackable pageblocks
 with others.
In-Reply-To: <20220124175957.1261961-1-zi.yan@sent.com>
References: <20220124175957.1261961-1-zi.yan@sent.com>
User-Agent: Roundcube Webmail
Message-ID: <58f3a261fbd1c8480ce2e64e8543e466@suse.de>
X-Sender: osalvador@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-24 18:59, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> This is done in addition to MIGRATE_ISOLATE pageblock merge avoidance.
> It prepares for the upcoming removal of the MAX_ORDER-1 alignment
> requirement for CMA and alloc_contig_range().
> 
> MIGRARTE_HIGHATOMIC should not merge with other migratetypes like
> MIGRATE_ISOLATE and MIGRARTE_CMA[1], so this commit prevents that too.
> 
> Remove MIGRARTE_CMA and MIGRATE_ISOLATE from fallbacks list, since they
> are never used.
> 
> [1] 
> https://lore.kernel.org/linux-mm/20211130100853.GP3366@techsingularity.net/
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Acked-by: Mel Gorman <mgorman@techsingularity.net>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs
