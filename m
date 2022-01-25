Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DEE49AC67
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 07:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345955AbiAYG1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 01:27:23 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:49780 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344098AbiAYGXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 01:23:51 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 064461F380;
        Tue, 25 Jan 2022 06:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643091827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SxB22q2urXIdsrmoPoT22ET5VLL7DY5GwQTRZaWBW4k=;
        b=zzHOzRVpDg59xKWbExTM2/HqgZWsRi4itrBoEkpBmycht04q+RJ8l1Qi1laURT8PHz4Oab
        LHsGRuS21D2Njw5+Rhxv2AEFlyFZnN9TPzzMn/dKmksWvxMze7T/UsO5biJ0hYg+D0/lxJ
        ABZ+HQkBmjrYGLC8E1Rc0wWyiwYzVKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643091827;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SxB22q2urXIdsrmoPoT22ET5VLL7DY5GwQTRZaWBW4k=;
        b=r5M9bjkVQyRw9A8wG8mbR8CjiorcPAjhdDcb4urtIt5x1C1NZ/0/s0Hv3QDrLBkE6xzwhc
        ZyzLjlvANPU60DCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D81F113D7B;
        Tue, 25 Jan 2022 06:23:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kQk5NHKX72GxdgAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 25 Jan 2022 06:23:46 +0000
MIME-Version: 1.0
Date:   Tue, 25 Jan 2022 07:23:46 +0100
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
Subject: Re: [PATCH v4 2/7] mm: page_isolation: move has_unmovable_pages() to
 mm/page_isolation.c
In-Reply-To: <20220119190623.1029355-3-zi.yan@sent.com>
References: <20220119190623.1029355-1-zi.yan@sent.com>
 <20220119190623.1029355-3-zi.yan@sent.com>
User-Agent: Roundcube Webmail
Message-ID: <d8809f69b4e813f981a2f13d81849b7b@suse.de>
X-Sender: osalvador@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-19 20:06, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> has_unmovable_pages() is only used in mm/page_isolation.c. Move it from
> mm/page_alloc.c and make it static.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE Labs
