Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE6749B80B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573037AbiAYPy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:54:56 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:55530 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1582615AbiAYPwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:52:21 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BDE1221763;
        Tue, 25 Jan 2022 15:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643125934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uStkJZ/673uwGdUqrEBqKiaTCy54xmWTpPSmxbPY6/I=;
        b=ih1ukAeSloNnQFxOxYkoeJWqYn1KBXpCiyUOZTBbtVL+S5eB2B7lOaZmXOCzEliPINjJB1
        azJ6gs7lY9KDnJMplUtazsB5AHDnHo8pe6megNkEwKIWKpw3JrR8qR9Tusqt85YPbYgR2j
        ixbez3RUX4nJeJxJDVO37xU9oqe0IZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643125934;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uStkJZ/673uwGdUqrEBqKiaTCy54xmWTpPSmxbPY6/I=;
        b=AZjlxKnnmwBiaUeaaTalBZ5pqw1oDikzfavZ+SfM79TZdyb9P+qFgse/I3e4q7oBCwJMms
        EE01Pyvs0cqCpiDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D26013E0E;
        Tue, 25 Jan 2022 15:52:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VJ2IJa4c8GHXHQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 25 Jan 2022 15:52:14 +0000
Message-ID: <270246c0-7550-4770-f880-01b5440bf977@suse.cz>
Date:   Tue, 25 Jan 2022 16:52:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mm: page_alloc: avoid merging non-fallbackable pageblocks
 with others.
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>, Mel Gorman <mgorman@techsingularity.net>,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220124175957.1261961-1-zi.yan@sent.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220124175957.1261961-1-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 18:59, Zi Yan wrote:
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
> [1] https://lore.kernel.org/linux-mm/20211130100853.GP3366@techsingularity.net/
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Acked-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
