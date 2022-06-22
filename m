Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6975540FF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 05:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356558AbiFVDr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 23:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiFVDr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 23:47:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944DC19C03
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 20:47:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 51DDB1F985;
        Wed, 22 Jun 2022 03:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655869644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cE0rQjAA42eU80dv5qRJXXM0yGtnKl5fWjJdWhwMZOs=;
        b=wyzwtDz8nUgOOSUThBQLx/THMAKUiRlAZDiQFl9VFGiUenMabY0x2WFp1dTCiOc59o0s52
        8sUvx9LCwIZ5wu2+VwZIG7agReZu4oMZx+oRdk/McQ0NmCTBISGPHOnOf/uyFnIwcUHMQO
        AxlMCAAT56ew/JQprKMjXPo81/XUHTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655869644;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cE0rQjAA42eU80dv5qRJXXM0yGtnKl5fWjJdWhwMZOs=;
        b=26jW/p2hSSQdrcX8rpve2Sq/al99Jctb0vc9NvLsDVipsyzYA6iLcVOllw+6CLRXN4SO9f
        pnXWkcHl1Qu2yIBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC955134A9;
        Wed, 22 Jun 2022 03:47:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M0jQNsuQsmJSEAAAMHmgww
        (envelope-from <osalvador@suse.de>); Wed, 22 Jun 2022 03:47:23 +0000
Date:   Wed, 22 Jun 2022 05:47:22 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/page_alloc: Do not calculate node's total
 pages and memmap pages when empty
Message-ID: <YrKQyhwDwMvueOUc@localhost.localdomain>
References: <20220621041717.6355-1-osalvador@suse.de>
 <20220621041717.6355-2-osalvador@suse.de>
 <506203e3-1de0-1187-5234-7afc66d4ddfe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <506203e3-1de0-1187-5234-7afc66d4ddfe@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 09:44:47AM +0200, David Hildenbrand wrote:
> 
> 
> It's worth noting that the check in pgdat_is_empty() is slightly
> different. I *think* it doesn't matter in practice, yet I wonder if we
> should simply fixup (currently unused) pgdat_is_empty().

I guess we could change it to

 static inline bool pgdat_is_empty(pg_data_t *pgdat)
 {
	 return node_start_pfn(pgdat->node_id) == node_end_pfn(pgdat->node_id)
 }

? And maybe even rename it to to node_is_empty (not sure why but I tend to like
that more than pgdat) 

I could squeeze a "fixup" patch for that before this one. 

> 
> Anyhow
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!


-- 
Oscar Salvador
SUSE Labs
