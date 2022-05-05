Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD02351BB7A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 11:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351732AbiEEJNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 05:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245698AbiEEJNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 05:13:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E554BB89
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 02:09:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6B0D1218EE;
        Thu,  5 May 2022 09:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651741760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=++cBF1w5i8CcTqxB+SUMAt0ENhwHRHhp+tJ4a9UnQn4=;
        b=TgnWAJYxoxaY7sYCMSsIU5UM+Yu3t1fxyCjL2KkKixmrMIDS3p5TbrcJ049UFYCuZxcMtb
        29YcJIBJvGc+BxC9V/OH6PVVCKQJwv+Og2EsW1DkgIVUz7Nz9IxlmSS5QBxmJV/TqJRxYT
        3MQhh+U8tJeHhBNZx8G4RGsNclRKx38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651741760;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=++cBF1w5i8CcTqxB+SUMAt0ENhwHRHhp+tJ4a9UnQn4=;
        b=K8dLxaTYW1jxnZ81S553YNn7UARlGAu0Hbp9m2Yv95HTzOKujosI7XFNltOCffpi28xRI0
        mcbDlFAH9ZPIjxDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D49F513B11;
        Thu,  5 May 2022 09:09:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ya+PMD+Uc2KvIgAAMHmgww
        (envelope-from <osalvador@suse.de>); Thu, 05 May 2022 09:09:19 +0000
Date:   Thu, 5 May 2022 11:09:18 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/page_alloc: Do not calculate node's total pages
 and memmap pages when empty
Message-ID: <YnOUPoqM3RncmraS@localhost.localdomain>
References: <20220307150725.6810-1-osalvador@suse.de>
 <20220307150725.6810-2-osalvador@suse.de>
 <f31caf6a-fb13-0be3-9fa2-0b4959cc0810@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f31caf6a-fb13-0be3-9fa2-0b4959cc0810@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 02:13:46PM +0200, David Hildenbrand wrote:
> Sorry, I'm late with review. My mailbox got flooded.

Hi David :)

> > +	/* Skip calculation for memoryless nodes */
> > +	if (node_start_pfn == node_end_pfn)
> > +		goto no_pages;
> > +
> 
> Just a NIT:
> 
> E.g., in zone_spanned_pages_in_node() we test for
> 	!node_start_pfn && !node_end_pfn
> 
> In update_pgdat_span(), we set
> 	node_start_pfn = node_end_pfn = 0;
> when we find an empty node during memory unplug.
> 
> Therefore, I wonder if a helper "is_memoryless_node()" or "node_empty()"
> might be reasonable, that just checks for either
> 	!node_start_pfn && !node_end_pfn
> or
> 	node_start_pfn == node_end_pfn

Yeah, I thoguth about that as well, but given the few places we check
for it I was hesitant to add it.
But it might make the situation more clear, so I will go with a helper.

> > +no_pages:
> >  		zone_init_internals(zone, j, nid, freesize);
> >  
> >  		if (!size)
> 
> We have another size check below. We essentially have right now:
> 
> "
> 	if (!size)
> 		goto no_pages;
> 
> 	[code]
> no_pages:
> 	zone_init_internals(zone, j, nid, freesize);
> 
> 	if (!size)
> 		continue
> 	[more code]
> "
> 
> IMHO, it would be nicer to avoid the label/goto by just doing a:
> 
> "
> 	if (!size) {
> 		zone_init_internals(zone, j, nid, 0);
> 		continue;
> 	}
> 
> 	[code]
> 	zone_init_internals(zone, j, nid, freesize);
> 	[more code]
> "
> 
> Or factoring out [code] into a separate function.

I did not think about how a refactor would look, so for now I will go
with your first proposal. If I see that a refactor is due, I will think
more about it.

thanks!


-- 
Oscar Salvador
SUSE Labs
