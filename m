Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA48F5541B9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 06:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356866AbiFVEZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 00:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiFVEZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:25:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A708335255
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:25:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A370921BB7;
        Wed, 22 Jun 2022 04:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655871923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WhHc108fd7a+OpnxW6vdJErjSH8L6j2zIy6yafQpOuM=;
        b=ZQ2x/Tx/YElTMBy9pLFeqUOLty6NnYiNC6AzvED+VQ532vEv6+6VLLadBygvyxWbGkridj
        W9Rhtvl979GhJs66T+QNXgv+gR5vDsSrNqtAjKA7OmAnU8zhHwZump1QdPdHE/95pHeAwo
        +KPaJ7Gmn784p/s8rIYl6USwy8IvUZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655871923;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WhHc108fd7a+OpnxW6vdJErjSH8L6j2zIy6yafQpOuM=;
        b=GNlk8wUlrvezFLFpuC5SQdGioW2Gz8JiODR/R8X7SETfaEZjxb/X6GTXWRhJhDhz9ktGNk
        vC35V3/9cWNgX6BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 49265134A9;
        Wed, 22 Jun 2022 04:25:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o/j6DrOZsmJjHQAAMHmgww
        (envelope-from <osalvador@suse.de>); Wed, 22 Jun 2022 04:25:23 +0000
Date:   Wed, 22 Jun 2022 06:25:21 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/memory_hotplug: Reset node's state when empty
 during offline
Message-ID: <YrKZsYNUAbfcC1CF@localhost.localdomain>
References: <20220621041717.6355-1-osalvador@suse.de>
 <20220621041717.6355-3-osalvador@suse.de>
 <139fc140-142f-c467-a5e3-0a0954dca127@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <139fc140-142f-c467-a5e3-0a0954dca127@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 09:59:07AM +0200, David Hildenbrand wrote:
> > +static void node_reset_state(int node)
> > +{
> > +	pg_data_t *pgdat = NODE_DATA(node);
> > +	int cpu;
> > +
> > +	kswapd_stop(node);
> > +	kcompactd_stop(node);
> > +
> > +	pgdat->nr_zones = 0;
> 
> ^ what is that? it should be "highest_zone_idx" and I don't see any
> reason that we really need this.

Uhm, I thought we need to reset this, otherwise init_currently_empty_zone()
might not set it to a right value:

...
 if (zone_idx > pgdat->nr_zones)
    pgdat->nr_zones = zone_idx
...

At least we set it to 0 in free_area_init_core_hotplug() (before this patch).

> To detect if a node is empty we can use pgdat_is_empty(). To detect if a
> zone is empty we can use zone_is_empty().
> 
> The usage of "pgdat->nr_zones" as an optimization is questionable,
> especially when iterating over our handful of zones where most nodes
> miss the *lower* zones like ZONE_DMA* in practice and have ZONE_NORMAL.
> 
> Can we get rid of that and just check pgdat_is_empty() and
> zone_is_empty() and iterate all applicable zones from 0..X?

So, lemme see if I get you.
You mean to e.g: replace the following (code snippet from set_pgdat_percpu_threshold)

  for (i = 0; i < pgdat->nr_zones; i++) {
           zone = &pgdat->node_zones[i];

		    [some code]
  }

with this:

  for (zid = 0; zid < MAX_NR_ZONES; i++) {
            struct zone *zone = pgdat->node_zones + i;

            if (zone_is_empty(zone))
                    continue; 
  }

I guess we can, and I can see that we have a mix of both usages, so it might be
good to consolidate one.
And actually, I think we do the same amount of work, right? So not really an
optimization in those pieces of code.

The only thing that unsettles me is the compaction part.
We set pgdat->kcompactd_highest_zoneidx by checking pgdat->nr_zones, and use
that as our compact_control->highest_zoneidx. (kcompactd->kcompactd_do_work)

Now, I do not really see any reason we could not adapt that code to not
realy on pgdat->nr_zones, but I would have to check further how this
interacts with highest_zoneidx down the road, and where else should
we rewrite code.


-- 
Oscar Salvador
SUSE Labs
