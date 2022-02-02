Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA8F4A75F8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239719AbiBBQf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:35:28 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:53082 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiBBQf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:35:27 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 97A6E1F384;
        Wed,  2 Feb 2022 16:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643819726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Dd4PVcW8Gh92qdOSXS52+1meGC/lQXnewRPI3vvCWE=;
        b=M/SKFXYhXQ0yaSChw6wIxQwQ5d7HBnBbnYDlWEH+hnqD2gnRU3+xCI+6AWEYpiwh1tZdAu
        KtJW8t4cx4QWxS5Zk62NXbTFdF8LzZ/KzDdwHjY0IPBREvgkfYKKJBsC6NFxl0sOiX45a/
        hZg94FHTstR+iwC2GeJTfVyDJOOjisk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643819726;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Dd4PVcW8Gh92qdOSXS52+1meGC/lQXnewRPI3vvCWE=;
        b=hsKjmKbgvjeh8w2ffnsVRR8qq8GIDQrxEVIgm82LLhaDtX8FUazOVZXfsAC08LwbHR+9cf
        G0oQWZAD3QabcgCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC30813E99;
        Wed,  2 Feb 2022 16:35:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HM+JMcyy+mFZNgAAMHmgww
        (envelope-from <osalvador@suse.de>); Wed, 02 Feb 2022 16:35:24 +0000
Date:   Wed, 2 Feb 2022 17:35:22 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
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
Message-ID: <YfqyyiB4HOxjStY/@localhost.localdomain>
References: <20220119190623.1029355-1-zi.yan@sent.com>
 <20220119190623.1029355-4-zi.yan@sent.com>
 <Yfp2rv0K6d3cNmwg@localhost.localdomain>
 <21c196f8-18ca-d720-4241-00c9461854d3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21c196f8-18ca-d720-4241-00c9461854d3@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 01:25:28PM +0100, David Hildenbrand wrote:
> That's the whole idea for being able to allocate parts of an unmovable
> pageblock that are movable.
> 
> If the first part is unmovable but the second part is movable, nothing
> should stop us from trying to allocate the second part.

Yeah, I see, I was a bit slow there, but I see the point now.
 
Thanks David

-- 
Oscar Salvador
SUSE Labs
