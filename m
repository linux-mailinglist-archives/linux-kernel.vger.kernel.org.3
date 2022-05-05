Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9264E51BD57
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 12:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243840AbiEEKld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 06:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiEEKla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 06:41:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B8615A03
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 03:37:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7309D218EA;
        Thu,  5 May 2022 10:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651747068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GTwVS8/eqyBZAbCKa/0l/VA+S7qOOVL2pm+hvdN4ZkE=;
        b=Y691v4KG12nrehqbFRumAxTm0U3do6LGpran0xuYs2VJs556/qMVRGzkX506WOJ/4Tejya
        nMvr4Os6Mb5jtS8kkDgVo5kAiGZsqLN/CG3CMTPZcFWjFF/NiFKe0mlJuSbCo5BDORjbyl
        iglvOVHeamzW+Vz3+wrrsB5Lurqc7iw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651747068;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GTwVS8/eqyBZAbCKa/0l/VA+S7qOOVL2pm+hvdN4ZkE=;
        b=PZsLciE3RxED7WH9BHH3zmF63v3B/dzCxY8262Ug9DncbaLD6MaYtfXtLcxOaxq6gA4K3+
        JfpufGt2DDHH/yCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B4D813B11;
        Thu,  5 May 2022 10:37:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NlsZAPyoc2IOTQAAMHmgww
        (envelope-from <osalvador@suse.de>); Thu, 05 May 2022 10:37:48 +0000
Date:   Thu, 5 May 2022 12:37:46 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm/memory_hotplug: Reset node's state when empty
 during offline
Message-ID: <YnOo+nSCqMw0gWXB@localhost.localdomain>
References: <20220307150725.6810-1-osalvador@suse.de>
 <20220307150725.6810-3-osalvador@suse.de>
 <0d2853f6-66e5-251a-2d9e-c229f0ebcd5e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d2853f6-66e5-251a-2d9e-c229f0ebcd5e@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 02:30:20PM +0200, David Hildenbrand wrote:
> On 07.03.22 16:07, Oscar Salvador wrote:
> > +static void node_reset_state(int node)
> > +{
> > +	pg_data_t *pgdat = NODE_DATA(node);
> > +	int cpu;
> > +
> > +	kswapd_stop(node);
> > +	kcompactd_stop(node);
> > +
> > +	reset_node_managed_pages(pgdat);
> > +	reset_node_present_pages(pgdat);
> > +
> > +	pgdat->nr_zones = 0;
> > +	pgdat->kswapd_order = 0;
> > +	pgdat->kswapd_highest_zoneidx = 0;
> > +	pgdat->node_start_pfn = 0;
> 
> 
> I'm confused why we have to mess with
> * present pages
> * managed pages
> * node_start_pfn
> 
> here at all.
> 
> 1) If there would be any present page left, calling node_reset_state()
> would be a BUG.
> 2) If there would be any manged page left, calling node_reset_state()
> would be a BUG.
> 3) node_start_pfn will be properly updated by
> remove_pfn_range_from_zone()->update_pgdat_span()

Yes, you are right, trusting update_pgdat_span() is the right to do
here.

> To make it clearer, I *think* touching node_start_pfn is very wrong.
> 
> What if the node still has ZONE_DEVICE? They don't account towards
> present pages but only towards spanned pages, and we're messing with the
> start range.

Did not think of that scenario, but as you said, we should be leaving
node/zone's pages accounting alone here.

> remove_pfn_range_from_zone()->update_pgdat_span() should be the only
> place that modifies the spanned range when offlining.

Will update the patch.

Thanks for the review David!


-- 
Oscar Salvador
SUSE Labs
