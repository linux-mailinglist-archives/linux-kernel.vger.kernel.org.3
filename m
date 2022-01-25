Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2BA49B515
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576842AbiAYN0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:26:22 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58766 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357522AbiAYNVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:21:37 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 48BE31F380;
        Tue, 25 Jan 2022 13:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643116871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tjUs1q6Quu5nC0h0Hi0GuZYGA16F6GuJibeMLPKEWzU=;
        b=geSefv54LvjC2z6DIL70spVZaDzppWHExeEG5OxDnG8ux2UIBLU/SIC6rjyOeDqGx8UTJ5
        rtZpzd3NDtiVdLKiNm4v5kg7ZQuQTemoYg8K1s+C5AFgglm0JkeqKbDEdleQKcVrGbfjlh
        6WTlFX0FQjrpiQqjYZeT2RUd8KHblWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643116871;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tjUs1q6Quu5nC0h0Hi0GuZYGA16F6GuJibeMLPKEWzU=;
        b=doyAyKlE0iwztVhHYXfNwIhvLng9A6f9n9xGSaOAj7D/+0C35msSljnb0rll8T8cizECN9
        h+VC6fPgSyqHt8CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91FB613DEB;
        Tue, 25 Jan 2022 13:21:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id c6QzIUb572FcSAAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 25 Jan 2022 13:21:10 +0000
Date:   Tue, 25 Jan 2022 14:21:08 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Zi Yan <ziy@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>
Subject: Re: [PATCH v4 3/7] mm: page_isolation: check specified range for
 unmovable pages
Message-ID: <20220125132108.GB5609@linux>
References: <20220119190623.1029355-1-zi.yan@sent.com>
 <20220119190623.1029355-4-zi.yan@sent.com>
 <b7c311d4b2cd377cdc4f92bc9ccf6af1@suse.de>
 <6AEF32AC-4E0D-41E0-8850-33B8BD955920@nvidia.com>
 <20220125131943.GA5609@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125131943.GA5609@linux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 02:19:46PM +0100, Oscar Salvador wrote:
> I know that this has been discussed previously, and the cover-letter already
> mentions it, but I think it would be great to have some sort of information about
> the problem in the commit message as well, so people do not have to go and find
> it somewhere else.

Sorry, the commit already points it out, but I meant to elaborate some more.

-- 
Oscar Salvador
SUSE Labs
